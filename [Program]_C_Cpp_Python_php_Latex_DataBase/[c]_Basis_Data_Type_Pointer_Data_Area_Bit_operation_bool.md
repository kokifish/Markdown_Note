[TOC]





For the following code snippet(片段):

char \*str = "Sanfoundry.com\0″ "training classes";
The character pointer str holds reference to string:

a) Sanfoundry.com
b) Sanfoundry.com\0training classes
c) Sanfoundry.comtraining classes
d) Invalid declaration
Answer:b
Explanation:'\0′ is accepted as a char in the string. Even though strlen(字符长度) will give length of string “Sanfoundry.com”, in memory str is pointing to entire string including training classes”

-   Foobar  在计算机程序设计与计算机技术的相关文档中，术语foo, bar是一个常见的无名氏化名，常被作为“伪变量”使用
-   const const int i 将被当作 const int i 处理
-   snippet(片段)

---

# 数据类型 data type



---

###### 标识符命名规则

>   Syntax for Identifiers

-   An identifier must consist only of letters, digits and underscore. And must begin with a letters or a underscore.
-   由下划线_ 数字，大小写字母组成。第一个不能是数字
-   valid: _3a  str  Acat                 NOT valid: $main  3kill
-   不可以是32个保留字中的任意一个（Reserved word保留字全为小写） case-sensitive大小写敏感




-   In the above example, the identifiers global_variable and extern_variable are external names. external names、外部名称、全局变量，最多31个characters
-   local_variable is an internal name. internal name、内部名称、局部变量,最多63个characters

```c
int global_variable;		//外部/全局变量 至多31字符

int main(void){
    int local_variable;		//局部变量 至多63字符
    extern int extern_variable;	//外部/全局变量 至多31字符
    return 0;
}
```





---

###### C关键字Reserved word

auto break case char const continue default do 
double else enum extern float for goto if int long register return short signed sizeof static 
struct switch typedef union unsigned void volatile while
ISO C99标准:
inline restrict \_Bool\_Complex	\_Imaginary
ISO C语言的新标准C11:
\_Alignas \_Alignof \_Atomic \_Static_assert \_Noreturn \_Thread_local \_Generic



△数据类型关键字：Reserved word 保留字，关键字

-   基本数据类型：void  char  int  float  double
-   类型修饰：short  long  signed  unsigned
-   复杂类型：struct(结构体) union(共用体)  enum(枚举)  typedef  sizeof
-   存储级别：auto  atatic  register const volatile

△流程控制关键字

-   跳转结构：return continue break goto
-   分支结构：if  else  switch  case  default
-   循环结构：for  do  while



---

### 基础数据类型

符号属性    长度属性  基本型  所占位数(bit)  取值范围     输入符举例            输出符举例
--             --      char     8        -2^7 ~ 2^7-1      %c                 %c、%d、%u
signed         --      char     8        -2^7 ~ 2^7-1      %c                 %c、%d、%u
unsigned       --      char     8         0 ~ 2^8-1        %c                 %c、%d、%u
[signed]     short    [int]     16       -2^15 ~ 2^15-1    %hd
unsigned     short    [int]     16       0 ~ 2^16-1        %hu、%ho、%hx
[signed]      --       int      32       -2^31 ~ 2^31-1    %d
unsigned      --      [int]     32       0 ~ 2^32-1        %u、%o、%x
[signed]     long     [int]     32       -2^31 ~ 2^31-1    %ld
unsigned     long     [int]     32      0 ~ 2^32-1         %lu、%lo、%lx
[signed]   long long  [int]     64      -2^63 ~ 2^63-1     %I64d %lld %I64d
unsigned   long long  [int]     64      0 ~ 2^64-1         %I64u、%I64o、%I64x
  --         --       float     32      +/- 3.40282e+038   %f、%e、%g
  --         --       double    64      +/- 1.79769e+308   %lf、%le、%lg %f、%e、%g
  --        long      double    96      +/- 1.79769e+308   %Lf、%Le、%Lg





---

char

1字节 8bit [-128,127]

---

short(int)

2字节 16bit  -32768 to 32767   3.2万   -2^15 ~ 2^15-1   qualifier修饰语,限定符/词/句



---

int

-   4字节(32位系统)32bit -2,147,483,648 to 2,147,483,647 (9-10位)  21.5亿   -2^31 ~ 2^31-1
-   一般32位计算机中 long 和 int 等同

---

long

4字节 32bit  -2,147,483,648 to 2,147,483,647  21.5亿   -2^31 ~ 2^31-1
一般32位计算机中 long 和 int 等同

---

longlong

-   8字节 64bit      -2^63 ~ 2^63-1

---

float

-   4字节 32bit  有效位 6~7位(尾数：2^23==8.3E6)   	-3.4E38 ~ 3.4E38
  -   指数符占1位二进制，表示指数的正负。指数存指数的有效数字。
  -   尾数表示浮点数有效数字，0.xxxxxxx,但不存开头的0和点 23bit


//指数占多少位，尾数占多少位，由计算机系统决定
符号Sign(高地址)指数Exponent			尾数Mantissa (低地址)
1 bit		8 bit				23 bit
数符（+-）	-127~128 指数（决定范围）	小数部分（决定精度）
0为正 1为负	阶码:真值(实际值)+127=存储值	前面省略了1. 只存了小数点后的数的二进制数
--- e.g.
0.5的二进制形式为0.1，由于规定正数部分必须为1，将小数点右移1位，则为1.0\*2^(-1)，其阶码为-1+127=126，表示为01111110，而尾数1.0去掉整数部分为0，补齐0到23位00000000000000000000000，则其二进制表示形式为

