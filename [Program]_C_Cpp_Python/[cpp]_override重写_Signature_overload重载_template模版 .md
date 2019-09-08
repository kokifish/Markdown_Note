
[TOC]





##### Abstract: 重载 != 重定义 != 重写

1. 重载 **overload**

- **范围相同**
- 函数名字相同，**参数不同**，不依赖于返回值
- virtual关键字可有可无

2. 重写(覆盖) **override**
- 不同的范围，**子类**重新定义父类中**有相同名称和参数的虚函数**(函数签名一致)
- 重写函数具有相同类型，名称，参数列表
- 基类函数**必须有virtual**关键字，不可是static
- 访问修饰符可以不同，virtual是private也可在派生类中override为public, protected

3. 重定义(隐藏) **redefining**

- 子类重新定义父类中有相同名字的**非虚函数**(形参列表可以不同)
- 如果派生类的函数和基类的函数同名，但是参数不同，不管有无virtual，基类的函数被隐藏



>   通过**重载函数**和**运算符重载**可以实现编译时多态性

---

# 函数重载 function overload



- 同名函数**不同形参**//不能仅通过返回类型不同来重载函数
- **同一作用域内，函数名相同，函数的参数列表不同**(个数 || 类型 || 顺序)
- 重载决策：编译器对比使用者传递的参数类型和定义中的参数类型，决定选用最适合的定义，选择最适合的重载函数或重载运算符
- 友元函数重载：第一个参数不是 this 指针


编译器在检查函数特征标时，将类型引用和类型本身视为同一个特征标

```c++
void f(int i) {}//这是一个错误demo
void f(const int i) {}//函数“void f(int)”已有主体//即重复定义
int main() {
	const int a = 0;
	f(a);//error!
}
```



```c++
void f(int* i) {}
void f(const int* i) {}//指向const的指针
int main() {
	const int a = 0;
	const int* p = &a;
	f(p);//调用: void f(const int* i)
}
```



cppp277

---

# 函数签名 signature

函数重载的关键是函数的形参列表，也称为函数特征标

如果两个函数的参数数目和类型相同，同时参数的排列顺序也相同，则特征标相同

> 函数签名 function signature
>
> C/C++ uses function overloading with various signatures
>
> 名字修饰/名字粉碎/名字重整 name mangling / name decoration

A function signature consists of the function prototype. 
函数签名包括函数的原型
It specifies the general information about a function like the name, scope and parameters.
包括函数的一般信息，如名称，范围，形参



- 编译器在检查函数特征标时，将类型引用和类型本身视为同一个特征标
- 匹配函数时，不区分const和非const变量，但const变量必须匹配const形参



---

# 运算符重写 operator override

> 实质是带有特殊名称的函数。由关键字 operator 和其后要重载的运算符符号构成



- 运算符重载的本质是函数重载
- 重载运算符有一个返回类型和一个参数列表
- Box operator + (const Box& temp);
- 定义类型 大多数的重载运算符可被定义为普通的非成员函数或者被定义为类成员函数

---

#### - 负号的重载

- 两种实现方法: 友元函数重载，成员函数重载




```c++
- (负号) **友元函数**重载
class Coordinate{
	//此处是 - 的重载原型，作为友元函数存在
	friend Coordinate& operator - (Coordinate &coor);
	//Coordinate& 是返回对象的引用,coor是传递coo对象的引用,提高传递效率
public:
	Coordinate(int x, int y);
private:
	int m_iX;
	int m_iY;
};
//- 符号重载的实现	//友元函数形式//无需::
Coordinate& operator - (Coordinate &coor){		
	coor.m_iX = -coor.m_iX;
	coor.m_iY = -coor.m_iY;
	return *this;	//等价于 return coor;
}
int main(){
	Coordinate coor1(3, 5);
	-coor1;	//会被解释成一个函数的调用:	//operator-(coor1);//会传入coor1
	return 0;
}
```



```c++
- (负号) 成员函数重载
class Coordinate{
public:
	Coordinate(int x, int y);

	//此处是 - 的重载原型，作为成员函数存在
	Coordinate& operator - ();	//Coordinate& 是对象的引用。目的是返回对象本身
private:
	int m_iX;
	int m_iY;
};
//- 符号重载的实现(成员函数形式)
Coordinate& Coordinate::operator - (){	
	m_iX = -m_iX;	//等价于 this->m_iX = -this->m_iX;
	m_iY = -m_iY;
	return *this;
}
int main(){
	Coordinate coor1(3, 5);
	-coor1;		//会被解释成一个函数的调用:	//coor1.operator-();
	return 0;
}
```









