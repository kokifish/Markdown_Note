

[TOC]







---

# 异常处理 Exceptions

-   Exceptions(例外.异常) provide a way to react to **exceptional circumstances**(例外/特殊情况) (like runtime errors) in programs by **transferring control**(控制转移) to special functions called **handlers**(处理程序/管理者).

-   c++的一项语言机制，用于程序处理异常事件



```c++
// exceptions
#include <iostream>
using namespace std;

int main () {
	try{			//try-block 保护代码块
		throw 20;	//exception is thrown 异常被抛出
	}
	catch (int e){	//exception handlers 异常处理程序
		cout << "An exception occurred. Exception Nr. " << e << '\n';
	}
	return 0;
}
```











### keyword 关键字



###### try

-   To catch exceptions(捕获异常), a portion of code is placed under **exception inspection**(异常检查). This is done by enclosing that portion of code in a **try-block**.


###### throw

-   When an exceptional circumstance(异常情况) arises within try-block, an exception is thrown that transfers the control(转移控制) to the **exception handler**(异常处理程序). 
-   If no exception is thrown, the code continues normally and all handlers are ignored.
-   如果没有异常被抛出，代码继续执行，异常处理程序将被忽略。
-   A `throw` expression **accepts one parameter** (in the case above the integer value `20`)
-   throw表达式接受一个参数(上例中为整数值20 )


###### catch

-   Exception handlers are declared with the keyword catch, which must be placed immediately after the try block.
-   异常处理程序用关键字 catch 声明，它必须在try块之后立即放置
-   一个 try-block 后可以跟多个 catch block




catch没有捕获到匹配的异常的时候，会调用默认的终止函数。可以调用set_terminate()来设置终止函数，参数是一个函数指针，类型是：void (*terminate)()







### demo 和常见错误

- 注意抛出字符串常量时要用   **const char\***  的参数类型来 catch，否则报错

  >   DEV中用 char\* 接收异常时会报错: (VS正常运行)
  >
  >   terminate called after throwing an instance of 'char const*'
  >
  >   ​
  >
  >   This application has requested the Runtime to terminate it in an unusual way.
  >
  >   Please contact the application's support team for more information.


```c++
#include <iostream>

double division(int a, int b){//该函数将会在 try 模块中执行 
	if( b == 0 ){		//当尝试除以0的时候，throw 抛出异常 
		throw "Division by zero condition!";
	}
	return (a/b);
}

int main (){
	int x = 50, y = 0;
	double z = 0;
	try {		//try 模块执行保护代码(division函数和输出结果) 
		z = division(x, y);
		std::cout << z << std::endl;
	}
	catch (const char* msg) {	//catch 住 throw 抛出的异常，注意参数要一致 
		std::cerr << msg << std::endl;//用 cerr 输出异常
	}
}
```





# exception

>  `std::exception` defined in the `<exception>` header.
>
>  ​	This class has a virtual member function called `what` that returns a null-terminated character sequence (of type `char *`) and that can be overwritten in derived classes to contain some sort of description of the exception.

How many types of guarantees are there in exception class can have?3
Explanation:There are three types of guarantees in c++. They are weak, strong and no-throw.



```c++
// using standard exceptions
#include <iostream>
#include <exception>
using namespace std;
class myexception : public exception {//throw()向编译器保证不会抛出异常
	virtual const char* what() const throw() {
		return "My exception happened";
	}
} myex;//定义了一个myexception对象myex

int main() {
	try { throw myex; }
	catch (exception& e) {
		cout << e.what() << '\n';
	}
}//Output:
My exception happened
```



- `throw()` - this function is not expected to throw any exceptions. If it does, `unexpected` will be called.





###### what

- Exception safety: No-throw guarantee:  this member function never throws exceptions.This also applies to all derived classes within the C++ standard library.

```c++
virtual const char* what() const noexcept;//返回char*
```



### runtime_error

> <stdexcept>

继承于exception，是range_error, overflow_error, underflow_error, system_error的直接基类。