符号位Sign       阶码Exponent          尾数Mantissa
0                       01111110                  00000000000000000000000
1bit                    8bit                             23bit
符号位：	0表示正，1表示负
阶码：	这里阶码采用移码表示，对于float型数据其规定偏置量为127,阶码有正有负，对于8位二进制，则其表示范围为-127 ~ 128，比如对于float型数据，若阶码的真实值为2，则加上127后为129，其阶码表示形式为10000010
尾数:	有效数字位，即部分二进制位(小数点后面的二进制位)，因为规定M的整数部分恒为1，所以这个1就不进行存储了

保留三位小数 第四位四舍五入 demo ---//输出时用%.3f 输出就可以实现四舍五入了←_←

```c
float x=12.34567;
float y=((int)(x*1000+0.5))/1000.0;
```



---

double

8字节 64bit   有效数字 15~16位(尾数52位，2^52=4.5E15，15位，有效位数是15位)

-1.7E308 — 1.7E308

63   		62-52  		51-0
符号位    	阶码                 尾数
1 bit		11 bit		52 bit

对于double型数据情况类似，只不过其阶码为11位，偏置量为1023，尾数为52位。其表示范围为-1023 ~ 1024。

---

long double

8 - 16字节 64 - 128bit  有效位 18~19位  -1.2*10^-4932~1.2*10^4932



---

size_t

-   std::size_t 是 sizeof 和 alignof操作符返回的一种**无符号整数类型**
-   **std::size_t** can store the maximum size of a theoretically possible object of any type (including array).
-   size_t 可以存放下理论上可能存在的**对象的最大大小**(该对象可以是任何类型，包括数组)
-   使用size_t可能会提高代码的可移植性、有效性或者可读性，或许同时提高这三者
-   size_t类型是一个类型定义，通常将一些无符号的整形定义为size_t，比如说unsigned int或者unsigned long，甚至unsigned long long。每一个标准C实现应该选择足够大的无符号整形来代表该平台上最大可能出现的对象大小
-   size_t的定义在<stddef.h>, <stdio.h>, <stdlib.h>, <string.h>, <time.h>, <wchar.h>中，也在相应的C++头文件中 <cstddef> <cstdio> <cstdlib> <cstring> <ctime> <cwchar>
-   包含以上任何C头文件（由C或C++编译的程序）表明将size_t作为**全局关键字**。包含以上任何C++头文件（当你只能在C++中做某种操作时）表明将size_t作为**std命名空间的成员**
-   在许多平台上（使用分段寻址的系统除外），std::size_t 可以存放下任何非成员的指针，此时可以视作其与 std::uintptr_t 同义
-   std::size_t 通常被用于数组索引和循环计数。使用其它类型来进行数组索引操作的程序可能会在某些情况下出错，例如在 64 位系统中使用 unsigned int 进行索引时，如果索引号超过 UINT_MAX 或者依赖于 32 位取模运算的话，程序就会出错。
-   在对诸如 std::string、std::vector 等 C++ 容器进行索引操作时，正确的类型是该容器的成员 typedef size_type，而该类型通常被定义为与 std::size_t 相同


```c++
#include <cstddef>
int main(){
	const std::size_t N = 100;
	int* a = new int[N];
	for(std::size_t n = 0; n<N; ++n)
		a[n] = n;
	delete[] a;
}
```





###### 常量

常量可分为：
1、直接常量：10，23.0f，234ll等。
2、符号常量：分两种，宏定义和const语句定义的符号常量
```c
#define PI 3.14     
const float PI=3.14;
```



###### 隐式类型转换

char,short --> int --> unsigned --> long --> double <-- float






### 数组 字符数组 字符串

-   一组具有相同类型的数据的集合，在内存中的地址连续
-   第一维长度可以不写，其它维必须写//int a\[2\]\[\]非法 //int a[][3]合法
-   有'\0'为字符串，没有'\0'是字符数组

```c
//字符数组 没有'\0'
char a[] = {‘A’,’B’,’C’}
//字符串 有'\0'
char a[] = “abcd”
char a[] = {“abcd”}//后面自动添加'\0'
//------------------------------------
char b[]={‘a’,’b’,’c’}
sizeof(b)//为3，strlen无法确定，因为后面不会添加'\0'
char a[]="abc"//sizeof是3+1，strlen是3，字符串能好好输出
//若中括号写3 sizeof是3，strlen不确定，字符串无法正常输出
//大部分编译程序 在编译的时候就把sizeof计算过了 是类型或是变量的长度
char str[20]="0123456789";
int a=strlen(str); //a=10;
int b=sizeof(str); //b=20;
```

在C语言中，二维数组是按行排列的。即，先存放a[0]行，再存放a[1]行，最后存放a[2]行。每行中有四个元素也是依次存放。由于数组a说明为int类型，该类型占四个字节的内存空间，所以每个元素均占有四个字节

在C语言中规定，数组名就代表了该数组的首地址。整个数组是以首地址开头的一块连续的内存单元。如有字符数组char c[10]，设数组c的首地址为2000，也就是说c[0]单元地址为2000。则数组名c就代表这个首地址。因此在c前面不能再加地址运算符&。如写作scanf("%s",&c);则是错误的。在执行函数printf("%s",c) 时，按数组名c找到首地址，然后逐个输出数组中各个字符直到遇到字符串终止标志'\0'为止

对一个字符数组，如果不作初始化赋值，则必须说明数组长度。还应该特别注意的是，当用scanf函数输入字符串时，字符串中不能含有空格，否则将以空格作为串的结束符

