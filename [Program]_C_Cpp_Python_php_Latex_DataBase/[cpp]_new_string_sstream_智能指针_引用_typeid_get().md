[TOC]


# reference 引用 &
- In the C++ programming language, a **reference** is a simple datatype that is less powerful but safer than the pointer type inherited from C.
- 引用是某一变量(目标)的一个**别名 (alias)**// call them *variable* is in fact a misnomer.(误称)

- 把引用初始化为某个变量，就可以使用该引用名称或变量名称来指向变量

- 声明格式：标识符 & 引用名 = 目标变量名//\<Type\> \& \<Name\>

- 占用空间：编译器在一般将其实现为const指针，即指向位置不可变的指针，但不产生新的变量。故占空间

- 效率: 当函数的参数是较复杂的变量时，将函数的参数类型改为const & 可以提高效率。节省构造、析构，const还能保证不变性，并保留了值传递时不改动原有对象的特性

```c++
    int& rA = A;    //int A = 5;
    extern int& rB; //Here, rA and rB are of type "reference to int"
    int funcX() { return 42 ; }; int (&xFunc)() = funcX;
    //funcX() is a function that returns a (non-reference type) int and xFunc() is an alias(别名) for funcX
```

 

---

### 常引用


-   不能通过引用对目标变量的值进行修改

-   定义：const 类型标识符&引用名=目标变量名;

-   意义：达到引用的安全性

```c++
int a;
const int &ra=a;
ra=1;   //错误，ra是a的常引用，不能通过常引用修改变量的值
a=1;    //正确，允许直接修改a
```

```c++
double dval = 3.14;
int& ri = dval; //Error：无法用double类型的值初始化int&类型的引用(非常量限定)
//ri引用了一个int。对ri的操作是整数运算，但dval是一个双精度的浮点数
//因此为了确保让ri绑定一个整数，编译器把上述代码变成了如下形式
double dval = 3.14;
int temp = dval;//temp是一个临时变量
int& ri = temp;//所以当ri改变时，并没有改变davl的值，所以这种引用是无效的
double dval = 3.14;
const int& ri = dval;//不通过ri改变dval的值，只要读到dval对应的int型的值就行
```

---

### 指针引用

-   **&** 连用，传递**指针的引用**
```c++
void pass_by_value(int* p){
    //Allocate memory for int and store the address in p
    p = new int;//局部变量，调用完此函数后销毁
}
void pass_by_reference(int*& p){//传递int指针的引用
    p = new int;//由于传递指针p的引用，修改main()中的p2本身，修改得到保留
}
int main(){
    int* p1 = NULL;
    int* p2 = NULL;
    pass_by_value(p1); 
    //p1 will still be NULL after this call//p1仍然是NULL
    pass_by_reference(p2);
    //p2 's value is changed to point to the newly allocate memory
}
```

### 临时匿名对象的引用

> 如果声明将引用指定为const，C++将在必要时生产临时变量，其操作类似于按值传递

如果实参和引用参数不匹配，C++将可能生成临时变量，但仅当参数为const引用时才允许

如果引用参数是const，编译器在以下两种情况下生成临时变量:

- 参数的类型正确，但不是左值

- 参数的类型不正确，但可以转换为正确的类型

临时变量只在函数调用期间存在，此后编译器便可以随意将其删除

```c++
double refcube(const double & ra){
    return ra*ra*ra;
}
double side = 3.0;
long edge = 5L;
double c1 = refcube(edge);//ra is temporary variable
double c2 = refcube(7.0);//ra is temporary variable
double c3 = refcube(side + 10);//ra is temporary variable
```

> edge 虽然是变量，但是类型不正确，double引用不能指向long，虽然side + 10类型是double，但是没有名字，故编译器都将创建一个临时匿名变量，让ra指向她



---

# string 类

-   string是以char作为模板参数的模板类实例. implemented in \<string\>

>   string本质上是以字符作为元素的vector特化版本；不存在0字符结尾这个概念，能装入'\0'这种数据

string存储在堆区Heap

- basic_string  std::basic_string属于C++ STL容器类，用户自定义的类也可以作为它的模板参数，适用C++ STL Algorithm库

- 类模板basic_string存储并操作类char对象的序列。该模板既不依赖于字符类型亦不依赖于该类型上的运算本性

