


[TOC]
***
# % 格式控制符 转换说明符

>% is also modulus operator 取模运算符



###### 整型


- %d  interger    以十进制形式输出带符号整数(正数不输出符号)
- %i 读入八进制/十进制/十六进制的整数
- %u unsigned 以十进制形式输出无符号整数
- %hd short/short int/signed short/signed short int//短整形和%hi有区别，同%i和%d的区别
- %hu unsigned short/unsigned short int无符号整形
- %ld %li long/long int/signed long/signed long int   十进制长整型输出
- %lu unsigned long/unsigned long int 无符号长整型
- %lld %lli (signed)long long(int)
- %llu unsigned long long

>输入: 0ddd(八进制),ddd(十进制),0xddd(十六进制)//0XA, 017...//09会输出0，不符合八进制技术规则|
>l修饰长long	h修饰短short

---

###### 八/十六进制


- %o 以八进制形式输入/出无符号整数(不输出前缀0零) Octal、OCT、O//要输出前缀则用%#o(# 显示前缀)
- %x 以十六进制数形式输入/出无符号整数(不输出前缀0x 、0X)  hexadecimal

---

###### 实型(和指数型)

- %f float 以小数形式输出单实数(promoted automatically to double for printf())
- %lf  double 双精度浮点型(实数)[在printf中l、lf、llf等同]
- %llf  | long double 长度byte不短于double
- %e %E 以指数形式输出单、双精度实数
- %g %G 以%f或%e中 较短的输出宽度输出单、双精度实数
>scanf中，E e f G g 效果等同

---

###### 字符和字符串

- %c char/signed char/unsigned char 输出单个字符[0,255]%hhi for numerical(数字的) output)
- %s string 输入/输出字符串
- %% 读/输出%符号
- %[] 扫描字符集合
- %n %number指到此时以输入或输出的字符个数（域宽）
- %n 至此已读入/输出的等价字符数，后面要跟&varible，包含空白字符 但不包括最后一个/一堆空白字符
```c++
scanf("%d%d%n", &a, &b, &x);//输入1 2↙//x==3
输入   1 2↙//x==6//前面三个空格，两个数字，中间还有一个空格，一共6个输入域宽
printf("abc%n", &x);//x==3	//事实上大部分printf中%n不输出但不会给x赋值(DEV就不行)
```

---



##### 标志

- 左对齐，右边填空格ASCii32// %-7d%d  总共输出7格，左对齐，后面的数字从第八格开始输出
- 输出符号(正号或负号)// %+d  不论正负都带符号
- space 空格输出值为正时冠以空格(ASCii 32)，为负时冠以负号，右对齐  // % d  123输出: 123(前带空格)  % d  -123输出:-123
- /# 对c、s、d、u类无影响；对o类(8进制)，在输出时加前缀o；对x(16进制)类，在输出时加前缀0x；对e、g、f 类当结果有小数时才给出小数点%#o 123输出:0173%#x 123输出:0x7b%#014E  123E3输出:01.230000E+005
- 0 在打印数据前面加上前导0以填满域宽
- 4 (打印域宽)△右对齐，自动补齐空格space(ASCii 32)至总共4位，包括实型的小数点和小数部分//超出时正常输出
- .4(精度) 对实型四舍五入至四位小数，对整型的效果等同于04，不足四位补充0 //%.4d 输出1为0001

> scanf中是扫描并丢弃一个对应类型的数据，故地址表中没有对应地址
>
> printf中是表示省略一个域宽数字或精度的数字，具体数字在实参列表中



---

###### 扫描集   scan set    %[]


- 描述 %[aeiou] 扫描集扫描输入流中的字符，寻找与扫描集中的字符相匹配的字符
- 停止 一旦扫描到扫描集中没有包含的字符，扫描集停止输入字符。如果第一个就不符合
- 逆向扫描集 %[ ^字符]在扫描字符前加"脱字符号(^)"，没有出现在扫描集中的字符反而被保存

```c++
//扫描集 demo ---		//char a[100];
scanf("%[abcd]", a);	//仅扫描abcd
输入ff，a[]'\0'		//输入ackkk,a[]ac
  
scanf("%'\n'", a);		//扫描除回车符外的字符	
输入 z u_l，a[]== z u_l	//除了回车符以外的字符包括空格，tab都被存储

scanf("%A-Z", a);		//扫描除了大写字母以外的
输入abcdTkk，a[]==abcd
```





