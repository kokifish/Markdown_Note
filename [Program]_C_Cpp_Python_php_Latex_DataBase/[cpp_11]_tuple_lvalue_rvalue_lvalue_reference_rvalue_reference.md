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









---

# \<tuple\> 元组

> c++11 标准
>
> https://en.cppreference.com/w/cpp/utility/tuple/tuple

元组是将(可能是)不同类型的元素打包在一个对象中的对象，某种意义上相当于`pair`的多维拓展。

类似于C的structs，但是没有具名数据成员，而是按照数据成员在tuple中的顺序访问。

元组元素的选择是在模板实例化级别完成的，因此必须在编译时使用get和tie等辅助函数指定。The selection of particular elements within a tuple is **done at the template-instantiation level**, and thus, it must be specified at compile-time, with helper functions such as **get** and **tie**.

> The [tuple](http://www.cplusplus.com/tuple) class is closely related to the [pair](http://www.cplusplus.com/pair) class (defined in header \<utility\>): Tuples can be constructed from pairs, and pairs can be treated as tuples for certain purposes.
>
> [array](http://www.cplusplus.com/array) containers also have certain tuple-like functionalities.



---

### Classes

- overview example

```cpp
#include <iostream>  // std::cout // tuple example
#include <tuple>     // std::tuple, std::get, std::tie, std::ignore
using namespace std;

int main() {
    int myint;
    char mychar;
    tuple<int, char> foo(10, 'x');

    tie(myint, ignore) = foo;                      // tie: unpack elements
    cout << myint << ", " << get<1>(foo) << endl;  // 10, x

    auto bar = make_tuple("test", 3.1, 14, 'y');
    get<2>(bar) = 5;  // bar: "test", 3.1, 14, 'y' -> "test", 3.1, 5, 'y'
    tie(ignore, ignore, myint, mychar) = bar;  // unpack with ignore
    cout << myint << ", " << mychar << endl;   // 5, y

    get<0>(foo) = get<2>(bar);  // foo: 10, x -> 5, x
    get<1>(foo) = mychar;       // foo: 5, x -> 5, y
    cout << get<0>(foo) << ", " << get<1>(foo);  // 5, y
}
```



##### tuple

- Tuple (class template )

```cpp
// tuple example
#include <iostream>
#include <memory>
#include <string>
#include <tuple>
#include <vector>

// helper function to print a tuple of any size
template <class Tuple, std::size_t N>
struct TuplePrinter {
    static void print(const Tuple& t) {
        TuplePrinter<Tuple, N - 1>::print(t);
        std::cout << ", " << std::get<N - 1>(t);
    }
};

template <class Tuple>
struct TuplePrinter<Tuple, 1> {
    static void print(const Tuple& t) { std::cout << std::get<0>(t); }
};

template <class... Args>
void print(const std::tuple<Args...>& t) {
    std::cout << "(";
    TuplePrinter<decltype(t), sizeof...(Args)>::print(t);
    std::cout << ")\n";
}

int main() {
    std::tuple<int, std::string, double> t1;
    std::cout << "Value-initialized: ";
    print(t1);
    std::tuple<int, std::string, double> t2(42, "Test", -3.14);
    std::cout << "Initialized with values: ";
    print(t2);
    std::tuple<char, std::string, int> t3(t2);
    std::cout << "Implicitly converted: ";
    print(t3);
    std::tuple<int, double> t4(std::make_pair(42, 3.14));
    std::cout << "Constructed from a pair";
    print(t4);

    // given Allocator my_alloc with a single-argument constructor my_alloc(int)
    // use my_alloc(1) to allocate 10 ints in a vector
    std::vector<int, my_alloc> v(10, 1, my_alloc(1));
    // use my_alloc(2) to allocate 10 ints in a vector in a tuple
    std::tuple<int, std::vector<int, my_alloc>, double> t5(
        std::allocator_arg, my_alloc(2), 42, v, -3.14);
}
```







#### Helper classes

##### tuple_size

- 获取一个tuple中元素数量的模板类

- Tuple size traits (class template). Class template designed to access the number of elements in a [tuple](http://www.cplusplus.com/tuple) (as a `constexpr`).

  ```cpp
  std::tuple<int, char, double> mytuple(10, 'a', 3.14);
  std::cout << std::tuple_size<decltype(mytuple)>::value;  // output: 3
  ```

  





##### tuple_element

- 元组元素类型 Tuple element type (class template )
- 用于访问元组中第i个元素的类型的类。Class designed to access the type of the *I*th element in a tuple.
- 只有一个成员类型`tuple_element::type`，定义为类型T的元组中第i个元素的类型的别名

> Attention! 获取到的就是数据类型，如int，char。而不是写有“int”或者“char”的字符串

```cpp
auto mytuple = std::make_tuple(10, 'a');
tuple_element<0, decltype(mytuple)>::type first = get<0>(mytuple);
tuple_element<1, decltype(mytuple)>::type second = get<1>(mytuple);

std::cout << first << ", " << second << '\n';// 10, a
```





---

### Functions

#### Object creation

##### make_tuple

- Construct tuple (function template)

```cpp
auto tup1 = std::make_tuple("test", 'a', 3.14, 0);
tuple <const char*, char, double, int> tup2 = std::make_tuple("test", 'a', 3.14, 0); // 等效


auto first = std::make_tuple(10, 'a'); // tuple < int, char >
const int a = 0; int b[3]; // decayed types:
auto second = std::make_tuple(a, b); // tuple < int, int* >
auto third = std::make_tuple(std::ref(a), "abc"); // tuple < const int&, const char* >
```





##### forward_as_tuple

- 构造一个适合作为参数转发给函数的tuple args的tuple右值引用。Constructs a tuple object with rvalue references to the elements in args suitable to be forwarded as argument to a function.
- 该函数设计用于转发参数，而不是将结果存在具名变量中，因为返回的对象可能包含对临时变量的引用。This function is designed to **forward arguments**, not to store its result in a named variable, since the returned object may contain references to temporary variables.

```cpp
//c++14
template<class... Types>
constexpr tuple<Types&&...> forward_as_tuple (Types&&... args) noexcept;
```

```cpp
#include <iostream> // std::cout
#include <string> // std::string
#include <tuple> // std::tuple, std::get, std::forward_as_tuple

void print_pack(std::tuple<std::string&&, int&&> pack) {
    std::cout << std::get<0>(pack) << ", " << std::get<1>(pack) << '\n';
}

int main() {
    std::string str("John");
    print_pack(std::forward_as_tuple(str + " Smith", 25));
    print_pack(std::forward_as_tuple(str + " Daniels", 22));
}
```





##### tie

Tie arguments to tuple elements (function template )

tie函数就只能接受左值

```cpp
auto tup1 = std::make_tuple(3.14, 1, 'test');
std::tie(a, b, c) = tup1;
```

```cpp
mytuple = std::make_tuple (10, 2.6, 'a');
std::tie(myint, std::ignore, mychar) = mytuple;
```





##### tuple_cat

Concatenate tuples (function template )

```cpp
// tuple_cat example
#include <iostream> // std::cout
#include <string> // std::string
#include <tuple> // std::tuple, std::tuple_cat, std::get
#include <utility> // std::pair

int main() {
    std::tuple<float, std::string> mytuple(3.14, "pi");
    std::pair<int, char> mypair(10, 'a');

    auto myauto = std::tuple_cat(mytuple, std::tuple<int, char>(mypair)); 
    // 3.14 pi 10 a
}
```



#### Element access

##### get

Get element (function template )

`get<i>(tup)`获取tup第 `i` 个元素



---

### Objects

##### ignore

> Ignore assignment (object )

- This object ignores any value assigned to it.
- 被设计用于在tie函数中，指定tuple的某个特定元素应当被忽略。It is designed to be used as an argument for [tie](http://www.cplusplus.com/tie) to indicate that a specific element in a [tuple](http://www.cplusplus.com/tuple) should be ignored.

