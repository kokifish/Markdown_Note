[TOC]



---

基本概念

- 面向对象程序设计(英语：Object-oriented programming，缩写: OOP)
- .c->.i->.s->.0->可执行文件//C文件生成可执行文件的过程
- 类别构成式面向对象程序设计语言(class-based object-oriented programming language)
- 严格来说，C++中对象的概念和C的对应概念接近，表示的是具有特定类型的存储，而非面向对象意义上的“对象”：一个对象不一定是类类型的。此外，C++意义上的“实例”仅指模板实例化的结果，而并不指对象
- 【数据抽象】只向外界提供关键信息，并隐藏其后台的实现细节，即只表现必要的信息而不呈现细节
- 【数据封装】数据封装是一种把数据和操作数据的函数捆绑在一起的机制，数据抽象是一种仅向用户暴露接口而把具体的实现细节隐藏起来的机制
- C++ 通过创建类来支持封装和数据隐藏(public、protected、private)
- 在面向对象对象程序设计术语中，对象(object)是数据(data)和处理数据的指令(instructions)的联合(association)



|               |                                          |
| ------------- | ---------------------------------------- |
| accessor      | 访问器 存取器	 get只读性质 读受保护的数据成员(private/protected)的函数 |
| mutator       | 修改器 变值器 设置方法	set只写性质 写受保护数据成员的函数         |
| polymorphism  | 多态，多态性                                   |
| inheritance   | 继承                                       |
| disambiguate  | 消除歧义                                     |
| asterix       | 星号 *                                     |
| instantiation | 实例                                       |
| mechanism     | 机制，机理，机构，机械                              |
| process       | 进程                                       |
| thread        | 线程                                       |
| oriented      | adj.导向/定向的;以…为方向的v.调整;使朝向(orient过去分词)确定…的方位 |
| hierarchy     | n. 层级;等级制度                               |
| snippet       | n. 小片;片断;  不知天高地厚的年轻人                    |
|               |                                          |
|               |                                          |
|               |                                          |
|               |                                          |
|               |                                          |
|               |                                          |

---





重载 **overload**   重写(覆盖) **override**   重定义(隐藏) **redefining**

---

# class 类



- 使用类(class)定义特定程序中的数据类型。这些数据类型的**实例**被称为**对象**

- 这些实例可以包含程序员定义的成员变量、常量、成员函数，以及重载的运算符

- 类包含了数据表示法和用于处理数据的方法。类中的数据和方法称为类的成员。函数在一个类被称为类的成员

- 语法上，类似C中结构体（struct）的扩展，结构体是由关键词 struct 定义的一种数据类型。 struct 的成员和基类默认为公有的(public)

- 结构解引用运算符 -> Structure dereference operator. 通过指针访问成员运算符(Element selection through pointer)

> 注意在类定义结束的大括号后要加**分号 ;**

###### 范围解析运算符 ::

>   ::    scope resolution operator范围解析运算符   



-   :arrow_down:派生类中通过 :: 指定调用父类中的函数

```c++
class A {//snippet
private:
	int a;
public:
	int getA () { return a; }
	void setA (int a) { this->a = a; }
};
class B :public A {
private:
	int b;
public:
	//通过范围解析符指定调用class A 中的函数
	void setA (int a) { this->A::setA(a); }//如缺少 A:: 则调用自身，死循环
	int getA () { return this->A::getA(); }
};
```





-   全局变量 命名空间中的变量 局部变量

```c++
namespace NamespaceA {
	int x;
}
//全局变量//注意尽量不要使用全局变量
int x;
int main () {
	int x;
	// the x in main() //访问main()中的x 
	x = 0;
	// The x in the global namespace //访问全局变量x
	::x = 1;
	// A namespace name used to disambiguate消除歧义 //访问 NamespaceA 中的x
	NamespaceA::x = 2;
}
```



-   名字空间/类定义嵌套用 :: 消除歧义

```c++
namespace NamespaceD {
	namespace NamespaceD1 {
		int x;
	}
}
namespace NamespaceE {
	class ClassE {
	public:
		class ClassE1 {
		public:
			int x;
		};
	};
}

int main () {
	//指定调用NamespaceD::NamespaceD1 中的x
	NamespaceD::NamespaceD1::x = 6;
	//指定实例化 NamespaceE 中的 class ClassE 中的class ClassE1
	NamespaceE::ClassE::ClassE1 e1;
	e1.x = 7;
}
```





###### .\* ->\* 指针到成员运算符

- .* 和 –>* 返回表达式左侧上指定的对象的特定类成员的值。右侧必须指定该类的成员
- expression .\* expression   expression –>\* expression //若第二操作数是左值，则结果为左值
- 包含 .* 运算符的表达式中，第一操作数必须是类类型且可访问，而指向第二操作数中指定的成员的指针或可访问类型的成员的指针明确从该类派生并且可供该类访问
- 包含 –>* 运算符的表达方式中，第一操作数必须是第二操作数中指定的类型的“指向类类型的指针”或明确地从该类派生的类型


```C++
#include <iostream>
using namespace std;

class Testpm {
public:
	void m_func1() { cout << "m_func1\n"; }
	int m_num;
};

// These types are pointers to members m_func1() and m_num, respectively.  
void ( Testpm::*pmfn )( ) = &Testpm::m_func1;//Testpm::m_func1()函数指针
int Testpm::*pmd = &Testpm::m_num;//指向Testpm::m_num的int型指针

int main() {
	Testpm ATestpm;
	Testpm *pTestpm = new Testpm;

	( ATestpm.*pmfn )( );
	( pTestpm->*pmfn )( );
  // Parentheses required since * binds less tightly than the function call.
  // ()优先级比 * 高，因此左侧有必要加括号
	ATestpm.*pmd = 1;// Access the member data
	pTestpm->*pmd = 2;//访问数据成员//只能是public中的
	cout << ATestpm.*pmd << endl << pTestpm->*pmd << endl;
	delete pTestpm;
}//output:
m_func1
m_func1
1
2
```



```c++
#include <iostream>
using namespace std;
class BaseClass {
public:
	BaseClass() { cout << "BaseClass Constructor" << endl; }
	void Func1() { cout << "BaseClass Func1" << endl; }
};
// Declare a pointer to member function Func1.
//声明一个指向BaseClass::Func1的函数指针
void ( BaseClass::*pmfnFunc1 )( ) = &BaseClass::Func1;

class Derived : public BaseClass {
public:
	Derived() { cout << "Derived Constructor" << endl; }
	void Func2() { cout << "Derived Func2" << endl; }
};
// Declare a pointer to member function Func2.
//声明一个指向Derived::Func2的函数指针
void ( Derived::*pmfnFunc2 )( ) = &Derived::Func2;

int main() {
	BaseClass ABase;
	Derived ADerived;

	( ABase.*pmfnFunc1 )( );// OK: defined for BaseClass.  
	//( ABase.*pmfnFunc2 )( );// Error: cannot use base class
//to access pointers to members of derived classes.//无法用基类访问派生类方法

	( ADerived.*pmfnFunc1 )( );//unambiguously derived from BaseClass.  
	( ADerived.*pmfnFunc2 )( );// OK: defined for Derived.  
}//output:
BaseClass Constructor//ABase的构造函数
BaseClass Constructor//ADerived中的基类的构造函数
Derived Constructor//ADerived中的派生类函数体
BaseClass Func1
BaseClass Func1
Derived Func2
```





---

###### * this 指针



- 对象通过this指针来访问自己的地址 this 指针是所有成员函数的隐含参数
- 成员函数隐含: 实际上一个类的成员函数隐式传递了一个指向所在类的指针 this//void Func(Class_Name* this) { } |
- warning:友元函数没有 this 指针，因为友元不是类的成员。只有成员函数才有 this 指针
- return *this;//返回


```c++
class Box{
public:	//此处构造函数用了默认参数，如果不传参，则按照默认参数来初始化//例如Box a;//不带参数定义
	Box(double l=2.0, double b=2.0, double h=2.0){//构造函数定义
		length = l;
		breadth = b;
		height = h;
	}
	double Volume(){
		return length * breadth * height;
	}
	int compare(Box box){
		return this->Volume() > box.Volume();//此处用了this指针来调用Box的内联函数Volume()
	}
private:
	double length;double breadth;double height;//私有
};
```



---
### 封装&访问说明符

>   Encapsulation 封装  Access modifiers 访问说明符


- Encapsulation 封装：将数据和处理数据的程序(procedure)组合起来，仅对外公开**接口**(**interface**)，达到**信息隐藏**(information hiding)减少耦合(Coupling)
- Access modifiers  访问说明符: public、private、protected。C++的类对其成员(包括数据成员、函数成员)分为三种封装状态
1. public 公有: 在程序中类的外部是可访问的。您可以不使用任何成员函数来设置和获取公有变量的值
2. protected  保护: 保护成员变量或函数与私有成员十分相似，但保护成员在**派生类**(子类)中是可访问的
3. private 私有(默认): 在类的外部不可访问，甚至不可查看。类和友元函数可以访问私有成员

-   一般，C++类的对外接口设定为公有成员; 类别内部使用的数据、函数设定为私有成员; 供派生自该类别的子类使用的数据、函数设定为保护成员

>类的对象的公共数据成员可以使用直接成员访问运算符 (.) 来访问
>私有的成员和受保护的成员不能使用直接成员访问运算符 (.) 来直接访问









