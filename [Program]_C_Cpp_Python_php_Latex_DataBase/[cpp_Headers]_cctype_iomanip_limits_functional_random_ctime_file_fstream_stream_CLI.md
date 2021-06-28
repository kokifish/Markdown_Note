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





[TOC]





---

# \<random\>





### uniform_real_distribution

- 均匀分布 一致分布 实数版

```cpp
int main() {
    const int nrolls = 10000;   // number of experiments
    const int nstars = 95;      // maximum number of stars to distribute
    const int nintervals = 10;  // number of intervals

    default_random_engine generator;
    uniform_real_distribution<double> distribution(0.0, 1.0);

    int p[nintervals] = {};

    for (int i = 0; i < nrolls; ++i) {
        double number = distribution(generator);
        ++p[int(nintervals * number)];
    }

    cout << "uniform_real_distribution (0.0,1.0):" << endl << fixed;
    cout.precision(1);

    for (int i = 0; i < nintervals; ++i) {
        cout << float(i) / nintervals << "-" << float(i + 1) / nintervals
             << ": ";
        cout << string(p[i] * nstars / nrolls, '*') << endl;
    }
}//
uniform_real_distribution (0.0,1.0):
0.0-0.1: *********
0.1-0.2: *********
0.2-0.3: *********
0.3-0.4: *********
0.4-0.5: *********
0.5-0.6: *********
0.6-0.7: *********
0.7-0.8: *********
0.8-0.9: *********
0.9-1.0: *********
```





### normal_distribution

- 正态分布

```cpp
std::default_random_engine generator;
std::normal_distribution<double> distribution(mean, stddev);
double number = distribution(generator);
```



---

# ctime



#### time()



```cpp
	time_t now;
	time(&now);//get current time; same as: 
	now = time(NULL);
```





#### clock

-   Returns the processor time consumed by the program. 返回当前的CPU时间
-   To calculate the actual processing time of a program, the value returned by clock shall be compared to a value returned by a previous call to the same function.
-   若要计算程序实际的执行时间，返回值需要和之前调用同一函数的返回值进行比较

```cpp
#include <stdio.h>//printf
#include <time.h>//clock_t, clock, CLOCKS_PER_SEC
#include <math.h>//sqrt

int frequency_of_primes(int n) {//计算小于等于n的素数的数量
	int i, j;
	int freq = n - 1;
	for (i = 2; i <= n; ++i) {
		for (j = sqrt(i); j > 1; --j) {
			if (i%j == 0) {
				--freq;
				break;
			}
		}
	}
	return freq;
}

int main() {
	clock_t t;
	int f;
	t = clock();//记录初始CPU时间
	printf("Calculating...\n");
	f = frequency_of_primes(99999);//计算小于100000的素数的数量
	printf("The number of primes lower than 100,000 is: %d\n", f);
	t = clock() - t;//计算CPU时间差值
	printf("It took me %d clicks (%f seconds).\n", t, ((float)t) / CLOCKS_PER_SEC);
}//possible output:
Calculating...
The number of primes lower than 100,000 is: 9592
It took me 61 clicks (0.061000 seconds).
```





#### struct tm

```cpp
struct tm {
	int tm_sec;//秒 – 取值区间为[0,59]
	int tm_min;//分 - 取值区间为[0,59]
	int tm_hour;//时 - 取值区间为[0,23]
	int tm_mday;//一个月中的日期 - 取值区间为[1,31]
	int tm_mon;//月份（从一月开始，0代表一月） - 取值区间为[0,11]
	int tm_year;//年份，其值等于实际年份减去1900
	int tm_wday;//星期 – 取值区间为[0,6]，其中0代表星期天，1代表星期一，以此类推
	int tm_yday;//从每年的1月1日开始的天数 – 取值区间为[0,365]，其中0代表1月1日，1代表1月2日，以此类推
	int tm_isdst; //夏令时标识符，实行夏令时的时候，tm_isdst为正。不实行夏令时的时候，tm_isdst为0；不了解情况时，tm_isdst()为负
	long int tm_gmtoff;//指定了日期变更线东面时区中UTC东部时区正秒数或UTC西部时区的负秒数
	const char *tm_zone;//当前时区的名字(与环境变量TZ有关)
};
```





