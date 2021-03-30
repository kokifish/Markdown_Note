[TOC]



---

# 左值 lvalue 右值 rvalue



- 在c++11中每个表达式有两个属性：
  - 1. 类型type: 除去引用特性，用于类型检查
    2. 值类型value category: 用于语法检查。e.g. 一个表达式结果是否能被赋值
- 值类型value category: 1. lvalue; 2. prvalue; 3. xrvalue. 2和3统称rvalue
- 左值：可以获取地址的量，可以用来标识一个对象或函数。
- 右值：不是左值的就是右值。prvalue: 纯粹的右值，比如字面量。xrvalue: 可以被重用的临时对象







---

# 左值引用 lvalue reference

- c++之前就有左值引用，通常简称为引用
- 使用&声明的引用称为左值引用

```cpp
int x = 1;
int & rx = x; // 左值引用 // 定义引用时必须初始化
```

- 引用分为const 引用和 non-const 引用

```cpp
int x = 20;
int& rx1 = x; // non-const引用可以被non-const左值初始化
const int y = 10;
int& rx2 = y; // error：non-const引用不能被const左值初始化
int& rx3 = 10; // error：non-const引用不能被右值初始化
```

```cpp
int x = 10;
const int cx = 20;
const int& rx1 = x; // const引用可以被non-const左值初始化
const int& rx2 = cx; // const引用可以被const左值初始化
const int& rx3 = 9; // const引用可以被右值初始化
```





- Attention! const 左值引用可以接受右值

---

# 右值引用 rvalue reference

> c++11 新增

- C++11以前，右值被认为是无用的资源，所以在C++11中引入了右值引用，就是为了重用右值
- 这种引用可指向右值，使用 **&&**声明

```c++
int&& rrx = 200;
double && rref = std::sqrt(36.00); //not allowed for double &
double j = 15.0;
double && jref = 2.0 * j + 18.5; //not allowed for double &
std::cout << rref << ' ' << jref << '\n'; //display 6.0 48.5
```

右值引用的主要目的是让库设计人员能够提供有些操作的更有效实现

```cpp
int x = 20; // 左值
int&& rrx1 = x; // 非法：右值引用无法被左值初始化
const int&& rrx2 = x; // 非法：右值引用无法被左值初始化
```

> 右值引用的目的是为了延长用来初始化对象的生命周期，对于左值，其生命周期与其作用域有关，没有必要去延长 https://zhuanlan.zhihu.com/p/54050093

```cpp
int x = 20; // 左值
int&& rx = x * 2; // x*2的结果是一个右值，rx延长其生命周期
int y = rx + 2; // 因此你可以重用它：42
rx = 100; // 一旦你初始化一个右值引用变量，该变量就成为了一个左值，可以被赋值
```

> 初始化之后的右值引用将变成一个左值，如果是non-const还可以被赋值 https://zhuanlan.zhihu.com/p/54050093

```cpp
// 接收左值
void fun(int& lref) {
    cout << "l-value reference\n";
}
// 接收右值
void fun(int&& rref) {
    cout << "r-value reference\n";
}
// 不仅可以接收左值，而且可以接收右值
void fun(const int& clref) {
    cout << "l-value const reference\n";
}

int main() {
    int x = 10;
    fun(x);   // output: l-value reference
    fun(10);  // output: r-value reference
}
```

> 函数参数要区分开右值引用与左值引用，是不同的重载版本



---

# 移动语义



https://zhuanlan.zhihu.com/p/54050093





---

# 基于范围的for循环(c++11)



```c++
#include <iostream>
using namespace std;

class A {
public:
	A() : a(1) {}
private:
	int a;
};

int main() {
	double p[5] = { 1.0, 5.2, 9.9, 12.3, 55.5 };
	for (double x : p) {
		cout << x << ' ' ;
	}
	for (double& x : p) {
		x = x*0.5;
	}
	for (double x : p) {
		cout << x << ' ' ;
	}
	for (int x : {1, 2, 3}) {
		cout << x;
	}
}//Output:
1 5.2 9.9 12.3 55.5 0.5 2.6 4.95 6.15 27.75 123
```





---

# 逻辑运算符的表示方式

|      |      |      |      |
| ---- | ---- | ---- | ---- |
| &&   | and  | \|\| | or   |
| !    | not  |      |      |