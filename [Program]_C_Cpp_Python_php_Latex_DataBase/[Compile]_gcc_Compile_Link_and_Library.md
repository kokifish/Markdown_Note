[TOC]



---

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







---

# GCC

用法：gcc [选项] 文件...
选项：
```bash
-pass-exit-codes         在某一阶段退出时返回最高的错误码
--help                   显示此帮助说明
--target-help            显示目标机器特定的命令行选项
--help={common|optimizers|params|target|warnings|[^]{joined|separate|undocumented}}[,...] #显示特定类型的命令行选项(使用'-v --help'显示子进程的命令行参数)
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
-no-canonical-prefixes   生成其他 gcc 组件的相对路径时不生成规范化的前缀
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
```

```bash
# 调试选项 优化选项
-g # 生成供 gdb 使用的调试信息
-ggdb # 产生更多的调试信息
-O[0,1,2,3] # 默认2级优化，0 不优化，优化和调试不兼容，所以不要同时使用-g 和-O 选项
```



## 头文件的来源

gcc 在编译时如何去寻找所需要的头文件：

1. header file的搜寻会从-I开始
2. 然后找gcc的环境变量 `C_INCLUDE_PATH，CPLUS_INCLUDE_PATH，OBJC_INCLUDE_PATH`
3. 再找内定目录: `/usr/include, /usr/local/include`（centos7中该目录下是空的）gcc的一系列自带目录 `/usr/include/c++/4.8.5`



## 库文件的来源

编译的时候：

1. `gcc`会去找`-L`
2. 再找`gcc`的环境变量`LIBRARY_PATH`
3. 再找内定目录：`/lib, /lib64, /usr/lib, /usr/lib64, /usr/local/lib, /usr/local/lib64`







---

# 编译与链接

-   编译(compile): c/c++首先把源文件编译成中间代码文件，Windows下是.obj，Linux下是.o，即Object File。一般来说，每个源文件都应该对应于一个中间目标文件(O / OBJ文件)
-   链接(link): 把大量的Object File合成执行文件



-   编译: 将高级语言编写的程序翻译成等价的二进制指令序列来代替，计算机执行等价的机器语言程序
-   解释: 以高级语言程序作为输入数据，顺序地检查它的每一条语句，并直接执行等价的机器语言指令序列，这种方法称为解释，例如MATLAB



## 编译compile

编译时，编译器需要的是语法的正确，函数与变量的声明的正确。对于后者，通常是你需要告诉编译器头文件的所在位置（头文件中应该只是声明，而定义应该放在C/C++文件中），只要所有的语法正确，编译器就可以编译出中间目标文件





## 链接link

链接时，主要是链接函数和全局变量，所以，我们可以使用这些中间目标文件（O文件或是OBJ文件）来 链接我们的应用程序。链接器并不管函数所在的源文件，只管函数的中间目标文件（Object File），在大多数时候，由于源文件太多，编译生成的中间目标文件太多，而在链接时需要明显地指出中间目标文件名，这对于编译很不方便，所以，我们要给 中间目标文件打个包，在Windows下这种包叫“库文件”（Library File)，也就是 .lib 文件，在UNIX下，是Archive File，也就是 .a 文件

**链接阶段**是将一个或者多个中间文件（.o文件）通过链接器将它们链接成一个可执行文件，链接阶段主要完成以下事情：

- 各个中间文之间的同名section合并
- 对代码段，数据段以及各符号进行地址分配
- **链接时重定位**修正

除了重定位过程，其它动作是无法修改中间文件中函数体内指令的，而重定位过程也只能是修改指令中的操作数，换句话说，**链接过程无法修改编译过程生成的汇编指令**



---

# makefile

makefile带来的好处是"自动化编译"，一旦写好只需要一个make命令整个工程完全自动编译

make是一个命令工具，是一个解释makefile中指令的命令工具，一般来说，大多数的IDE都有这个命令，比如：Delphi的make，Visual C++的nmake，Linux下GNU的make。可见，makefile都成为了一种在工程方面的编译方法

```makefile
目标 ： 需要的条件 #注意冒号两边有空格
　　　　命令　　#注意前面用tab键开头且必须以tab开头
```

```makefile
test.exe : test.o 
	gcc -o test test.o 

test.o : test.c
	gcc -c test.c
clean :
	rm test.o
```



-   目标可以是一个或多个，可以是Object File，也可以是执行文件，甚至可以是一个标签
-   需要的条件就是生成目标所需要的文件或目标
-   命令就是生成目标所需要执行的脚本

