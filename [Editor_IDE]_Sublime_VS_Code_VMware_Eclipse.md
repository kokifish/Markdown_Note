[TOC]



# Visual Studio Code





### C/C++

- C/C++ support for Visual Studio Code is provided by a Microsoft C/C++ extension to enable cross-platform C and C++ development using VS Code on Windows, Linux, and macOS.

Extension name: C/C++

##### `task.json`

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



##### `launch.json`

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



#### Getting Started

1. Open VS Code
2. ctrl+shift+P: open command palette; input: Extensions: Install Extensions;(or install)
3. Search for c/c++
4. click **Install**, then click **Reload**.



First Use:

1. Open VS Code, then open a folder that contains your C/C++ source code.(VS Code will place various settings files into a `.vscode` subfolder.)
2. Check for json file in `.vscode` subfolder: ctrl+shift+P, then search **C/Cpp: Edit configurations**, check **compilerPath** for existing compiler. (The C/C++ extension does not include a C++ compiler or debugger) 
3. If no compiler, you can download mingw-w64, then add it to platform PATH.





### setting



Auto Closing Brackets: 是否自动加右括号, close brackets.

```c
//可在user setting中添加//实现大括号不换行
	"editor.formatOnSave": true,
    "C_Cpp.clang_format_style":
    "{ BasedOnStyle: Chromium, IndentWidth: 4}"
```



##### setting.json

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



# Sublime Text 3 快捷键精华版

Ctrl+Shift+P：打开命令面板
Ctrl+P：搜索项目中的文件
Ctrl+G：跳转到第几行
Ctrl+W：关闭当前打开文件
Ctrl+Shift+W：关闭所有打开文件
Ctrl+Shift+V：粘贴并格式化
Ctrl+D：选择单词，重复可增加选择下一个相同的单词
Ctrl+L：选择行，重复可依次增加选择下一行
Ctrl+Shift+L：选择多行
Ctrl+Shift+Enter：在当前行前插入新行
Ctrl+X：删除当前行
Ctrl+M：跳转到对应括号
Ctrl+U：软撤销，撤销光标位置
Ctrl+J：选择标签内容
Ctrl+F：查找内容
Ctrl+Shift+F：查找并替换
Ctrl+H：替换
Ctrl+R：前往 method
Ctrl+N：新建窗口
Ctrl+K+B：开关侧栏
Ctrl+Shift+M：选中当前括号内容，重复可选着括号本身
Ctrl+F2：设置/删除标记
Ctrl+/：注释当前行
Ctrl+Shift+/：当前位置插入注释
Ctrl+Alt+/：块注释，并Focus到首行，写注释说明用的
Ctrl+Shift+A：选择当前标签前后，修改标签用的
F11：全屏
Shift+F11：全屏免打扰模式，只编辑当前文件
Alt+F3：选择所有相同的词
Alt+.：闭合标签
Alt+Shift+数字：分屏显示
Alt+数字：切换打开第N个文件
Shift+右键拖动：光标多不，用来更改或插入列内容
鼠标的前进后退键可切换Tab文件
按Ctrl，依次点击或选取，可需要编辑的多个位置
按Ctrl+Shift+上下键，可替换行

## 选择类

Ctrl+D 选中光标所占的文本，继续操作则会选中下一个相同的文本。

Alt+F3 选中文本按下快捷键，即可一次性选择全部的相同文本进行同时编辑。举个栗子：快速选中并更改所有相同的变量名、函数名等。

Ctrl+L 选中整行，继续操作则继续选择下一行，效果和 Shift+↓ 效果一样。

Ctrl+Shift+L 先选中多行，再按下快捷键，会在每行行尾插入光标，即可同时编辑这些行。

Ctrl+Shift+M 选择括号内的内容（继续选择父括号）。举个栗子：快速选中删除函数中的代码，重写函数体代码或重写括号内里的内容。

Ctrl+M 光标移动至括号内结束或开始的位置。

