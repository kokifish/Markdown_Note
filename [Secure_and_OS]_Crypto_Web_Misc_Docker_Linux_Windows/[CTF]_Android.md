

# Android

> https://xmsg.org/wordpress/2017/02/%E5%90%BE%E7%88%B1%E7%A0%B4%E8%A7%A3%E5%AE%89%E5%8D%93%E9%80%86%E5%90%91%E5%85%A5%E9%97%A8%E6%95%99%E7%A8%8B/

apk实际是zip压缩包，改apk后缀为zip后解压可以看到内部结构。但不完全？用AndroidKiller可以完全解开

apk组成

子目录: 

- assets: 资源目录。assets目录下的资源文件不需要生成索引，Java代码中用AssetManager访问
- lib: .so库目录
- META-INF: 存放工程属性文件. e.g. Manifest.MF
- res: 资源目录2。编译时会自动生成索引文件（R.java），在Java代码中用R.xxx.yyy来引用

根目录文件: 

- AndroidManifest.xml: Android工程的基础配置属性文件
- classes.dex: Java代码编译得到的 Dalvik VM 能直接执行的文件
- resources.arsc: 对res 目录下的资源的一个索引文件，保存了原工程中 strings.xml等文件内容



## Dalvik

Dalvik 是 google 专门为 Android 操作系统设计的一个虚拟机，经过深度优化。虽然 Android 上的程序是使用 java 来开发的，但是 Dalvik 和标准的 java 虚拟机 JVM 还是两回事。Dalvik VM 是基于寄存器的，而 JVM 是基于栈的；Dalvik有专属的文件执行格式 dex （dalvik executable），而 JVM 则执行的是 java 字节码。Dalvik VM 比 JVM 速度更快，占用空间更少。
通过 Dalvik 的字节码我们不能直接看到原来的逻辑代码，这时需要借助如 Apktool 或 dex2jar+jd-gui 工具来帮助查看。但是，我们最终修改 APK 需要操作的文件是 .smali 文件，而不是导出来的 Java 文件重新编译



## Smali



# Tools



## apktool

```bash
apktool.jar d andra.apk # 然后会出现一个文件夹 andra 保存经过了解压的apk里面的文件
apktool.jar d -r andra.apk -o andra # 与上面一样 
```







### Installation

> test in 2020.3, Kali20.04, apktool 2.5   https://ibotpeaches.github.io/Apktool/install/

1. Download Linux [wrapper script](https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool) (Right click, Save Link As `apktool`)
2. Download apktool-2 ([find newest here](https://bitbucket.org/iBotPeaches/apktool/downloads/))
3. Rename downloaded jar to `apktool.jar`
4. Move both files (`apktool.jar` & `apktool`) to `/usr/local/bin` (root needed)
5. Make sure both files are executable (`chmod +x`)
6. Try running apktool via cli. (actually, use apktool.jar)



## jeb

https://forum.reverse4you.org/t/cracked-jeb-3-24-anti-blm-edition-by-dimitarserg/11768 JEB 3.24 demo

https://rextester.com/DYRN51380 online keygen

打开后，Bytecode/Disassembly前面几行的 `# Main Activity: xxx (SplashActivity)` 中的xxx一般就是APP一开始运行时打开的activity。点蓝色可以跳转过去，然后在跳转过去的地方右键，点解析(或按tab)可以看到java代码



## AndroidKiller

win GUI app，可以完全解开apk，



