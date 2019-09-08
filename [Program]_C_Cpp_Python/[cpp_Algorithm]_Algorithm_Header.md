

[TOC]
# [algorithm  C++](http://www.cplusplus.com/reference/algorithm/) Standard Library



- In the C++ Standard Library , algorithms are components(组件) that perform algorithmic(算法) operations on containers(容器) and other sequences(序列).
- <numeric>中还有一些算法
- All algorithms are in the std namespace.




---

## <algorithm>成员函数





---

###all_of  		

- Test condition on all elements in range  	[c++11]

- All algorithms are in the std namespace

  >   behavior of this function template is equivalent to ↓

```c++
template<class InputIterator, class UnaryPredicate>

bool all_of (InputIterator first, InputIterator last, UnaryPredicate pred){
	while (first!=last) {
		if (!pred(*first)) return false;
		++first;
	}
	return true;
}
```




```c++
#include <iostream>     // std::cout
#include <algorithm>    // std::all_of
#include <array>        // std::array

int main () {
	std::array<int,8> foo = {3,5,7,11,13,17,19,23};
	//传参：
	if ( std::all_of(foo.begin(), foo.end(), [](int i){return i%2;}) ){
		std::cout << "All the elements are odd numbers.\n";
	}
	return 0;
}
```











---

### any_of











---

### find

-   Find value in range

- Return value: Returns an iterator to the first element in the range **`[first,last)`** that compares equal to val. If no such element is found, the function returns last.

- The function uses **`operator==`** to compare the individual elements to val.

- val: Value to search for in the range.

    T shall be a type supporting comparisons with the elements pointed by InputIterator using **`operator==`** (with the elements as left-hand side operands, and val as right-hand side).

    所以需要重载==    ？



>   The behavior of this function template is equivalent to:

```c++
template<class InputIterator, class T>
InputIterator find (InputIterator first, InputIterator last, const T& val){
	while (first!=last) {
		if (*first==val)  return first;//找到了就返回找到时的迭代器
		++first;
	}
	return last;	//一直没找到就返回last
}
```





```c++
// find example
#include <iostream>     // std::cout
#include <algorithm>    // std::find
#include <vector>       // std::vector

int main () {
	// using std::find with array and pointer:
	int myints[] = { 10, 20, 30, 40 };
	int * p;
	p = std::find (myints, myints+4, 30);
	if (p != myints+4)
		std::cout << "Element found in myints: " << *p << '\n';
	else
		std::cout << "Element not found in myints\n";

	// using std::find with vector and iterator:
	std::vector<int> myvector (myints,myints+4);
	std::vector<int>::iterator it;

	it = find (myvector.begin(), myvector.end(), 30);
	if (it != myvector.end())
		std::cout << "Element found in myvector: " << *it << '\n';
	else
		std::cout << "Element not found in myvector\n";

	return 0;
}
```







---

### copy

-   Copies the elements in the range `[first,last)` into the range beginning at result.
-   ​




```c++
void copyVecFast(const vec<int>& original){
	vector<int> newVec;
	newVec.reserve(original.size());
	copy(original.begin(),original.end(),back_inserter(newVec));
}
```



---

### sort

