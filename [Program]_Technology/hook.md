

# Xposed

> https://www.freebuf.com/articles/terminal/189021.html

Xposed最高支持到Andoird8，后续版本使用EdXposed，Android12, 13使用LSPosed，需要搭配magisk使用，需要使用magisk插件Riru，但是Riru可以脱离magisk使用。Riru提供在目标进程中隐藏注入的so文件的能力



### Xposed原理

Xposed将Android的Java方法替换为Native JNI方法，然后在这些Native方法中插入用户的代码

# Xposed Detection



## java Level Detection

- 检查系统安装包中是否有xposed安装包

```java
public static boolean isXposedInstalled(Context context) {
    PackageManager packageManager = context.getPackageManager();
    try {
        // 尝试获取Xposed Installer的包信息
        packageManager.getPackageInfo("de.robv.android.xposed.installer", 0);
        return true;
    } catch (PackageManager.NameNotFoundException e) {
        // 如果获取失败，那么可能系统没有安装Xposed Installer
        return false;
    }
}
```

- 自抛异常，判断栈回溯信息中是否包含特征字符串，e.g. "de.robv.android.xposed"。因为

```java
try {
    throw new Exception("Detect Xposed");
} catch (Exception e) {
    StackTraceElement[] traceElements = e.getStackTrace();
    if (traceElements != null && traceElements.length > 0) {
        for (StackTraceElement element : traceElements) {
            if (element.getClassName().contains("de.robv.android.xposed")) {
                Log.d("Detection", "Xposed detected!");
                break;
            }
        }
    }
}
```

- 检查java方法是否替换为native JNI方法。xposed通过替换java方法为native方法来实现其功能

```java
public class XposedDetection {
    public static boolean isXposedInstalled() {
        try {
            // 选择一个常用的Java方法
            Method method = String.class.getMethod("startsWith", String.class);
            // 检查这个方法是否是Native方法
            return method.getModifiers() == Modifier.NATIVE;
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
            return false;
        }
    }
}
```

- 通过反射方法：尝试加载xposed特定类，通过是否加载成功，以及加载失败的具体类型，来判断是否安装xposed
- 内存漫游获取classloader：`getInstancesOfClasses`获取某个类的所有实例，通过此函数获取所有`ClassLoader`实例并查看此`ClassLoader`加载的所有类信息，看是否存在特殊类名称。`getInstancesOfClasses`是hide api，需要先绕过hide api限制

## native/c++, etc Detection

- 检查特定文件或目录

```c++
#include <sys/stat.h>

bool isXposedInstalled() {
    struct stat buffer;
    // 检查Xposed框架的主要文件
    if (stat("/system/framework/XposedBridge.jar", &buffer) == 0) {
        return true;
    }
    // 检查Xposed Installer的数据目录
    if (stat("/data/data/de.robv.android.xposed.installer", &buffer) == 0) {
        return true;
    }
    return false;
}
```

- 系统属性检测

```java
public static boolean isXposedInstalled() {
    String xposedProp = System.getProperty("persist.sys.xposed");
    return xposedProp != null && xposedProp.contains("Xposed");
}
```

- 检查运行时环境

```java
#include <dlfcn.h>
bool isXposedInstalled() {
    // 尝试加载Xposed的特定类
    void* handle = dlopen("libxposed_art.so", RTLD_NOW);
    if (handle != NULL) {
        dlclose(handle);
        return true;
    }
    return false;
}////////////////// 检查 /proc/self/maps 是否包含xposed特有的文件如 XposedBridge.jar
```

