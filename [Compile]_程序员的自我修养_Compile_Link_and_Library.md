

-   Concurrency [n.] 并发性 同时发生
-   Preemptive 抢占式
-   LBA 逻辑扇区地址 Logical Block Address
-   DDA 一种画直线的图形算法
-   GDI 图形设备接口 Graphics Device Interface或Graphical Device Interface 是微软公司视窗操作系统(Microsoft Windows)的三大核心部件(“子系统”)之一。kernel管理内核，user管理用户操作，GDI




历史 公司 机器相关


-   PowerPC  IBM和Apple公司联合生产的个人台式机
-   Sparc  SUN 公司的工作站系统









-   虚拟机技术在硬件和操作系统之间添加一层虚拟层




Windows中，图形硬件被抽象成GDI，声音、多媒体设备被抽象成DirectX对象，硬盘被抽象成普通文件系统

操作系统中的**硬件驱动(Device Driver)程序**跟操作系统内核一起运行在特权级，但与操作系统之间有一定独立性。



# GCC

用法：gcc [选项] 文件...
选项：

-pass-exit-codes         在某一阶段退出时返回最高的错误码

--help                   显示此帮助说明

--target-help            显示目标机器特定的命令行选项

--help={common|optimizers|params|target|warnings|[^]{joined|separate|undocumented}}[,...]
  显示特定类型的命令行选项
  (使用‘-v --help’显示子进程的命令行参数)

--version                显示编译器版本信息

-dumpspecs               显示所有内建 spec 字符串

-dumpversion             显示编译器的版本号

-dumpmachine             显示编译器的目标处理器

-print-search-dirs       显示编译器的搜索路径

-print-libgcc-file-name  显示编译器伴随库的名称

-print-file-name=<库>    显示 <库> 的完整路径

-print-prog-name=<程序>  显示编译器组件 <程序> 的完整路径

-print-multiarch         Display the target's normalized GNU triplet, used as a component in the library path

-print-multi-directory   显示不同版本 libgcc 的根目录

-print-multi-lib         显示命令行选项和多个版本库搜索路径间的映射

-print-multi-os-directory 显示操作系统库的相对路径

-print-sysroot           显示目标库目录

-print-sysroot-headers-suffix 显示用于寻找头文件的 sysroot 后缀

-Wa,<选项>               将逗号分隔的 <选项> 传递给汇编器

-Wp,<选项>               将逗号分隔的 <选项> 传递给预处理器

-Wl,<选项>               将逗号分隔的 <选项> 传递给链接器

-Xassembler <参数>       将 <参数> 传递给汇编器

-Xpreprocessor <参数>    将 <参数> 传递给预处理器

-Xlinker <参数>          将 <参数> 传递给链接器

-save-temps              不删除中间文件

-save-temps=<arg>        不删除中间文件

-no-canonical-prefixes   生成其他 gcc 组件的相对路径时不生成规范化的
前缀

-pipe                    使用管道代替临时文件

-time                    为每个子进程计时

-specs=<文件>            用 <文件> 的内容覆盖内建的 specs 文件

-std=<标准>              指定输入源文件遵循的标准

--sysroot=<目录>         将 <目录> 作为头文件和库文件的根目录

-B <目录>                将 <目录> 添加到编译器的搜索路径中

-v                       显示编译器调用的程序

-###                     与 -v 类似，但选项被引号括住，并且不执行命令

-E                       仅作预处理，不进行编译、汇编和链接

-S                       编译到汇编语言，不进行汇编和链接

-c                       编译、汇编到目标代码，不进行链接

-o <文件>                输出到 <文件>

-pie                     Create a position independent executable

-shared                  Create a shared library

-x <语言>                指定其后输入文