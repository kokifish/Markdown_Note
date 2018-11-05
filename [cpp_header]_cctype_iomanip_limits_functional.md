[TOC]



---

# cassert



**assert() *宏*  macro**

>    `#include <cassert>`    //C Diagnostics Library  //Diagnostics 诊断
>
>    assert: 断言 声称 宣称 树立 辩护...

-   使用时，在括号中写入自己期望的状态，如果不满足自己的期望状态则终止运行
-   实现：先**计算括号中的表达式**，若真值为假(NULL / 0)，先向**stderr**打印一条出错信息，然后调用 abort 终止程序运行
-   优点：任何系统状态下都可以安全使用的无害测试手段
-   缺点：频繁的调用会极大的影响程序的性能，增加额外的开销
-   warning：为了不在程序的Debug版和Release版引起差别，assert 不应该产生任何副作用。所以assert 不是函数，而是**宏**


```c++
bool func(int* p){
	assert(p != NULL);
}
```






**使用注意事项**

1.  在函数开始处检验传入参数的合法性
2.  每个assert只检验一个条件,因为同时检验多个条件时,如果断言失败,无法直观的判断是哪个条件失败
3.  不能使用改变环境的语句,因为assert只在DEBUG个生效//assert(i++ < 100) 要写成 assert(i < 100); i++;
4.  assert和后面的语句应空一行,以形成逻辑和视觉上的一致感//代码格式
5.  有的地方,assert不能代替条件过滤
6.  使用断言捕捉不应该发生的非法情况。不要混淆非法情况与错误情况之间的区别，后者是必然存在的并且是一定要作出处理的

```c++
#include <stdio.h>//assert() 终止程序运行并打印出错误信息
#include <assert.h>
#include <stdlib.h>
int main( void ){
	FILE *fp;
    
	fp = fopen( "test.txt", "w" );//以可写的方式打开一个文件，如果不存在就创建一个同名文件
	assert( fp );//所以这里不会出错
	fclose( fp );
    
	fp = fopen( "noexitfile.txt", "r" );//以只读的方式打开一个文件，如果不存在就打开文件失败
	assert( fp );//所以这里出错
	fclose( fp );//程序永远都执行不到这里来
}//output：打印错误信息

Assertion failed!

Program: C:\Users\puretea\Desktop\C++.exe
File: C:\Users\puretea\Desktop\C++实验.cpp, Line 13//这里指的是出错的行号

Expression: fp

This application has requested the Runtime to terminate it in an unusual way.
Please contact the application's support team for more information.
```





---

# iostream

cin 是标准输入流对象，即istream类的对象



---

# iomanip

>   manipulator 操纵器

-   IO **Manipulators**  IO**操纵器** 操纵运算子	I/O流控制头文件

    ​


>   有效位数默认是6位，即setprecision(6)小数点前面和小数点后面加起来的位数为6个有效数字(不包括小数点)(注意会四舍五入)
>
>   科学计数法输出E与十六进制输出默认是小写，要换成大写需添加uppercase

```c++
using namespace std;
double PI=3.141592654;
cout << PI << endl;					//3.14159
cout << setprecision(2) << PI << endl;		//3.1
cout << fixed << setprecision(2) << PI << endl;//3.14//fixed+setprecision(n),显示小数点后n位
cout << setfill('*') << setw(20) << setprecision(10) << PI << endl;	
//********3.1415926540//小数点后10个数字
cout << setfill('*') << setw(20) << setprecision(10) << left << PI << endl;
//3.1415926540********//8个'*'
cout << scientific << setprecision(10) << PI << endl;
//3.1415926540e+000 //scientific
cout << scientific << uppercase << setprecision(10) << PI << endl;
//3.1415926540E+000//uppercase作用
cout << showpoint << setprecision(8) << fixed << PI << endl;
//3.14159265//强制显示小数点及小数点后8位

//hex 等效于 setbase(16)
cout << hex << setiosflags (ios::showbase);
//设置16进制表示//显示基底(0x)
cout << 100 << endl;//输出:0x64
cout << resetiosflags (ios::showbase) << 100 << endl;
//复位showbase//输出:64
cout << hex;//设定显示16进制数

cout << setiosflags (std::ios::showbase | std::ios::uppercase);
//同时设定显示数制和大写
cout << showbase << uppercase;//与上一条等价
```



# cctype

-   This header declares a set of functions to classify and transform individual characters.
-   <cctype>声明了一组用于分类和转换单个char的函数
-   C语言版本为<ctype.h>


```cpp
int main() {
	int i = 0;
	string str = "2XxC+ ";
	for (int i = 0; i < str.size(); i++) {
		if (isalnum(str.at(i))) {
			cout << str.at(i) << " is digit or alphabetic" << endl;
		}
		if (isalpha(str.at(i))) {
			cout << str.at(i) << " is alphabetic" << endl;
		}
		if (isdigit(str.at(i))) {
			cout << str.at(i) << " is decimal digit" << endl;
		}
		if (isxdigit(str.at(i))) {
			cout << str.at(i) << " is hexadecimal digit" << endl;
		}
		if (isupper(str.at(i))) {
			cout << str.at(i) << " is upper case alphabetic" << endl;
		}
		if (isblank(str.at(i))) {
			cout << str.at(i) << " is blank" << endl;
		}
	}
}//output:
2 is digit or alphabetic
2 is decimal digit
2 is hexadecimal digit
X is digit or alphabetic
X is alphabetic
X is upper case alphabetic
x is digit or alphabetic
x is alphabetic
C is digit or alphabetic
C is alphabetic
C is hexadecimal digit
C is upper case alphabetic
  is blank
```