- 运算的定义由Traits模板参数——std::char\_traits的一个特化或兼容的特性类提供

> c++11basic_string的元素是连续存储的
>
> 对于basic_string s，有：&*(s.begin() + n) == &*s.begin() + n，其中n属于[0, s.size())。换句话说，指向s[0]的指针即为指向CharT[]数组的首元素指针
>
> c++17  std::basic_string 类模板，满足以下的要求
>
> 分配器容器 Allocator Aware Container 、顺序容器 Sequence Container 及连续容器 Contiguous Container

| 类型                          | 定义                               |
| --------------------------- | -------------------------------- |
| std::string                 | std::basic_string\<cha\r>          |
| std::wstring                | std::basic_string\<wchar_t>       |
| std::u16string (C++11)      | std::basic_string\<char16_t>      |
| std::u32string (C++11)      | std::basic_string\<char32_t>      |
| std::pmr::string (C++17)    | std::pmr::basic_string\<char>     |
| std::pmr::wstring (C++17)   | std::pmr::basic_string\<wchar_t>  |
| std::pmr::u16string (C++17) | std::pmr::basic_string\<char16_t> |
| std::pmr::u32string (C++17) | std::pmr::basic_string\<char32_t> |


###### length + c_str + copy + data

```c++
str.length();//返回 str 的长度//等同于str.size()
str.c_str();//成员函数返回string类的C语言风格字符串(ASCII-零串)的指针，用于C语言字符串的互操作，建议不要使用
str.data();//返回不一定是0结尾的字符串的内存地址//不需要零结尾的字符串时使用
str.copy(p,n,0);//p指char*，n是复制的长度，0是复制位置，0表示从头开始复制  
//*(p+5)='\0'; //要手动加上结束符
char *str2=const_cast<char*>(str1.c_str())  //
```

###### to_string (c++11)

-   Convert numerical value to string. 将数值转换为字符串

>   :arrow_down: to_string 重载的类型 //返回值是string

```c++
string to_string (int val);
string to_string (long val);
string to_string (long long val);
string to_string (unsigned val);
string to_string (unsigned long val);
string to_string (unsigned long long val);
string to_string (float val);
string to_string (double val);
string to_string (long double val);
```

```c++
#include <iostream>   // std::cout
#include <string>     // std::string, std::to_string
int main () {
    std::string pi = "pi is " + std::to_string(3.1415926);
    std::string perfect = std::to_string(1+2+4+7+14) + " is a perfect number";
    std::cout << pi << '\n';
    std::cout << perfect << '\n';
}//Output:
pi is 3.141593
28 is a perfect number
```

###### insert

```c++
// inserting into a string(c++14)
#include <iostream>
#include <string>
int main (){
    std::string str="to be question";
    std::string str2="the ";
    std::string str3="or not to be";
    std::string::iterator it;
    //used in the same order as described above://括号中的内容为insert部分
    str.insert(6, str2);//to be (the )question//6表示在str[6]前面插入
    str.insert(6, str3, 3, 4);//to be (not )the question
    str.insert(10, "that is cool", 8); //to be not (that is )the question
    str.insert(10, "to be ");//to be not (to be )that is the question
    str.insert(15, 1, ':');//to be not to be(:) that is the question
    it = str.insert(str.begin()+5, ',');//to be(,) not to be:that is the question
    str.insert (str.end(), 3, '.');// to be, not to be: that is the question(...)
    str.insert (it+2, str3.begin(), str3.begin()+3); // (or )
    std::cout << str << '\n';
}//Output:
to be, or not to be: that is the question...
```

###### find_first_of

>   Notice that it is enough for one single character of the sequence to match (not all of them). See string::find for a function that matches entire sequences. 注意，仅对参数序列的其中一个字符匹配即可。string::find是匹配整个序列

| string | `size_t find_first_of (const string& str, size_t pos = 0) const noexcept;` |
| ------ | ------------------------------------------------------------ |
| c-string | `size_t find_first_of (const char* s, size_t pos = 0) const;` |
| buffer | `size_t find_first_of (const char* s, size_t pos, size_t n) const;` |
| character | `size_t find_first_of (char c, size_t pos = 0) const noexcept;` |

