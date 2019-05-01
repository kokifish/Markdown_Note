[TOC]





- adaptor  适配器




-   warning！
-   vector不可以存引用

---

# vector

-   Vectors are sequence containers representing arrays that can change in size.
-   <vector>是可以改变大小的数组的序列容器
-   **元素不可以是引用类型**






-   (constructor) Construct vector (public member function )
-   (destructor) Vector destructor (public member function )
-   operator= Assign content (public member function )

Iterators 迭代器

-   **begin** 返回指向开头的迭代器 Return iterator to beginning (public member function )
-   **end** 返回指向结尾的迭代器Return iterator to end (public member function )
-   rbegin Return reverse iterator to reverse beginning (public member function )
-   rend Return reverse iterator to reverse end (public member function )
-   cbegin Return const_iterator to beginning (public member function )
-   cend Return const_iterator to end (public member function )
-   crbegin Return const_reverse_iterator to reverse beginning (public member function )
-   crend Return const_reverse_iterator to reverse end (public member function )

Capacity 容量

- **size** 返回vector的大小Return size (public member function )
- max_size Return maximum size (public member function )
- resize Change size (public member function )
- capacity Return size of allocated storage capacity (public member function )
- **empty** 查看vector是否为空 Test whether vector is empty (public member function )
- reserve Request a change in capacity (public member function )
- shrink_to_fit Shrink to fit (public member function )

Element access 元素访问

- operator[] Access element (public member function )
- **at** 访问特定元素Access element (public member function )
- front 访问第一个元素Access first element (public member function )
- back 访问最后一个元素Access last element (public member function )
- data Access data (public member function )

Modifiers 修改器

-  assign Assign vector content (public member function )
-  **push_back** 在末尾增加新元素 Add element at the end (public member function )
-  pop_back 删除最后一个元素 Delete last element (public member function )
-  insert 插入元素 Insert elements (public member function )
-  erase 删除元素 Erase elements (public member function )
-  swap Swap content (public member function )
-  clear Clear content (public member function )
-  emplace Construct and insert element (public member function )
-  emplace_back Construct and insert element at the end (public member function )

Allocator

- get_allocator Get allocator (public member function )

Non-member function overloads

- relational operators Relational operators for vector (function template )
- swap Exchange contents of vectors (function template )


###### constructor

```cpp
vector<vector<int> > adj_arr(vertex_num, vector<int>(vertex_num, 9999999));
```



```cpp
// constructing vectors
#include <iostream>
#include <vector>
using namespace std; 
int main() {
	// constructors used in the same order as described above:
	vector<int> first;// empty vector of ints
	vector<int> second(4, 100);// four ints with value 100
	vector<int> third(second.begin(), second.end());// iterating through second
	vector<int> fourth(third);// a copy of third

	// the iterator constructor can also be used to construct from arrays:
	int myints[] = { 16,2,77,29 };
	vector<int> fifth(myints, myints + sizeof(myints) / sizeof(int));

	cout << "The contents of fifth are:";
	for (vector<int>::iterator it = fifth.begin(); it != fifth.end(); ++it)
		cout << ' ' << *it;
	cout << '\n';
}
```



###### erase + push_back

```c++
#include <iostream>
#include <vector>

int main (){
	std::vector<int> myvector;
	for (int i=1; i<=10; i++)  myvector.push_back(i);
	// set some values (from 1 to 10)

	myvector.erase (myvector.begin()+5);// erase the 6th elemen	
	myvector.erase (myvector.begin(),myvector.begin()+3);// erase the first 3 elements:
	std::cout << "myvector contains:";
	for (unsigned i=0; i<myvector.size(); ++i) std::cout << ' ' << myvector[i];
	std::cout << '\n';
	return 0;
}//Output:
myvector contains: 4 5 7 8 9 10
```







###### reserve

-   reserve(n); 表示vector capacity至少要能容纳n个元素
-   If *n* is greater than the current vector capacity, the function causes the container to reallocate its storage increasing its capacity to *n* (or greater).
-   如果n大于当前vector capacity, 则函数将重新分配内存至n或更多
-   In all other cases, the function call does not cause a reallocation and the vector capacity is not affected.
-   该函数不影响vector size, 不改变elements