---

###### 赋值抑制字符

>   assignment suppression character

-   字符说明 使scanf函数从输入流中读取任意类型的数据并将其丢弃


赋值抑制字符 demo
```c++
scanf("%d%*c%d%c%d", &num1, &num2, &num3);//读取三个int型数据，中间的字符舍弃，实参列表没有对应变量
```

```C++
//整型
scanf("%.d%d%d", &a, &b, &c);//%.d等同于%/d %td//因为中间有非法字符，所以赋值全部失败
scanf("%d%/d%d", &a, &b, &c);//第一个赋值正常，第二个及以后的都赋值失败
scanf("%d%dd%d", &a, &b, &c);//只有输入1 2d3，才正常，d必须紧跟2，%dd后面的d是输入形式的控制
scanf("%d%*s%d", &a, &b);//输入1 zxchwg 2，输入正常//注意需要空白字符 因为数字和字符串之间都以空白字符为间隔
printf( "%07d\n", 123 );0000123//自动补齐0至总共7位，右对齐
printf( "%.7d\n", 123 );0000123//效果与07d相同
printf( "%7d\n", 123 );       123//自动补齐空格space至总共7位，右对齐
printf("a=%d b=%d", 3, 4);a=  4 b=(Garbage values)4//前面有2个空格//3替换了表示域宽(右对齐)，4为%*d打印的数字，后面的%d因为没有实参对应，打印垃圾值
```

```C++
浮点数
scanf("%3lf", &test);	输入 1.234 输出1.200000 输入 12345678.9 输出 123.000000 //3为输入域宽只被保存了前3个数字包括小数点
scanf("%8.3lf", &test);		输入无法被保存，只要带了小数点.就无法保存
printf( "%.3f",  123 ); 	0.000			123是整型数据，按float输出为 0.000
printf( "%.3f",  (float)123 );	123.000 	保留三位有效数字，浮点型的123可以正常输出
printf( "%7.3f",  123.55555);	123.556		位宽控制包含小数点和小数部分，浮点数会进行四舍五入
printf( "%8.3f",  123.55555);	123.556		第一个是空格，三位小数+小数点+整数=7位，补齐1空格
printf("%.f", 4, 3, 1.23456);	1.235		3是小数部分的长度 1.23456被四舍五入为 1.235//4是域宽，小数点和小数部分已经为4了，整数部分还要1域宽，所以被自动改成了最低的5
```

```C++
字符串
scanf( "%10s", str);只scan 10个characters
scanf( "%.2s", str);str没有被赋值，%.2s无法赋值
printf("%.5s", "abcdefg");abcde %.5s只允许输出5个char
printf( "%10.1s", "four");         f	打印域宽10，前九个是空格，只输出第一个char
printf( "%-10.3s", "four");fou       	左对齐，域宽为10， 只输出3个char，后面跟着7个空格spaces
```





---

# \ 反斜线  转义序列

> Escape sequence

控制类


- \n Newline (Line feed in ASCII)換行 Ctrl + j  ASCII:10  0x0A
- \r return 回车   ASCII:13   0x0D
- \t Horizontal tab 水平制表符 横向跳到下一制表位置Ctrl + i  ASCII:9
- \v Vertical Tab  垂直制表符 Ctrl + k   ASCII:11   0x0B
- \b Backspace 退格，需要在\b 后紧跟一个字符，来代替需要删除的字符。若后面没有需要输出的字符，可用空格跟在\b后，用来替换被退格的字符 退格字符  ASCII:8   0x08
- \a Alert (bell or beep)Ctrl + g ASCII:7  0x07
- \f formfeed 换页


输出字符类

- \\ Backslash 输出反斜线
- \'   | Single quote (apostrophe)单引号
- \”   | Double quote (quotation mark) 双引号
- \?   | Question mark 输出问号?


ASCii表示需输出的%c(字符)