---

#### ++ 符号重载



###### 前置 ++ 运算符成员函数重载

-   若不返回引用，则需要生成临时变量，进行构造、析构，影响效率(同理 [ ]、+=系列、=)
-   也能允许++ ++foo 这样的写法




```c++
//前置++运算符成员函数重载
class Coordinate{
public:
	Coordinate(int x, int y);
	Coordinate& operator++();	//前置++重载的原型
private:
	int m_iX;
	int m_iY;
};
//前置++重载的实现//返回引用
Coordinate& Coordinate::operator ++ (){	
	m_iX++;
	m_iY++;
	return *this;
}
int main(void){
	Coordinate coor1(3, 5);
	++coor1;	//会被解释成一个函数的调用:	//coor1.operator++();
}
```





###### 后置++运算符成员函数重载

-   与前置++区别：返回值不是引用&，形参列表的 int 是一个标识，标识当前++符号做的是后置重载，int标识不传入任何值，即便传入值也没有意义，因为不去使用。只是标识
-   原因：后置++是当前表达式是旧值，当前表达式以后是新值
-   返回const对象：如果没有const,  foo++++ 这样的写法过后，不管能不能编译通过，就算通过，foo只是自增了1次而非两次。增加const则会编译器报错

```c++
//后置++运算符成员函数重载
class Coordinate {
public:
	Coordinate(int x, int y):m_iX(x), m_iY(y) { }
	const Coordinate operator ++ (int);
	//后置++重载原型//返回一个Coordinate对象的值，为const类型
private:
	int m_iX, m_iY;
};
//后置++运算符重载的实现//返回值不是引用，int作为标识
const Coordinate Coordinate::operator ++ (int) {
	Coordinate old(*this);//定义临时对象old，调用拷贝构造
	m_iX++;
	m_iY++;
	return old;//返回拷贝构造函数中定义的old
}
int main() {
	Coordinate coor1(3, 5);
	coor1++;//会被解释成函数调用://coor1.operator++(0);//一般是0，无意义，表明是后置++的运算
}
```









---

#### + 加号的重载

-   ObjectA+=ObjectB 相当于调用 ObjectA.operator+（ObjectB）




```c++
//+ 加号的成员函数重载
#include <iostream>
using namespace std;  

struct Complex {
	Complex(double r, double i) : re(r), im(i) {}  
	Complex operator + (Complex& other);  
	void Display() {   cout << re << ", " << im << endl; }  
private:  
	double re, im;
};  
// Operator overloaded using a member function//加号的成员函数重载
Complex Complex::operator+( Complex &other ) {  
	return Complex( re + other.re, im + other.im );  
}  

int main() {  
	Complex a = Complex( 1.2, 3.4 );  
	Complex b = Complex( 5.6, 7.8 );  
	Complex c = Complex( 0.0, 0.0 );  
	c = a + b;  
	c.Display();//output: 6.8, 11.2
}
```







```c++
//+ 加号友元函数重载//友元函数重载//const可写可不写
class Coordinate{
	firend Coordinate operator+(const Coordinate& c1, const Coordinate& c2);
public:
	Coordinate(int x, int y);
private:
	int m_iX;
	int m_iY;
};
//+ 运算符友元函数重载的实现
Coordinate operator+(const Coordinate& c1, const Coordinate& c2){	
	Coordinate temp;
	temp.m_iX = c1.m_iX + c1.m_iX;
	temp.m_iY = c2.m_iY + c2.m_iY;
	return temp;
}

int main(){
	Coordinate coor1(3, 5);
	Coordinate coor2(4, 7);
	Coordinate coor3(0, 0);
	coor3 = coor1 + coor2;	//相当于调用 operator+(coor1, coor2)
}//coor3 ： 7, 12
```



---

#### = 赋值运算符重载

-   ​







---

#### << 输出运算符重载

- 必须用**友元函数**重载不可以通过成员函数重载
- 第一个参数必须是 ostream &temp//必须是引用
- 返回值必须是 ostream &//即return abc;//必须是引用
  - 调用时 perator << (cout, abc);//可知cout是一个 ostream 类型的对象
- 第一个对象必须是ostream意味着不能是this或当前这个对象



-   You should define `ostream& operator<<(ostream&, const A&)` as a **non**-member function, definitely not as a member of a class since it has nothing to do with that class! That is why you should define define  `operator<<` as a friend function.