---
#### 类成员函数 & const

>   在class里面声明或定义的函数


- 把定义和原型写在类定义内部的函数，就像类定义中的其他变量一样。类成员函数是类的一个成员，它可以操作类的任意对象，可以访问对象中的所有成员
- 成员函数可以定义在类定义内部，或者单独使用范围解析运算符 :: 来定义
- Box myBox;//创建一个对象    myBox.getVolume();//调用该对象的成员函数
- 成员函数第一个传入的参数必须是 this 指针(默认) 
- 在类定义中定义的成员函数把函数声明为内联的，即便没有使用 inline 标识符
- 在类的外部用范围解析运算符::定义 //TypeName ClassName::FunctionName(parameter)
- 在 :: 运算符之前必须使用类名。调用成员函数是在对象上使用点运算符(.)，才能操作与该对象相关的数据

```c++
class Box{
public:			//公有
    double length;	//double型变量长度
    double get_length(){//该成员函数定义在类的内部，把函数声明为内联的
    	return length;
    }
};
```

```c++
//在类的外面定义类的成员函数//注意使用范围解析符
double Box::getVolume(){//TypeName ClassName::FunctionName()
	return length * breadth * height;
}
```



常成员函数 const

>   对捆绑的对象, 不允许写操作//形参列表后带有const

- 声明: bool ClassName::FuncName(const ClassName& a) const;
- 定义: bool ClassName::FuncName(const ClassName& a) const {   }





---

#### 构造函数 constructor

三种构造函数: Default constructor, Parameterized constructor, Copy constructor

-   类的特殊的成员函数 在每次创建类的新对象时执行且必须执行(其中一个版本)
-   构造函数不可以显式调用 //例如在重载 = 时调用构造函数会导致编译错误
-   构造函数可被重载，不能是虚函数，一定要在public中，不被继承
-   可用于为某些成员变量设置初始值(形参列表中可以初始化const变量)
-   显式无参构造 **ClassName() = default;**//表示使用默认的无参构造函数
-   no-arg constructor 无参构造。无显式定义构造函数，则自动生成什么都不做的无参构造
-   构造函数的名称与类的名称 完全相同。无返回值，不返回void
-   构造函数不能是虚函数。而且，在构造函数中调用虚函数，实际执行的是父类的对应函数，因为自己还没有构造好, 多态是被disable的




- 没有带明显形参的构造函数，提供了默认实参的构造函数称为默认构造函数(编译器总会在构造函数形参表插入一个隐含的this指针，因此本质上不存在不带形参的构造函数)
- 编译器自动生成的默认构造函数成为“合成的默认构造函数”
- 合成的默认构造函数不会初始化内置或复合类型的成员