```c++
#include <iostream>
#include <vector>

int main () {
	std::vector<int>::size_type sz;//vector<int>的容量大小

	std::vector<int> foo;//定义一个vector<int>变量foo
	sz = foo.capacity();//查看foo大小
	std::cout << "making foo grow:\n";
	for (int i=0; i<100; ++i) {
		foo.push_back(i);
		if (sz!=foo.capacity()) {//foo的容量大小改变了
			sz = foo.capacity();//查看改变后的foo的容量大小
			std::cout << "capacity changed: " << sz << '\n';
		}
	}

	std::vector<int> bar;
	sz = bar.capacity();
	bar.reserve(100);   // this is the only difference with foo above
	std::cout << "making bar grow:\n";
	for (int i=0; i<100; ++i) {
		bar.push_back(i);
		if (sz!=bar.capacity()) {
			sz = bar.capacity();
			std::cout << "capacity changed: " << sz << '\n';
		}
	}
	return 0;
}//Output:
making foo grow:
capacity changed: 1
capacity changed: 2
capacity changed: 4
capacity changed: 8
capacity changed: 16
capacity changed: 32
capacity changed: 64
capacity changed: 128
making bar grow:
capacity changed: 100
```







---

# map

-   Map是STL的一個容器，它提供一對一的hash
-   第一個可以稱為關鍵字(key)，每個關鍵字只能在map中出現一次，第二個可能稱為該關鍵字的值(value)
-   Map主要用於資料一對一映射(one-to-one)的情況，map內部的實現自建一顆紅黑樹，這顆樹具有對數據自動排序的功能
-   key-value的key不要用指针，直接用对象，否则无法使用find找到
-   红黑树 RB树(Red-Black Tree)












###### find + end + erase

```c++
//定义一个string到string的映射
map<string, string> mapStudent;

//用insert函數插入pair
mapStudent.insert(pair<string, string>("r000", "student_zero"));
//用"array"方式插入
mapStudent["r123"] = "student_first";
mapStudent["r456"] = "student_second";

//查找：出現時，它返回資料所在位置，如果沒有，返回iter與end函數返回相同
iter = mapStudent.find("r123");
if(iter != mapStudent.end())
	cout<<"Find, the value is"<<iter->second<<endl;
else
	cout<<"Do not Find"<<endl;

//刪除與清空
//清空map中的數據可以用clear()函數，判定map中是否有數據可以用empty()函數，它返回true則說明是空map
//資料的刪除要用到erase函數，它有三個overload的函數
//迭代器刪除
iter = mapStudent.find("r123");
mapStudent.erase(iter);
//用關鍵字刪除
int n = mapStudent.erase("r123");//如果刪除了會返回1，否則返回0
//用迭代器範圍刪除 : 把整個map清空
mapStudent.erase(mapStudent.begin(), mapStudent.end());
//等同於mapStudent.clear()
```





```c++
#include <iostream>
#include <string>
#include <map>
using namespace std;

int main(){
    //declaration container and iterator
    map<string, string> mapStudent;
    map<string, string>::iterator iter;
    map<string, string>::reverse_iterator iter_r;

    //insert element
    mapStudent.insert(pair<string, string>("r000", "student_zero"));

    mapStudent["r123"] = "student_first";
    mapStudent["r456"] = "student_second";

    //traversal//迭代器遍历+反向遍历
    for(iter = mapStudent.begin(); iter != mapStudent.end(); iter++)
                cout<<iter->first<<" "<<iter->second<<endl;
    for(iter_r = mapStudent.rbegin(); iter_r != mapStudent.rend(); iter_r++)
                cout<<iter_r->first<<" "<<iter_r->second<<endl;

    //find and erase the element
    iter = mapStudent.find("r123");
    mapStudent.erase(iter);

    iter = mapStudent.find("r123");

    if(iter != mapStudent.end())
       cout<<"Find, the value is "<<iter->second<<endl;
    else
       cout<<"Do not Find"<<endl;

    return 0;
}//Output:
r000 student_zero
r123 student_first
r456 student_second
r456 student_second
r123 student_first
r000 student_zero
Do not Find
```






###### insert 