一条makefile规则规定了编译的依赖关系，也就是目标文件依赖于条件，生成规则用命令来描述

**编译时，如果需要的条件的文件比目标更新的话，就会执行生成命令来更新目标**

位于编译下层的文件如果更新，则依赖该文件的上层文件都会因此重新编译以保持最新



Makefile里主要包含了五个东西
1.  显式规则。显式规则说明了，如何生成一个或多个目标文件。这是由Makefile的书写者明显指出，要生成的文件，文件的依赖文件，生成的命令。
2.  隐晦规则。由于我们的make有自动推导的功能，所以隐晦的规则可以让我们比较简略地书写Makefile，这是由make所支持的。
3.  变量的定义。在Makefile中我们要定义一系列的变量，变量一般都是字符串，这个有点像你C语言中的宏，当Makefile被执行时，其中的变量都会被扩展到相应的引用位置上。
4.  文件指示。其包括了三个部分，一个是在一个Makefile中引用另一个Makefile，就像C语言中的include一样；另一个是指根据某些情况指定Makefile中的有效部分，就像C语言中的预编译#if一样；还有就是定义一个多行的命令。有关这一部分的内容，我会在后续的部分中讲述
5.  注释。Makefile中只有行注释，和UNIX的Shell脚本一样，其注释是用“#”字符，这个就像C/C++中的“//”一样。如果你要在你的Makefile中使用“#”字符，可以用反斜杠进行转义，如：“\#”



```makefile
targetfile : main.o kbd.o command.o display.o \ # \是换行的意思
		insert.o search.o files.o utils.o #注释:如果后面这些.o文件比edit可执行文件新,那么才会去执行下面这句命令
	cc -o targetfile main.o kbd.o command.o display.o \
		insert.o search.o files.o utils.o

main.o : main.c defs.h
	cc -c main.c
kbd.o : kbd.c defs.h command.h
	cc -c kbd.c
command.o : command.c defs.h command.h
	cc -c command.c
display.o : display.c defs.h buffer.h
	cc -c display.c
insert.o : insert.c defs.h buffer.h
	cc -c insert.c
search.o : search.c defs.h buffer.h
	cc -c search.c
files.o : files.c defs.h buffer.h command.h
	cc -c files.c
utils.o : utils.c defs.h
	cc -c utils.c
clean :
	rm targetfile main.o kbd.o command.o display.o \
		insert.o search.o files.o utils.o
```





### makefile工作过程

1.  make会在当前目录下找名字叫“Makefile”“GNUmakefile”“makefile”的文件
2.  若找到，会找文件中的第一个目标文件(target)，并把这个文件作为最终的目标文件//对应上例的targetfile
3.  如果targetfile不存在，或是targetfile所依赖的后面的.o文件的修改时间比当前targetfile新，则执行后面定义的命令来生成targetfile文件
4.  如果targetfile所依赖的.o文件不存在，则make会在当前文件中找目标为.o文件的依赖性，再根据该.o文件的依赖性生成.o文件//类似堆栈的过程
5.  如果c cpp h文件存在，make会生成.o文件，再用.o文件生成targetfile文件

-   make会一层一层找文件依赖关系直到最终编译出第一个目标文件，若在寻找过程中出现错误例如最后被依赖的文件找不到，则make会直接退出并报错。而对于所定义的命令的错误，或是编译不成功，make根本不理。make只管文件的依赖性，即，如果在我找了依赖关系之后，冒号后面的文件还是不在，那么不工作
-   例子中的clean没有被第一个targetfile直接或间接的关联，则后面的命令不会自动执行，但可以显示要make执行："make clean"，以此来清除所有的目标文件以便重编译
-   make -f Test.Linux //指定特定的Makefile 文件名为 Test.Linux


### makefile的变量

makefile的变量也就是一个字符串，可以理解成C语言中的宏

```makefile
objects = main.o bbb.o

edit : $(objects)
	cc -o edit $(objects)
main.o : main.c
	cc -c main.c
bbb.o : bbb.c bbb.h
	cc -c bbb.c
```





### 自动推导

GNU的make可以自动推导文件依赖关系后面的命令//make的“隐晦规则”

make看到一个.o文件就自动把同名.c文件加在依赖关系中，且cc -c ***.c也会被推导出来