-   \0 Null character (all zero bits) 空字符Ctrl + @  ASCII:00    0x00
-   \ddd  | Octal equivalent 八进制 (3 octal digits)//ddd代表数字// \65输出5，八进制65对应十进制53，5的ASCii为53
-   \xddd | Hexadecimal equivalent 十六进制(1 or more hex digits for integer value of character)

```c++
printf("abc\b%c",'v');  	//此处的输出结果是abv，后面的'v'就是用来替换'c'的字符
printf("abc\b%c",'\0');		//输出ab，\b退格后，c被\0替代(\0 为Null  空字符)
printf("%c", '\x61');		//输出a，a的ASCii 16进制为61
printf("\101");				//输出A，A的ASCii 8进制为101
```

---

# 输入输出函数

###### scanf

通用终端格式化输入函数，它从标准输入设备(键盘) 读取输入的信息。可以读入任何固有类型的数据并自动把数值变换成适当的机内格式

scanf("<格式化字符串>"，<地址表>);// <stdio.h>

-   函数原型 int scanf(char *format[,argument,...]);
-   返回成功赋值的数据项数，出错时则返回EOF
-   其控制串由三类字符构成： 1、格式化说明符；  2、空白符；  3、非空白符；

（A）                格式化说明符

%a%A            读入一个浮点值(仅C99有效) 
%c                 读入一个字符 
%d                 读入十进制整数 
%i                 读入十进制，八进制，十六进制整数 
%o                 读入八进制整数 
%x%X           读入十六进制整数 
%c                 读入一个字符 
%s                 读入一个字符串 
%f  %F %e  %E %g  %G  读入一个浮点数 
%p                 读入一个指针 
%u                 读入一个无符号十进制整数 
%n                 至此已读入值的等价字符数 
%[]                扫描字符集合 
%%                 读%符号

附加格式说明字符表
L/l 长度修饰符               输入"长"数据 
h 长度修饰符                 输入"短"数据 
W 整型常数                   指定输入数据所占宽度
\*星号                       空读一个数据 // * 表示本输入项在读入后不赋值给相应的变量

hh,ll同上h,l但仅对C99有效

（B）         空白字符
空白字符会使scanf()函数在读操作中略去输入中的一个或多个空白字符，空白符可以是space,tab,newline等等，直到第一个非空白符出现为止。

（C）        非空白字符
一个非空白字符会使scanf()函数在读入时剔除掉与这个非空白字符相同的字符。



scanf()函数接收输入数据时，遇以下情况结束一个数据的输入：（不是结束该scanf函数，scanf函数仅在每一个数据域均有数据，并按回车后结束）

1.  遇空格、“回车”、“跳格”键
2.  遇宽度结束
3.  遇非法输入

```c
scanf("%d%d%d",&a,&b,&c);//&是地址运算符，分别获得这三个变量的内存地址
scanf("%d,%d",&a,&b);//合法输入： 3，4 或 a=3，b=4  scanf()的格式控制串可以使用其它非空白字符，但在输入时必须输入这些字符
scanf("%c%c%c",&c1,&c2,&c3);//输入：a□b□c↙  结果：a→c1，□→c2，b→c3 (其余被丢弃)
//在用"%c"输入时，空格和“转义字符”均作为有效字符
scanf("%s",str);//此处输入:I love you!//输出：I 
scanf("%[^/n]",string); 
//为了清除缓冲区的，而更严格的连换行符都清除的 清除缓冲区方法
scanf("%*[^\n]");
scanf("%*c");
//或者写到一起
scanf("%*[^\n]%*c");//这样写在个别情况下会出小错误，建议分开写
//解释：%*[^\n] 是接收任意多个非\n字符，然后缓冲区只剩下一个换行符，%*c把最后那个换行符也扔掉，垃圾清除干净
```



###### sscanf

-   <stdio.h>
-   int sscanf (char *str, char * format [, argument, ...]);//参数str为要读取数据的字符串；format为用户指定的格式；argument为变量，用来保存读取到的数据
-   成功则返回参数数目，失败则返回-1，错误原因存于errno 中
-   sscanf()与scanf()类似，都是用于输入，scanf()以键盘 (stdin)为输入源，sscanf()以固定字符串为输入源