```c++
#include <iostream>
#include <map>

int main () {
	std::map<char,int> mymap;

	// first insert function version (single parameter):
	mymap.insert ( std::pair<char,int>('a',100) );
	mymap.insert ( std::pair<char,int>('z',200) );

	std::pair<std::map<char,int>::iterator,bool> ret;
	ret = mymap.insert ( std::pair<char,int>('z',500) );
	if (ret.second==false) {
		std::cout << "element 'z' already existed";
		std::cout << " with a value of " << ret.first->second << '\n';
	}

	// second insert function version (with hint position):
	std::map<char,int>::iterator it = mymap.begin();
	mymap.insert (it, std::pair<char,int>('b',300));
	// max efficiency inserting
	mymap.insert (it, std::pair<char,int>('c',400));
	// no max efficiency inserting

	// third insert function version (range insertion):
	std::map<char,int> anothermap;
	anothermap.insert(mymap.begin(),mymap.find('c'));

	// showing contents:
	std::cout << "mymap contains:\n";
	for (it=mymap.begin(); it!=mymap.end(); ++it)
		std::cout << it->first << " => " << it->second << '\n';

	std::cout << "anothermap contains:\n";
	for (it=anothermap.begin(); it!=anothermap.end(); ++it)
		std::cout << it->first << " => " << it->second << '\n';
	return 0;
}//Output:
element 'z' already existed with a value of 200
mymap contains:
a => 100
b => 300
c => 400
z => 200
anothermap contains:
a => 100
b => 300
```



---



# unordered_map

> http://www.cplusplus.com/reference/unordered_map/unordered_map/

- unordered_map: Unordered Map (class template )
- unordered_multimap: Unordered Multimap (class template )

```cpp
template < class Key,                                    // unordered_map::key_type
           class T,                                      // unordered_map::mapped_type
           class Hash = hash<Key>,                       // unordered_map::hasher
           class Pred = equal_to<Key>,                   // unordered_map::key_equal
           class Alloc = allocator< pair<const Key,T> >  // unordered_map::allocator_type
           > class unordered_map;
```

Internally, the elements in the `unordered_map` are not sorted in any particular order with respect to either their *key* or *mapped* values, but organized into *buckets* depending on their hash values to allow for fast access to individual elements directly by their *key values* (with a constant average time complexity on average). 在内部，unordered_map不会根据key或mapped values来排序，但组织进的buckets取决于key的hash值，以满足快速获取的能力（常数复杂度）。

`unordered_map` containers are faster than `map` containers to access individual elements by their *key*, although they are generally less efficient for range iteration through a subset of their elements. unordered_map获取单个元素的速度快于map，但他们都在遍历元素的子集时效率较低。

- Associative: Elements in associative containers are referenced by their *key* and not by their absolute position in the container.
- Unordered: Unordered containers organize their elements using hash tables that allow for fast access to elements by their *key*. 使用hash表来组织元素以实现通过key快速获取元素
- Map: Each element associates a *key* to a *mapped value*: Keys are meant to identify the elements whose main content is the mapped value. 
- Unique keys: No two elements in the container can have equivalent *keys*. 容器中不能有相同的key
- Allocator-aware: The container uses an allocator object to dynamically handle its storage needs. 使用分配器对象来动态处理其存储需求。



```cpp
#include <iostream>
#include <string>
#include <unordered_map>
using namespace std;
int main ()
{
  unordered_map<string,int> mymap = {{"a", 100},{"b", 200},{"c", 30000 }};
  mymap["a"] = 110;
  mymap.at("b") += 1;

  for (auto& x: mymap) {
    cout << x.first << ": " << x.second << endl;
  }
}
```







---

# queue

-   队列是只允许在表的前端(front)进行删除操作，而在表的后端(rear)进行插入操作的线性表。队列的修改按照先进先出(First In First Out, FIFO)的原则进行，是操作受限的线性表
-   **queue**s are a type of container adaptor, specifically designed to operate in a FIFO context (first-in first-out), where elements are inserted into one end of the container and extracted from the other.
-   queue模板类也需要两个模板参数，一个是元素类型，一个容器类型，元素类型是必要的，容器类型是可选的，默认为deque类型