![](https://ooo.0o0.ooo/2017/06/28/5953170e6a273.jpg)

编译器需要默认构造函数，会生成默认构造函数的情况:

1. 类没有任何构造函数时，含有类对象数据成员，且该类对象数据成员有默认构造函数，则在构造函数真正需要被调用时，会生成默认构造函数
2. 基类带有默认构造函数的派生类。若类中定义了多个构造函数，编译器不会重新定义一个合成默认构造函数，而是把合成默认构造函数的内容插入到每个构造函数中
3. 带有虚函数的类。不论是类本身定义了虚函数，还是从继承体系中继承了虚函数，都会因为需要vptr来满足虚函数机制，而生成一个合成默认构造函数来设置vptr的初值。//同样，如果已经定义了构造函数，则会自动在每个构造函数中插入设置vptr的代码





```c++
class Line {//声明类型名为Line的class类型变量
public:	
	Line(double len);//声明Line的构造函数//构造函数的函数名与class名相同
	void setLength( double len );
	double getLength( void );
private:
    double length;
};

//！！！Line的构造函数定义
Line::Line( double len) {//也可以放在class Line的声明中定义构造函数
	cout << "Object is being created, length = " << len << endl;
	length = len;
}//构造函数不返回任何类型

/*使用初始化列表来初始化字段Line构造函数的另一种写法，可以改变const变量
Line::Line( double len): length(len){	//把传递过来的变量len的值赋值给length
	cout << "Object is being created, length = " << len << endl;
}*以上是使用初始化列表来初始化字段的 demo *************/

void Line::setLength( double len ) {//Line的成员函数定义
	length = len;//接收一个double len后给length赋值
}

double Line::getLength( void ) {//Line的成员函数定义
	return length;//返回length，成员函数可以访问private数据
}
int main( ) {
	//Line有构造函数(但没有无参构造)定义新class Line的实例line时，要传递对应的变量
	Line line(10.0);

	cout << "Length : " << line.getLength() <<endl;// 获取默认设置的长度
	line.setLength(6.0); 		// 再次设置长度
	cout << "Length : " << line.getLength() <<endl;
}
```





###### 初始化列表

>单个冒号的其中一个用处

-   构造函数名与类名相同。同时注意这种构造函数的写法使用到了单个冒号



>类名 **::** 构造函数名(形参列表)**:** 字段(形参1)**,** 字段(形参2)**,** 字段(形参3){
>​	 构造函数的其它内容;
>}


-   " 字段( 形参 ) " 的数量可以少于 形参列表 中形参的数量//形参也可以多次使用
-   使用形参列表可以**改变**类中的**const**变量 :happy:


```c++
//demo snippet 该demo涉及 构造函数 友元类
class B_Test;//前置声明class B_Test
class A_Test{
	friend class B_Test;//声明友元类 B_Test
public:	//char* pchar_para 与 //char pchar_para[] 效果相同，同样传递首地址
	A_Test(int int_para, char pchar_para[]) : A_int(int_para), A_pchar(pchar_para){	//类成员变量(形参)
		cout << "A_Test的构造函数被定义在类定义中" << endl;
	}
protected:
	char* A_pchar;
private:
	int A_int;
};
class B_Test{			//定义A_Test的友元类B_Test
public:
    B_Test (void* pvoid_para){//这个构造函数必须在public中
    	B_pvoid = pvoid_para;
    }
    int getA_Test_A_int(A_Test &classA_var){//给外部调用的话就需要在public中
        return classA_var.A_int;//访问友元类 A_Test 的 private 成员  
    };
private:
    void* B_pvoid;
};
int main() {
	void* pvoid_aaa = (void*)0xabcdef;//定义一个void指针，注意要强制转换
	A_Test classA_var(3, NULL);	
	//传参以初始化class A_Test类型的变量classA_var
	B_Test classB_var(pvoid_aaa);
	//传参以初始化 class B_Test 类型的变量 classB_var
	cout << classB_var.getA_Test_A_int(classA_var)<<endl;
	//友元类的函数可以访问友元类的保护和私有变量//类名.类成员函数名(参数列表)
}
```









###### explicit specifier

>   explicit: 明确的，精密，不含糊，明确的，明晰的，直率的。反义: implicit

-   The explicit specifier specifies that a **constructor** or **conversion function** (since C++11) **doesn't allow implicit conversions or copy-initialization**. It may only appear within the decl-specifier-seq of the declaration of such a function within its class definition.
-   explicit 说明符指定构造函数或转换函数(c++11)**不允许隐式转换或隐式拷贝构造**。这可能只出现在类定义中的函数声明上
-   阻止不应该允许的经过[转换构造函数](http://en.cppreference.com/w/cpp/language/converting_constructor)进行的隐式转换的发生。有效得防止构造函数的隐式转换带来的错误或者误解

```c++
struct A{
	A() { }         // converting constructor (since C++11)  
	A(int) { }      // converting constructor 转换构造函数
	A(int, int) { } // converting constructor (C++11)
	operator bool() const { return true; }
};
 
struct B{
	explicit B(int) { }
	explicit B(int, int) { }
	explicit operator bool() const { return true; }
};
 
int main(){
    A a1 = 1;      // OK: copy-initialization selects A::A(int)
    A a2(2);       // OK: direct-initialization selects A::A(int)
    A a3 {4, 5};   // OK: direct-list-initialization selects A::A(int, int)
    A a4 = {4, 5}; // OK: copy-list-initialization selects A::A(int, int)
    A a5 = (A)1;   // OK: explicit cast performs static_cast
    if (a1) ;      // OK: A::operator bool()
    bool na1 = a1; // OK: copy-initialization selects A::operator bool()
    bool na2 = static_cast<bool>(a1); // OK: static_cast performs direct-initialization
 
	//B b1 = 1;   // error: copy-initialization does not consider B::B(int)
    B b2(2);       // OK: direct-initialization selects B::B(int)
    B b3 {4, 5};   // OK: direct-list-initialization selects B::B(int, int)
  
	//编译不通过，不允许隐式的转换。调用 B::B(int,int); 被 explicit 关键字禁止了
//	B b4 = {4, 5};
	//error: copy-list-initialization does not consider B::B(int,int)

    B b5 = (B)1;   // OK: explicit cast performs static_cast
    if (b2) ;      // OK: B::operator bool()
//  bool nb1 = b2;// error: copy-initialization does not consider B::operator bool()
    bool nb2 = static_cast<bool>(b2);
	// OK: static_cast performs direct-initialization
}
```



###### 拷贝构造函数 

> shallow 浅

-   特殊的构造函数，创建对象时，使用同一类中之前创建的对象来初始化新创建的对象

-   ClassName (ClassName &toCopy);   //拷贝构造函数名与类名相同
-   唯一的一个参数是本类型的一个引用变量，该参数应该设为 const 类型，不可修改
-   当类的对象需要拷贝时，拷贝构造函数将会被调用
-   拷贝构造函数一定要传引用，否则会导致递归调用//传值时创建新对象，创建新对象调用拷贝构造函数，而这个拷贝构造函数又传值，又调用拷贝构造函数...

```c++
classname (const classname &obj) {	//声明用类名，参数为const 对应类的指针
	// 构造函数的主体
}
//类中包含指向另一个类的指针，通过new ClassName(*(temp.ClassName)) 传值new
Person::Person(Person& temp){
	this->id = temp.getId();
	this->birthDate = new Date(*(temp.birthDate));
	//虽然class Date中没有拷贝构造函数，但依旧可以如此调用
}
```



###### 转换构造函数

> Converting constructor

- A constructor that is **not** declared with the specifier **explicit** and which can be called with a single parameter (until C++11) is called a **converting constructor**.
- 没有explicit关键字的构造函数
- **Unlike explicit constructors**, which are only considered during direct initialization (which includes explicit conversions such as static_cast), converting constructors are also considered during copy initialization, as part of user-defined conversion sequence.
- **explicit 构造函数只在显示初始化时调用**
- It is said that a converting constructor specifies an **implicit conversion** from the types of its arguments (if any) to the type of its class. Note that **non-explicit user-defined conversion function** also specifies an **implicit conversion**.
- Implicitly-declared and user-defined non-explicit copy constructors and move constructors are converting constructors.
- 隐式声明和用户定义的**非explicit**拷贝构造函数和移动构造函数都是转换构造函数。
- 对比ClassName(2.5)和int(2.5)。二者形式类似，int(2.5)是强制类型转换，将2.5转换为整数。可以认为Complex(2.5)的作用也是强制类型 转换，将2.5转换为Complex类对象。

---

#### 析构函数

类的特殊的成员函数 在每次删除所创建的对象时执行 ~Class\_Name 为标志


- 有助于在跳出程序(如关闭文件、释放内存...)前释放资源
- 析构函数的名称与类的名称完全相同。前面以波浪号( ~ )作为前缀。无返回值，无任何参数
- **析构函数应是虚函数，除非类不用做虚类**
- 构造函数在定义对应class变量时执行，析构函数在删除对应class变量时执行
- [内存泄漏]  析构函数应 delete 在构造函数中 new 的对象!



```c++
//demo snippet 析构函数声明与定义
class Line{
public:
	~Line();	//析构函数声明
private:
	double length;
};
Line::~Line(void){	//析构函数定义	//不传参，不返回
	cout << "析构函数在删除所建对象时执行！Object is being deleted" << endl;
}
```




```c++
#include <string>//delete 一个 class 的作用过程
#include <iostream> 
//using namespace std;
class A{
public:
	//构造函数中 new 了一个指向 int 的指针 ptr 
	A(){//此处 new 一个 int 因此class A实例化后将拥有其它资源(int)
		ptr = new int;
	}
	~A(){//析构函数中没有 delete 指向 int 的指针 ptr
		//delete(ptr);	//此处理应delete(ptr)以释放ptr指向的内存
	}			//由于没有释放ptr指向的内存，所以造成内存泄漏
private:
	int data;
	int *ptr;
};
int main(){
	A* ptr_A = new A;
	delete(ptr_A);
	return 0;
}
```
- main内delete执行

  1. 调用析构函数，释放类成员变量指向的内存//但这个析构函数没有写，所以不释放ptr所指向的内存
2. 调用free释放类ptr_A，释放类所占的内存//本例中就是释放 date 和 ptr 自身所占的内存

> 若对象**持有了其他资源**，比如其他new对象的指针，文件句柄，互斥量等，编译器不知道该如何释放它们，得**靠析构来正确释放**







---

#### 类型转换函数

>   type conversion function 类型转换函数 类型转换运算符函数 类型转换运算符重载函数 强制类型转换运算符重载函数

-   **将一个类的对象转换成另一类型的数据**
-   类型转换函数只能作为**成员函数**，因转换的主体是本类的对象，不能作为友元函数/普通函数
-   **operator** 类型名{ }
-   函数名前**不能指定函数类型**，**没有形参**。**返回值的类型是函数名中指定的类型名**
-   与转换构造函数作用相反，转换构造函数将一个指定类型转换成类的对象



```c++
#include <iostream>
using namespace std;
class Complex {
public:
	Complex(double r,double i) : real(i), imag(i){ }

	//类型转换函数
	operator double( ) {//不能指定返回类型，没有形参
		return real;//返回的类型是operator后的类型double
	}
private:
	double real;
	double imag;
};
int main( ) {
	Complex c1(3, 4), c2(5, -10);
	double d;
	d = 2.5 + c1;//将一个double数据与Complex类数据相加，调用类型转换函数
	// 2.5 + 3
	cout << d << endl;
	return 0;
}//Output:
5.5
```

>   如果没有定义类型转换函数，则编译出错，因为不能将一个double对象和一个不同类型的对象相加



#### 默认函数&已删除函数

-   可以显示控制是否生成特殊成员函数
-   c++中，若某个类型未声明它本身，编译器将自动为该类生成默认构造函数、复制构造函数、复制赋值运算符和析构函数//这些称为特殊成员函数，使 C++ 中的简单用户定义类型的行为如同 C 中的struct
-   如果显式声明了任何构造函数，则不会自动生成默认构造函数
-   如果显式声明了虚拟析构函数，则不会自动生成默认析构函数
-   如果显式声明了移动构造函数或移动赋值运算符，则：
    - 不自动生成复制构造函数。
    - 不自动生成复制赋值运算符。
-   如果显式声明了复制构造函数、复制赋值运算符、移动构造函数、移动赋值运算符或析构函数，则：
    - 不自动生成移动构造函数
    - 不自动生成移动赋值运算符
-   如果显式声明了复制构造函数或析构函数，则弃用复制赋值运算符的自动生成
-   如果显式声明了复制赋值运算符或析构函数，则弃用复制构造函数的自动生成



```c++
struct noncopyable {//snippet//c++11前的做法
	noncopyable() {};  
private:
	noncopyable(const noncopyable&);//在private中仅声明不定义
	noncopyable& operator=(const noncopyable&);//在private中仅声明不定义
};

struct noncopyable {//与上例等同
	noncopyable() = default;
	noncopyable(const noncopyable&) = delete;
	noncopyable& operator = (const noncopyable&) = delete;
};
```

```c++
class A {
public:
    A() : a(1) {}
private:
    const int a;
};

int main() {
    A a, b; //调用默认构造函数
    A c(a); //使用默认的拷贝构造函数
    a = b;  //compile error!因为A::a是const int，只能进行初始化，不能进行赋值
}
```







---

### 聚合类 & POD 结构

没有用户定义的构造函数，没有私有(private) 保护(protected)非静态数据成员，没有基类，没有虚函数

```c++
struct C{
	int a;
	double b;
};

struct D{
	int a; 
	double b;
	C c;
};
// initialize an object of type C with an initializer-list
C c = { 1, 2 };
// D has a sub-aggregate of type C. In such cases initializer-clauses can be nested
D d = { 10, 20, { 1, 2 } };	//可以由封闭的大括号用逗号分隔开初始化列表
```



---

POD 结构 (普通旧式数据结构)

> 有时不正式地被称为“C风格结构”(C-style struct)

- 是一个不包含非POD结构、非POD联合(或者这些类型的数组)或引用的非静态成员变量(静态成员没有限制)，并且没有用户定义的赋值运算符和析构器的聚合类
- 可以说是C struct在C++中的等价物。在大多数情况下，一个POD结构拥有和一个在C中声明的对应的**结构相同的内存布局**







---

# 友元

>  key word: friend

- 友元关系不可传递，友元关系有单向性
- 友元只是封装的补充，不建议使用
- 在派生类中声明的友元(函数/类)不能访问基类中的private，但可访问protected/public

```c++
class Base {
protected:
	int a;
};
class Derived :public Base {
	friend void print(const Derived& rhs);
};
void print(const Derived& rhs) {//注意函数签名要一致
	cout << rhs.a;//可以访问基类的protected
}

int main() {
	Derived test;
	print(test);
}//Output: 垃圾值
```



### 友元类

一个类与另一个类友元

- 友元类的声明在该类的声明中，而实现在该类外
- 由于编译器不同，友元类有两种写法。1、friend class 类名; 2、friend 类名;

```c++
class Circle;		//需要先声明class Circle
class Test{
	friend Circle;	//声明友元类Circle
	private:
	int b;			//private和protected可被友元类访问
}
class Circle{		//实现友元类Circle
public:  
	int getB_b(B _classB){  
		return _classB.b;//访问友元类B的私有成员  
	};
};
```





### 友元全局函数

>    原型有在类的定义中出现，不属于成员函数，但可以访问类的private/protected成员

- 定义在类外部，**有权访问类的所有私有(private) 保护(protected)成员**
- 原型在类的定义中出现过，但友元函数不是成员函数
- 在类定义中友元函数原型前加关键字 firend
- 因为已经有权访问类的私有/保护成员，故声明在private也可以正常调用

```c++
#include <iostream>
using namespace std;
class Box {
private://将友元函数放在private中也不影响正常调用
	//友元全局函数声明，前加friend//在class Box中声明//传递类型是Box类型的引用
	friend void printWidth (Box& box);
	int width = 0;
};
//printWidth() 不是任何类的成员函数，定义时不需要范围解析运算符::
void printWidth (Box& box) {
	cout << "Width of box : " << box.width << endl;
	//printWidth() 是 Box 的友元，可以直接访问该类的任何成员
}

int main () {
	Box box;
	printWidth (box);//直接调用 printWidth 无需通过box.调用
}
```

### 友元成员函数

- 在**另一个类中**定义的函数，与该类friend

```c++
class a{
	friend void b::Func_Name(a &t);
	//这个是定义在b中的class a的友元函数//可写在public private protected中
}
```





---

# 内联inline


- 内联函数的代码副本放置在**每个**调用该函数的地方
- 编译时编译器会把该函数的代码副本放置在每个调用该函数的地方//C++ 内联函数是通常与类一起使用
- 作为编译器优化手段的一种技术，可以降低运行时间。但增大可执行程序的体积
- 声明: 在函数名前面放置关键字 inline//最终是否采用由编译器决定
- **类定义中的定义的函数都是内联函数**，即使没有 inline 说明符。利于类实现细节的隐藏
- 对内联函数进行任何修改，都需要重新编译函数的所有客户端，因为编译器需要重新更换一次所有的代码，否则将会继续使用旧的函数
- 内联函数不能进行递归调用

```c++
Class A{//snippet//pattern_1: 在类定义中定义
Public:
	inline int add(int a, int b){//默认已经是inline
		return (a + b);
	};
}

Class A{//pattern_2: 在类定义外定义
Public:
	int add(int a, int b);
};

inline int A::add(int a, int b){	//内联函数的具体定义，注意范围解析符::
	return (a + b);
}
```


>###### 其余说明
>
>内联声明只是一种对编译器的建议，编译器是否采用内联措施由编译器自己来决定。甚至在汇编阶段或链接阶段，一些没有inline声明的函数编译器也会将它内联展开。
>编译器的内联看起来就像是代码的复制与粘贴，这与预处理宏是很不同的：宏是强制的内联展开，可能将会污染所有的命名空间与代码，将为程序的调试带来困难。
>所有中类中定义的函数都默认声明为inline函数，我们不用显示地去声明inline。
>**虚函数不允许内联**
>虽然说模板函数放中头文件中，但它们不一定是内联的
>
>### 内联与宏macro
>
>C语言用预处理器语句#define来提供宏——内联代码的原始实现
>
>e.g   #define SQUARE(X) ((X)*(X)) //注意加括号，否则可能有意向不到的运行结果



### 虚函数的内联问题

- 说法一：虛函數肯定不會被内联這一点毋庸置疑，因为虛函數只有到了Runtime才能被识别到底是哪一個被調用，而内联是編譯期就會將代碼展開並安插這個明显不是一回事
- 内联函数是可以内联的，在使用d->Base::f()形式调用时，可能会被内联


```c++
class A {
public:
	virtual void foo();
};
class B : public A {
	inline virtual void foo() final { }
};
class C : public B{ };

void bar(B const& b) {
	A const& a = b;// Allowed, every B is an A.
	a.foo();//Call to B::foo()can be inlined, even if b is actually a class C
}
```





---

# static静态成员

>   **static** 静态数据成员 静态成员函数 静态成员只有**一个副本**

-   在类的所有对象中共享
-   初始化: 如果不存在其他的初始化语句，创建第一个对象时，静态数据会被初始化为零?
-   依赖性: 调用静态成员函数和静态数据成员时，并不与对象相关，只是与类相关
-   内存中如果不实例化类，静态成员数据/函数在内存中仍然存在
-   sizeof : sizeof求对象大小时，不包含静态成员




### 静态数据成员

-   **类中声明用static**  **类外定义不用static**
-   非静态的成员函数可以调用静态成员
-   静态成员函数用 ClassName::var访问
-   静态数据成员必须**单独在类外单独初始化** //而不是在构造函数中
-   作用域: 在类范围中声明数据成员，但在文件范围内执行定义
-   warning: 静态数据成员不是对象的一部分。因此，静态数据成员的声明不被视为一个定义







###### 静态数组的初始化

```c++
class Factory {//snippet
private:
	static Stooge* s_prototypes[4]; 
};

Stooge* Factory::s_prototypes[] = { 0, new Larry, new Moe, new Curly };

class Card {
private:
    static const char* Names[2];
};
const char* Card::Names[2]={"Ace", "Deuce"};
```





### 静态成员函数

-   **类中声明用static**  **类外定义不用static**
-   公有静态成员函数即使在类对象不存在的情况下也能被调用
-   公有静态函数使用类名加范围解析运算符 :: 访问 或者用 对象.静态成员函数名访问
-   静态成员函数**不能调用非静态成员函数和非静态数据成员**
-   **只能访问静态成员** 不能访问常数据成员和类外部的其它函数，没有this指针


> 静态成员函数不属于任何对象，而**依赖于类**，把函数与类的任何特定对象独立开来。故无法隐式传递指向一个对象的this指针


```c++
//snippet//静态成员与普通成员声明与定义的对比
class Tank{
public:
	Tank(){ Tank_Count++; }//构造函数//访问静态数据成员
	~Tank(){ Tank_Count--; }//析构函数

	void fire(){//函数成员隐式传递参数(Tank* this)
		m_strCode = "01";
		Tank_Count = 0;//静态数据成员依赖于类而不依赖于对象
	}
	static int getCount(){//静态函数成员
		return Tank_Count;
	}
	static int Tank_Count;//静态数据成员//静态数据成员的声明不被视为一个定义
private:
	string m_strCode;//常数据成员，普通数据成员
};
int Tank::Tank_Count = 0;//静态数据成员单独实例化，实例化时无需添加static

//1、通过类访问(使用::)   2、通过对象访问(使用.)
int main(void){
	cout << Tank::getCount() << endl;	//通过类调用静态函数成员
	cout << Tank::Tank_Count << endl;	//通过类访问静态数据成员
	Tank tank;			//实例化class Tank
	cout << tank.getCount() << endl;	//通过对象调用静态函数成员
	cout << tank.Tank_Count << endl;	//通过对象访问静态数据成员
}
//---也可以如下定义-------------------------------------------------
int Tank :: getCount(){//静态函数成员//类外定义不用static
	return Tank_Count;//返回的是一个类的静态成员
}
```











---

# 继承 & 多态



>   inheritance继承  derived派生  polymorphism多态  override覆盖/重写


1.  代码重用：子类继承父类的行为

2.  概念重用：子类重写在父类中定义的行为

>  虽然子类和父类**没有代码共享**，子类和父类**分享方法的定义**


-   多继承(Multiple Inheritance)是指从多个直接基类中产生派生类的能力
-   多继承: 一个子类可以有多个父类，它继承了多个父类的特性


```c++
class Derived: public Base1, public Base2 { };
```

five types of inheritance: single, Multiple, Hierarchical(分层的), Multilevel(多层的), Hybrid(混合的)



---

### 继承 inheritance

>    依据另一个类来定义一个类，一个类可以派生自多个类 是一种 is a 的关系
>
>    派生类方法中，使用域解析运算符调用基类方法//不重定义redefining或重写override则不需要



> ### 继承类型
>
> 继承类型 public、protected 或 private，**默认为 private**   //继承访问控制
>
> 1. 公有继承(public)  派生自公有基类 //使用频率最高
>    基类的公有成员也是派生类的公有成员，基类的保护成员也是派生类的保护成员
> 2. 保护继承(protected)  派生自保护基类
>    基类的公有和保护成员将成为派生类的保护成员 //可被以该类为父类的派生类访问
> 3. 私有继承(private)  派生自私有基类
>    基类的公有和保护成员将成为派生类的私有成员 //private无法被继续派生的派生类访问







-   派生类继承下来的成员称为派生类的**继承成员**
-   类派生列表  class derived-class: access-specifier base-class { };

1. **derived class派生类** 指定新建的类继承了一个已有的类的成员 //sub class子类
2. **base-class基类** 之前定义过的某个类的名称，被继承 //parent class父类、super class超类
- public派生类可访问基类的public, protected, **不可访问private**
- 派生类继承了所有的基类方法，下列**除外**：基类的构造+析构+拷贝构造函数 
- **基类的私有成员不能直接被派生类访问**，但是**可以通过调用基类的公有和保护成员来访问**
- protected: 具有private与public双重身份，对派生类成员函数为public, 对类外部而言是private. 即protected成员只能由本类和后代类的成员函数访问


>   多层继承中，无论是第几层派生类均可将其指针 push_back 到其最顶端基类的`vector<Base*>`中




```c++
#include <iostream>
using namespace std;

class Polygon {//Polygon多边形
protected://若放在private，则派生类无法直接访问，但可通过protected/public接口访问
	int width, height;//派生类可访问protected/public
public:
	Polygon( int a, int b ) : width( a ), height( b ) { }//Constructor
	//派生类通过指针/引用调用虚函数时，将会寻找派生类自己的area函数
	virtual int area( void ) { return -1; }
	void printarea( ) {//用指针调用该对象的area将调用派生类自己的area
		cout << "this->area( ):" << this->area( ) << endl;}
};

class Rectangle : public Polygon {//公有继承
public:
	Rectangle( int a, int b ) : Polygon( a, b ) { }//调用基类构造函数
	int area( ) override { return width*height; }//override基类的对应虚函数
};//如果是通过基类指针/引用调用到area(),则在private也一样运行

int p_getArea( Polygon* p_Polygon ) {//传指针与传引用类似
	//通过指针调用时,虚函数优先调用派生类版本//不是虚函数则调用基类自己的版本
	return p_Polygon->area( );//优先级: 派生类版本 > 基类版本
}
int val_getArea( Polygon p_Polygon ) {//通过传值方式传参，
	return p_Polygon.area( );//通过Polygon值调用，只能调用到Polygon版本
}
int main( ) {
	Polygon * p_Polygon = new Rectangle( 4, 5 );
	p_Polygon->printarea( );//通过指针调用，将优先使用派生类自己的成员函数
	cout << "pass by pointer: " << p_getArea( p_Polygon ) << endl;
	cout << "pass by value : " << val_getArea( *p_Polygon ) << endl;
	delete p_Polygon;
}//output:
this->area( ):20
pass by pointer: 20
pass by value : -1
```

继承时应遵守的守则:

1.  绝不重新定义继承而来的缺省参数(Never redefine function’s inherited default parameters value.)
2.  






###### constructor与调用顺序



-   基类的构造函数不被继承，派生类需要声明自己的构造函数
-   继承来的基类成员(继承数据成员)通过派生类构造函数中写出调用版本并由XXX自动调用基类构造函数来完成
-   派生类的构造函数需要给基类的构造函数传递参数

定义派生类构造函数时，通过**初始化列表显式调用基类的构造函数**(有参无参均可)，调用无参版本时可以直接不写

```c++
class Polygon {//snippet
	int width, height;
public:
	Polygon(int a, int b) : width(a), height(b) { }//constructor
	Polygon() = default;//no-arg constructor
};

class Rectangle : public Polygon {
public:
	Rectangle(int a, int b) { }//调用no-arg constructor
//	Rectangle(int a, int b) : Polygon(){ }//调用no-arg constructor
//	Rectangle(int a, int b) : Polygon(a, b){ }//调用Polygon(int, int)函数
};
```



**调用顺序**

1.  **基类**的构造函数(按照**基类被继承时的声明顺序**)//further in 虚继承之构造函数 block
2.  本类**对象成员**的构造函数(顺序按**对象成员在本类中的声明顺序**)
3.  **本类的构造函数**//最后执行

撤销派生类对象时，析构函数的调用次序与构造函数调用次序**相反**

1.  本类的析构函数

2.  本类对象成员的析构函数

3.  基类的析构函数


> C++标准规定以对象**声明相反的顺序**销毁这些对象


```c++
#include <iostream>
using namespace std;
class V1 {
public:
	V1() {cout << "V1 no-arg constructor" << endl;}
	V1(const V1 &v1) {cout << "V1 copy constructor" << endl;}
	~V1() {cout << "V1 deconstructor" << endl;}
};

class V2 {
public:
	V2() {cout << "V2 no-arg constructor" << endl;}
	V2(const V2 &v2) {cout << "V2 copy constructor" << endl;}
	~V2() {cout << "V2 deconstructor" << endl;}
};

class Base {
public:
	Base() {cout << "Base no-arg constructor" << endl;}
	~Base() {cout << "Base deconstructor" << endl;}
};

class Derived : public Base {
public:
	Derived() { cout << "Derived no-arg constructor" << endl; }
	Derived(const V1 &v1, const V2 &v2) : m_v1(v1), m_v2(v2) {
		cout << "Derived constructor with[V1, V2] - by references" << endl;
	}
	Derived(const V2 &v2, const V1 &v1) : m_v2(v2), m_v1(v1){
		cout << "Derived constructor with[V2, V1] - by references" << endl;
	}
	~Derived() { cout << "Derived deconstructor" << endl; }
private:
	V1 m_v1;//在调用本类对象成员时，构造函数调用顺序与声明顺序一致
	V2 m_v2;//(与虚继承构造顺序同理，可以保证唯一的析构顺序)
};

int main (int argc, char** argv) {
	V1 v1; V2 v2;//v1 v2 调用构造函数

	cout << endl << "test case 1:" << endl;
	Derived deri_1;//先基类，后对象成员，最后本对象的构造函数

	cout << endl << "test case 2:" << endl;
	Derived deri_2(v1, v2);//

	cout << endl << "test case 3:" << endl;
	Derived deri_3(v2, v1);//(3)
}//output:
V1 no-arg constructor
V2 no-arg constructor

test case 1:
Base no-arg constructor//先基类的构造函数
V1 no-arg constructor//按声明顺序，类成员中第一个类对象的构造函数
V2 no-arg constructor//类成员中第二个类对象
Derived no-arg constructor//该类对象自己的构造函数

test case 2:
Base no-arg constructor
V1 copy constructor
V2 copy constructor
Derived constructor with[V1, V2] - by references

test case 3:
Base no-arg constructor
V1 copy constructor
V2 copy constructor
Derived constructor with[V2, V1] - by references//传参顺序不影响构造函数调用顺序
test case end

Derived deconstructor//逆序析构，先调用类自己的析构函数
V2 deconstructor//调用类成员中倒数第一个类对象的析构函数
V1 deconstructor//调用类成员中倒数第二个类对象的析构函数
Base deconstructor//调用该类对象的基类对象的析构函数
Derived deconstructor
V2 deconstructor
V1 deconstructor
Base deconstructor
Derived deconstructor
V2 deconstructor
V1 deconstructor
Base deconstructor
V2 deconstructor
V1 deconstructor
```

>   1.  创建对象v1, v2 ，执行v1, v2的构造函数
>   2.  Test Case 1:创建对象deri\_1，先执行基类Base的构造函数，其次成员m\_v1,m\_v2的构造函数来构造成员，最后调用自身的构造函数(无参数)
>   3.  Test Case 2:创建对象deri\_2，调用顺序与case 1顺序相同，但m\_v1,m\_v2调用的是拷贝构造函数，Derived(const V1 &v1, const V2 &v2) 版本
>   4.  Test Case 3:创建对象 deri\_3，调用顺序与case 1顺序相同。注意deri\_2,deri\_3的创建执行的是不同的Derived构造函数，虽然构造函数参数的顺序不同，但是构造成员的顺序是相同的
>   5.  销毁对象deri\_3, deri\_2, deri\_1，析构函数执行顺序相同，与构造对象的顺序相反
>   6.  销毁对象v1, v2



tips:

1.  基类的构造函数执行顺序不受初始化列表中的次序影响，**仅由类声明中的继承顺序决定**//因为构造函数可以重载多个，在初始化列表中的次序可以不同，而类声明则是唯一的，继承顺序的唯一导致了析构函数可以获得唯一的逆序
2.  析构严格按照构造相反的次序执行
3.  对象成员的构造函数按**对象成员在本类中的声明顺序**执行，理由类比基类构造函数顺序












###### 恢复访问控制

-   基类中的public/protected成员，因使用protected/private继承访问控制，导致在派生类中的访问权限发生改变，可以使用"访问声明"恢复为原来的访问控制方式
-   基类名::成员名; //放于适当的成员访问控制后

```c++
class Base {//snippet
public:
	void set_i(int x) { i = x; }
protected:
	int i;
};

class Derived: private Base {//私有继承
public: //如果将BASE::set_i;放在protected:后将无法在类外部调用
	Base::set_i; //访问声明//恢复为原来的访问控制方式public
	Base::i; //访问声明//恢复为原来的访问控制方式protected
	void test(int x){ set_i(x); }//由于恢复了，故可调用BASE::set_i
	int get_ij() { return i + j; }//由于恢复了，故可访问BASE::i
};
```



###### 赋值&指针&引用

-   可将后代类的对象赋值给祖先类对象，反之不可
-   祖先类 = 后代类 (赋值)//valid,  但导致继承成员被"忽略"
-   每个派生类对象包含一个基类部分，意味着可以将派生类对象当作基类对象使用
-   可以用基类指针存储公有派生类对象地址，反之不可，派生类指针不能指向基类
-   只有公有派生类才能兼容基类类型

```c++
class Base {};//snippet
class Derived : public Base {};//公有派生类才能兼容基类类型
{
	Base base;
	Derived derived;
	Base* p_Base = nullptr;//基类指针
	p_Base = &derived;//指向基类对象的指针也可指向公有派生类对象
	Derived* p_Derived = nullptr;//派生类指针
//	p_Derived = &base;//Error: 派生类指针不能指向基类
}
```

- 基类指针可以在不进行显式转换的情况下指向派生类对象，基类引用可以在不进行显式类型转换的情况下引用派生类对象，但是基类指针或引用只能用于调用基类方法，不可用于调用派生类方法(除非为虚函数)
- 能够用派生类对象初始化基类对象

```c++
#include <iostream>
using namespace std;

class BASE1 {
	int i;
public:
	BASE1(int i) :i(i) { }
};
class DERIVED : public BASE1 {
	int j;
public:
	DERIVED(int i, int j) :BASE1(i), j(j) { }
};

int main() {
	DERIVED b(1, 2);
	BASE1 a(b);//允许用派生类对象来初始化基类对象，基类存在隐式复制构造函数
}//基类对象a::i == 1
```





###### 继承时的名字冲突

-   一个派生类继承自多个基类时，其基类有相同名字的成员时，client code通过派生类对象访问此名字时，编译器无法确定使用哪个基类的对应成员，发生名字冲突。


解决方法:

1. 使用域运算符明确说明使用哪个基类的接口
2. 在派生类中重新定义冲突的成员

```c++
#include <iostream>
using namespace std;

class BASE1 {
public:	void show() { cout << "BASE1: " << i << "\n"; }
protected:	int i;
};
class BASE2 {
public:	void show() { cout << "BASE2: " << j << "\n"; }
protected:	int j;
};


class DERIVED : public BASE1, public BASE2 {
public:
	void set(int x, int y) {i = x; j = y;}//注意继承而来的i,j无法写在初始化列表
	void show() {cout << "DERIVED: " << i << ", " << j << endl;}//重定义
};

int main() {
	DERIVED obj;// 声明一个派生类的对象
	obj.set(5, 7);// set()是DERIVED类自身定义的
	obj.show();// 无二义性问题，调用的是DERIVED中新定义的版本

	obj.BASE1::show();//显式调用从BASE1继承下来show()
	obj.BASE2::show();//显式调用从BASE2继承下来show()
}//output:
DERIVED: 5, 7
BASE1: 5
BASE2: 7
```









---

### 多态 polymorphism

>   **多态**是指计算机程序运行时，相同的消息可能会送给多个不同的类别之对象，而系统可依据对象所属类别，引发对应类别的方法，而有不同的行为
>
>   简单来说，所谓多态意指相同的消息给予不同的对象会引发不同的动作称之

函数多态的实现基于函数重载



实现多态公有继承的两种方法：

1. 在派生类中**重新定义**基类方法
2. 使用**虚方法**



-   多种形态， 类之间存在层次结构，并且类之间通过继承相关联时会用到
-   多态简而言之就是用父类型别的指针指向其子类的实例，然后通过父类的指针调用实际子类的成员函数。这种技术可以让父类的指针有“多种形态”，这是一种泛型技术。所谓泛型技术，说白了就是试图使用不变的代码来实现可变的算法。比如：模板技术，RTTI技术，虚函数技术，要么是试图做到在编译时决议，要么试图做到运行时决议
-   指针或引用才能展现类的多态性




多态性指**相同对象收到不同消息**或**不同对象收到相同消息**时产生不同的实现动作

1.  **编译时多态**性：通过**重载函数**和**运算符重载**实现
2.  **运行时多态**性：通过**虚函数**和**继承**实现





###### 静态多态

-   静态多态又称静态链接、早绑定。函数调用在程序执行前就准备好了//无virtual修饰

联编：将源代码中的函数调用解释为要执行函数代码

1. **静态联编**：编译时能确定唯一函数

在C中，每个函数名都能确定唯一的函数代码
在C++中，因为有函数重载，编译器须根据函数名，参数才能确定唯一的函数代码

2. **动态联编**：编译时不能确定调用的函数代码，运行时才能

C++中因为多态的存在，有时编译器不知道用户将选择哪种类型的对象，因此无法确定调用的唯一性，只有在运行时才能确定

> 当**类中的方法声明为virtual**时，使用**指针**或**引用**调用该方法，就是**动态联编**。
> 若是普通方法，则为静态联编









---

### 虚函数 Virtual Function

```c++
class A {//snippet
public:
    void f(int i) {}
};
class B : public A {
public:
    void f(A a) {}
};

int main() {
    B b;
    b.f(3);//此处会导致一个compile error，因为B中没有匹配的f
}//让此处可以调用基类A中的f的其中一个方法就是使用虚函数
```



-   从父类中继承的时候，虚函数和被继承的函数具有相同的签名，在运行过程中，运行系统将根据对象的类型，自动地选择适当的具体实现运行//优先级: 派生类版本 > 基类版本
-   虚函数是面向对象编程实现**多态**的基本手段
-   定义一个函数为虚函数，不代表函数为不被实现的函数
-   虚函数是为了**允许用基类的指针来调用子类的函数**
-   **不是虚函数意味着不允许通过基类指针调用派生类对应函数**
-   只有虚函数才使用的是**动态绑定**，其他的全部是静态绑定
-   虚函数会忽略 inline前缀，但虚函数是可以内联的
-   派生类的override虚函数定义必须和父类完全一致。除了一个特例，如果父类中返回值是一个**指针/引用**，子类override时可以**返回这个指针/引用的派生**
-   方法在基类中声明为虚的后，在派生类中将自动成为虚方法//写上virtual更好






-   一个基类 `Animal` 有一个虚函数 `eat`。子类 `Fish` 要实做一个函数 `eat()`，这个子类 `Fish` 与子类 `Wolf` 是完全不同的，但是你可以引用类别 Animal 底下的函数 `eat()` 定义，而使用子类 `Fish` 底下函数 `eat()` 的进程

```c++
# include <iostream>//from wiki
# include <vector>
using namespace std;

class Animal {
public:
	virtual void eat() const {//虚函数
		cout << "I eat like a generic Animal." << endl;
	}
	virtual ~Animal() {}//虚的析构函数
};

class Wolf : public Animal {
public:
	void eat() const {
		cout << "I eat like a wolf!" << endl;
	}
};

class Fish : public Animal {
public:
	void eat() const {
		cout << "I eat like a fish!" << endl;
	}
};

class GoldFish : public Fish {
public:
	void eat() const {
		cout << "I eat like a goldfish!" << endl;
	}
};

class OtherAnimal : public Animal { };
//由于没有实例化eat(),通过基类指针调用虚函数eat()会调用基类的eat()

int main() {
	std::vector<Animal*> animals;//！vector存储基类指针
	animals.push_back( new Animal() );
	animals.push_back( new Wolf() );//存入派生类指针
	animals.push_back( new Fish() );
	animals.push_back( new GoldFish() );
	animals.push_back( new OtherAnimal() );

	for( std::vector<Animal*>::const_iterator it = animals.begin();
	        it != animals.end(); ++it ) {
		(*it)->eat();//由于eat()是virtual函数，故向派生类寻找对应函数调用
		delete *it;
	}
}//output:
I eat like a generic Animal.
I eat like a wolf!
I eat like a fish!
I eat like a goldfish!
I eat like a generic Animal.
```

>   这个示例没有异常处理的代码。尤其是 `new` 或是 `vector::push_back` 丢出一个异常时，程序在运行时有可能会出现当掉或是错误的现象






###### override specifier 重写

>   显式说明**一个虚函数重载另一个虚函数**//C++11

- Specifies that a virtual function overrides another virtual function.
  指定一个**虚函数重载了另一个虚函数**
- override is an identifier with a special meaning when used after member function declarators: it's not a reserved keyword otherwise.
  override是在成员函数声明符之后使用时具有特殊含义的标识符，但**不是保留的关键字**
- The identifier override, if used, appears immediately after the declarator in the syntax of a member function declaration or a member function definition.
  override标识符在使用时，应紧跟在成员函数声明或成员函数定义的语法中的声明符之后
- 派生类的override虚函数定义必须和父类完全一致。除了一个特例，如果父类中返回值是一个指针/引用，子类override时可以返回这个指针/引用的派生
- 有助于防止出现意外的继承行为↓

```c++
class BaseClass{
	virtual void funcA();
	virtual void funcB() const;
	virtual void funcC(int = 0);
	void funcD();
};

class DerivedClass: public BaseClass{
	virtual void funcA(); // ok, works as intended

	virtual void funcB(); // DerivedClass::funcB() is non-const
	//so it does not override BaseClass::funcB() const
	//and it is a new member function //const和非const不可override

	virtual void funcC(double = 0.0);//创建了新的成员函数而非重载
	// DerivedClass::funcC(double) has a different parameter type than BaseClass::funcC(int)
	//so DerivedClass::funcC(double) is a new member function
};
```

>   上例由于DerivedClass中的funcB() funcC(double)的签名与BaseClass中的签名不匹配，故这两个函数不会override(重载) BaseClass中的funcB() funcC(int)，而是产生两个独立的，与BaseClass中的函数无关的函数//即创建了新的成员函数

为避免出现如上的"预料外"情况，可使用下例方法


```c++
//snippet//使用 override 避免意外创建新的成员函数
class BaseClass{
	virtual void funcA();
	virtual void funcB() const;
	virtual void funcC(int = 0);
	void funcD();
};

class DerivedClass: public BaseClass{
	virtual void funcA() override;// ok, 正确重载

	virtual void funcB() override;//编译错误，签名不一致
	// compiler error:
	// DerivedClass::funcB() does not override BaseClass::funcB() const

	virtual void funcC( double = 0.0 ) override;//编译错误，签名不一致
	// compiler error: 
	// DerivedClass::funcC(double) does not override BaseClass::funcC(int)

	void funcD() override;//编译错误，想要重载的函数是非虚函数 non-virtual
	// compiler error: DerivedClass::funcD()
	// does not override the non-virtual BaseClass::funcD()
};
```





- 此案例演示了override的正确用法和可能的错误情况
- 签名不匹配，重载non-virtual非虚函数

```c++
struct A{
	virtual void foo();
	void bar();
};
 
struct B : A{
	void foo() const override;// Error: B::foo does not override A::foo
							// (signature mismatch)签名不匹配
	void foo() override; // OK: B::foo overrides A::foo
	void bar() override; // Error: A::bar is not virtual//A::bar不是虚函数
};
```





---

###### final specifier 最终

c++11

-   final作用于类，说明该类不可被继承(最后一次被继承)
-   final作用于函数(一定要是virtual虚函数)，则指定该函数不可被重载(最后一次被重载)

```c++
struct Base{
    virtual void foo();
};
 
struct A : Base{
    void foo() final;// A::foo is overridden and it is the final override
    void bar() final;// Error: non-virtual function cannot be overridden or be final
};

struct B final : A {	// struct B is final//B不可被继承
	void foo() override;// Error: foo cannot be overridden as it's final in A
};

struct C : B {			// Error: B is final
};
```



-   标记了`final`的`virtual`函数说明该函数不可被重载(覆盖)，会将其从类的虚表中删除(GNU C++ 前端会识别)
-   标记为`final`的类，编译器则根本不会生成虚表(显然更有效率)





###### 虚析构函数

> 基类的析构函数应是虚函数
>
> 虚析构函数也在虚表中，调用方法同其它虚函数

- 为了当用一个基类指针删除一个派生类对象时，派生类的析构函数会被调用，基类的析构函数需要是virtual函数
- 调用派生类析构函数会自动调用基类构造函数，内存可以安全释放
- 析构函数可以是纯虚的，但纯虚析构函数必须有定义体，因为析构函数的调用是在子类中隐含的



```c++
#include <iostream>//虚析构函数标准做法//snippet
using namespace std;
class Base{
public:
	virtual ~Base(){}
};
class Derived: public Base{
public:
	~Derived(){};
};

int main(){
   Base *pb = new Derived;
   delete pb;
}
```





###### 虚函数与传值/引用

-   被类外部函数调用时虚函数的区别

```c++
#include <iostream>
#include <string>
using namespace std;

class Person {
public:
	virtual string toString() { return "Person";}
};

class Employee:public Person {
public:
	string toString() { return "Employee";}
};

class Faculty:public Employee {// Faculty学院
private://实例化基类虚函数时可以定义在private//自身不可被调用但可用基类指针调用
	string toString() { return "Faculty";}
};

//类外部函数///////////////////////////////////
void Person_by_val(Person p) {//Person对象传值
	cout << p.toString() << endl;
}
void Employee_by_val(Employee e) {//Employee对象传值
	cout << e.toString() << endl;
}
void Person_by_ref(Person &p) {//Person对象按引用传递
	cout << p.toString() << endl;
}

int main() {
	Person person; 
	Employee employee;
	Faculty faculty;

	Person_by_val(person);
	Person_by_val(employee);
	Person_by_val(faculty);

	Employee_by_val(employee);
	Employee_by_val(faculty);

	Person_by_ref(person);
	Person_by_ref(employee);
	Person_by_ref(faculty);
}//output:如果是传引用则依据基类寻找派生类的对应函数来调用
Person
Person
Person
Employee
Employee
Person
Employee
Faculty
//当person类中toString()不是virtual //全部访问基类的函数
//不是虚函数意味着不允许通过基类指针调用派生类对应函数
Person
Person
Person
Employee
Employee
Person
Person
Person
```



---

### 纯虚函数 & 抽象类 (ABC)

-   纯虚函数(pure virtual function)提供**接口框架**

>   凡是含有纯虚函数的类就叫抽象类(详情见本文件的抽象类)

-   **纯虚函数**或**纯虚方法**是一个需要被非抽象的派生类覆盖(**override**)的虚函数
-   声明: virtual Type_Name Function_Name ( int... ) = 0; //VS 也支持 abstract 关键字
-   基类中不能对虚函数给出有意义的实现故声明为纯虚函数。其实现留给该基类的派生类去做
-   纯虚函数通常没有定义体，但是，纯虚函数**也可以有函数体**




>    Abstract base classes 只能用作基类
>
>    类中至少有一个函数被声明为**纯虚函数**

- 抽象类是为了给其他类提供可以继承的适当的基类。不能用于实例化对象，只能作为接口使用
- 外部应用程序提供的功能(即公有函数)在抽象基类中是以纯虚函数的形式存在的。这些纯虚函数在相应的派生类中被实现
- 如果一个 ABC 的子类需要被实例化，则必须实现每个虚函数，这也意味着 C++ 支持使用 ABC 声明接口
- 试图**实例化一个抽象类的对象会导致编译错误** //故要在派生类中重载所有纯虚函数


>    可用于实例化对象的类被称为具体类



---

### 菱形继承

- Duplicate inheritance(复制继承)：There are several copies of the base class members in a derived class object.派生类对象有基类成员的多个副本
- 以下案例出现了D继承自B C, 而B C又继承自A的菱形继承问题
- 解决方案见 虚继承 虚基类 板块
- Shared inheritance(共享继承)：There is only one copy of the base class members in a derived class object. 派生类对象只有基类成员的一个副本。

```c++
class A {//间接基类A//snippet
protected://为让派生类可访问不可在private
	int m_a;
};

class B: public A {//直接基类B//可class B: virtual public A 以解决菱形继承问题
protected:
	int m_b;
};

class C: public A {//直接基类C//可class C: virtual public A 以解决菱形继承问题
protected:
	int m_c;
};
//派生类D
class D: public B, public C {
public://error: m_a访问出现二义性//可以用范围解析符指定使用的m_a
	void seta(int a) { m_a = a; }//命名冲突//存在D->C->A和D->B->A两个A基类的m_a
	void setb(int b) { m_b = b; }//正确//仅存在D->B一个B基类的m_b
};
```

>   由此可见多继承常会出现二义性问题，尽力不使用多继承！使用时多注意二义性问题
>
>   因为二义性问题，c++后很多面向对象的编程语言Java C# PHP等不支持多继承
>
>   ###### c++ STL库中的菱形继承
>
>   istream 和 ostream 继承自一个共同的名为 base_ios 的类
>
>   iostream 从 istream 和 ostream 直接继承而来，所以
>
>   istream 和 ostream 必须采用虚继承，否则导致 iostream 中保留两份 base_ios 的成员



### 虚继承 虚基类

>   基类可以通过使用关键字`virtual`来声明虚继承关系
>
>   继承时被virtual修饰的基类称为虚基类 Virtual Base Class
>
>   Virtual base class is used for shared inheritance. 虚基类用于共享继承

-   目的是使从不同路径(直接基类)继承过来的间接基类只有一份(多重继承出现重复的基类时)
-   必须在虚派生的需求出现前就完成虚派生的操作(如菱形继承案例中B C应虚派生自A)
-   继承是"is a"关系，虚继承是"has a"关系，即派生类有一个指向基类的vptr虚表指针

```c++
class Derived : virtual public Base{
	//Derived类做出virtual声明共享Base基类。这个被共享的Base基类就称为虚基类
};
```

-   最派生类：最后派生出来的类，继承类结构中建立对象时所指定的类




###### 虚继承与constructor

-   在虚基类(直接或间接派生)的派生类中的构造函数初始化列表中，都要**列出对虚基类构造函数的调用**，但**只有最派生类的构造函数真正调用虚基类的构造函数**，而**该派生类的所有基类中列出的对虚基类构造函数的调用在执行中被忽略**，从而保证对虚基类子对象只初始化一次
-   在派生类的构造函数的成员初始化列表中，必须列出虚基类构造函数的调用，如果没有列出则调用无参构造函数





```c++
#include <iostream>
#include <string>
using namespace std;

class A {
	int a;
public:
	A(int a) :a(a) { cout << "A::a " << a << endl; }
};
class B :virtual public A {
	int b;
public://B的子类在调用时，将忽略B的c-tor初始化列表中对虚基类Ac-tor的调用
	B(int b) :A(b), b(b) { cout << "B::b " << b << endl; }
};
class C :virtual public A {
	int c;
public:
	C(int c) :A(c), c(c) { cout << "C::c " << c << endl; }
};
class D :virtual public A {
	int d;
public:
	D(int d) :A(d), d(d) { cout << "D::d " << d << endl; }
};

class T :public B, public C, public D {
	int t;
public://先调用虚基类A的构造函数，再按照类派生列表依次是B C D的constructor
	T(int v1, int v2, int v3, int v4, int v5) :D(v1), B(v2), C(v3), A(v4), t(v5) {
		cout << "T::t " << t << endl;//调用顺序与初始化列表先后顺序无关
	}
};
int main(int argc, char* argv[]) {
	T *ptr = new T(1, 2, 3, 4, 5);
	delete ptr;
	ptr = NULL;
}//output:
A::a 4//先是虚基类的构造函数
B::b 2//后是类派生列表的第一个直接基类
C::c 3
D::d 1
T::t 5//最后是最派生类构造函数的函数体
```

虚基类构造函数的调用顺序

1. 调用虚基类构造函数
2. 调用普通基类构造函数，按派生类声明时列出的次序左到右调用 (不是初始化列表中的次序)
3. 调用对象成员的构造函数，按类声明中对象成员出现的次序调用 (不是初始化列表中的次序)
4. 最后执行派生类的构造函数

```c++
#include <iostream>
using namespace std;

class baseA {
public:
	baseA() { cout << "baseA" << endl; }
};
class baseB {
public:
	baseB() { cout << "baseB" << endl; }
};

class derivedA : public baseB, virtual public baseA {
public:
	derivedA() { cout << "derivedA" << endl; }
};
class derivedB : public baseB, virtual public baseA {
public:
	derivedB() { cout << "derivedB" << endl; }
};
class DERIVED : public derivedA, virtual public derivedB {
public:
	DERIVED() { cout << "DERIVED" << endl; }
};

int main() {
	DERIVED obj;
}//output:
baseA//首先调用虚基类的构造函数，这个baseA是虚基类DERIVED::derivedB中的虚基类
baseB//调用普通基类的构造函数，这个baseB是虚基类DERIVED::derivedB中的普通基类
derivedB//调用DERIVED的虚基类
baseB//调用DERIVED::derivedA的普通基类(因为baseA已经存在一个实例故跳过)
derivedA//调用DERIVED的普通基类
DERIVED//最后是最派生类的构造函数
```

![](http://op4fcrj8y.bkt.clouddn.com/17-5-11/35011207-file_1494478472749_e7f6.png)

> 紫色代表虚继承







###### 虚表 Vtable

>   虚函数的处理通常是通过**虚函数表**来实现
>
>   虚函数是运行时多态，模板是编译时多态，一个动，一个是静

-   每一个有虚函数的类都有virtual table虚表
-   每一个含虚函数的类只用一个vtable，不是每一个该类对象有一个vtable，而是**每个同一个类的对象都有一个指针指向该类的vtable**(如果有的话)//因此每个对象只增加了一个指针大小
-   内存布局：首先是该类的vtable(首地址) 然后是对象数据
-   虚表记录了本类中所有虚函数的函数指针，是一个函数指针表，每一个表项指向一个函数。实质上是一个**函数指针的数组**
-   如果类本身含有virtual 声明的函数，或者继承了virtual 函数，那么它肯定会包含一个指向虚函数表的指针




>   在通過對象指針調用一個虛函數時，編譯器生成的代碼將先獲取對象類的vtable指針，然後調用vtable中對應的項。對於通過對象指針調用的情況(引用同理)，在編譯期間無法確定指針指向的是基類對象還是派生類對象，或者是哪個派生類的對象。但是在運行期間執行到調用語句時，這一點已經確定，編譯后的調用代碼能夠根據具體對象獲取正確的vtable，調用正確的虛函數，從而實現多態性


```c++
#include <iostream>//验证类首地址存放虚表首地址，虚表首地址存放第一个虚函数地址
using namespace std;

class Base {
public://virtual_Func_1的函数地址将在虚函数表的第一位
	virtual void virtual_Func_1() { cout << "Base::virtual_Func_1" << endl; }
	virtual void virtual_Func_2() { cout << "Base::virtual_Func_2" << endl; }
};
class Derived : public Base {
public://Derived类重载了Base的virtual_Func_1(),增加了一个虚函数virtual_Func_3()
	virtual void virtual_Func_1() { cout << "Base::virtual_Func_1" << endl; }
	virtual void virtual_Func_3() { cout << "Base::virtual_Func_2" << endl; }
};
typedef void(*Fun)( void );//Fun是指向形参列表为void，返回值为void的函数指针类型

int main() {
	Base b;
	Fun pFun = NULL;//pFun是指向形参列表为void，返回值为void的函数指针
	//取b的地址并强制转换，是存储b的首地址也是存放虚函数表地址的地址
	cout << "虚函数表地址：" << (size_t*)( &b ) << endl;
	//取b的地址后解引用得到虚函数表的首地址//也是存储第一个虚函数首地址的地址
	cout << "虚函数表第一个函数地址：" << (size_t*) *(size_t*)( &b ) << endl;
	
	//再次解引用得到第一个虚函数的地址(函数实现的首地址)并强制转换为函数指针
	pFun = (Fun) * ( (size_t*) *(size_t*)( &b ) );
	pFun();//通过函数指针 Invoke调用 the first virtual function
}//output:地址值不定
虚函数表地址：0x6dfe98
虚函数表第一个函数地址：0x48e338
Base::virtual_Func_1 //此处说明成功调用Base::virtual_Func_1()
```

>   [虚表地址参考链接](http://blog.csdn.net/haoel/article/details/1948051)
>
>   [虚表地址参考链接2](http://blog.csdn.net/lihao21/article/details/50688337)











>   [虚继承时的virtual pointer 和 虚表](https://www.oschina.net/translate/cpp-virtual-inheritance)



### 内存分布



虚表中虚函数指针的排列顺序基本遵照以下规则

1.  虚函数按照声明顺序放在虚表中
2.  **父类的虚函数在子类虚函数前面**
3.  父类override子类的虚函数覆盖虚表中原来父类虚函数的位置
4.  父类继承来的虚函数若没有被子类override，则位置不变
5.  **多继承时有几个基类就有几个虚表，存放虚表地址的地址在派生类实例的首地址依次排列**
6.  多继承时派生类没有override的虚函数在第一个虚表的末尾依次排列
7.  虚表末尾: 虚函数表的最后多加了一个结束结点，标志了虚函数表的结束。这个结束标志的值在不同的编译器下是不同的。在WinXP+VS2003下，这个值是NULL。而在Ubuntu 7.10 + Linux 2.6.22 + GCC 4.1.3下，这个值是如果1，表示还有下一个虚函数表，如果值是0，表示是最后一个虚函数表



1.  线性继承时虚表中函数指针排列规则

    线性继承时，基类的虚函数按照基类虚表中的顺序，在派生类虚表中从头排列，派生类中重载了基类的虚函数的，覆盖原来父类虚函数指针的位置

2.  多继承时虚表中函数指针的排列规则

    例如class Derived : public Base1, public Base2, public Base3 { };//则&derived(Derived的一个实例)的值是存放Base1的虚表地址的地址，++(&derived)是存放Base2的虚表地址的地址，再下一个地址是存放Base3的虚表地址的地址。而各虚表中的函数指针排列规则不变，基类中被重载了的虚函数就会会被派生类对应函数的函数指针覆盖，而派生类中没有覆盖基类虚函数的**虚函数的指针**，将会按照声明顺序，依次排列在Base1的虚表后。



```c++
#include <iostream>//验证虚表的内存分配
using namespace std;

class Base1 {
public:
	virtual void f() { cout << "Base1::f" << endl; }
	virtual void g() { cout << "Base1::g" << endl; }
	virtual void h() { cout << "Base1::h" << endl; }
};

class Base2 {
public:
	virtual void f() { cout << "Base2::f" << endl; }
	virtual void g() { cout << "Base2::g" << endl; }
	virtual void h() { cout << "Base2::h" << endl; }
};

class Base3 {
public:
	virtual void f() { cout << "Base3::f" << endl; }
};

class Derived : public Base1, public Base2, public Base3 {
public://Derived::f()重载了Base1 Base2 Base3中的f()
	virtual void f() override { cout << "Derived::f" << endl; }
	virtual void g1() { cout << "Derived::g1" << endl; }
};

typedef void(*Fun)(void);//Fun为形参列表为void,返回值为void的函数指针类型

int main() {
	Fun pFun = NULL;//pFun为Fun类型变量
	Derived d;
	int** pVtab = (int**)&d;//pVtab是指向d首地址的双重指针

	//Base1's vtable 虚表
	//pFun = (Fun)*((int*)*(int*)((int*)&d+0)+0);//等价
	pFun = (Fun)pVtab[0][0];
	pFun();//Base1::f()已被Derive::f() override,故调用了Derive::f
	pFun = (Fun)pVtab[0][1];
	pFun();
	//pFun = (Fun)*((int*)*(int*)((int*)&d+0)+2);
	pFun = (Fun)pVtab[0][2];
	pFun();
	//Derive's vtable//Derive::g1()
	pFun = (Fun)*((int*)  *(int*)((int*)&d+0)  +3);
	//pFun = (Fun)pVtab[0][3];
	pFun();
	//The tail of the vtable
	pFun = (Fun)pVtab[0][4];
	cout<<pFun<<endl;//Base1虚表的末尾 输出1表示下面还有一张虚表

	//Base2's vtable
	pFun = (Fun)pVtab[1][0];
	pFun();
	//pFun = (Fun)*((int*)*(int*)((int*)&d+1)+1);
	pFun = (Fun)pVtab[1][1];
	pFun();
	pFun = (Fun)pVtab[1][2];
	pFun();
	//The tail of the vtable
	pFun = (Fun)pVtab[1][3];
	cout<<pFun<<endl;//Base2虚表的末尾 输出1表示下面还有一张虚表 

	//Base3's vtable
	pFun = (Fun)pVtab[2][0];
	pFun();
	//The tail of the vtable
	pFun = (Fun)pVtab[2][1];//pFun指向Base3虚表的末尾 
	cout<<pFun<<endl;//Base3虚表的末尾 输出0表示全部虚表结束 
}//output:
Derived::f
Base1::g
Base1::h
Derived::g1
1
Derived::f
Base2::g
Base2::h
1
Derived::f
0
```





---

# struct

初始化struct对象时，如果指定的初始值比成员少，余下的成员将被设置为零

```c++
#include <iostream>//如果不包含，会报错：二进制“<<”: 没有找到接受
#include <string>//“std::string”类型的右操作数的运算符(或没有可接受的转换)
using namespace std;
struct A {
	string str;
	int a;
	long l;
	double f;
};
int main() {
	A A1 = { "hhh", 1, 123, 2.222 };
	A A2 = { "abc", 2};
	cout << A1.str << ' ' << A1.a << ' ' << A1.l << ' ' << A1.f << '\n';
	cout << A2.str << ' ' << A2.a << ' ' << A2.l << ' ' << A2.f << '\n';
}//Output:
hhh 1 123 2.222
abc 2 0 0
```