```c++
//<< 输出运算符友元函数重载
#include <iostream>
using std::cout;

class Coordinate{
  friend std::ostream& operator<<(std::ostream& out, const Coordinate& coor);
public:
    Coordinate(int x, int y):m_iX(x), m_iY(y){}//构造函数
    private:
    int m_iX;
    int m_iY;
};
// << 输出运算符重载的实现
std::ostream& operator<<(std::ostream & out, const Coordinate& coor){
	out << coor.m_iX << "," << coor.m_iY;
	//out(即第一个形参ostream的标识符) 替代了 cout
	return out;	//必须return ostream & out	//返回类型是ostream
}
int main(void){
	Coordinate coor(3, 5);
	cout << coor;	//相当于调用 operator << (cout, coor);
	return 0;
}//output: 3,5
```





---

#### [ ] 索引运算符重载

- warning 索引运算符**不可以**用友元函数重载，**必须使用成员函数重载** 

  ​

- 索引运算符的第一个值必须是this指针，只有第一个参数是this指针，才能传入索引使索引所表达的是当前对象当中的成员

- 成员函数第一个传入的参数是 this 指针

- 重载索引时，成员函数的第一个隐藏的默认参数为\*this且只能为this\*

```c++
class Coordinate{
public:
	Coordinate(int x, int y);	//构造函数
	int operator[](int index);	// []索引运算符成员函数重载
private:
	int m_iX;
	int m_iY;
};
// [] 索引运算符成员函数重载的实现
int Coordinate::operator[](int index){
	if(0 == index){
		return m_iX;
	}
	if(1 == index){
		return m_iY;
	}
}
int main(void){
	Coordinate coor(3, 5);
	cout << coor[0];//相当于 cout << operator[](0);//即输出 coor 的 m_iX
	cout << coor[1];//相当于 cout << operator[](1);//即输出 coor 的 m_iY
	return 0;
}
```





---

#### ( ) 括号重载

-   函数对象(伪函数)
-   方便实现inline: 

```c++
Class Sum {
	int operator ()(int value1, int value2){
		return (value1+value2);
    }
};
Sum sum;
cout << sum(2,3);//Output: 5
```





#### -> 向量符号重载



```c++
class obj {
public:
	explicit obj(string st):str(st) { }
	void print() {
		cout << str << endl;
	}
private:
	string str;
};

class objcontainer {
public:
	objcontainer(obj ob) : o(ob){ }
	obj* operator ->(){
		return &o;
	}
private:
	obj o;
};

int main() {
	string str("test!");
	obj o(str);
	objcontainer obj_ctn(o);//定义一个objcontainer类型的对象obj_ctn
	obj_ctn->print();//一个对象调用其->
}//Outpur:
test!
```



---

### 不可重载的运算符

- 成员访问运算符(.) 和成员指针访问运算符(.*) 不能重载是为了保证访问成员的功能不能被改变


- :: 域运算符和 sizeof 运算符的运算对象是类型而不是变量或一般表达式，不具备重载的特征

|      |         |                                     |          |
| ---- | ------- | ----------------------------------- | -------- |
| .    | 成员访问运算符 | 成员指针访问运算符                           | .*   ->* |
| ::   | 域运算符    | 长度运算符                               | sizeof   |
| ?  : | 条件运算符   | Preprocessor convert to string(预处理) | #        |
|      |         |                                     |          |



```c++
class ClassName {//本例具体在class.md中
public:
	int foo(int);
};
int (ClassName::*pmf)(int) = &ClassNmae::foo;//把pmf定义为指向ClassNmae::foo()的函数指针
ClassName c;
(c.*pmf)(5);//.*的用法，经由对象调用
ClassName *pc = &c;
(Pc->*pmf)(6);//->*的用法，经由对象指针调用
```



### 不可作为友元重载

友元函数不是该类的成员，因此在友元函数中不能使用this指针

| =    | ()   | []   | ->   |
| ---- | ---- | ---- | ---- |
|      |      |      |      |



---

# 模板 template