-   [**empty**](http://www.cplusplus.com/reference/queue/queue/empty/)

    Test whether container is empty (public member function )


-   [**size**](http://www.cplusplus.com/reference/queue/queue/size/)

    Return size (public member function )


-   [**front**](http://www.cplusplus.com/reference/queue/queue/front/)

    Access next element (public member function )


-   [**back**](http://www.cplusplus.com/reference/queue/queue/back/)

    Access last element (public member function )


-   [**push**](http://www.cplusplus.com/reference/queue/queue/push/)

    Insert element (public member function )


-   [**emplace **](http://www.cplusplus.com/reference/queue/queue/emplace/)

    Construct and insert element (public member function )


-   [**pop**](http://www.cplusplus.com/reference/queue/queue/pop/)

    Remove next element (public member function )


-   [**swap **](http://www.cplusplus.com/reference/queue/queue/swap/) //交换两个同类型的队列，整个队列的swap

    Swap contents (public member function )


```c++
#include <iostream>
#include <queue>// std::queue // queue::emplace
int main () {
	std::queue<std::string> myqueue;
	myqueue.emplace ("First sentence");//在队尾添加元素
	myqueue.emplace ("Second sentence");//调用底层容器的emplace_back

	while (!myqueue.empty()) {
		std::cout << myqueue.front() << '\n';//front获取队头元素
		myqueue.pop();
	}
}//Output:
First sentence
Second sentence
```



```c++
int main () {//push back size front pop
	std::queue<int> a;
	for(int i=0; i<10; i++){
		a.push(i);//入队 0 1 2 3 4 5 6 7 8 9
	}
	cout << a.back() << " " << a.size() << endl;// 9 10
	while (!a.empty()) {
		cout << a.front() << " ";//front获取队头元素
		a.pop();//p队头元素出队
	}
}//output:
9 10
0 1 2 3 4 5 6 7 8 9
```



### priority_queue

```cpp
template <class T, //存储的对象
	class Container = vector<T>,//底层实现
	class Compare = less<typename Container::value_type> //排序规则 比较结构
	> class priority_queue;
```

-   Priority queues are a type of container adaptors, specifically designed such that its first element is always the greatest of the elements it contains, according to some *strict weak ordering* criterion.
-   优先队列本质是个heap，底层实现为vector/deque + heap操作
-   第三个参数默认为less，默认情况下，会选择第一个参数决定的类的<运算符来做这个比较函数，但是队列的出队顺序却是greater的先出，因此默认情况下，priority_queue的top有最大值，更改为 priority_queue<T, std::vector<T>, greater<T> > 可以改为top有最小值
-   想要让自定义类能够使用优先队列，要重载小于号//或者指定第三个参数


```cpp
//使用模板的第三个参数，改为top有最小值
priority_queue<int, std::vector<int>, std::greater<int> > p_que;
```







---

# deque

-   双向队列 
-   deque (usually pronounced like *"deck"*) is an irregular acronym of **d**ouble-**e**nded **que**ue. Double-ended queues are sequence containers with dynamic sizes that can be expanded or contracted on both ends (either its front or its back).

![](http://op4fcrj8y.bkt.clouddn.com/17-12-29/87295195.jpg)





---

# set

-   set封装了二叉树
-   在set中每个元素的值都唯一，并且会根据元素的值自动进行排序。set中数元素的值不能直接被改变
-   C++ STL中标准关联容器set, multiset, map, multimap内部采用的就是一种非常高效的平衡检索二叉树：红黑树，也成为RB树(Red-Black Tree)。RB树的统计性能要好于一般平衡二叉树，所以被STL选择作为了关联容器的内部结构




### multiset

-   Multiple-key set 多重集合 set中的一个值只能出现一次，multiset中的值可出现多次

```cpp
template <class T,// multiset::key_type/value_type
          class Compare = less<T>,// multiset::key_compare/value_compare
          class Alloc = allocator<T>// multiset::allocator_type
          > class multiset;
```

-   ​

```cpp
//snippet:
#include <iostream>
#include <set>

using namespace std;

int main(){
	std::multiset<int> myset;

	// set some initial values:
	for (int i = 0; i < 10; ++i) {
		myset.insert((i * 3)%7);    // set: 3 6 9 12
	} 

	for (int i = 0; i < 7; ++i){
		cout << myset.count(i) << " ";
	}
	cout << endl << myset.size() << endl;
	system("PAUSE");
}
```





---

# stack

-   栈是限定仅在表尾进行插入或删除操作的线性表。栈的修改是按后进先出的原则进行的。因此，本又称为后进先出(Last In First Out)的线性表(简称LIFO结构)
-   stack模板类需要两个模板参数，一个是元素类型，一个容器类型，但只有元素类型是必要的，在不指定容器类型时，默认的容器类型为deque(双向队列)





---

# list

```c++
#include <iostream>// list::assign
#include <list>//赋值，会替换原来的内容，同时改变大小

int main() {
	std::list<int> first;
	std::list<int> second;

	first.assign(7, 100);// 7 ints with value 100
	second.assign(first.begin(), first.end()); //用first赋值second，共7元素
	int myints[] = { 1776,7,4 };
	first.assign(myints, myints + 3);//用数组赋值first，从7元素变成3元素
	std::cout << "Size of first: " << int(first.size()) << '\n';
	std::cout << "Size of second: " << int(second.size()) << '\n';
}//Output:
Size of first: 3
Size of second: 7
```



###### sort

-   Sorts the elements in the list, altering their position within the container.
-   对list的元素排序，改变在容器中的位置
-   排序是稳定的

```cpp
void sort();//对内置类型或重载了 < 的可以调用这个函数

template<class Compare>
void sort (Compare comp);
//Parameters comp
Binary predicate that, taking two values of the same type of those contained in the list, returns true if the first argument goes before the second argument in the strict weak ordering it defines, and false otherwise.
This shall be a function pointer or a function object.
```





```cpp
//code snippet: overload "<" to enable use list::sort without pass parameter
class Annms {
public:
	int id;
	Annms(int i = 0) : id(i) {}
	//重载的 < 会在list::sort中用到
	bool operator < (const Annms &rhs) const {
		return id < rhs.id;
	}
};

int main() {
	srand(time(NULL));
	list<Annms> l_test;
	for (int i = 0; i < 10; i++)
		l_test.push_back(Annms(rand() % 100));
	cout << "before sort" << endl;
	for (list<Annms>::iterator itr = l_test.begin(); itr != l_test.end(); itr++) {
		cout << itr->id << " ";
	}

	//sort(list3.begin(), list3.end());//error! 
	l_test.sort();//调用list::sort,使用类定义的 < 做比较
	cout << endl << "after sort" << endl;
	for (list<Annms>::iterator itr = l_test.begin(); itr != l_test.end(); itr++) {
		cout << itr->id << " ";
	}
}//Output://sample case
before sort
2 78 77 55 16 85 31 60 98 37
after sort
2 16 31 37 55 60 77 78 85 98
```




```c++
//此例的list::sort传入了一个call back function用于指定排序方法
#include <iostream>// list::sort
#include <list>
#include <string>
#include <cctype>
//给list::sort调用的回调函数 call back function
//传递给list::sort()的比较函数//函数功能:不区分大小写的string比较
// comparison, not case sensitive.
bool compare_nocase(const std::string& first, const std::string& second) {
	unsigned int i = 0;
	while ((i < first.length()) && (i < second.length())) {
		if (tolower(first[i]) < tolower(second[i])) return true;
		else if (tolower(first[i]) > tolower(second[i])) return false;
		++i;
	}
	return (first.length() < second.length());
}

int main() {
	std::list<std::string> mylist;
	std::list<std::string>::iterator it;
	mylist.push_back("one");
	mylist.push_back("two");
	mylist.push_back("Three");

	mylist.sort();

	std::cout << "mylist contains:";
	for (it = mylist.begin(); it != mylist.end(); ++it)
		std::cout << ' ' << *it;
	std::cout << '\n';

	mylist.sort(compare_nocase);//传递一个函数地址

	std::cout << "mylist contains:";
	for (it = mylist.begin(); it != mylist.end(); ++it)
		std::cout << ' ' << *it;
}//Output:
mylist contains: Three one two//默认按升序排列
mylist contains: one Three two
```





---

# pair



```c++
#include <utility>// std::pair// make_pair example
#include <iostream>// std::cout

int main() {
	std::pair <int, int> foo, bar;
	foo = std::make_pair(10, 20);
	bar = std::make_pair(10.5, 'A');//ok:implicit conversion
									//from pair<double,char>
	std::cout << "foo: " << foo.first << ", " << foo.second << '\n';
	std::cout << "bar: " << bar.first << ", " << bar.second << '\n';

	foo.first = 9;
	foo.second = 1;
	std::cout << "foo: " << foo.first << ", " << foo.second << '\n';
}//output:
foo: 10, 20
bar : 10, 65
```