###### isalpha

>   int isalpha ( int c );

-   Check if character is alphabetic
-   判断一个char是否是字母


若参数c 为字母，则返回true，否则返回null(0)





isdigit

>   int isdigit ( int c );

-   Check if character is decimal digit
-   判断一个char是否是数字




isxdigit

>   int isxdigit ( int c );

-   Check if character is hexadecimal digit
-   判断一个char是否是十六进制数字(01 2 3 4 5 6 7 8 9 a b c d e f A B C D E F)






###### isalnum

>   int isalnum ( int c );

- Check if character is alphanumeric
- 判断一个char是否是数字或者字母
- A value different from zero (i.e., `true`) if indeed *c* is either a digit or a letter. Zero (i.e., `false`) otherwise.



###### islower

>   int islower ( int c );

-   Check if character is lowercase letter
-   判断一个char是否是小写字母

###### isupper

>   int isupper ( int c );

-   Check if character is uppercase letter
-   判断一个char是否是大写字母

###### isblank

>   int isblank ( int c );

-   Check if character is blank

-   判断一个char是否是空白字符

-   A blank character is a space character used to separate words within a line of text.

    The standard `"C"` locale considers blank characters the tab character (`'\t'`) and the space character (`' '`).

    Other locales may consider blank a different selection of characters, but they must all also be *space characters* by isspace.

```c++
#include <stdio.h>
#include <ctype.h>
int main (){
	char c;
	int i=0;
	char str[]="Example sentence to test isblank\n";
	while (str[i]){
		c=str[i];
		if (isblank(c))  c='\n';//判断一个char是否是空白字符，是则替换为\n
		putchar (c);
		i++;
		}
	return 0;
}/*output:
Example
sentence
to
test
isblank */
```



###### 空白字符 blank

-   A blank character is a space character used to separate words within a line of text.
-   The standard `"C"` locale considers blank characters the **tab** character (`'\t'`) and the **space** character (`' '`).





###### tolower

>   int tolower ( int c );

-   Convert uppercase letter to lowercase
-   将一个大写字母转换成小写字母
-   Converts *c* to its lowercase equivalent if *c* is an uppercase letter and has a lowercase equivalent. If no such conversion is possible, the value returned is *c* unchanged.


toupper

-   类比tolower






### 函数返回true的对照表



![](http://op4fcrj8y.bkt.clouddn.com/17-12-6/37695940.jpg)







---

# limits

>   Provides information about the properties of arithmetic types (either integral or floating-point) in the specific platform for which the library compiles.
>
>   提供有关库编译的，在特定平台上算数类型(整形/浮点)的属性信息
>
>   注意仅对基本算数类型fundamental arithmetic type有效，其它类型是无效的



```c++
#include <limits>
#include <iostream>
using namespace std;
int main () {
	cout << boolalpha;
	cout << "max(short): " << numeric_limits<short>::max () << endl;
	cout << "min(short): " << numeric_limits<short>::min () << endl;
	cout << "max(int): " << numeric_limits<int>::max () << endl;
	cout << "min(int): " << numeric_limits<int>::min () << endl;
	cout << "max(long): " << numeric_limits<long>::max () << endl;
	cout << "min(long): " << numeric_limits<long>::min () << endl;
	cout << "max(long long): " << numeric_limits<long long>::max () << endl;
	cout << "min(long long): " << numeric_limits<long long>::min () << endl;
	cout << endl;
	cout << "max(float): " << numeric_limits<float>::max () << endl;
	cout << "min(float): " << numeric_limits<float>::min () << endl;
	//min返回的是浮点型别可以表示的最小的正值
	cout << "max(double): " << numeric_limits<double>::max () << endl;
	cout << "min(double): " << numeric_limits<double>::min () << endl;
	cout << "max(long double): " << numeric_limits<long double>::max () << endl;
	cout << "min(long double): " << numeric_limits<long double>::min () << endl;
	cout << endl;
	cout << "is_signed(char): "
		<< numeric_limits<char>::is_signed << endl;
	cout << "is_specialized(string): "
		<< numeric_limits<string>::is_specialized << endl;
}//output:
max(short): 32767
min(short): -32768
max(int): 2147483647
min(int): -2147483648
max(long): 2147483647
min(long): -2147483648
max(long long): 9223372036854775807
min(long long): -9223372036854775808

max(float): 3.40282e+38
min(float): 1.17549e-38//min返回的是float型别可以表示的最小的正值
max(double): 1.79769e+308
min(double): 2.22507e-308//min返回的是double型别可以表示的最小的正值
max(long double): 1.79769e+308
min(long double): 2.22507e-308

is_signed(char): true
is_specialized(string): false
```









------

# functional

- *Function objects* are objects specifically designed to be used with a syntax similar to that of functions. In C++, this is achieved by defining member function `operator()` in their class
- 函数对象是专门设计来模仿函数行为的对象

```cpp
#include <iostream>// std::cout
#include <functional>// std::greater
#include <algorithm>// std::sort
#include <vector>
#include <queue>
#include <list>

using namespace std;

int main() {
	//创建一个从小到大的优先队列
	priority_queue<int, std::vector<int>, std::greater<int> > q1;
	int arr[5] = { 2,4,5,1,3 };
	//用greater<int>作为sort的对比函数
	std::sort(arr, arr + 5, std::greater<int>());//5 4 3 2 1
	for (int i = 0; i < 5; i++)
		std::cout << arr[i] << ' ';
	std::cout << endl;

	system("PAUSE");
	return 0;
}
```