Searches the string for the first character that matches **any** of the characters specified in its arguments. 根据参数给定的字符，在string中查找任意一个匹配的字符的位置

When *pos* is specified, the search only includes characters at or after position *pos*, ignoring any possible occurrences before *pos*. pos指定时，仅查找pos及以后的位置，忽略之前的

```c++
#include <iostream>       // std::cout
#include <string>         // std::string
#include <cstddef>        // std::size_t
int main (){
    std::string str ("Please, replace the vowels in this sentence by asterisks.");
    std::size_t found = str.find_first_of("aeiou");//仅需满足其中一个
    while (found!=std::string::npos){
        str[found]='*';
        found = str.find_first_of("aeiou",found+1);//从找到的位置之后开始找
    }
    std::cout << str;
}//Pl**s*, r*pl*c* th* v*w*ls *n th*s s*nt*nc* by *st*r*sks.
```



###### find

std::string::find: 搜索第一次出现整个序列都匹配的位置

| string (1)    | `size_t find (const string& str, size_t pos = 0) const; `   |
| ------------- | ----------------------------------------------------------- |
| c-string (2)  | `size_t find (const char* s, size_t pos = 0) const; `       |
| buffer (3)    | `size_t find (const char* s, size_t pos, size_t n) const; ` |
| character (4) | `size_t find (char c, size_t pos = 0) const;`               |

- pos: 指定搜索起始位置
- n: Length of sequence of characters to match. 传入的需匹配的目标串长度
- Return Value: The position of the first character of the first match.If no matches were found, the function returns **string::npos**.

```cpp
std::string str ("There are two needles in this haystack with needles.");
std::string str2 ("needle");
// different member versions of find in the same order as above:
std::size_t found = str.find(str2);
if (found!=std::string::npos)
    std::cout << "first 'needle' found at: " << found << '\n';//first 'needle' found at: 14

found=str.find("needles are small",found+1,6);
if (found!=std::string::npos)
    std::cout << "second 'needle' found at: " << found << '\n';//second 'needle' found at: 44

found=str.find("haystack");
if (found!=std::string::npos)
    std::cout << "'haystack' found at: " << found << '\n';//'haystack' found at: 30

found=str.find('.');
if (found!=std::string::npos)//Period: 句号
    std::cout << "Period found at: " << found << '\n';//Period found at: 51

//replace the first needle: 找到str2的位置，将该位置开始的str2.length()长度的字串替换为第三个参数指定的字串
str.replace(str.find(str2),str2.length(),"preposition");//原本needles的s不会被替换
std::cout << str << '\n';//There are two prepositions in this haystack with needles.
```





---

### 成员函数

下面列出所有成员函数，其中 string是 std::basic_string\<T\> 的简写：

构造表示

string::string   (构造)
string::string  (析构)
string::operator\=       赋值

string::assign          赋值

string::get_allocator       获得内存分配器

字符访问

**string::at            访问特定字符，带边界检查**

string::operator[]      访问特定字符

string::front           访问第一个字符

string::back            访问最后一个字符

string::data            访问基础数组，C++11 后与 c_str() 完全相同

string::c_str           返回对应于字符串内容的 C 风格零结尾的只读字符串

string::substr          以子串构造一个新串；参数为空时取全部源串

迭代器

**string::begin         获得指向开始位置的迭代器**

**string::end           获得指向末尾的迭代器**

string::rbegin          获得指向末尾的逆向迭代器

string::rend            获得指向开始位置的逆向迭代器

**string::cbegin        获得指向开始位置的只读迭代器**

string::cend            获得指向末尾的只读迭代器

string::crbegin         获得指向末尾的逆向只读迭代器

string::crend           获得指向开始位置的逆向只读迭代器

容量

string::empty           检查是否为空

**string::size          返回数据的字符长度**

string::length          返回数据的字符长度，与 size() 完全相同

string::max_size        返回可存储的最大的字节容量，在 32 位 Windows 上大概为 43 亿字节。

string::reserve         改变 string 的字符存储容量，实际获得的存储容量不小于 reserve 的参数值。

string::capacity        返回当前的字符存储容量

**string::shrink_to_fit     (C++11 新增)降低内存容量到刚好**

修改器

**string::clear         清空内容**