#### difftime

-   double difftime (time_t end, time_t beginning);

-   返回前者时间-后者时间相差的秒数

```cpp
#include <cstdio>
#include <ctime>//time_t, struct tm, difftime, time, mktime
int main() {
	time_t now;
	struct tm newyear;
	double seconds;
	time(&now);  //get current time; same as: now = time(NULL)
	newyear = *localtime(&now);
	newyear.tm_hour = 0; newyear.tm_min = 0; newyear.tm_sec = 0;
	newyear.tm_mon = 0;  newyear.tm_mday = 1;
	seconds = difftime(now, mktime(&newyear));
	printf("%.f seconds since new year.\n", seconds);
}//possible output:24231037 seconds since new year.
```

---

# 文件和流

>   需包含头文件 <iostream> 和 <fstream>







- ofstream该数据类型表示输出文件流，用于创建文件并向文件写入信息
- ifstream 该数据类型表示输入文件流，用于从文件读取信息
- fstream 该数据类型通常表示文件流，且同时具有 ofstream 和 ifstream 两种功能，这意味着它可以创建文件，向文件写入信息，从文件读取信息
- `ifstream`和`istringstream`是从`istream`中继承来的，继承保证我们在使用`ifstream`和`istringstream`时好像在使用`istream`(`cin`)一样






```cpp
int main () {
	std::fstream file_stream;
	file_stream.open ("test.txt", std::fstream::in | std::fstream::out | std::fstream::app);
	if (file_stream.is_open()){
		std::cout << "fs.open successfully \n";
	}else{
		std::cout << "Error opening file";
	}
	stringstream ss_file_buffer;
	ss_file_buffer << file_stream.rdbuf();
	string s_file_content = ss_file_buffer.str();

	file_stream << " more lorem ipsum";//将输出到file_stream对应的文件中
	file_stream.close();
}
```



#### read

> istream& read (char* s, streamsize n);

- Read block of data
- Extracts n characters from the stream and stores them in the array pointed to by s.


```c++
// read a file into memory
#include <iostream>     // std::cout
#include <fstream>      // std::ifstream

int main () {
	std::ifstream is ("test.txt", std::ifstream::binary);
	if (is) {
		is.seekg (0, is.end);
		int length = is.tellg();// get length of file
		is.seekg (0, is.beg);

		char * buffer = new char [length];

		std::cout << "Reading " << length << " characters... ";
		// read data as a block:
		is.read (buffer,length);//buffer contains the entire file

		if (is)
			std::cout << "all characters read successfully.";
		else
			std::cout << "error: only " << is.gcount() << " could be read";

		is.close();
		delete[] buffer;
	}
}//output:
Reading 640 characters... all characters read successfully.
```

> http://www.cplusplus.com/reference/istream/istream/read/



#### rdbuf



```cpp
#include <iostream>//#include <fstream>#include <sstream>#include <string>using namespace std;int main (){	string file_name("test.txt");//file name	fstream file_stream;	file_stream.open(file_name, std::fstream::in);//以仅输入打开文件	if(!file_stream.is_open()){//if open file end		cout << "Error opening file!" << endl;		return;	}	stringstream ss_file_buffer;	ss_file_buffer << file_stream.rdbuf();	string file_content = ss_file_buffer.str();	cout << file_content << endl;	file_stream.close();//file close}
```















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
ref class X abstract : B1, B2 { // ok, can only be the keyword	int abstract;//ok, just another identifier};class abstract { };//ok, just another identifiernamespace abstract { /*...*/ }// ok, just another identifier
```









###### ref class

Basically, a `ref class` is a CLR class. It's the equivalent of `class` in C#

> 需设置公共语言运行时支持 (/clr)    属于c++/CLI范畴

The `ref` keyword tells the compiler that the class or structure will be allocated on the heap(堆) and a reference to it will be passed to functions or stored in class members. The `value` keyword tells the compiler that all of the data in the class or structure is passed to functions or stored in members.