Ctrl+Enter 在下一行插入新行。举个栗子：即使光标不在行尾，也能快速向下插入一行。

Ctrl+Shift+Enter 在上一行插入新行。举个栗子：即使光标不在行首，也能快速向上插入一行。

Ctrl+Shift+[ 选中代码，按下快捷键，折叠代码。

Ctrl+Shift+] 选中代码，按下快捷键，展开代码。

Ctrl+K+0 展开所有折叠代码。

Ctrl+← 向左单位性地移动光标，快速移动光标。

Ctrl+→ 向右单位性地移动光标，快速移动光标。

shift+↑ 向上选中多行。

shift+↓ 向下选中多行。

Shift+← 向左选中文本。

Shift+→ 向右选中文本。

Ctrl+Shift+← 向左单位性地选中文本。

Ctrl+Shift+→ 向右单位性地选中文本。

Ctrl+Shift+↑ 将光标所在行和上一行代码互换（将光标所在行插入到上一行之前）。

Ctrl+Shift+↓ 将光标所在行和下一行代码互换（将光标所在行插入到下一行之后）。

Ctrl+Alt+↑ 向上添加多行光标，可同时编辑多行。

Ctrl+Alt+↓ 向下添加多行光标，可同时编辑多行。

## 编辑类

Ctrl+J 合并选中的多行代码为一行。举个栗子：将多行格式的CSS属性合并为一行。

Ctrl+Shift+D 复制光标所在整行，插入到下一行。

Tab 向右缩进。

Shift+Tab 向左缩进。

Ctrl+K+K 从光标处开始删除代码至行尾。

Ctrl+Shift+K 删除整行。

Ctrl+/ 注释单行。

Ctrl+Shift+/ 注释多行。

Ctrl+K+U 转换大写。

Ctrl+K+L 转换小写。

Ctrl+Z 撤销。

Ctrl+Y 恢复撤销。

Ctrl+U 软撤销，感觉和 Gtrl+Z 一样。

Ctrl+F2 设置书签

Ctrl+T 左右字母互换

F6 单词检测拼写

## 搜索类

Ctrl+F 打开底部搜索框，查找关键字。

Ctrl+shift+F 在文件夹内查找，与普通编辑器不同的地方是sublime允许添加多个文件夹进行查找，略高端，未研究。

Ctrl+P 打开搜索框。举个栗子：1、输入当前项目中的文件名，快速搜索文件，2、输入@和关键字，查找文件中函数名，3、输入：和数字，跳转到文件中该行代码，4、输入#和关键字，查找变量名。

Ctrl+G 打开搜索框，自动带：，输入数字跳转到该行代码。举个栗子：在页面代码比较长的文件中快速定位。

Ctrl+R 打开搜索框，自动带@，输入关键字，查找文件中的函数名。举个栗子：在函数较多的页面快速查找某个函数。

Ctrl+： 打开搜索框，自动带#，输入关键字，查找文件中的变量名、属性名等。

Ctrl+Shift+P 打开命令框。场景栗子：打开命名框，输入关键字，调用sublime text或插件的功能，例如使用package安装插件。

Esc 退出光标多行选择，退出搜索框，命令框等。

## 显示类

Ctrl+Tab 按文件浏览过的顺序，切换当前窗口的标签页。

Ctrl+PageDown 向左切换当前窗口的标签页。

Ctrl+PageUp 向右切换当前窗口的标签页。

Alt+Shift+1 窗口分屏，恢复默认1屏（非小键盘的数字）

Alt+Shift+2 左右分屏-2列

Alt+Shift+3 左右分屏-3列

Alt+Shift+4 左右分屏-4列

Alt+Shift+5 等分4屏

Alt+Shift+8 垂直分屏-2屏

Alt+Shift+9 垂直分屏-3屏

Ctrl+K+B 开启/关闭侧边栏

F11 全屏模式

Shift+F11 免打扰模式

`update`

Ctrl+k+2 折叠注释和方法

Ctrl+k+3 折叠if

Ctrl+k+4 折叠switch





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