- Sorts the elements in the range **`[first,last)` **into **ascending**(上升的) order.
- Equivalent elements are not guaranteed to keep their original relative order (see [stable_sort](http://www.cplusplus.com/stable_sort)).









>   std::sort   function template 模版[^Return value]

```c++
//default (1)	//带有两个参数
template <class RandomAccessIterator>
	void sort (RandomAccessIterator first, RandomAccessIterator last);
//custom (2)	//带有三个参数
template <class RandomAccessIterator, class Compare>
	void sort (RandomAccessIterator first, RandomAccessIterator last, Compare comp);
```



> Note that invalid arguments cause undefined behavior .

```c++
// sort algorithm example	//completed demo
#include <iostream>
#include <algorithm>
#include <vector>

bool myfunction (int i,int j) {//这一函数将被用于sort()的第三个参数
	return (i < j);
}
struct myclass {
    bool operator() (int i,int j) { return (i<j);}
} myobject;

int main () {
	int myints[8] = {32,71,12,45,26,80,53,33};
	std::vector<int> myvector (myints, myints + 8);// 32 71 12 45 26 80 53 33

	// using default comparison (operator <):
	std::sort (myvector.begin(), myvector.begin() + 4);
	//(12 32 45 71)26 80 53 33

	// using function as comp
	std::sort (myvector.begin() + 4, myvector.end(), myfunction);
	// 12 32 45 71(26 33 53 80)

	// using object as comp
	std::sort (myvector.begin(), myvector.end(), myobject);
	//(12 26 32 33 45 53 71 80)

	std::cout << "myvector contains:";// print out content:
	for (std::vector<int>::iterator it=myvector.begin(); it!=myvector.end(); ++it) {//使用了iterator(迭代器)遍历vector<int>数组
		std::cout << ' ' << *it;//迭代器解引用获取
	}
	return 0;
}//Output:
myvector contains: 12 26 32 33 45 53 71 80
```







---

### swap



```c++
//[c++98]The behavior of this function template is equivalent to:
template <class T> void swap ( T& a, T& b ){
	T c(a); a=b; b=c;
}
```

```c++
//This function is no longer defined in header <algorithm>, but in <utility>.
//The behavior of these function templates is equivalent to:
template <class T> void swap (T& a, T& b){
	T c(std::move(a));
	a=std::move(b);
	b=std::move(c);
}
template <class T, size_t N> void swap (T (&a)[N], T (&b)[N]){
	for (size_t i = 0; i<N; ++i) swap (a[i],b[i]);
}
```

```c++
// swap algorithm example (C++98)
#include <iostream>     // std::cout
#include <algorithm>    // std::swap
#include <vector>       // std::vector

int main () {
	int x=10, y=20;						// x:10 y:20
  	std::swap(x,y);						// x:20 y:10

	std::vector<int> foo (4,x), bar (6,y);// foo:4x20 bar:6x10
	std::swap(foo,bar);					// foo:6x10 bar:4x20

	std::cout << "foo contains:";
	for (std::vector<int>::iterator it=foo.begin(); it!=foo.end(); ++it)
		std::cout << ' ' << *it;
	return 0;
}
//Output:foo contains: 10 10 10 10 10 10
```





### max_element

-   传递头迭代器与尾迭代器，返回最大元素的迭代器

```c++
template <class ForwardIterator>
ForwardIterator max_element (ForwardIterator first, ForwardIterator last);
template <class ForwardIterator, class Compare>//第二个参数可以是函数/仿函数
ForwardIterator max_element (ForwardIterator first, ForwardIterator last,
                               Compare comp);
```

```c++
// min_element/max_element example
#include <iostream>// std::cout
#include <algorithm>// std::min_element, std::max_element

bool myfn(int i, int j) {
	return i<j;
}

struct myclass {
	bool operator() (int i, int j) {
		return i<j;
	}
} myobj;

int main() {
	int myints[] = { 3,7,2,5,6,4,9 };

	// using default comparison:
	std::cout << "The smallest element is " << *std::min_element(myints, myints + 7) << '\n';
	std::cout << "The largest element is " << *std::max_element(myints, myints + 7) << '\n';

	// using function myfn as comp:
	std::cout << "The smallest element is " << *std::min_element(myints, myints + 7, myfn) << '\n';
	std::cout << "The largest element is " << *std::max_element(myints, myints + 7, myfn) << '\n';

	// using object myobj as comp:
	std::cout << "The smallest element is " << *std::min_element(myints, myints + 7, myobj) << '\n';
	std::cout << "The largest element is " << *std::max_element(myints, myints + 7, myobj) << '\n';
}
```

















[^Return value]: 无返回值