```c
int a5={ {80,75,92}, {61,65,71}, {59,63,70}, {85,87,90}, {76,77,85} };
//按行连续赋值可写为：
int a5={80,75,92,61,65,71,59,63,70,85,87,90,76,77,85};
//这两种赋初值的结果是完全相同的
//可以只对部分元素赋初值，未赋初值的元素自动取0值
int a[3][3]={ {1},{2},{3} };
int a [3][3]={ {0,1},{0,0,2},{3} };
//赋值后的元素值为：
    0  1  0
    0  0  2
    3  0  0
//如对全部元素赋初值，则第一维的长度可以不给出
int a[3][3]={1,2,3,4,5,6,7,8,9};
//可以写为
int a[][3]={1,2,3,4,5,6,7,8,9};
```

```c
#include <stdio.h>
int main(){
    char test[3][4];    //三行的字符数组，每行有四个char，其中一个给换行符
    int i, j;
    for(i = 0; i < 3; i++){     //i == 0-2,三次循环，按行scan
        scanf("%s",test[i]);      //以string输入，不需要&   以 空格 作为不同行的间隔，每行char最多三个，其中一个留给换行符
        printf("row%d is %s\n", i, test[i]); 
    }
    printf("%s",test[0]);//test[0]为输出第0行，%s指string字符串
    return 0;
}//
//input（1）：//以空格作为行的分隔，超过部分不被scan
a bc def ghijklmn//若有一行的字符超过三个（一个为结束符），会可能有错误输出
//output（1）：
row0 is a
row1 is bc
row2 is def
a
//输入刚好12个char时，被并为一行
//input（2）：
abcdefghijkl
//output（2）：
row0 is abcdefghijkl
```





### 结构体struct

-   派生数据类型 derived data type
-   一种数据结构。聚合数据类型(aggregate data type)的一类
-   结构体成员运算符 . structure member operator
-   结构体指针运算符 -> structure pointer operator (箭头运算符 arrow operator)
-   -> 中间加了空格是语法错误



```c++
struct tag {//tag:结构体标记(structure tag)
	member-list;//member-list为结构体成员列表，其必须列出其所有成员
} variable-list ;//大括号后面的分号 ; 不能少，这是一条完整的语句
//variable-list可省，为此结构体定义的变量
//一般情况下，tag、member-list、variable-list这3部分至少要出现2个
```



###### 初始化 & sizeof

-   用初始值列表来初始化结构体
-   定义语句的变量后面加上  = { 初始值列表 }; 
-   成员要一一对应，缺少会运行时报错，字符串用双引号

```c++
struct card aCard = { "Three", 2, &num, ""}
//最后一个没有双引号会报错，缺少成员会运行时报错
//struct card: char a[6]; int b; int* ptr; char c[6];
```



-   结构体大小必须是最大数据类型大小的倍数
-   每种数据存储的时候要从数据类型大小的整数倍开始存//要求每一个成员在字边界
-   //对齐规则是机器相关的//如: char占了1byte，存int时跳过三个byte再存

```c++
struct test{
	long long a;//8 bytes
	char c;//1 byte  //后面有7 bytes"空洞"，因此相同类型的struct也不能比大小
};//sizeof(struct test) == 16
```



```c++
typedef struct addr{
	char a;	//1 byte
	int :0;	//当前面没有位结构的时候不起作用
	short b;//2 bytes
	int :0;	//后面没有位结构的时候也不起作用
}i;//sizeof( i ) == 4
//
typedef struct addr{
	char a:1;	//1 bit
	int :0;	//跳到下一个int单位，即到下一个4字节开始存储
	short b;//2 bytes
	int :0;	//后面没有位结构的时候不起作用
}i;//sizeof( i ) == 8//int :0;起了作用，计算大小按int倍数算
//
typedef struct addr{
	char a:1;	//1 bit
	short :0;	//跳到下一个short单位，即到下一个2字节开始存储
	short b;	//2 bytes
	int :0;	//后面没有位结构的时候不起作用
}i;//sizeof( i ) == 4//short :0;起了作用，计算大小按short倍数算
```



##### 位结构/位域/位段

-   一种特殊的结构。在需按位访问一个字节或字的多个位时, 位结构比按位运算符更加方便
-   把一个字节中的二进位划分为几个不同的区域， 并说明每个区域的位数bit,标志为 ' : '
-   数据类型必须是int(unsigned或signed) char, long, long long
-   **变量名是选择项, 可以不命名**, 这样规定是为了排列需要。
-   整型常数必须是非负的整数, 范围是0~该类型最大值, 表示二进制位bit的个数
-   无名位域 unnamed bit field.用于填充(padding)结构体中的存储缝隙//unsigned :19;
-   type :0; 跳到下一个type单位，即到下一个 sizeof(type) 开始存储
-   type :3; 跳过3bit再存储。即空出3bit
-   成员访问 与结构成员的访问相同//位结构变量.成员名  位结构指针->成员名
-   优劣势 节约存储空间。但会使编译器生成运行速度较慢的机器代码。因为访问一个正常编址的存储单元中的一部分需要一些额外的机器指令
-   位结构中的成员可以定义为unsigned, 也可定义为signed, 但当成员长度为1时, 会被认为是unsigned类型。因为单个位不可能具有符号
-   位结构中的成员不能使用数组和指针, 但位结构变量可以是数组和指针, 如果是指针, 其成员访问方式同结构指针
-   获取一个位域的地址属于语法错误，因为位域没有地址