- 检查`/proc/<pid>/maps`：`.so`会被隐藏名字，但是内存块是可执行的(`rwx`)，一般很少出现匿名可执行内存。注意误杀
- riru check：检查是否存在`/system/lib64/libriruloader.so`. `fopen("/system/lib64/libriruloader.so", "r");`
- zygisk check: 检查环境变量`LD_PRELOAD`。shamiko可以对这些变化做抹去(https://github.com/LSPosed/LSPosed.github.io/releases)



# Xposed Anti-Detection

- 字符串对抗：`xposed`特征字符串更名，需要在源码上修改类名和文件名，包括修改xml, java。类似方法适用`getprop`



# Lsposed

> https://www.cnblogs.com/revercc/p/17034028.html#%E6%A3%80%E6%B5%8Blsposed%E6%8C%87%E7%BA%B9
>
> https://liwugang.github.io/2021/11/21/analysis_jd_mystique.html 京东安全发现的魔形女漏洞分析





lspd启动：

- daemon/src/main/java/org/lsposed/lspd/Main.java   ServiceManager.start(args);

会依次开启6个服务：

- logcatService = new LogcatService(); logcatService.start();     收集和记录系统的日志信息
- new LSPosedService();            加载和管理 Xposed 模块，处理app的 hook 请求
- new LSPApplicationService();    app的启动、退出
- new LSPManagerService();       管理 LSPosed 的状态，启用/禁用 LSPosed，**启用/禁用 Xposed 模块**。与cli交互的主要class
- new LSPSystemServerService(systemServerMaxRetry);      初始化LSPosed框架，系统级操作
- dex2OatService = new Dex2OatService(); dex2OatService.start();    优化app DEX文件，提高app运行效率



cli PR开启xposed模块的关键调用：

`LSPManagerService.enableModule(packageName)`

- scope: 系统框架 android_framework 相关逻辑写在 app/src/main/java/org/lsposed/manager/adapters/ScopeAdapter.java `public void onBindViewHolder(@NonNull ViewHolder holder, int position)`
- `refresh`？app/src/main/java/org/lsposed/manager/adapters/ScopeAdapter.java   `public void refresh(boolean force)`的`searchList`保存ui里面可以勾选的app，逻辑大致为：扫一遍所有packages包括系统的，然后去除掉所有系统的，加上一个安卓框架(system)



### submodule

- cxx: 安卓的LLVM libc++，移除exception, RTTI
- fmt: 格式化输出库
- lsplant: 安卓ART java hook库
- dobby: hook框架

### build

```bash
git submodule update --init --recursive

    echo 'org.gradle.caching=true' >> ~/.gradle/gradle.properties
    echo 'org.gradle.parallel=true' >> ~/.gradle/gradle.properties
    echo 'org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8 -XX:+UseParallelGC' >> ~/.gradle/gradle.properties
    echo 'android.native.buildOutput=verbose' >> ~/.gradle/gradle.properties

git clone https://github.com/libxposed/api.git libxposed/api
git clone https://github.com/libxposed/service.git libxposed/service

cd libxposed/api
./gradlew publishToMavenLocal
cd ../service
./gradlew publishToMavenLocal

export ANDROID_HOME=/data/path/ # cmdline-tools 的上一级 !!!!!!!!!!
./gradlew zipAll --stacktrace --info

magisk-loader/release/LSPosed-vx.x.x-xxx-xxx.zip
### clean gradle caches
rm -r $HOME/.gradle/caches/
rm -rf /root/.gradle/
rm -rf .gradle
rm -rf build
# unzip files
cd magisk-loader/release/ && unzip -o LSPosed-v1.9.1-6996-riru-debug.zip -d LSPosed-v1.9.1-6996-riru-debug
```





### Source

```bash
# system_server Process: # 首次启动时 system_server进程的
> nativeForkSystemServerPost
  > OnNativeForkSystemServerPost
    > RequestSystemServerBinder
    > RequestLSPDex
    > RequestObfuscationMap
    > LoadDex(env, PreloadedDex(dex_fd, size));
    > HookBridge
    > (application_binder == 0)
dispatchBootCompleted

# lspd process
> daemon/src/main/java/org/lsposed/lspd/service/ServiceManager.java ServiceManager: start
  > systemServerService = new LSPSystemServerService(systemServerMaxRetry); # LSPSystemServerService::LSPSystemServerService
  > Dex2OatService
  > systemServerService.putBinderForSystemServer(); # 注册系统服务，如果该服务died，自动解除与原始服务的绑定
  > var configManager = ConfigManager.getInstance();
  > ActivityThread.systemMain();
  > ConfigFileManager.reloadConfiguration();
  > Looper.loop();
```



#### LoadModules & Zygote Injection

```bash
# lsp 1.9.1
> magisk-loader/src/main/jni/api/riru_main.cpp: RIRU_EXPORT RiruVersionedModuleInfo *init(Riru *riru) # 给riru调的

> magisk-loader/src/main/jni/api/riru_main.cpp: nativeForkSystemServerPost
  > OnNativeForkSystemServerPost # system_server_binder
    > auto *instance = Service::instance();
    > system_server_binder = instance->RequestSystemServerBinder(env); # system_server_binder 决定下一调用的返回值
    > instance->RequestApplicationBinderFromSystemServer(env, system_server_binder); # 返回值会决定是否调用到 forkCommon
      > wrapper.transact(system_server_binder, BRIDGE_TRANSACTION_CODE) # 
    > magisk-loader/src/main/java/org/lsposed/lspd/core/Main.java forkCommon()
      > Startup.initXposed() # 初始化
      > Startup.bootstrapXposed()
        > startBootstrapHook() # hookAllMethods
        > loadLegacyModules() # 唯一会调用下面这个函数的地方
          > private static boolean loadModule(String name, String apk, PreLoadedApk file) # 加载模块的实际逻辑
            > LspModuleClassLoader.loadApk(apk, file.preLoadedDexes, librarySearchPath, initLoader);
            > initNativeModule # 记录so名字
            > initModule
              > if (moduleInstance instanceof IXp0sedHookZygoteInit) { # 会配置 param
                 IXposedHookZygoteInit.initZygote(param); # 用 param 启动 zygote, 实现注入？
```



# Dobby

- 动态二进制插桩库，提供函数hook `DobbyHook`，指令hook `DobbyInstrument`。lsposed只使用`DobbyHook`



### Function Intercept

>  external/dobby/source/InterceptRouting/Routing/FunctionWrapper/function-wrapper.cc

**BuildPreCallRouting**

1. 执行流控制: 将hook处替换为` ldr.w pc, [pc, #-0x0]; &prologue_dispatch_bridge`，即原本的指令被替换为跳转到**prologue_dispatch_bridge**
2. hook逻辑: 通过修改PC和返回地址，在原本的函数调用前调用用户的handler pre_call，执行原本的函数后执行用户handler post_call，再执行



- CreateClosureTrampoline: 转发执行流。创建ClosureTrampolineEntry用于记录闭包跳板信息；`turbo_assembler_`生成汇编:
  - 分配`2*8`的栈空间，`str(lr, SP+8)`保存LR，存储用户handler函数地址到栈SP+0；调用`forward_bridge_label / closure_bridge`；释放栈空间 执行后续指令
  - FinalizeFromTurboAssembler(``turbo_assembler_`): 获取code buffer和实际目标code地址，调用DobbyCodePatch用code替换目标code。返回目标code地址，code长度
    - DobbyCodePatch: 修改内存页为rwx，memcpy生成的code到目标code，改内存页为rx
- 组合执行流和pre_call逻辑：`this->prologue_dispatch_bridge = ClosureTrampoline::CreateClosureTrampoline(entry_, (void *)prologue_routing_dispatch);`
- prologue_routing_dispatch: 在执行原本的函数前调用用户handler. `pre_call_forward_handler(ctx, entry);`
- pre_call_forward_handler: 创建pre_call post_call共享栈帧，如果`pre_call`有定义则调用`pre_call`。保存原始返回地址，设置prologue bridge下一跳转地址为**重定位代码**的原始函数地址，将重定位代码的返回地址替换为`epilogue_dispatch_bridge`的地址，拦截原函数返回过程

> prologue dispatch bridge 序言派遣桥？



### Instruction Intercept

1. 执行流控制：同函数拦截，都是调用CreateClosureTrampoline，但跳板目标地址为`instrument_routing_dispatch`
2. hook逻辑：pre_handler有定义则调用pre_handler之后，执行重定位的原本的代码。(无post_handler)

- DispatchRouting
  - BuildRouting: 生成跳板代码，跳转到用户handler
    - GenerateTrampolineBuffer: 生成跳转到用户handler的拦截跳板buffer
  - GenerateRelocatedCode: 生成重定向代码，即hook前原本的代码

![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Android_IOS_Virtual_Hook/dobby_hook_prologue_dispatch_bridge_example.png)