**string::insert            插入字符或字符串。目标 string 中的插入位置可用整数值或迭代器表示。如果参数仅为一个迭代器，则在其所指位置插入0 值**

**string::erase         删除 1 个或 1 段字符**

**string::push_back     追加 1 个字符**

string::pop_back        删除最后 1 个字符，C++11 标准引入

**string::append        追加字符或字符串**

string::operator+=      追加，只有一个参数——字符指针、字符或字符串；不像 append() 一样可以追加参数的子串或若干相同字符

string::copy            拷贝出一段字符到 C 风格字符数组；有溢出危险

**string::resize            改变(增加或减少字符串长度；若增加了字符串长度，新字符缺省为 0**

string::swap            与另一个 string 交换内容

string::replace         替换子串；如果替换源数据与被替换数据的长度不等，则结果字符串的长度发生改变

搜索

string::find            前向搜索特定子串的第一次出现

string::rfind           从尾部开始，后向搜索特定子串的第一次出现

**string::find_first_of 搜索指定字符集合中任意字符在 \*this 中的第一次出现**

string::find_last_of        搜索指定字符集合中任意字符在 \*this 中的最后一次出现

string::find_first_not_of   \*this 中的不属于指定字符集合的首个字符

string::find_last_not_of    \*this 中的不属于指定字符集合的末个字符

**string::compare       与参数字符串比较**

常量值

string::npos            表示“未找到”，值为static const unsigned -1

非成员的有关的全局函数

std::operator+          字符串连接

std::operator!=         不等比较

std::operator==     相等比较

std::operator\<          小于比较

std::operator\<=     小于等于比较

std::operator\>          大于比较

std::operator>=     大于等于比较

std::operator\<\<     字符串内容写到输出流中

std::operator>>     从输入流中读取一个字符串

std::getline            从istream中读入一行或一段字符到string中//getline( cin, str );

std::swap           交换两个string的内容。是std::swap算法针对std::basic_string的特化版本

**std::stoi         字符串转为整形**

std::stol           字符串转为长整形

std::stoll          字符串转为长长整形

std::stoul          字符串转为无符号长整形

std::stoull         字符串转为无符号长长整形

**std::stof         字符串转为单精度浮点形**

std::stod           字符串转为双精度浮点形

std::stold          字符串转为长双精度浮点形

**std::to_string            整型、无符号整型、浮点型转化为string**

std::to_wstring         整型、无符号整型、浮点型转化为wstring

std::hash<std::string>      计算hash值

std::hash<std::wstring>     计算hash值

std::hash<std::u16string>   计算hash值

std::hash<std::u32string>   计算hash值





std::operator\<\<     字符串内容写到输出流中

std::operator>>     从输入流中读取一个字符串

std::getline            从istream中读入一行或一段字符到string中//getline( cin, str );

std::swap           交换两个string的内容。是std::swap算法针对std::basic_string的特化版本

**std::stoi         字符串转为整形**

std::stol           字符串转为长整形

std::stoll          字符串转为长长整形

std::stoul          字符串转为无符号长整形

std::stoull         字符串转为无符号长长整形

**std::stof         字符串转为单精度浮点形**

std::stod           字符串转为双精度浮点形

std::stold          字符串转为长双精度浮点形

**std::to_string            整型、无符号整型、浮点型转化为string**

std::to_wstring         整型、无符号整型、浮点型转化为wstring

std::hash<std::string>      计算hash值

std::hash<std::wstring>     计算hash值

std::hash<std::u16string>   计算hash值

std::hash<std::u32string>   计算hash值

---

---

### c++14  "..." s 常量

>   C++14定义了如下的std::basic_string字面量 //此案例在DEV无法通过，VS2015通过

>   string operator "" s (const char \*str, std::size_t len);
>
>   u16string operator "" s (const char16_t \*str, std::size_t len);
>
>   u32string operator "" s (const char32_t \*str, std::size_t len);
>
>   wstring operator "" s (const wchar_t \*str, std::size_t len);

```c++
include <string> //- c++14
include <iostream>
int main () {
    using namespace std::string_literals;
    std::string str = "abc\0\0def"; //forms the string "abc"    //'\0'当作string的结尾，后面不保存
    std::string str_s = "abc\0\0def"s;//form the string "abc\0\0def"    //'\0'不当作string的结尾，正常保存
    std::cout << str_s.size () << std::endl;//output 8
    std::cout << str << std::endl;//output abc
    std::cout << str_s << std::endl;//output abc  def
}
```

---
# sstream C字符串流

>   stringstream 串流输入/输出类，基于std::string编写

- \<sstream\> is a part of the C++ Standard Library. It is a header file that provides templates and types that enable interoperation between stream buffers and string objects.

### seekg()

对输入流的操作，seekg()是设置读位置

```c++
istream& seekg (streampos pos);
istream& seekg (streamoff off, ios_base::seekdir way);
```

```c++
#include <iostream>
#include <sstream>
using namespace std;
int main() {
    stringstream mys(ios::in | ios::out);
    std::string dat("The double value is : 74.79 .");
    mys.str(dat);
    mys.seekg(-7, ios::end);//基地址为end处，偏移地址为-7
    double val;
    mys >> val;
    val = val*val;
    mys.seekp(-7, ios::end);
    mys << val;
    std::string new_val = mys.str();
    cout << new_val;
}//Output:
The double value is : 5593.54
```

### str()

> basic_string<char_type,traits_type,allocator_type> str() const;①不传参

> void str (const basic_string<char_type,traits_type,allocator_type>& s);②

1. The first form returns a basic_string object with a copy of the current contents of the stream. 第一种方式返回stringstream内容的basic_string对象类型的拷贝

2. The second form  sets str as the contents of the stream, discarding any previous contents. The object preserves its *open mode*: if this includes ios_base::ate, the *writing position* is moved to the end of the new sequence.第二种形式将str设置为流的内容，丢弃任何先前的内容。 该对象保留其打开模式：如果这包括ios_base :: ate，写入位置将移动到新序列的末尾

#### getline 后拆分string

```c++
#include <iostream>  //从标准输入接受多行带空格字符串，然后对每行进行按空格拆分
#include <sstream>
#include <string>
using namespace std;
int main() {
    string s;  //定义一个stirng对象，从标准输入接受一个字符串
    while (getline(cin, s)) {// 遇EOF结束
        stringstream ss(s);  //定义一个string流（使用s实例化）
        for (string s1; ss >> s1; cout << s1 << endl);  //将string流里的东西输出
    }
}// Input: aa bb cc 
// Output:
aa
bb
cc
```

#### string\<\-\>int

> https://www.systutorials.com/131/convert-string-to-int-and-reverse/

```c++
//string到int的转换
string result="10000";
int n=0;
stream << result;
stream >> n;//int n等于10000
string intTranStr(int integer) {//int to string
    stringstream ss;
    ss << integer;
    return ss.str();//str()函数不传值时返回string
}
```

```c++
#include <iostream>//输入数字表示将数字前的字符重复n遍  //x表示结束输入
#include <string>//注意解决数字为0的问题
#include <sstream>
using namespace std;
int main() {
    string inStr, outStr;//inStr输入的string; outStr输出的string;
    int repeat;
    char toPrint, temp;
    while( cin >> inStr, inStr != "x") {//input x to end decode
        stringstream s_inStr(inStr);//用inStr初始化 stringstream s_inStr
        while( s_inStr >> toPrint ) {//先读入一个char toPrint
            s_inStr >> temp;//预读一个char(紧跟着toPrint的)
            if( s_inStr.fail() ) {//判断s_inStr是否输入失败
              //s_inStr输入失败说明toPrint是最后一个字符，则直接放在outStr末尾
                outStr.push_back(toPrint);
            } else if( isdigit(temp) ) {
                s_inStr.putback(temp);//将temp(判断为数字)放回流中
                s_inStr >> repeat;//以int类型读入被判断为int的字符
                for(int i = 0; i<repeat; i++)
                    outStr.push_back(toPrint);//将toPrint重复toPrint次
            } else {//如果 toPrint 后跟着的不是一个数字
                s_inStr.putback(temp);//将 toPrint 后读入的 char 放回
                outStr.push_back(toPrint);//将toPrint放入outStr中
            }
        }
        cout << outStr << endl;
        outStr.clear();//清空outStr, 为下一个inStr的解码做准备
    }
}
```

#### string\<\-\>stringstream

```c++
#include <string>       // std::string
#include <iostream>     // std::cout
#include <sstream>      // std::stringstream, std::stringbuf
int main () {
    std::stringstream ss;
    ss.str ("Example string");//用str()给ss赋值
    std::string s = ss.str();//stringstream的成员函数str()返回string
    std::cout << s << '\n';
}
```

---

# new + delete

### new

-   调用相应的`operator new()`函数，动态分配内存。如果`operator new()`不能成功获得内存，则调用new_handler函数。如果没有设置new_handler函数或者new_handler未能分配足够内存，则抛出`std::bad_alloc`异常。“new运算符表达式”所调用的`operator new()`函数，按照C++的名字查找规则，首先做依赖于实参的名字查找（即ADL规则），在要申请内存的数据类型T的内部、数据类型T定义处的命名空间查找；如果没有查找到，则直接调用全局的::operator new()函数。

-   在分配到的动态内存块上初始化相应类型的对象并返回其首地址。如果调用构造函数初始化对象时抛出异常，则自动调用operator delete()函数释放已经分配到的内存

```c++
p_var = new typename;//p_var是已经定义的类型为typename的指针变量
p_var = new type(initializer);//initializer是传递给构造函数的实参表或初值
p_var = new type [size];//也可创建一个对象数组，称之为“array forms new”
int *p_int = new int[3] {1,2,3};//C++11已经允许显式初始化
```

###### 保证不抛出异常的new

-   在分配内存失败时，new运算符的标准行为是抛出`std::bad_alloc`异常。也可以让new运算符在分配内存失败时不抛出异常而是返回空指针

```c++
new (nothrow) Type ( optional-initializer-expression-list );
new (nothrow) Type[size];//nothrow是std::nothrow_t的一个实例
```

### delete

-   每个`new`获取的对象，必须用delete析构并释放内存，以免内存泄漏

```c++
delete p_var;   //delete一维指针
delete[] p_int; //delete多维指针
```

###### 多维数组new delete

```c++
int **array2D;//双重指针，二维数组的首地址
//假定数组第一维长度为m， 第二维长度为n
//动态分配空间，二维数组的new和delete
array2D = new int *[m];
for( int i = 0; i < m; i++ ){
    array2D[i] = new int [n]  ;
}
for( int i = 0; i < m; i++ ){   //释放
    delete[] arrar2D[i];
}
delete[] array2D;
```

```c++
int ***array3D;//三维数组的首地址，三重指针
//假定数组第一维为m， 第二维为n， 第三维为h
//动态分配空间，三维数组的new和delete
array3D = new int **[m];
for( int i=0; i<m; i++ ){
    array3D[i] = new int *[n];
    for( int j=0; j<n; j++ ){
        array3D[i][j] = new int [h];
    }
}
for( int i=0; i<m; i++ ){   //释放
    for( int j=0; j<n; j++ ){
        delete[] array3D[i][j];//先删第三维的指针
    }
    delete[] array3D[i];//再删第二维的指针
}
delete[] array3D;//最后删第一维的指针
```

---

# 智能指针

### auto_ptr(c++11弃用)

### shared_ptr

### weak_ptr

### unique_ptr

---

# 悬挂引用 悬挂指针 野指针

- 原因：不同CPU实现的内存解引用(dereference)语意不同

- 某些CPU(尤其嵌入式处理器)当指针被free后，不能解引用(否则可能是error)

- 一些功能富集的处理器中，基于性能的原因，处理器把这个已经free掉的内存地址抛给操作系统

- 对悬挂指针解引用，可能是error，一块后面分配的内存，exception等。C++将这种情况归结为"undefined behavior"

- **迷途指针**，**悬空指针**、**野指针**：不指向任何合法的对象的指针

- 野指针：未初始化的指针。

- 迷途指针：所指向的对象被释放或者收回，但对该指针没有作任何的修改，该指针仍旧**指向已经回收的内存地址**

>    解引用0 / nullptr的指针:Segmentation Fault (UNIX系统) 或 General Protection Fault (Windows)    0 / nullptr，取决于编译器实现，而非操作系统。在操作系统中，没有指针的概念，在编译器实现中，编译器可能会检测每一个指针的引用

> c++11 考虑使用 Smart Pointers

```c++
//内部实现一个更安全的 free --- 解决悬挂指针 ---
void safeFree(void **pp){
    assert(pp); //assert宏的原型定义在<assert.h>中，条件返回错误，则终止程序执行
    if (pp != nullptr){
        free(*pp); 
        *pp = nullptr;
    }
}
```

---

# typeid

c++关键字之一，使用typeid必须使用头文件<typeinfo>

typeid是一个返回类型为typ_info的引用的函数

函数原型(也许)：type_info& typeid(object);//是type_info的友元函数

```c++
class type_info {//type_info具体实现方式依编译器而定，但一般都有如下的成员定义
private:
    type_info(const type_info&);//拷贝构造函数私有
    type_info& operator=(const type_info&);//不允许用户创建自己的type_info对象
    //type_info类的复制构造函数和赋值运算符是私有的
public:
    virtual ~type_info();//虚析构函数
    bool operator==(const type_info&)const;//在type_info类中重载了==运算符,该运算符可以比较两个对象的类型是否相等
    bool operator!=(const type_info&)const;//重载的!=运算符，以比较两个对象的类型是否不相等
    const char* name()const;//成员函数name，返回对象的类型的名字
    bool before(const type_info&);
};
```

> RTTI (Run-Time Type Information)

> 通过运行时类型信息程序能够使用基类的指针或引用来检查这些指针或引用所指的对象的实际派生类型



typeid(a).name()返回a的类型名(const char\*)//该函数返回的名字因编译器而定

```c++
#include <iostream>//实验环境:win10 64 vs2017 x86 debug
#include <iomanip>
#include <typeinfo>
using namespace std;
class Base { };
class Derived :public Base {
public://f()输出基类引用的实际类型
    void f(Base& ref) { cout << typeid(ref).name(); }
};

int main() {
    Derived der;
    Base b, *pb = &b, &ref_b = b;
    Base* pd = &der;
    cout << left << setw(20) << typeid(double).name() << typeid(unsigned).name() << endl
        << setw(20) << typeid(Base).name() << typeid(b).name() << endl
        << setw(20) << typeid(pb).name() << typeid(ref_b).name() << endl
        << setw(20) << typeid(der).name() << typeid(string).name() << endl
        << setw(20) << typeid(pd).name() << typeid(*pd).name() << endl;
    der.f(*pd);
}//Output:
double              unsigned int
class Base          class Base
class Base *        class Base
class Derived       class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >
class Base *        class Base
class Base//此处存疑，没有反应引用的实际类型
```

---


# 缓冲区 & flush

缓冲区又称为缓存，是内存空间的一部分。

在内存空间中预留了一定的存储空间，这些存储空间用来缓冲输入或输出的数据，这部分预留的空间就叫做缓冲区

缓冲区根据其对应的是输入设备还是输出设备，分为输入缓冲区和输出缓冲区

比如我们从磁盘里取信息，我们先把读出的数据放在缓冲区，计算机再直接从缓冲区中取数据，等缓冲区的数据取完后再去磁盘中读取，这样就可以减少磁盘的读写次数，再加上计算机对缓冲区的操作大大快于对磁盘的操作，故应用缓冲区可大大提高计算机的运行速度

避免低速的输入输出设备占用CPU，解放出CPU，使其能够高效率工作

引发缓冲区的刷新:

1. 缓冲区满时

2. 执行flush语句

3. 执行endl语句

4. 关闭文件

可以使用flush函数来刷新缓冲区（执行I/O操作并清空缓冲区）

```c++
cout << std::flush; //将显存的内容立即输出到显示器上进行显示
//你以为endl就是个'\n'
cout << endl;
cout << '\n'<< flush;//endl相当于这样的...
```

# cin get()

```c++
int main () { 
    char ch; 
    ch = cin.get();//或者cin.get(ch); //cin.get(字符变量名)可以用来接收字符
    cout << ch << endl; 
}//输入:jljkljkl 
Output:j
```

```c++
int main () { 
    char a[20]; 
    cin.get(a,20);//cin.get(字符数组名,接收数目)接收一行字符串,可以接收空格
    cout << a << endl; 
}//输入:jkl jkl jkl 
Output:jkl jkl jkl
```