```c++
struct 位结构名{			//基本形式和普通struct结构体相同
	数据类型 变量名: 整型常数;	//类型说明符 位域名：位域长度
	数据类型 变量名: 整型常数;	//注意使用了冒号 :
} 位结构变量;
```



```c++
struct info{
	char name[8];//8 byte
	int age;//4 byte
	struct addr address;//占8字节，内部是 char a:2;  short :0;  int b;
	float pay;//4 byte
	unsigned state: 1;//1 bit
	unsigned pay2: 1;//1 bit
}workers;//sizeof(workers)==28//数组和struct仍按其数据类型的倍数算，因此是4的倍数
```





##### 匿名struct

-   匿名struct、匿名union及C++的匿名class，是指既没有类型名，也没有直接用这种类型定义的对象
-   如果紧随类型定义之后，又定义了该类型的对象，就不算是匿名类型，与普通情形的使用是一样的。
-   匿名类型作为嵌套定义，即在一个外部类（这里的类是指struct、union、class）的内部定义，则编译器就在匿名类型定义之后定义一个无名变量，并把该匿名类型的数据成员的名字提升到匿名类的外部类的作用域内。如果匿名类型是连续嵌套，则最内部的匿名类型的成员名字被提升到最外部的可用变量名字访问的类的作用域内

```c++
struct sn{	//声明struct sn
	struct { int i;};  // 匿名 struct
}v1;
//可以直接通过外部struct的变量访问
v1.i=101;
```



---

### 枚举enum

>   enumeration 用户自定义的数据类型//构造数据类型 

-   用标识符表示的整型枚举常量(enumeration constant)的集合
-   enum typeName{ Name1, Name2, Name3, ...... };//typeName:枚举类型的名字
-   枚举类型中的枚举值从0开始依次递增 1 //除非专门定义
-   一个枚举类型中的多个成员可以拥有相同的常数值

-   枚举和宏其实非常类似。宏在预处理阶段将名字替换成对应的值，枚举在编译阶段将名字替换成对应的值。可以将枚举理解为编译阶段的宏
-   一个枚举类型中出现的标识符必须互不相同，但不同enum可以相同。定义结束的分号不可少
-   在对应数据域内不能再定义与枚举类型中的变量的名字相同的变量


```c++
enum months{ JAN = 1, FEB, MAR, ... };//FEB为2，MAR为3...
enum week{a};enum test{a};//编译报错[Error] redeclaration of enumerator 'a'
```

```c++
enum week{ Mon = 1, Tues, Wed, Thurs, Fri, Sat, Sun } day;
//一定程度上等于#define Mon 1 ...
//声明一个枚举类型week，并随之定义一个enum week型的变量day
enum test{ Haha=9 };//另外定义一个enum类型，Haha为9
scanf("%d", &day);//给day赋值//合法:day = Haha;//赋值可以跨enum，因为声明后相当于变量
switch( day ){
        case Mon: puts("Monday"); break;	//当day的值等于Mon(1)时
	/*...*/
        case Sun: puts("Sunday"); break;	//case 关键字后面必须是一个整数
        default: puts("Error!");
}//sizeof(enum week)==4	//即int的大小
//枚举列表中的Mon, Tues, Wed这些标识符的作用范围是main()函数内部，不能再定义与它们名字相同的变量
//Mon、Tues、Wed 等都是常量，不能对它们赋值，只能将它们的值赋给其他的变量
//它们不占用数据区（常量区、全局数据区、栈区和堆区）的内存，而是直接被编译到命令里面，放到代码区，所以不能用&取得它们的地址
```



**int to enum**

-   c++ Compiler 不提供int to enum的自动转换//强制类型转换可以，但需保证有意义
-   c Compiler 提供int to enum的自动转换

---

### 联合体 共用体 union

-   共用体成员共享同一个存储空间，节省存储空间
-   对某一个成员赋值，会覆盖其他成员的值
-   定义方式同struct，大小由最大的成员的大小决定
-   所有成员都从低地址开始存放
-   移植性取决于目标系统对共用体成员的数据类型的存储对齐要求
-   每次只允许访问一个成员，要按照正确的数据类型来访问，否则数值无意义
-   union比较大小是语法错误//[Error]invalid operands to binary ...(have'union ...')
-   定义语句中初始化---只能对第一个成员相同的数据类型的数值来初始化


```c++
union number{
	int x;//4 byte
	double y;//8 byte
};//注意要有分号//sizeof(union number)==8(double的大小)
union number value = {10};	//定义一个union number类型的变量value同时初始化
printf("%d %lf", value.x, value.y);//10 0.000000//value.y 值无意义
printf("%d %d", value.x, value.y);//10 10//注意格式控制符错误
union number value = {99.1234};//输出value.x为99 小数部分被截掉
//若对调x 和 y的前后位置，则value.y==99.1234，value.x的值无意义
```

















---

# 指针变量pointer

-   数据在内存中的地址也称为指针，若一个变量存了某份数据的指针(地址)，就是指针变量
-   referenced type: 数组、字符串、函数，普通变量，指针变量
-   在32位系统中，指针是 4 字节宽，即 32 位。 64 位系统中为 8 字节
  -   指针类型决定长度和解析方式//指针的两种属性
