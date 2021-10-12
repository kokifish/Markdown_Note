[TOC]





# Visual Studio Code







## Use in Linux

```cmd
code # 启动visual studio code
code . # 打开当前文件夹
code . --user-data-dir # 打开当前文件夹(root)
code /path/to/ # 打开指定文件夹
ctrl + d # 选中当前单词
```





## C/C++

- C/C++ support for Visual Studio Code is provided by a Microsoft C/C++ extension to enable cross-platform C and C++ development using VS Code on Windows, Linux, and macOS.

Extension name: C/C++

#### `task.json`

- `Terminal` -> `Configure Default Build Task`

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "type": "shell",
            "label": "g++.exe build active file",
            "command": "C:\\MinGW\\bin\\g++.exe",
            "args": [
                "-g",
                "${workspaceFolder}\\*.cpp", // -g ${workspaceFolder}\\*.cpp仅可在当前目录下仅有一个main函数时使用
                "-std=c++17",
                "-o",
                "${fileDirname}\\${fileBasenameNoExtension}.exe"
            ],
            "options": {
                "cwd": "${workspaceFolder}"
            },
            "problemMatcher": [
                "$gcc"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ]
}
```



#### `launch.json`

- `Run`-> `Open Configurations` -> `launch.json`

```cpp
{   // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(Windows) Launch",
            "type": "cppdbg",
            "request": "launch",
            "program": "${fileDirname}\\${fileBasenameNoExtension}.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "miDebuggerPath": "C:\\MinGW\\bin\\gdb.exe", // gdb Path
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
            "preLaunchTask": "g++.exe build active file" // corresponding to task.json's label
        }
    ]
}
```



#### `c_cpp_properties.json`

```json
// how to resolve "include file not found" error: // demo
// C/C++ Edit Configurations(JSON) // c_cpp_properties.json
{
    "configurations": [
        {
            "name": "Linux",
            "includePath": [
                "${workspaceFolder}/**",
                "${PWD}/**", // added
                "/opt/Qt5.14.1/5.14.1/gcc_64/include/**" // added // find / -name QProcess
            ],
            "defines": [],
            "compilerPath": "/usr/bin/gcc"
        }
    ],
    "version": 4
}
```







### Getting Started

1. Open VS Code
2. ctrl+shift+P: open command palette; input: Extensions: Install Extensions;(or install)
3. Search for c/c++
4. click **Install**, then click **Reload**.



First Use:

1. Open VS Code, then open a folder that contains your C/C++ source code.(VS Code will place various settings files into a `.vscode` subfolder.)
2. Check for json file in `.vscode` subfolder: ctrl+shift+P, then search **C/Cpp: Edit configurations**, check **compilerPath** for existing compiler. (The C/C++ extension does not include a C++ compiler or debugger) 
3. If no compiler, you can download mingw-w64, then add it to platform PATH.





### clang-format ERROR

在使用`clang-format`对代码进行格式化时，出现`libtinfo.so.5 not found`问题的解决方法：

```cmd
# 1. install clang-format
dnf install git-clang-format # fedora
apt install clang-format # ubuntu
# 2. open setting.json, add:
"C_Cpp.clang_format_path": "/usr/bin/clang-format"
```





## setting



Auto Closing Brackets: 是否自动加右括号, close brackets.

```c
//可在user setting中添加//实现大括号不换行
	"editor.formatOnSave": true,
    "C_Cpp.clang_format_style":
    "{ BasedOnStyle: Chromium, IndentWidth: 4}"
