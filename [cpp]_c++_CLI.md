[TOC]



---

# c++ / CLI



公共语言运行时





### Outright reserved words

> Outright reserved words 直接保留字

gcnew   generic   nullptr(截至2003)

直接保留字较少，其余关键字是与标识符无关的上下文关键字



### Spaced keywords

间距关键字

- for each
- enum class/struct
- interface class/struct
- ref class/struct
- value class/struct

实现技术：指定一些关键字(包括嵌入式空白embedded whitespace)，由于c++程序无法创建包含空格字符的标识符，故此方法可行

### Contextual keywords

Contextual keywords that can never appear where an identifier could appear.

上下文关键字

abstract    finally    in    override    sealed    where

在原有语法中，不能出现任何东西的位置，定义一些关键字。由于在这种关键字出现的地方不会出现标识符，故两者不冲突

```c++
ref class X abstract : B1, B2 { // ok, can only be the keyword
	int abstract;//ok, just another identifier
};
class abstract { };//ok, just another identifier
namespace abstract { /*...*/ }// ok, just another identifier
```















###### ref class

Basically, a `ref class` is a CLR class. It's the equivalent of `class` in C#

> 需设置公共语言运行时支持 (/clr)    属于c++/CLI范畴

The `ref` keyword tells the compiler that the class or structure will be allocated on the heap(堆) and a reference to it will be passed to functions or stored in class members. The `value` keyword tells the compiler that all of the data in the class or structure is passed to functions or stored in members.