-   取值运算/解引用/dereferencing: \*p 取出在那个地址中存储的值。按地址访问。用于访问p指向的变量（p指向的内存）
-   C与C++语言规定指针类型为强类型，即指针值不仅是一个内存地址，同时它的数据类型说明了存在这个地址可以安全访问的地址的范围，例如，float*可以访问4个字节的内存空间，double*可以访问8个字节的内存空间
-   因为指针更贴近硬件，编译器能够很容易的将指针翻译为机器码，这使指针操作时的负担较少，因此能够提高程序的运作速度。使用指针能够简化许多数据结构的实现，例如在遍历字符串，查取表格，控制表格及树状结构上。对指针进行复制，之后再解引用指针以取出数据，无论在时间或空间上，都比直接复制及访问数据本身来的经济快速。指针表示法较为直觉，使程序的表达更为简洁，同时也能够提供动态机制来创建新的节点
-   取地址在 CPU的寄存器 产生，不占内存
-   地址由计算机总线控制，地址作为常量不消耗内存
-   指针是一个变量，变量自身占内存，指针可以存储不同的地址
-   32位计算机的地址空间为32位，采用32位地址编码//e.g. 0XF7654321 (4bit为一个16进制数，32位系统的地址由8个16进制数表示







>   野指针，悬挂指针，智能指针问题参见另一 .md 笔记文件





### pointer与 typedef / define

```c++
#define test int*	//纯粹的替换
typedef int* INTP;	//typedef语句需要有分号;

//#define name int
int main(void){
	int* normal_a, normal_b;//normal_a 是int*, normal_b 只是int
	INTP a, b;	//两个都是int*，属于指针	//typedef使得定义时每一个都变成了指针
	test c, d;	//相当于int* c, d;//c是int指针，但d是int	//因为define是直接替换
	printf("%d %d %d %d", sizeof(a), sizeof(b),sizeof(c),sizeof(d));
}//output:8 8 8 4
```

### 空类型指针void* & 空指针NULL

-   void *vp; //没有类型，不能判断指向的对象的长度和解析方式
-   **任何指针都可以复制给void指针，无需转换**，只获得变量/对象地址而不获得大小
-   **void指针赋值给其它类型都要进行转换，获得指向变量/对象大小**
-   void指针不能解引用。void指针不能参与指针运算,除非进行转换//因为void指针只知道指向变量/对象的起始地址

```c
void * vp;//不能解引用
*vp=10;//error: 不能赋值,void指针只知道指向变量/对象的起始地址，不能参与指针运算
```



-   指向的地址为NULL / nullptr	//double *p = NULL;
-   指针没有存储地址，或说存储地址为空。不能解引用，不能 \*p 赋值




### 数组名 & 数组指针

-   数组名是数组首元素的地址，也就是&a[0]的值。虽然数组名不是指针，但是用的很像指针
-   **数组名不可自加，是指针常量**(指针所指向的地址不能改变)//a++非法，但*(a+2)合法


```c
int a[3][3] = { {0, 1, 2}, {3, 4, 5}, {6, 7, 8}};//定义并初始化一个二维数组
for(int i=0; i<3; i++){
	for(int j=0; j<3; j++){
		printf("%d\n", *((int *)(a+i) + j));//包含强制类型转换
		//printf("%d\n", *(*(a+i) + j));//两者输出效果一样，顺序输出整个二维数组
	}
}
```



-   数组指针是数组名的指针，数组首元素的指针，指向数组的指针。本质是一个指针
-   int (*p)[10];//p即指向数组的指针，少了圆括号就变成了指针数组
-   指针数组是一个由指针组成的数组(很多个指针)，而数组指针是指向数组的一个指针

```c
int main(){
	int a[4][5]={ {1, 2, 3, 4, 5}, {11, 12, 13, 14,15},	//二维数组的初始化
    	{21, 22, 23, 24,25}, {31, 32, 33, 34,35},};
	int (*p)[5]=a;	//方括号内数字需要对应数组第二维的长度，否则会有warning或无法通过编译
	printf("%d\n", *(*(p+2)+3) );	//值为a[2][3] == 24
}
这里a是个二维数组的数组名，相当于一个二级指针常量；
p是一个指针变量，它指向包含5个int元素的一维数组，此时p的增量以它所指向的一维数组长度为单位；
*(p+i)是二维数组a[i][0]的地址;
*(p+2)+3表示a[2][3]地址（第一行为0行，第一列为0列），*（*(p+2)+3）表示a[2][3]的值。
a[0]是第一个一维数组的数组名和首地址。a[1]是第二个一维数组的数组名和首地址
*(a+0)或*a是与a[0]等效的，它表示一维数组a[0]0号元素的首地址

a+i，a[i]，&a[i]，*(a+i)，&a[i][0]是等同的，都表示a[i]这个一维数组名和首地址
C语言规定，这是一种地址计算方法，表示数组a第i行首地址

a[i]+j则是一维数组a[i]的j号元素首地址，它等于&a[i][j]
该元素的值等于*(*(a+i)+j)
//调用函数时：
int foo(int (*p)[5] );
```

```c
int test[2][3][4][5][6];
int (*ptr)[5][6] = test[0][1];
/*	等同于
	int (*ptr)[5][6]=(int (*)[5][6])(test[0]+1);	//将test的首地址强制转换为指向[5][6]个int的行指针
*/
ptr[2][5][1] = 4;	//等同于*(*(*(ptr+2)+5)+1)=4;
printf("%d %d\n",  ptr[2][5][1], test[0][1][2][5][1]);
```











### 常量指针 & 指针常量

常量指针：int const * p;

-  **只读**，**指向常量**，无法修改指向的值
-  定义: `const int * p`; `int const * p`;//注意const的位置在 *之前
-  将一个常量的地址赋给一个对应类型的常量指针，常量指针不能够通过指针修改内存数据




指针常量：int * const p = &a;//必须初始化