```makefile
objects = main.o kbd.o command.o display.o \
		insert.o search.o files.o utils.o
 cc = gcc

targetfile : $(objects)
	cc -o targetfile $(objects)

main.o : defs.h
kbd.o : defs.h command.h
command.o : defs.h command.h
display.o : defs.h buffer.h
insert.o : defs.h buffer.h
search.o : defs.h buffer.h
files.o : defs.h buffer.h command.h
utils.o : defs.h

.PHONY : clean #表示clean是个伪目标文件
clean :
	rm targetfile $(objects)
```







```makefile
#银行叫号系统的模拟 //windows下的makefile rm会报错
#makefile with g++
simulate.exe : main.o customer.o bank.o
	g++ -o simulate main.o customer.o bank.o

main.o : main.cpp customer.h bank.h
	g++ -c main.cpp
bank.o : bank.cpp bank.h customer.h
	g++ -c bank.cpp
customer.o : customer.cpp customer.h
	g++ -c customer.cpp
.PHONY : clean
clean : #表示clean是个伪目标文件
	del simulate.exe
```



```makefile
CC = gcc
CPP = g++
CFLAGS = -Wall -O3
#CFLAGS = -I"C:\MinGW\include"
LDFLAGS = 
#LDFLAGS = -L"C:\MinGW\lib" -mwindows -s
MKDIR = mkdir
RM = rm -frv


.PHONY: all clean

all: build/test_keylogger.exe build/keylogger.exe

build/keylogger.exe: build/main.o build/functions.o
    $(CPP) $(CFLAGS) $^ -o $@ $(LDFLAGS)

build/main.o: src/main.cpp src/main.h src/config.h build
    $(CPP) $(CFLAGS) -c $< -o $@

build/functions.o: src/functions.cpp src/functions.h build
    $(CPP) $(CFLAGS) -c $< -o $@

build/test_keylogger.exe: build/test_keylogger.o build/functions.o
    $(CPP) $(CFLAGS) $^ -o $@ $(LDFLAGS)
    $@

build/test_keylogger.o: tests/test_keylogger.cpp build
    $(CPP) $(CFLAGS) -c $< -o $@

build:
    $(MKDIR) "$@"

clean:
    $(RM) build/main.o build/functions.o build/keylogger.exe build/test_keylogger.o build/test_keylogger.exe
    @#$(RM) build
```













---

# 多文件编译



-   .cpp被编译成.obj文件，同一程序中的各个obj文件被**链接**成.exe可执行文件
-   C++中多文件程序中的各.cpp文件被单独编译(separate compilation)且可在不同时刻编译



>   通常几个程序文件多次包含同一个头文件(包含 typedef 语句、 常量或类声明) 
>
>   相同的标识符如果被重复定义，会导致编译错误

```c++
#ifndef TIME_H //如果没有定义TIME_H//预处理器指令
#define TIME_H //先定义TIME_H,下次编译上一句条件不成立,下面的内容就不会再编译

class  Time{
};
#endif//与#ifndef配对
```



```c++
#pragma once
```





### 编译单元

>   translate unit / compilation unit / translation unit 编译单元

-   .c / .cpp 编译时，预处理器先递归包含头文件，形成一个含有所有必要信息的单个源文件就是编译单元
-   这个编译单元会被编译成一个与cpp文件同名的目标文件(.o / .obj)，链接程序把不同编译单元产生的符号联系起来，构成一个可执行程序
-   简单说，一个编译单元就是一个经过预处理的cpp文件










### 前置声明

-   前置声明只能作为指针或引用，不能定义类的对象，也就不能调用对象中的方法
-   注意如果在类中含有另一个类的引用，要用初始化列表初始化(详见class.md)



```c++
class A;//此处仅仅前置声明，但A未定义，用到A的完整对象或A中函数均会报错
class B {//若class B中没有调用A中的方法，没有A的实体，仅有A的指针或引用可以过编译
	A a;//[Error] field 'a' has incomplete type 'A'//不完整的类型A
	void func(){ a.func();}//[Error] invalid use of incomplete type 'class A'
};

class A {//B中含有一个class A的实例，但是A的定义在后面，故报错
	void func(){}
};

int main() { }
```







---

# 组合composition

> 分层layering, 包含containment, 聚合 aggregation, 植入embedding

组合(composition)是一种类型之间的关系，这种关系当一种类型的对象包含另外一种类型的对象时就会产生

组合即意味着“has a”(应用域)，也意味着“is implemented in terms of”(实现域)



```c++
class Address { ... };      // where someone lives
class PhoneNumber { ... };
class Person {
public:
private:
	std::string name;//has a 的关系
	Address address;
	PhoneNumber voiceNumber;
}; 
```