> **泛型程序设计**是程序设计语言的一种风格或范式。泛型允许程序员在[强类型程序设计语言](https://zh.wikipedia.org/wiki/%E5%BC%B7%E9%A1%9E%E5%9E%8B%E7%A8%8B%E5%BC%8F%E8%AA%9E%E8%A8%80)中编写代码时使用一些以后才指定的类型，在实例化时（instantiate）作为参数指明这些类型。各种程序设计语言和其编译器、运行环境对泛型的支持均不一样。[Ada](https://zh.wikipedia.org/wiki/Ada)、[Delphi](https://zh.wikipedia.org/wiki/Delphi)、[Eiffel](https://zh.wikipedia.org/wiki/Eiffel)、[Java](https://zh.wikipedia.org/wiki/Java)、[C#](https://zh.wikipedia.org/wiki/C)、[F#](https://zh.wikipedia.org/wiki/F)、[Swift](https://zh.wikipedia.org/wiki/Swift_(%E7%A8%8B%E5%BC%8F%E8%AA%9E%E8%A8%80))和[Visual Basic .NET](https://zh.wikipedia.org/wiki/Visual_Basic_.NET)称之为泛型（generics）；[ML](https://zh.wikipedia.org/wiki/ML%E8%AF%AD%E8%A8%80)、[Scala](https://zh.wikipedia.org/wiki/Scala)和[Haskell](https://zh.wikipedia.org/wiki/Haskell)称之为参数多态（parametric polymorphism）；[C++](https://zh.wikipedia.org/wiki/C%2B%2B)和[D](https://zh.wikipedia.org/wiki/D%E8%AA%9E%E8%A8%80)称之为[模板](https://zh.wikipedia.org/wiki/%E6%A8%A1%E6%9D%BF_(C%2B%2B))。具有广泛影响的1994年版的《Design Patterns》一书称之为参数化类型（parameterized type）//wikipedia





- 模板是泛型编程的基础，泛型编程即以一种独立于任何特定类型的方式编写代码
- **模板**（**Template**）指C++程序设计语言中的函数模板与类模板，是一种[参数化类型](https://zh.wikipedia.org/w/index.php?title=%E5%8F%82%E6%95%B0%E5%8C%96%E7%B1%BB%E5%9E%8B&action=edit&redlink=1)机制，大体对应于java和C＃中的[泛型](https://zh.wikipedia.org/wiki/%E6%B3%9B%E5%9E%8B)，但也有一些功能上的显著差异（C++模板支持后两者没有明确对应的模板模板参数和模板非类型参数，但不支持Java的通配符以及C#的泛型类型约束）。模板是C++的[泛型编程](https://zh.wikipedia.org/wiki/%E6%B3%9B%E5%9E%8B%E7%BC%96%E7%A8%8B)中不可缺少的一部分。
- 关键字：**template typename class**，其中class和typename作用相同，不用于表示类，而用于表示**对象**




### 声明与定义

- 模板定义以关键字`template`开始，后接模板形参表（template parameter list），模板形参表是用尖括号括住的一个或者多个模板形参的列表，形参之间以逗号分隔。模板形参可以是表示类型的类型形参（type parameter），也可以是表示常量表达式的非类型形参（non-type parameter）。非类型形参跟在类型说明符之后声明。类型形参跟在关键字class或typename之后声明。模板形参可以给出默认值（default arguments for template parameters）


```c++
template <class 形参名，class 形参名，......> 返回类型 函数名(参数列表){
/*函数体*/
}
```






### 模板的非类型形参



### 函数模板

- 用于创建一个通用的函数，以支持多种不同的形参，避免重载函数的函数体重复设计。
- 函数使用的数据类型是参数
- **定义函数模版不占用内存**，使用模版时才会产生真正的代码，占用内存



```c++
//函数模版声明形式
template<typename 数据类型参数标识符>
<返回类型><函数名>(参数表){
	函数体
}
```

```c++
template <class T>//class可替换成typename
T max(T a, T b){
	return (a > b) ? a : b;
}

//使用模版//实例化模版函数
int ival = max(100, 99);//模版函数//实例化一个int类型的函数max//由编译器自己选择
char cval = max<char>('A', 'B');//指定是char类型，则实例化
```







### 类模板





```c++
template <typename T>
class A {
	T data;//类型为T的私有成员data
public:
	T func(); //返回类型为T的func函数
};
//在类模版外定义函数时，先写template和模板形参表template parameter list
template<typename T>
inline T A<T>::func() {//用A<T>::说明范围
	return data;
}
```



```c++
#include <iostream>
#include <typeinfo>

using namespace std;

class Spec { int num; };

template <typename T>
class A {
public:
	A();
	void f() {
		cout << "template for " << typeid(T).name() << endl;
	}
};
template <typename T> //类外定义一般的模板需要加template <模板形参表>
A<T>::A() { }

template <> //class A为Spec特例化一个模板
class A<Spec> {
public:
	void f() {
		cout << "special template for Spec" << endl;
	}
	A();
};
//class A<Spec>的特例化模板的构造函数无需再用template <>限定
A<Spec>::A() { }

int main() {
	A<float> a_float;
	A<Spec> a_spec;
	a_float.f();
	a_spec.f();
}//Output:
template for float
special template for Spec
```