-   指针所指向的地址不变，即指针本身是一个常量，但是指针所指向的内容可以改变
-   p不变, *p可变
-   指针常量必须在**声明的同时对其初始化**，不允许先声明一个指针常量随后再对其赋值，这和声明一般的常量是一样的
-   函数中使用: `int FuncName(int* const p_val);`
-   指向常量的指针常量: `int FuncName(const int* const p_val);`



```c++
int a = 1;//定义变量
const int b = 2;//定义常量
const int *ptr1 = &a;//定义常量指针，可以不初始化
int* const ptr2 = &a;//定义指针常量，必须赋值以初始化
int *ptr3 = &b;//错误，不能把常量的地址赋给指针变量 
const int* ptr4 = &b;//正确，可以把常量的地址赋给常量指针  
    
*ptr1 = 3;//错误，间接引用常量指针不可以修改内存中的数据 
*ptr2 = 4;//正确，间接引用指针常量可以修改内存中的数据  
ptr1 = &b;//正确，常量指针可以指向其他变量  
ptr2 = &b;//错误，指针常量不可以指向其他变量  
const int * const ptr5 = &a;//常量指针常量，即不可以间接引用修改内存数据，也不可以指向别的变量
*ptr5 = 5;//错误，不可以间接引用修改内存数据  
ptr5 = &b;//错误，不可以修改指向的对象  
```





### 双重指针

-   指向指针的指针，本身是指针，指向的也是指针
-   本质上，指针值就是内存地址。但为了防范指针值被滥用（如内存访问时越界），可以规定指针类型为强类型，即指针值及保存在该内存地址的对象的类型。双重指针不过是这种强类型的一个应用：该地址空间长度为一个指针长度（4或8字节），对象类型为另一种指针


```c
int ** ptr_to_ptr;
```



### 函数指针

-   函数指针可以像一般函数一样，用于调用函数、传递参数
-   函数指针只能指向具有特定特征的函数。因而所有被同一指针调用的函数必须具有相同的参数和返回类型




```c++
typedef void(*Fun)( void );//Fun是指向形参列表为void，返回值为void的函数指针类型
int (*p)(int, int) = & FuncName; //p是函数指针, &可以省略
```



```c++
# include <stdio.h>
int max(int x, int y) {
	return x > y ? x : y;
}

int main(void) {
	int (*p)(int, int) = & max; //p是函数指针, &可以省略
	int a = 1, b = 3, c = 2, d = 0;
	d = p(p(a, b), c);//通过指针调用与直接调用函数等价: d = max(max(a, b), c);
	printf("the maxumum number is: %d\n", d);
}//output: the maxumum number is: 3
```























---

# 数据区



```c++
int a = 0;	//全局已初始化数据区
char *p1;	//BSS区（未初始化全局变量）
int main()  {  
	int b;//栈
	char s[] = "abc";//数组变量，栈区//"abc"为字符串常量，存储在已初始化数据区
	char *p2;//栈
	char *p3 = "123456";//123456\0在常量区，在已初始化数据区，p3在栈区  
	static int c =0;//全局(静态)数据，存在于已初始化数据区//静态数据会自动初始化
	p2 = (char *)malloc(20); free(p2);//分配得来的20字节的区域在堆区,p2在栈区
	strcpy(p1,"123456");//123456\0放在常量区，编译器可能会将它与p3所指向的"123456"优化成一个地方
	free(p2);
}
```





### 数据区顺序





>   高地址 //内核虚拟内存(内核使用)

1. **栈区stack**(运行时出现)向下增长//函数参数，临时创建的局部变量。系统**自动**给局部变量分配
2. **堆区heap**(运行时出现)向上生长//一般由程序员分配/释放(new malloc，注意内存泄露问题)
3. **未初始化全局**变量BSS区(Block Started by Symbol),用0初始化，静态内存分配
4. **已初始化全局**变量global、静态变量存储区static、常量数据Data Segment(数据段)
5. 可执行**代码**区(code segment/text segment)
>   低地址

---

>   高地址

###### 栈区 stack

>   栈向下(栈已经处于高地址)向低地址方向增长

-   由编译器**自动分配释放**//无需手工控制
-   内存的分配是连续的，编译器会自动接着当前栈区的结尾来分配内存
-   只要栈的剩余空间大于所申请空间，系统为程序提供内存，否则报异常提示栈溢出
-   存放函数的参数值、局部变量的值等，函数括弧“{}”中定义的变量（但不包括static声明的变量，static意味着在数据段中存放变量。其操作方式类似于数据结构中的栈


C实现函数递归调用的方法：每当一个函数被调用，该函数返回地址和一些关于调用的信息，比如某些寄存器的内容，被存储到栈区。然后这个被调用的函数再为它的自动变量和临时变量在栈区上分配空间。每执行一次递归函数调用，一个新的栈框架就会被使用，这样这个新实例栈里的变量就不会和该函数的另一个实例栈里面的变量混淆。
在函数被调用时，其参数也会被压入发起调用的进程栈中，并且待到调用结束后，函数的返回值也会被存放回栈中。由于栈的先进先出特点，所以栈特别方便用来保存/恢复调用现场。从这个意义上讲，我们可以把堆栈看成一个寄存、交换临时数据的内存区



###### 堆区 heap

>   堆向上(堆处于较低(对比栈)地址)向高地址方向增长

-   由程序员分配和释放//动态分配的内存段(容易产生memory leak)
-   大小并不固定，可**动态扩张**或缩减。heap在内存中位于bss区和stack之间
-   当进程调用malloc等函数分配内存时，新分配的内存就被动态添加到堆上（堆被扩张）；当利用free等函数释放内存时，被释放的内存从堆中被剔除（堆被缩减），若程序员不释放，程序结束时有可能由OS回收