format参数
%[a-z] 表示匹配a到z中任意字符，贪婪性(尽可能多的匹配)
%[aB'] 匹配a、B、'中一员，贪婪性
%\[\^a\] 匹配非a的任意字符，贪婪性

```c
//format不仅可以用空格界定字符串，还可以用其他字符界定，可以实现简单的字符串分割
sscanf("2006:03:18", "%d:%d:%d", &a, &b, &c);
sscanf("2006:03:18 - 2006:04:18", "%s - %s", sztime1, sztime2);
```

```c
#include <stdio.h>
int main(void){
    char str[100] ="123568qwerSDDAE";
    char lowercase[100];
    int num;
    sscanf(str,"%d %[a-z]", &num, lowercase);//分别给int变量num和 char数组lowercase
    printf("The number is: %d.\n", num);
    printf("The lowercase is: %s.", lowercase);
}//Output:
The number is: 123568.
The lowercase is: qwer.
```



###### gets

-   gets是get string的缩写，获取用户从键盘输入的字符串
-   gets()不会把空格作为输入结束的标志，能避免空格截断
-   C11 中移除get(char *str); c11: gets_s(char *str, rsize_t n)

```c
#include <stdio.h>
int main(){
	char str1[30], str2[30];
	gets(str1);
	gets(str2);
}//input:
Java Python C-Sharp↙
www.google.com↙
//output:
Java Python C-Sharp
www.google.com
```

- C11中使用gets_s();
```c
//c11 standard
gets_s(char *buff,rsize_t size);//n: char数组的最大长度
```





###### printf

-   int printf (char * format,args, ...); //format可以是一个字符串，或字符数组的起始地址
-   返回成功输出的字符个数，包含空字符，若出错，则返回负数

```c
printf("\x41");	//A	//16进制的41对应ASCii十进制65的A
printf("\65");	//5	//8进制的65对应ASCii十进制53的A
printf("\68");	//□8	//6被转义，当成8进制数，并用char输出，8正常输出
printf("\0");	//null	//ASCii的0对应空字符null
printf("a%s","b%s","c");//ab%s	//第一个%s被第二个引号内的b%s替代，c舍弃
printf("%d\n",printf("%d",printf("%d",999)));//99931//最右边的最先执行，输出999，三个char，中间的输出3，一个char，输出1
```



```c
#include <stdio.h>
int main(){
	printf("C programming %s", "Class by\n%s Sanfoundry", "WOW");
}
```



---

# 条件/控制/选择语句



There are three types of control structures available in C and C++  控制结构，流程控制

1.  Sequence structure (straight line paths) 顺序结构
  2.  Selection Control Structure (one or many branches) 选择结构
  3.  Loop Control Structure (repetition of a set of activities) 循环控制结构





### switch-case

```c++
switch (表达式){
    case 常量表达式1://case后面常量表达式的值必须互不相等
    	语句1;break;//每个case语句的结尾不要忘了加break，否则将导致多个分支重叠
    case 常量表达式2://case和常量表达式之间要有空格
    	语句2;break;
    default://case和default出现可以在任何位置，其先后次序不影响执行结果
    	语句3;break;//不要忘记最后的default分支。即使程序真的不需要default处理，也应该保留语句： default : break;
}
```

```c++
int main(void){
    int a;
    scanf("%d",&a);
    switch (a){ //switch语句括号内的表达式可以是 整型 或 字符型 ,不能是float型
		case 1:printf("Monday\n");break;
        //注意冒号“:”，以及break语句，注意case 1之间的空格，
		case 2:printf("Tuesday\n");break;//注意case X 语句结束后的break;
		case 3:printf("Wednesday\n");break;
        //若缺少 break; 则后面的所有语句都将被执行一次。
        /*......*/
		default:printf("error\n");
	}
}
```





### goto

-   无条件转移语句
-   goto  语句标号;
-   标号必须与goto语句同处于一个函数中，但可以不在一个循环层中
-   通常goto语句与if条件语句连用，当满足某一条件时，程序跳到标号处运行
-   goto的目标是一个标号，因为标号只用于goto，所以它的名字可以与任何变量名以及其它标识符一样而不产生重名

```c++
int main(void){
	int i,sum=0;
	i=1;
	l1: if(i<=100){   //loop是一个标号，goto loop之后，执行冒号：后的语句
		sum=sum+i;
		i++;
		goto l1;
	}
	printf("%d\n",sum);
}
```





### ? : 三目运算符

>   Conditional Expression 条件运算符//唯一的三目运算符
>
>   If Condition is true ? Then value X : Otherwise value Y

-   <表达式1> ? <表达式2> : <表达式3> 	条件运算符
-   其中表达式1为布尔表达式，或真或为假。若表达式1为真，则返回表达式2的值作为整个条件表达式的值。若条件为假，则返回表达式3的值

```c++
int max = (a > b)? a : b ;//执行结果就是将a和b中最大值赋给max
```

  





---

# 产生随机数



```c++
#include <stdio.h>
#include <stdlib.h>//rand和srand所在的库
#include <time.h>//time()
int main(){
    int i;
    srand(time(NULL));//设置随机数种子。time()   位于#include <time.h>
    for(i = 0; i < 10; i ++)//运行10次。
        printf("%d\n", rand());//每次获取一个随机数并输出。
}
//demo 2 - 产生介于1 到10 间的随机数值
int main(){
	int i,j;
	srand(time(NULL));//设置随机数种子
	for(i=0;i<10;i++){//输出10个
		j=1+(int)(10.0*rand()/(RAND_MAX+1.0));//输出介于1-10的随机数
		printf("%d ",j);//也可以用取余的方式取得一定区间内的随机数
	}
}
```

>   # RAND_MAX
>
>   Maximum value returned by rand
>
>   This macro expands to an integral constant expression whose value is the maximum value returned by the rand function.
>   This value is library-dependent, but is guaranteed to be at least `32767` on any standard library implementation.



###### srand & rand

srand

-   设置随机数种子//<stdlib.h>
-   void srand(unsigned int seed);
-   srand( time(NULL) );//time()包含于<time.h>
-   传递一个整型数据，无返回值
-   srand只需要在所有rand调用前，被调用一次即可，没必要调用多次


rand

-   产生伪随机数//<stdlib.h>
-   int rand( void );//无需传递参数
-   rand() % (internal_wide + 1); //产生随机数后与区间宽度取余
-   根据产生的随机数种子产生随机数，随机数种子相同时，每次产生的随机数相同
-   返回一个int型数据//伪随机数
-   伪随机数 由随机种子根据一定的计算方法计算出来的数值




###### time()

- 返回1970年1月1日00:00:00（UTC）至今秒数//<time.h>
- time_t time(time_t *t);
- a = time(NULL);
- 返回自 Unix 纪元（January 1 1970 00:00:00 GMT）起的当前时间的秒数









---

# 内存层面操作











###### memcpy

- 内存拷贝函数//<string.h>
- void *memcpy(void *dest, const void *src, size_t n);
- memcpy(d,s,strlen(s));//从地址s中 拷贝strlen(s)个字节到d所指的内存地址中
- 从源src所指的内存地址的起始位置开始 拷贝n个字节 到目标dest所指的内存地址中。
- 、目标地址的指针。2、源数据地址的指针。3、需要拷贝的字节数。
- 返回dest的指针，即目标地址，函数传递参数的第一个


strcpy和memcpy主要有以下3方面的区别
1. 复制的内容不同。strcpy只能复制字符串，而memcpy可以复制任意内容，例如字符数组、整型、结构体、类等。
2. 复制的方法不同。strcpy不需要指定长度，它遇到被复制字符的串结束符"\0"才结束，所以容易溢出。memcpy则是根据其第3个参数决定复制的长度。
3. 用途不同。通常在复制字符串时用strcpy，而需要复制其他类型数据时则一般用memcpy




###### memset

- 内存初始化<string.h>
- void * memset( void * ptr, int value, size_t num ); //返回指向 ptr 的指针
- 用来指定内存的前 num 字节设置为特定的值。(参数：地址，值，长度)
- ptr:指针 value:要设置的值既可以向value传递int类型的值 也可以传递char类型的值
- int 和 char 可以根据 ASCII 码相互转换。num为ptr的前 num 个字节，size_t 是unsigned int
- memset() 会将 ptr 所指的内存区域的前 num 个字节的值都设置为 value，然后返回指向 ptr 的指针
- memset() 可以将一段内存空间全部设置为特定的值，所以经常用来初始化字符数组

```c++
char str[20];
memset(str, '\0', sizeof(str)-1);
```

menset 对数组

- memset函数对数组而言只能用于置 0 或置 -1 操作。
- 因为memset函数是对单个字节操作如果你把int a[5] 置2；memset（a,2,sizeof(int )*5）; 因为它是整数型数组有四个字节，而每个字节都被赋值为2；
- 即数(例 int a[5])每个元素（如a[0]）中的每个字节（整型数组每个元素含有四个字节）的值都被赋予成2，二进制表示及（00000010 00000010 00000010 00000010）；
- 所以输出十进制printf(" %d ",a[0])为33686018；
- 所以不能用memset对数组置0与-1以外的数赋值，因为-1的二进制码为(11111111 11111111 11111111 11111111)置负一数不会改变

```c++
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(){	//字符数组是可以被修改的，字符串是只读的
    char str[] = "http:	//c.biancheng.net";//不可以声明为 char *str = "http://c.biancheng.net";
    memset(str, '-', 7);//将 str[]的前七个设置成为 - 
    puts(str);
}//output：
-------c.biancheng.net//前七个char数组（字符数组名为str）的元素被替换成了'-'
//字符数组是可以被修改的，字符串是只读的，不能被修改，而 memset() 又必须修改 str，
//所以不能将 char str[] = "http://c.biancheng.net";声明为 char *str = "http://c.biancheng.net"; 否则运行时会报错
```







###### malloc

- 动态分配：程序在执行时调用malloc等库函数申请分配。
- 分配一定大小的内存(不初始化)//<stdlib.h>
- void* malloc (size_t size);  动态地分配内存空间memery allocable
- 指针变量名 = ( 类型名* ) malloc ( num * sizeof( type ) ); 
- size 为需要分配的内存空间的大小，以字节（Byte）计
- malloc() 在堆区分配一块指定大小的内存空间，用来存放数据。这块内存空间在函数执行完成后不会被初始化，它们的值是未知的。如果希望在分配内存的同时进行初始化，用 calloc() 函数
- 分配成功返回指向该内存的地址，失败则返回 NULL
- 函数的返回值类型是 void\* 并不是说没有返回值或者返回空指针，而是返回的指针类型未知。所以在使用 malloc() 时通常需要进行强制类型转换，将 void 指针转换成我们希望的类型
```c++
  #include <stdio.h>   	//printf, scanf, NULL
  #include <stdlib.h>  	//malloc, free, rand, srand, system 
  #include <time.h>   	//time()
  int main (){
    int i,n;
    char * buffer;   		//char指针buffer
    scanf ("%d", &i);		//输入字符串长度i
    buffer = (char*)malloc(i+1);//malloc//字符串最后包含 '\0'
    if(buffer==NULL) exit(1);  	//判断内存空间分配是否成功。自行判断后，再进行后续操作
    srand(time(NULL));		//srand()设置随机数种子,嵌套函数time()返回值为从 1970年1月1日 UTC 时间从0时0分0秒算起到现在所经过的秒数
    for(n=0; n<i; n++){
        buffer[n] = rand()%26+'a';//随机生成长度为i的字符串
    }
    buffer[i]='\0';  		//字符串以 '\0' 为结尾，malloc没有初始化分配的内存块
    printf ("%s\n",buffer);	//输出随机产生的字符串
    free(buffer);  		// 释放内存空间
  }
```



###### calloc


- 分配一定大小的内存空间并初始化//<stdlib.h>
- void\* calloc (size_t num, size_t size);  //总分配的大小为 num \* size
- 指针变量名 = (类型名\*) calloc(num, sizeof(类型名));
- calloc() 在内存中动态地分配 num 个长度为 size 的连续空间，并将**每一个字节都初始化为 0** //分配的内存屈原上，每一bit均为0
- 所以它的结果是分配了 num\*size 个字节长度的内存空间，并且每个字节的值都是0
- 分配成功返回指向该内存的地址，失败则返回 NULL
- calloc() 与 malloc() 的一个重要区别是：calloc() 在动态分配完内存后，自动初始化该内存空间为0，而 malloc() 不初始化，里边数据是未知的垃圾数据。下面的两种写法是等价的：
```c++
char *str1 = (char *)calloc(10, 2);// calloc() 分配内存空间并初始化
//效果等同于
char *str2 = (char *)malloc(20);// malloc() 分配内存空间并用 memset() 初始化
memset(str2, 0, 20);
```





###### realloc

- void* realloc (void* ptr, size_t size);  //<stdlib.h>//realloc的前缀re-是重新的意思，就是重新分配
- ptr 为需要重新分配的内存空间指针，size 为新的内存空间的大小。
- realloc 对 ptr 指向的内存重新分配 size 大小的空间，size 可比原来的大或者小，还可以不变。如果 ptr 为 NULL，它的效果和 malloc() 相同，即分配 size 字节的内存空间。如果 size 的值为 0，那么 ptr 指向的内存空间就会被释放，但是由于没有开辟新的内存空间，所以会返回空指针；类似于调用 free()
- 分配成功返回新的内存地址，可能与 ptr 相同，也可能不同；失败则返回 NULL。
- 指针 ptr 必须是在动态内存空间分配成功的指针，形如如下的指针是不可以的：int \*i; int a[2]；会导致运行时错误，用 malloc()、calloc()、realloc() 分配成功的指针才能被 realloc() 函数接受。
- 成功分配内存后 ptr 将被系统回收，一定不可再对 ptr 指针做任何操作，包括 free()；相反的，可以对 realloc() 函数的返回值进行正常操作。
- 如果是扩大内存操作会把 ptr 指向的内存中的数据复制到新地址（新地址也可能会和原地址相同，但依旧不能对原指针进行任何操作）；如果是缩小内存操作，原始据会被复制并截取新长度。
- 如果分配失败，ptr 指向的内存不会被释放，它的内容也不会改变，依然可以正常使用




###### free

- void free (void\* ptr);//<stdlib.h>//free(指针)
- free() 可以释放由 malloc()、calloc()、realloc() 分配的内存空间，以便其他程序再次使用。如果 ptr 所指向的内存空间不是由上面的三个函数所分配的，或者已被释放，那么调用 free() 会有无法预知的情况发生
- ptr 为将要释放的内存空间的地址。
- free() 不会改变 ptr 变量本身的值，调用 free() 后它仍然会指向相同的内存空间，但是此时该内存已无效，不能被使用。所以建议将 ptr 的值设置为 NULL

```c++
free(ptr);
ptr = NULL;//将 ptr 的值设置为 NULL
```



```c++
#include <stdlib.h>
int main (){
    int * buffer1, * buffer2, * buffer3;
    buffer1 = (int*) malloc (100*sizeof(int));
    buffer2 = (int*) calloc (100,sizeof(int));
    buffer3 = (int*) realloc (buffer2,500*sizeof(int));
    free (buffer1);
    free (buffer3);
}
```





---

# 字符串操作

###### strlen

-   <string.h>字符串长度
-   extern unsigned int strlen(char \*s);//字符串的地址，或字符数组的首地址
  -   strlen(a);//a为地址，或者数组名
-   求的是字符串的实际长度，它求得方法是从开始到遇到第一个'\0'的长度(不包含'\0')
-   返回从传递的地址到遇到第一个'\0'的长度(不包含'\0')
-   如果只定义字符数组没有给赋初值，结果是不定的，首地址一直找下去，直到遇到'\0'停止

```c++
char a[10];//定义而未初始化//strlen(a)不定，sizeof(a)为10
```



###### strcat 

-   <string.h>连接字符串
  -   strcat(s1, s2);//传递两个指向字符串的指针
-   将src字符串连接到dest字符串的**结尾**
-   返回指向dest字符串的指针

```c
char *strcat(char *dest, const char *src);//src: to be appended
s1 = strcat(s1, s2);//传递两个指向字符串的指针
```



###### strchr

-   <string.h>查找字符串中首次出现某字母的位置
-   extern char \*strchr(const char \*s,char c);
-   成功则返回要查找字符第一次出现的位置，失败返回NULL



###### strstr 

-   <string.h>判断子字符串
-   extern char \*strstr(char \*str1, const char \*str2);
-   判断str2是否str1的子串。前:长字符串，被搜索的字符串。后:所搜索的字符串(短)
-   若后者是前者的子串，返回str2在str1首次出现的地址。否则返回NULL

###### strcpy

-    <string.h><stdio.h> 字符串复制 
-    **char \*strcpy(char\* dest, const char \*src);**
-    strcpy(a,c);//char a[20],c[]="i am";//strcpy(a,"ha");//a是char数组，"haha"是字符串常量
  -    目标字符串的首地址  +源字符串的首地址
-    将后面地址的字符串复制到前面的地址中去
-    返回指向dest的地址（即前面的）地址
-    src地址中（后面的地址）存储的字符串要有结束符 '\0'







###### strcmp

-   <string.h>字符串对比大小
-   int strcmp(const char \*s1, const char \*s2);
  -   strcmp(a, b); //char \*a = "aBcDeF";char \*b = "AbCdEf";
-   s1, s2 是需要比较的字符串的首地址
-   自左向右逐个字符相比（按ASCII值大小相比较）。s1 第一个字符值减去s2 第一个字符值，
-   若差值为0 则再继续比较下个字符，若差值不为0，则将差值返回//通常是这样
-   若str1==str2，则返回零；若str1<str2，则返回负数；若str1>str2，则返回正数。
-   只能比较字符串。ANSI标准规定，返回值为正数，负数，0 。而确切数值是依赖不同的C实现的。

```c
if(strcmp(a, b) > 0) //或者(strcmp(a, b) < 0) //(strcmp(a, b) == 0)
```



###### strncmp

-   <string.h>字符串限制长度的对比大小
-   int strncmp( const char \* str1, const char \* str2, size_t num );
  -   strncmp(str1, str2, 3);//指针，指针，整型(需要比较的长度)
-   需对比的两个字符串的地址，第三个是需要比较的字符串长度
-   比较s1和s2前num个字符串是否相等
-   相等返回0，str1小于str2，返回值就<0；str1大于str2，返回值就>0
-   写bool表达式时用 \=\=0 或 >0 或 <0表示，不可用\=\=\-1表达，与编译器有关//此处同strcmp



---

# 变量有关的关键字



static extern const violatile关键字

### static	

有两种作用，改变生命期和限制作用域

修饰inline函数	限制作用域

修饰普通函数	限制作用域。表明函数不能够被其他模块的函数调用
修饰局部变量	改变生命期。在函数调用结束时不销毁。函数再次被调用时，不再次定义，用上次调用结束时的值，生命期是第一次调用开始到main结束
修饰全局变量	限制作用域。不能够被其他模块的函数使用。只能是本身的编译单元

### extern	

修饰函数		表明函数可以被其他模块的函数调用
修饰全局变量	表明该变量在别的地方已经定义过了,在这里要使用那个变量

-与C++的联系

### extern "C"

extern "C" void fun(int a, int b);//这个函数是一个C环境下声明的函数

告诉编译器在编译fun这个函数名时按着C的规则去翻译相应的函数名而不是C++的，C++的规则在翻译这个函数名时会把fun这个名字变得面目全非，可能是fun@aBc_int_int#%$也可能是别的，这要看编译器的"脾气"了

### const	

用const修饰的变量放在rodata里，字符串默认就是常量
指针常量		指向的数据是常量。如 const char* p = "abc"; 	p指向的内容是常量，不能改变，p本身是变量可以改变，可以让p再指向其他地方
常量指针		指针本身是常量。如：char* const p = "abc"; 	p本身就是常量，不能让p再指向"123"
指针常量+常量指针	指针和指针指向的数据都是常量。const char* const p =”abc”; 两者都是常量，不能再修改。

### violatile	

通常用来修饰多线程共享的全局变量和IO内存
告诉编译器，不要把此类变量优化到寄存器中，每次都要老老实实的从内存中读取，因为它们随时都可能变化。这个关键字可能比较生僻，但千万不要忘了它









---

# 补码

计算机系统中，数值一律用补码来表示（存储）
(1) 正数的补码与原码相同
(2) 负数的补码为相应正数按位取反再加1;   或正数-1再按位取反
(+0)补码 = (-0)补码 = 0 0000000
-1补码:  1111 1111 1111 1111 