![](http://op4fcrj8y.bkt.clouddn.com/17-6-9/86541374.jpg)

```c++
class runtime_error : public exception {//从exception继承了what()
public://继承runtime_error时一定要写构造函数，一定要传参
	explicit runtime_error (const string& what_arg);
	explicit runtime_error (const char* what_arg);
};
```





### logic_error

> <stdexcept>

![](http://op4fcrj8y.bkt.clouddn.com/17-6-9/51506949.jpg)





---

# 命名空间 namespace

>   namespace: 命名空间/名字空间/名称空间/名域

-   C++语言中，命名空间是一种实体(**entity**)，用namespace来声明，用{ }来界定命名空间体
-   Namespaces provide a method for preventing name conflicts in large projects.
-   namespace 表示着一个标识符(identifier)的可见范围。**避免标识符的命名发生冲突**。以更好地控制标识符的作用域
-   **一个标识符可在多个命名空间中定义**，它在不同命名空间中的含义是**互不相干**的
-   name(名称): 符号常量、变量、宏、函数、结构、枚举、类和对象等等
-   一种描述逻辑分组的机制。可以将按某些标准在逻辑上属于同一个集团的声明放在同一个命名空间中
-   命名空间可以是**全局**的，也可以**位于另一个命名空间之中**，但是不能位于类和代码块中。所以，在命名空间中声明的名称（标识符），默认具有外部链接特性（除非它引用了常量）。（除非声明的是 `const` 对象，它默认是具有内部链接属性）
-   标准C++库（不包括标准C库）中所包含的所有内容（包括常量、变量、结构、类和函数等）都被定义在命名空间**`std`**（standard标准）中了








---

### 作用域 scope



>   声明域declaration region  >  潜在作用域potential scope  >  作用域scope

1.  声明域: declaration region 声明标识符的区域
  如在函数外面声明的全局变量，它的声明域为声明所在的文件。在函数内声明的局部变量，它的声明域为声明所在的代码块（例如整个函数体或整个复合语句）
2.  潜在作用域: potential scope 从声明点开始，到声明域的末尾的区域
  因为C++采用的是先声明后使用的原则，所以在声明点之前的声明域中，标识符是不能用的。即，标识符的潜在作用域，一般会小于其声明域
3.  作用域: scope 标识符对程序可见的范围
  标识符在其潜在作用域内，并非在任何地方都是可见的。例如，局部变量可以屏蔽全局变量、嵌套层次中的内层变量可以屏蔽外层变量，从而被屏蔽的全局或外层变量在其倍屏蔽的区域内是不可见的。所以，一个标识符的作用域可能小于其潜在作用域


---

### 变量屏蔽

-   在一个函数中，如果有和外部变量重名的变量，则外部变量被屏蔽

```c++
int a=10;		//外部变量
int main(){
	int a=1;	//局部变量
	printf("%d", a);//输出为1，外部变量的a被局部变量的a屏蔽了
}			//c++语言可用::a访问外部变量的a
```





---

### 命名空间定义与声明

-   声明一个命名空间时，命名空间内可以包含变量(可初始化)、常量、结构体、类、模版、命名空间
-   命名空间**可以嵌套**。嵌套的子命名空间必须定义在上层命名空间体之内。禁止把子命名空间的声明与定义分开
-   命名空间内不能包含命令行 #include 

```c++
#include <vector>
namespace vec {	//有名命名空间
	template< typename T >
	class vector {
		// ...
	};
}

int main(){
	std::vector<int> v1; //Standard vector.
	vec::vector<int> v2; //User defined vector.
	//由于v1和v2出自不同命名空间中的vector，故类型不一样
	v1 = v2; //Error: v1 and v2 are different object's type.
 	{
		using namespace std;//此语句仅在当前代码块中有作用
		vector<int> v3;		//Same as std::vector
		v1 = v3;			//OK
	}
 	{
		using vec::vector;	//指明使用vec命名空间中的vector
		vector<int> v4;		//Same as vec::vector
		v2 = v4;			//OK
	}
	return 0;
}
```





###### 命名空间的开放性

-   命名空间是开放的，即可以随时把新的成员名称加入到已有的命名空间之中去。允许**多次声明和定义同一命名空间**，每次都将添加新的成员，但属于同一实体
-   不允许直接使用“ 命名空间名::成员名 ... ”的方法为命名空间添加成员

```c++
//多次定义同一个命名空间A，多次定义后仍然是同一实体
namespace A {
	int i;
	void f();
}// 现在A有成员i和f()

namespace A {//namespace A的再次定义
	int j;
	void g();
}// 现在A有成员i f() 以及 j g()
```









###### 有名命名空间

>   有名命名空间 Named namespace
>
>   Named namespace definition for the namespace ns_name.
>
>   **namespace** ns_name { declarations }











###### 匿名命名空间

>   匿名命名空间 Unnamed namespace
>
>   Inline namespace definition for the namespace ns_name. Declarations inside ns_name will be visible in its enclosing namespace.
>
>   定义方式: **namespace** { declarations }
>
>   匿名命名空间中的名字具有文件作用域。这些名字在本编译单元中可以直接使用；也可以用前缀为::的qualified-id显式限定后使用。匿名命名空间中的名字具有内部链接属性



```c++
namespace {// Unnamed namespace
	int i;  // defines ::(unique)::i
}
void f() {
	i++;  // increments ::(unique)::i
}
 
namespace A {
	namespace {
		int i; // A::(unique)::i
		int j; // A::(unique)::j
	}
	void g() { i++; } // A::unique::i++
}
 
using namespace A; // introduces all names from A into global namespace
void h() {
	i++;    // error: ::(unique)::i and ::A::(unique)::i are both in scope
	A::i++; // ok, increments ::A::(unique)::i
	j++;    // ok, increments ::A::(unique)::j
}
```













### 引用命名空间的成员

-   using 指令可以用来指定引用命名空间中的特定项目
-   随后的代码中，在使用已引用的特定项目时就可以不用加上命名空间前缀
-   但是调用其它未引用的对象时，仍需要命名空间前缀说明所在命名空间

```c++
#include <iostream>
using std::cout;//只打算使用 std 命名空间中的 cout 部分 
int main (){
	cout << "std::endl is used with std!" << std::endl;
	//std命名空间中的其他项目(如 endl )仍然需要加上命名空间名称作为前缀
	return 0;
}
```

























---

# const

-   默认状态下，const对象仅在**文件内有效**
-   多个文件中出现了同名const变量时，等同于不同文件分别定义了独立的变量
-   extern可压制const的内部连接属性，想在多个文件之间共享const对象，必须在变量定义之前添加extern关键字




尽可能使用const

1. const可以避免无意中修改数据的编程错误
2. const使函数能够处理const和非const实参，否则将只能接受非const数据
3. const引用使函数能够正确生成并使用临时变量




### const 变量

-   编译过程中会把const变量都替换成对应的值，如下例

```c++
const int bufSize = 512;
```

-   编译器会把用到该变量bufSize的地方都替换成512



-   为能够在多个文件中声明并使用，可以对const变量不管声明还是定义都添加extern关键字

```c++
//file_1.cc 定义并初始化了一个常量，该常量可被其它文件访问
extern const int a = func();//包含初始值显然是个定义
//file_1.h头文件
extern const int a;//与file_1.cc 中定义的是同一个a
```



### const 成员函数

>   详情见class的.md文件

-   不允许修改类的数据成员。若类中包含指针，可以通过指针修改指向的数据。
-   声明与定义都需要在参数列表后加`const`








### const 引用

-   把引用绑定到const对象上称之为对常量的引用(reference to const)

```c++
const int a = 1024;
const int &ref = a;//正确，引用及其对应的对象都是常量//缺少const则报错
ref = 42;//错误：ref是对常量的引用
int &ref2 = a;//错误：不允许非常量引用指向常量对象
```

>   "对const的引用"可简称为"常量引用"





---

#mutable

-   **mutable** - applies to non-static [class members](http://en.cppreference.com/w/cpp/language/data_members) of non-reference non-const type and specifies that the member does not affect the externally visible state of the class (as often used for mutexes, memo caches, lazy evaluation, and access instrumentation). `mutable` members of *const* class instances are modifiable. (Note: the C++ language grammar treats `mutable` as a [storage-class-specifier](http://en.cppreference.com/w/cpp/language/storage_duration), but it does not affect storage class.)

>   C++11标准-Storage Class Specifiers :是声明语法的一部分;指定了标识符2个独立的属性: storage duration(存储生命周期); linkage;

-   用mutable修饰成员变量，可以使该成员变量即使在const成员函数中也能被修改



---

# extern

-   extern可压制const的内部连接属性
-   extern可以置于变量或者函数前，以标示变量或者函数的定义在别的文件中，提示编译器遇到此变量和函数时在其他模块中寻找其定义
-   如果函数的声明中带有关键字extern，仅仅是暗示这个函数可能在别的源文件里定义，没有其它作用
-   当函数提供方单方面修改函数原型时，如果使用方不知情继续沿用原来的extern申明，这样编译时编译器不会报错。但是在运行过程中，因为少了或者多了输入参数，往往会照成系统错误。通常的做法是提供方在自己的xxx_pub.h中提供对外部接口的声明，然后调用方include该头文件，从而省去extern这一步。以避免这种错误
-   C++语言在编译的时候为了解决函数的多态问题，会将函数名和参数联合起来生成一个中间的函数名称，而C语言则不会，因此会造成链接时找不到对应函数的情况，此时C函数就需要用extern C进行链接指定

###### const extern联合修饰

-   C++规定，**有const修饰的变量，不但不可修改，还都将具有内部链接属性**，也就是只在本文件可见(这是原来C语言的static修饰字的功能，现在const也有这个功能了)
-   又补充规定,extern const联合修饰时，extern将压制const这个内部链接属性
-   extern char const s[]将仍然有外部链接属性，但是还是不可修改的
-   具体使用方法如下:



```c++
//在cpp文件中:
extern const int a = 1;

//在要使用该常量的另一cpp文件中:
extern const int a;	//也可以将其放到头文件中
cout << a << endl;
```



-   当用extern修饰const变量将强制为其分配内存，因为extern表示采用外部链接，因此其必须有某个地址保存其值




---

# static





### static 全局变量

-   非静态全局变量为静态存储方式，静态全局变量也是静态存储方式，存储方式没有区别
-   非静态全局变量的作用域是整个源程序，在源程序中的多个源文件中都有效(extern获取)
-   静态全局变量只初始化一次，并限制了作用域，防止在其它文件单元中被引用。仅在定义该变量的源文件内有效，只能为该源文件内的函数使用，同一源程序的其它源文件中无法使用



### static局部变量

-   static局部变量只被初始化一次，下次依据上次的值







### static函数

>   further in class .md

-   static函数在内存中只有一份，普通函数在每个调用中维持一份拷贝