###### 未初始化数据区 BSS

> Block Started by Symbol
>
> BSS段属于静态内存分配。.bss section 的空间结构类似于 stack

-   没有初始化的和初始化为0的全局变量，在运行时改变其值
-   在采用段式内存管理的架构中，BSS段（bss segment）通常是指用来存放程序中**未初始化的全局变量**的一块内存区域
-   静态内存分配
-   bss段并不给该段的数据分配空间，只是记录数据所需空间的大小，故bss类型的全局变量只占运行时的内存空间，而不占文件空间
-   大多数操作系统，在加载程序时，会把所有的bss全局变量全部清零，无需要你手工去清零。但为保证程序的可移植性，手工把这些变量初始化为0也是一个好习惯



###### 全局初始化数据区 静态区

>   Data Segment 静态数据区 

-   在采用段式内存管理的架构中，数据段（data segment）通常是指用来存放程序中**已初始化且不为0**的**全局变量**的一块内存区域。
-   静态内存分配


###### 代码区 text segment

-   代码区指令根据程序设计流程依次执行，对于顺序指令，则只会执行一次（每个进程），如果反复，则需要使用跳转指令，如果进行递归，则需要借助栈来实现
-   这部分区域的大小在程序运行前就已经确定，并且内存区域通常属于只读,某些架构也允许代码段为可写，即允许修改程序。
-   代码区的指令中包括操作码和要操作的对象(或对象地址引用)。如果是立即数(即具体的数值，如5)将直接包含在代码中；如果是局部数据，将在栈区分配空间，然后引用该数据地址；如果是BSS区和数据区，在代码中同样将引用该数据地址







>   低地址

---

需要说明的是，stack区是从第1GByte地址处以下开始，第1GByte地址处到stack开始的地方，是命令行参数和环境列表的存储区。

```c
//str是放在函数的栈空间中的，字符串"ABCD"也是放在栈空间中的：
char str[] = "ABCD";
//str是放在栈空间中的，而字符串是放在data区的read-only部分：
char *str = "ABCD";//这种字符串是不可以更改的
//那么，str是放在栈空间中的，而字符串是放在堆空间中的：
char str = (char *)malloc(sizeof(char)size);  *(str+0) = 'A'; 
```







---

### 数据区(疑)



###### rodata段

>   只读数据段 read only(const)
>
>   存放常量，字符常量，const常量，#define定义的常量，据说还存放调试信息

-   常量不一定就放在rodata里，有的立即数直接编码在指令里，存放在代码段(text)中。
-   对于字符串常量，编译器会自动去掉重复的字符串，保证一个字符串在一个可执行文件(EXE/SO)中只存在一份拷贝。
-   rodata是在多个进程间是共享的，这可以提高空间利用率。
-   在有的嵌入式系统中，rodata放在ROM(如norflash)里，运行时直接读取ROM内存，无需要加载到RAM内存中。
-   在嵌入式Linux系统中，通过一种叫作XIP（就地执行）的技术，也可以直接读取，而无需要加载到RAM内存中。



由此可见，把在运行过程中不会改变的数据设为rodata类型的，是有很多好处的：在多个进程间共享，可以大大提高空间利用率，甚至不占用RAM空间。同时由于rodata在只读的内存页面(page)中，是受保护的，任何试图对它的修改都会被及时发现，这可以帮助提高程序的稳定性





### 效率与碎片











---

# bit operation位运算



-   对一个比特位(bit)进行操作。比特/bit/位 是电子元器件，8个比特构成一个字节(Byte)，只有 0 和 1 两个取值，它是粒度最小的可操作单元
-   位操作依赖于机器，通常将数据当作无符号整型处理

| operation        | symbol | use    | meaning                            |
| ---------------- | ------ | ------ | ---------------------------------- |
| left shift 左移    | <<     | x << y | all bits in x shifted left y bits  |
| right shift 右移   | >>     | x >> y | all bits in x shifted right y bits |
| bitwise NOT 按位取反 | ~      | ~x     | all bits in x flipped              |
| bitwise AND 按位与  | &      | x & y  | each bit in x AND each bit in y    |
| bitwise OR 按位或   | \|     | x \| y | each bit in x OR each bit in y     |
| bitwise XOR 按位异或 | ^      | x ^ y  | each bit in x XOR each bit in y    |



```c++
//snippet//按位与运算通常用来对某些位清 0，或保留某些位。例如要把 n 的高16 位清0，保留低16位
	num= n & 0XFFFF;
//0XFFFF 在内存中的存储形式为 (0000 0000 -- 0000 0000 -- 1111 1111 -- 1111 1111)

//按位异或运算可以用来将某些二进制位反转。例如要把 n 的高 16 位反转，保留低 16 位
	num = n ^ 0XFFFF0000;
```



###### & 按位与
- 只有参与&运算的两个位都为 1 时，结果才为 1，否则为 0
  &是根据内存中的二进制位进行运算的，而不是数据的二进制形式；其他位运算符也一样

9&5
0000 0000 -- 0000 0000 -- 0000 0000 -- 0000 1001  （9 在内存中的存储）
0000 0000 -- 0000 0000 -- 0000 0000 -- 0000 0101  （5 在内存中的存储）
0000 0000 -- 0000 0000 -- 0000 0000 -- 0000 0001  （1 在内存中的存储）
- 按位与运算通常用来对某些位清 0，或者保留某些位。例如要把 n 的高 16 位清 0 ，保留低 16 位，可以进行n & 0XFFFF运算
  (0XFFFF 在内存中的存储形式为 0000 0000 -- 0000 0000 -- 1111 1111 -- 1111 1111)