```



### setting.json

- 20200920 backup `VScode setting.json`

```json
{
    "window.zoomLevel": -0.5,
    "files.autoSave": "afterDelay",
    "terminal.integrated.shell.windows": "C:\\Windows\\System32\\cmd.exe",
    "editor.autoClosingBrackets": "always",
    "editor.rulers": [
        90,
        120
    ],
    "editor.minimap.enabled": true,
    "editor.renderWhitespace": "none",
    "files.eol": "\n",
    "editor.formatOnSave": true,
    "C_Cpp.clang_format_style": "{ BasedOnStyle: Chromium, IndentWidth: 4, MaxEmptyLinesToKeep: 2, SortIncludes: true, UseTab: Never, ReflowComments: false, ColumnLimit: 90}",
    "workbench.activityBar.visible": true,
    "workbench.colorCustomizations": {
        "terminal.foreground": "#b5e08f",
    },
    "breadcrumbs.enabled": false,
    "python.linting.flake8Enabled": true,
    "python.linting.flake8Args": [
        "--max-line-length=300"
    ],
    "python.linting.pylintEnabled": true,
    "http.proxySupport": "off",
    "matlab.matlabpath": "C:\\Matlab\\bin",
    "matlab.mlintpath": "C:\\Matlab\\bin\\win64",
    //"python.formatting.provider": "none",
    "latex-workshop.latex.recipes": [ //----------- latex-workshop -----------//
        // {
        //     "name": "PDFLaTeX",
        //     "tools": [
        //         "pdflatex"
        //     ]
        // },
        {
            "name": "pdflatex -> bibtex -> pdflatex*2",
            "tools": [
                "pdflatex",
                "bibtex",
                "pdflatex",
                "pdflatex"
            ]
        },
        {
            "name": "xelatex -> xelatex",
            "tools": [
                "xelatex",
                "bibtex",
                "xelatex",
                "xelatex"
            ]
        },
        {
            "name": "xelatex",
            "tools": [
                "xelatex"
            ]
        },
        {
            "name": "latexmk",
            "tools": [
                "latexmk"
            ]
        }
    ],
    "latex-workshop.latex.tools": [
        {
            "name": "xelatex",
            "command": "xelatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOC%"
            ]
        },
        {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-pdf",
                "%DOC%"
            ]
        },
        {
            "name": "pdflatex",
            "command": "pdflatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOC%"
            ]
        },
        {
            "name": "bibtex",
            "command": "bibtex",
            "args": [
                "%DOCFILE%"
            ]
        }
    ],
    "latex-workshop.view.pdf.viewer": "tab",
    "debug.onTaskErrors": "debugAnyway",
    "todo-tree.tree.showScanModeButton": false
}
```





------

# Visual Studio



```cpp
#pragma warning(disable:4996)//禁止4996的warning
```





### 快捷键

- 显示代码提示 alt + ->
- 开始调试 F5
- 构建工程 F7
- 设置断点、取消断点 F9
- 单步跟踪 F10
- 单步步入 F11
- 转到定义 F12
- 新建文件ctrl + N
- 查找 ctrl + F
- 转为小写 ctrl + U
- 转为大写 ctrl + shilt + U
- 注释所在行 ctrl + K      ctrl + C
- 设置文档格式 ctrl + K      ctrl + D





### 查看class内存布局

- 项目 ➡️ [项目]属性 ➡️ C/C++ ➡️ 命令行 ➡️ 其它选项 ➡️ /d1reportSingleClassLayout[Class]
- demo: /d1reportSingleClassLayoutTest
- 查看: 输出(下方) ➡️ 输出来源：生成





# Eclipse

### 环境配置与安装

1. 安装Eclipse IDE for Java EE Developers//运行java
2. 安装java的依赖环境JDK (java development kit)http://www.oracle.com/technetwork/java/javase/downloads/index.html
3. 配置JDK：增加环境变量"JAVA_HOME"，变量值为JDK的安装路径；修改已有的Path环境变量（如不存在则新增），在变量值的起始位置添加"%JAVA_HOME%\bin;"
4. 安装MinGW64并配置环境变量
5. 安装Eclipse C/C++ Development Tools, Help > Eclipse Marketplace 



> https://www.cnblogs.com/jason2013/p/3707648.html
>
> 

### 快捷键

Default

1. Window > Preferences > General > Keys
2. 找到对应功能的Command
3. 在下方更改Binding and When

![](http://op4fcrj8y.bkt.clouddn.com/17-12-31/61358733.jpg)

更改后可以在Text Editing Category用 ctrl + = 对界面进行放大



- F11 Debug 
- ctrl + F11 Run
- ctrl + shift + Format 格式风格化文本



# VMware

## Shared Folder

kali官网有文档，安装过程更简单： https://www.kali.org/docs/virtualization/install-vmware-guest-tools/







## 连接局域网主机的VMware虚拟机

> VMware Workstation 16 Pro Version 16.1
>
> VM: kali 2020.4-vm-amd64

1. VMware => Edit => Virtual Network Editor... : lower right: Change Settings (to get administrator privileges)
2. Select VMnet8 NAT => NAT Settings... => Port Forwarding => Add...
3. Fill: Host port(宿主机的端口), TCP or UDP(TCP if set for `ssh`), Virtual machine IP address(VM虚拟机的IP), Virtual machine port(VM虚拟机的port, 22 if set for `ssh`)
4. OK, then can connect `virtual machine IP:virtual machine port` through `host machine IP:host machine port` on host machine subnet

> 案例：VM虚拟机kali: IP: 192.168.149.129 ssh配置在22端口(默认)
>
> VM宿主机IP: 172.18.33.87, 经过上述配置，Host Port设置为40123后(数字随机，不被占用即可，猜的)
>
> 可以在172.18.216.103通过ssh连接172.18.33.87:40123来连接到VM虚拟机kali的22端口





Kali 创建共享文件夹:

Kali Client Process:

1. apt-get install open-vm-tools-desktop fuse  //安装 VMware-Tools
2. vmware-hgfsclient     //查看共享目录//其余VMware命令在bin中
3. mkdir /mnt/ShareDir/       //创建新文件夹
4. /usr/bin/vmhgfs-fuse .host:/ /mnt/ShareDir-o subtype=vmhgfs-fuse //链接到主机文件夹



### 安装VMware Tools

Fedora安装VMware Tools

https://blog.csdn.net/pan869823184/article/details/7237248?utm_source=blogxgwz0



1. Workstation Pro menu bar: VM > Install VMware Tools
2. 可以先用su以root登录，使用 rpm -q perl 等命令分别确认 perl gcc kernel kernel-devel 都已安装
3. Virtual machine terminal: `mount` with no arguments to determine whether your Linux distribution automatically mounted the VMware Tools virtual CD-ROM image. 若已挂载，挂载形式一般如下： /dev/cdrom on /mnt/cdrom type iso9660 (ro,nosuid,nodev) 
4. 若未挂载，则挂载CD-ROM drive:
   1. mkdir /mnt/cdrom   //若已存在可以跳过
   2. **mount /dev/cdrom /mnt/cdrom**
5. Change to a working directory, e.g. cd /tmp   cd /
6. (Optional) Delete any previous vmware-tools-distrib directory before you install VMware Tools.
7. List the contents of the mount point directory and note the file name of the VMware Tools tar installer. `ls mount-point`
8. 解压安装文件:   tar zxpf /mnt/cdrom/VMwareTools-x.x.x-yyyy.tar.gz -C /      //解压到根目录
9. If necessary, unmount the CD-ROM image.  `umount /dev/cdrom`
10. `cd vmware-tools-distrib
    sudo ./vmware-install.pl`
11. 安装过程中，基本都可以直接回车，若遇到说gcc目录的，如果不需要gcc，可以写no，最后出现enjoy， VM team则说明成功安装VM tools



eject -rf -v /dev/cdrom





## Q&A



### ping不通虚拟机 ping得通主机

- 禁用VMware的两个虚拟网卡，再启用。欸，好了？？？？？



### 'DevicePowerOn' power on failed

问题对话框内容：

```
Unable to open kernel device '\\.\VMCIDev\VMX': The operation completed successfully. Did you reboot after installing VMware Workstation?
Module 'DevicePowerOn' power on failed.
Failed to start the virtual machine.
```

解决方案：

- 用打开虚拟机所在目录下的.vmx文件
-  vmci0.present = "TRUE"将 TRUE 改为 FALSE