###### | 按位或

- 参与|运算的两个二进制位有一个为 1 时，结果就为 1，两个都为 0 时结果才为 0。例如1|1为1，0|0为0，1|0为1，这和逻辑运算中的||非常类似

9|5
0000 0000 -- 0000 0000 -- 0000 0000 -- 0000 1001  （9 在内存中的存储）
0000 0000 -- 0000 0000 -- 0000 0000 -- 0000 0101  （5 在内存中的存储）
0000 0000 -- 0000 0000 -- 0000 0000 -- 0000 1101  （13 在内存中的存储）

- 按位或运算可以用来将某些位置(变成) 1，或者保留某些位。例如要把 n 的高 16 位置 1，保留低 16 位，可以进行n | 0XFFFF0000运算
  (0XFFFF0000 在内存中的存储形式为 1111 1111 -- 1111 1111 -- 0000 0000 -- 0000 0000)




###### ^ 按位异或

- 异为1，同为0
- 参与^运算两个二进制位不同时，结果为 1，相同时结果为 0。例如0\^1为1，0\^0为0，1\^1为0  （0为假，非零为真，与这相反，相同为零即假）

9^5
0000 0000 -- 0000 0000 -- 0000 0000 -- 0000 1001  （9 在内存中的存储）
0000 0000 -- 0000 0000 -- 0000 0000 -- 0000 0101  （5 在内存中的存储）
0000 0000 -- 0000 0000 -- 0000 0000 -- 0000 1100  （12 在内存中的存储）

- 按位异或运算可以用来将某些二进制位反转。例如要把 n 的高 16 位反转，保留低 16 位，可以进行n ^ 0XFFFF0000运算
  (0XFFFF0000 在内存中的存储形式为 1111 1111 -- 1111 1111 -- 0000 0000 -- 0000 0000)


###### ~ 取反

- 取反运算符\~为单目运算符，右结合性，作用是对参与运算的二进制位取反。例如\~1为0，\~0为1，这和逻辑运算中的!非常类似

~9
0000 0000 -- 0000 0000 -- 0000 0000 -- 0000 1001  （9 在内存中的存储）
1111 1111 -- 1111 1111 -- 1111 1111 -- 1111 0110  （-10 在内存中的存储）
```printf("%d, %d\n", ~9, ~-9 );	//output:  -10, 8```

-   任何数取反，和原来的数相加都等于-1; a + ~a == -1;//-1补码为全1


###### << 左移运算

-   左移运算符<<用来把操作数的各个二进制位全部左移若干位，高位丢弃，低位补0

9<<3
0000 0000 -- 0000 0000 -- 0000 0000 -- 0000 1001  （9 在内存中的存储）
0000 0000 -- 0000 0000 -- 0000 0000 -- 0100 1000  （72 在内存中的存储）

- 如果数据较小，被丢弃的高位不包含 1，那么左移 n 位相当于乘以 2 的 n 次方
  printf("%d, %d\n", 9<<3, (-9)<<3 );//output:     72, -72
- 如果整型数据 n 占32 位，则 n << 31 和 n << 0 都合法，而 n << 32 和 n << -1都不合法




###### >> 右移运算

- 右移运算符>>用来把操作数的各个二进制位全部右移若干位，低位丢弃，高位补 0 或 1
- 如果被移位的是无符号数，则填 0 。如果是有符号数，可能填 0 或符号位 //与机器有关//高位补什么具体还是取决于数据类型、编译器、环境

9>>3
0000 0000 -- 0000 0000 -- 0000 0000 -- 0000 1001  （9 在内存中的存储）
0000 0000 -- 0000 0000 -- 0000 0000 -- 0000 0001  （1 在内存中的存储）
- 若被丢弃的低位不包含 1，那么右移 n 位相当于除以 2 的 n 次方（但被移除的位中经常会包含 1）
> 右操作数是负数，报错或warning







---

# 逻辑表达式 布尔运算

>   布尔运算 Boolean operation

-   优先级 非(!) ← 算术运算符 ← 关系运算符 ← 逻辑与(&&)逻辑或(||) ← 赋值运算符
-   真 非零，true(包含 <stdbool.h> 时)
-   假 0，flase(包含 <stdbool.h> 时)
-   || 逻辑或运算要注意短路现象，即左边为真时，右边不执行





---

# %取模运算



---

# 杂项


```c++
int Square(int);// 函数声明不分配内存，声明时只需写上传递的数据类型
int Cube(int);// value-returning functions
int main( ){    
      /* ()says no  parameters(形式参数)不是实际存在变量，所以又称虚拟变量*/
    int i;
    i = Square(27);// function call函数调用，只需写变量名或常量表达式
    printf( "The square of 27 is %d \n", i );
    i = Cube(27);// function call 函数调用
    printf( "The cube of 27 is %d \n", i );  	
}

int Square( int n ){
	//函数定义时分配内存，并且写上传递参数的类型及其变量名（仅在此子函数内有效）
    int result;
//Square:name of the function * int Square( int n )：function heading函数首部
    result = n*n;
    return result;
}//from ｛  to ｝ is function body（函数体）

int Cube( int n ){
//A block(块) is a sequence of zero or more statements enclosed by a pair of curly braces {  }.
    int result;
    result = n*n*n;
    return result;
}//from { to }   is body block( function body )
```

调用函数时：
int foo(int p[4] );	//4会被直接忽略，相当于p[],是一个指针
int foo(int (*p)[4] );	//一个数组指针，指向一个有四个int元素的数组的首地址



