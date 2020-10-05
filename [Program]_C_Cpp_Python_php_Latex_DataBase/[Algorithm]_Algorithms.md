[TOC]







---

# 算法基础知识

 

-   递归 recursion: 程序调用自身的编程技巧
-   回溯 backtracking
-   前驱 先导 precursor
-   优先 居先 precedence


算法五大特征:

- 有穷性（Finiteness）算法的有穷性是指算法必须能在执行有限个步骤之后终止
- 确切性(Definiteness)算法的每一步骤必须有确切的定义
- 输入项(Input)一个算法有0个或多个输入，以刻画运算对象的初始情况，所谓0个输入是指算法本身定出了初始条件
- 输出项(Output)一个算法有一个或多个输出，以反映对输入数据加工后的结果。没有输出的算法是毫无意义的
- 可行性(Effectiveness)算法中执行的任何计算步骤都是可以被分解为基本的可执行的操作步，即每个计算步都可以在有限时间内完成（也称之为有效性）


问题类型：

-   排序
-   查找
-   字符串处理
-   图问题
-   组合问题
-   几何问题
-   数值问题




**分治法**Divide and Conquer

- 分治法是把一个复杂的问题分成两个或更多的相同或相似的子问题，再把子问题分成更小的子问题……直到最后子问题可以简单的直接求解，原问题的解即子问题的解的合并。
- 分治法所能解决的问题一般具有以下几个特征：
- 1. 该问题的规模缩小到一定的程度就可以容易地解决
  2. 该问题可以分解为若干个规模较小的相同问题，即该问题具有最优子结构性质
  3. 利用该问题分解出的子问题的解可以合并为该问题的解
  4. 该问题所分解出的各个子问题是相互独立的，即子问题之间不包含公共的子子问题





**回溯法**

-   回溯法（探索与回溯法）是一种选优搜索法，按选优条件向前搜索，以达到目标。但当探索到某一步时，发现原先选择并不优或达不到目标，就退回一步重新选择，这种走不通就退回再走的技术为回溯法，而满足回溯条件的某个状态的点称为“回溯点”
-   其基本思想是，在包含问题的所有解的解空间树中，按照深度优先搜索的策略，从根结点出发深度探索解空间树
-   当探索到某一结点时，要先判断该结点是否包含问题的解，如果包含，就从该结点出发继续探索下去，如果该结点不包含问题的解，则逐层向其祖先结点回溯。（其实回溯法就是对隐式图的深度优先搜索算法）。
-   若用回溯法求问题的所有解时，要回溯到根，且根结点的所有可行的子树都要已被搜索遍才结束。 而若使用回溯法求任一个解时，只要搜索到问题的一个解就可以结束







---

# 算法效率分析与设计

-   时间效率：时间复杂度 time complexity
-   空间效率：空间复杂度 space complexity


$$
\lim_{N\rightarrow \infin}\frac{T(N)-\tilde{T}(N)}{T(N)}\rightarrow 0
$$

> T(N)为算法A的时间复杂性函数

若满足上述表达式，则称$\tilde{T}(N)$为$T(N)$当$N\rightarrow \infin$时的渐近性态



上界

### 平均时间复杂度

> 加权平均时间复杂度 期望时间复杂度



## 递归与分治

> 分而治之 divide and conquer, D&C

- 直接或间接地调用自身的算法称为递归算法。用函数自身给出定义的函数称为递归函数
- 由分治法产生的子问题往往是原问题的较小模式，这就为使用递归技术提供了方便。在这种情况下，反复应用分治手段，可以使子问题与原问题类型一致而其规模却不断缩小，最终使子问题缩小到很容易直接求出其解。这自然导致递归过程的产生











---

# 排序



-   优秀的排序算法可以做到  n log(n) 的复杂度
-   如果排序算法保留了等值元素在输入中的相对顺序，就可以说事稳定的(stable)
-   一般，将相隔很远的key交换位置的算法虽然不稳定但往往速度很快
-   算法需要的额外存储空间：若不需要额外存储空间(除个别存储单元外)，则说它事在位的(in-place)
-   不稳定排序口诀：快一些选堆（快：快排， 些：希尔，选：选择，堆：堆排）






### 插入排序 Insertion Sort

![](http://op4fcrj8y.bkt.clouddn.com/18-1-19/65265284.jpg)

-   算法复杂度Θ(n^2^)  空间复杂度Θ(1) 

1.  从第一个元素开始，该元素可以认为已经被排序
2.  取出下一个元素，在已经排序的元素序列中从后向前扫描
3.  如果该元素（已排序）大于新元素，将该元素移到下一位置
4.  重复步骤3，直到找到已排序的元素小于或者等于新元素的位置
5.  将新元素插入到该位置后
6.  重复步骤2~5

```c
void insertion_sort(int arr[], int len) {
	for (int i = 1, j = 0 ; i < len; ++i) {//对比len - 1次，直到最后只剩一个数
		int temp = arr[i];//temp为关键数,关键数从第二个开始，因为第一个单个有序
		for (j = i - 1; j >= 0 && arr[j] > temp; --j)//对比关键数前的所有数
			arr[j + 1] = arr[j];//找到比关键数大的数值，插入到关键数后面
		arr[j + 1] = temp;//插入关键数
	}
}
```








### 选择排序 Selection sort

-   蛮力法
-   时间复杂度 Θ(n^2^)，但对key的交换仅为Θ(n)，更精确的说是n-1，这一特性使排序算法优于许多其他排序算法

1.  扫描最后i个元素 //i初始为元素总数
2.  将扫描到的最小元素放在i个元素的第一个
3.  i-- ，跳到第一步 //跳过已排序好的那个最小元素，继续排序剩下的




![](http://op4fcrj8y.bkt.clouddn.com/17-11-10/83433286.jpg)

```c
void selection_sort(int arr[], int len) {
	for (int i = 0, min = 0 ; i < len - 1; i++) {
		min = i;
		for (int j = i + 1; j < len; j++)//遍历未排序元素
			if (arr[min] < arr[j])//找到当前最小值
				min = j;//记录下标值
	   	swap(arr[min], arr[i]);//交换数值
	}//每次循环结束都会使数组开头形成有序数列
}
```



### 希尔排序 Shell Sort 

-   希尔排序，也称递减增量排序算法，插入排序的一种更高效的改进版本
-   非稳定排序算法
-   插入排序在对几乎已经排好序的数据操作时，效率高，即可以达到线性排序的效率
-   但插入排序一般来说是低效的，因为插入排序每次只能将数据移动一位

```c
void shell_sort(int arr[], int len) {
	int gap, i, j;
	int temp;
	for (gap = len >> 1; gap > 0; gap >>= 1){
		for (i = gap; i < len; i++) {
			temp = arr[i];
			for (j = i - gap; j >= 0 && arr[j] > temp; j -= gap)
				arr[j + gap] = arr[j];
			arr[j + gap] = temp;
		}
    }
}
```





### 冒泡排序 Bubble Sort

-   蛮力法

```c++
for(j = 0; j < total; j++){//j loop *total   total* num
	//k from j+1 to total-1
	for(k = j+1; k < total; k++){//num1 num2...numj..*num k*...num(total-1);
		if(num[j] > num[k]){//exchange,let min to front, max to end
			temp = num[j];
			num[j] = num[k];
			num[k] = temp;
		}
	}
}
```













### 快速排序 Quick Sort

-   Quicksort 是对冒泡排序的一种改进
-   又称**划分交换排序** partition-exchange sort
-   最优时间复杂度 平均时间复杂度 *O*(n log n)  最坏时间复杂度Θ(n^2^)
-   快速排序通常明显比其他*O*(n log n) 算法更快，因为它的内部循环（inner loop）可以在大部分的架构上很有效率地被实现出来//硬件相关
-   基本思想：通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列
-   不稳定
-   Worst-case performance O(n^2^) Best-case performance O(n log~2~n) Average performance O(n log~2~n) Worst-case space complexity O(log~2~n)


```c++

```






```c++
void sort(int *a, int left, int right) {
	if (left >= right) {//left大于或者等于right 代表已经整理完成一个组
		return;
	}
	int key = a[left];//key记录left元素//在后来的递归调用中一直存在故O(log n)
	int l = left, r = right;

	while (l < r) {//控制在当组内寻找一遍
		while (l < r && key <= a[r]) {//寻找结束的条件: 1，找到一个小于或者大于key的数（大于/小于取决于想升序还是降序）2，没有符合条件1，且i与j的大小没有反转
			r--;//从后往向前找
		}//在右边找比key小的元素，然后扔到左边
		a[l] = a[r];
		//找到一个这样的数后就把它赋给前面的被拿走的i的值
		//如果第一次循环且key是a[left]，那么就是给key

		while (l < r && a[l] < key) {//这是r在当组内向前寻找
			//因为排序思想是把数往两边扔，所以左右两边的数大小与key的关系相反
			l++;//从前往后找
		}//在左边找比key大的元素，然后扔到右边
		a[r] = a[l];
	}//该循环结束时，l一定等于r，是最后一个被扔掉的元素下标
	a[l] = key;//当在当组内找完一遍以后就把中间数key回归
	sort(a, left, l - 1);//最后用同样的方式对分出来的左边的小组进行同上的做法
	sort(a, l + 1, right);//用同样的方式对分出来的右边的小组进行同上的做法
}
```

```c++
template <typename T>//递归法
void quick_sort_recursive(T arr[], int start, int end) {
	if (start >= end)
		return;
	T mid = arr[end];//mid要被放在最中间，左边比mid小，右边比mid大
	int left = start, right = end - 1;
	while (left < right) {//控制在当组内寻找一遍
		while (arr[left] < mid && left < right)
			left++;
		while (arr[right] >= mid && left < right)
			right--;
		std::swap(arr[left], arr[right]);
	}
	if (arr[left] >= arr[end])
		std::swap(arr[left], arr[end]);
	else
		left++;
	quick_sort_recursive(arr, start, left - 1);
	quick_sort_recursive(arr, left + 1, end);
}
template <typename T> //使用class時必須設定(<)、(>)、(>=)的運算子功能
void quick_sort(T arr[], int len) {
	quick_sort_recursive(arr, 0, len - 1);
}
```









### 归并排序 Merge Sort

-   归并操作merge，也叫归并算法，指的是将两个已经排序的序列合并成一个序列的操作。归并排序算法依赖归并操作
-   分治法 Divide and Conquer
-   速度仅次于快速排序，为稳定排序算法，一般用于对总体无序，但是各子项相对有序的数列
-   Worst-case performance O(n log~2~n) Best-case performance O(n log~2~n) O(n) natural variant Average performance O(n log~2~n)  Worst-case space complexity O(n) O(1) auxiliary with linked lists



```c++
//递归版
template<typename T>
void merge_sort_recursive(T arr[], T reg[], int start, int end) {
	if (start >= end)
		return;
	int len = end - start, mid = (len >> 1) + start;
	int start1 = start, end1 = mid;
	int start2 = mid + 1, end2 = end;
	merge_sort_recursive(arr, reg, start1, end1);
	merge_sort_recursive(arr, reg, start2, end2);
	int k = start;
	while (start1 <= end1 && start2 <= end2)
		reg[k++] = arr[start1] < arr[start2] ? arr[start1++] : arr[start2++];
	while (start1 <= end1)
		reg[k++] = arr[start1++];
	while (start2 <= end2)
		reg[k++] = arr[start2++];
	for (k = start; k <= end; k++)
		arr[k] = reg[k];
}
template<typename T> //整數或浮點數皆可使用,若要使用class 必須設定 < 的運算子功能
void merge_sort(T arr[], const int len) {
	T reg[len];
	merge_sort_recursive(arr, reg, 0, len - 1);
}
```

```c++
template<typename T> //若要使用class時必須設定"小於"(<)的運算子功能
void merge_sort(T arr[], int len) {
	T* a = arr;
	T* b = new T[len];
	for (int seg = 1; seg < len; seg += seg) {
		for (int start = 0; start < len; start += seg + seg) {
			int low = start, mid = min(start + seg, len), high = min(start + seg + seg, len);
			int k = low;
			int start1 = low, end1 = mid;
			int start2 = mid, end2 = high;
			while (start1 < end1 && start2 < end2)
				b[k++] = a[start1] < a[start2] ? a[start1++] : a[start2++];
			while (start1 < end1)
				b[k++] = a[start1++];
			while (start2 < end2)
				b[k++] = a[start2++];
		}
		T* temp = a;
		a = b;
		b = temp;
	}
	if (a != arr) {
		for (int i = 0; i < len; i++)
			b[i] = a[i];
		b = a;
	}
	delete[] b;
}
```





### 堆排序 Heap Sort

-   **堆排序**是指利用堆这种数据结构所设计的一种排序算法。堆积是一个近似完全二叉树的结构，并同时满足堆积的性质：即子结点的键值或索引总是小于/大于它的父节点

![](http://op4fcrj8y.bkt.clouddn.com/17-11-24/65419774.jpg)


- 最坏时间复杂度 O(n log~2~n)
- 最优时间复杂度 O(n log~2~n) 
- 平均时间复杂度 Θ(n log~2~n)}
- 空间复杂度 O(n) total O(1) auxiliary




通常堆是通过一维数组来实现的。在数组起始位置为0的情形中：

-   父节点 i 的左子节点在位置 (2i+1)
-   父节点 i 的右子节点在位置 (2i+2)
-   子节点 i 的父节点在位置 floor((i-1)/2)


```cpp
//堆排序
#include <iostream>
#include <list>
#include <algorithm>

using namespace std;

template<typename Record>
void print(Record* arr, int len) {
	for (int i = 0; i < len-1; i++) {
		cout << arr[i] << " ";
	}
	cout << arr[len-1] << endl;
}

//在排序时，相当于当arr[low]值为current时，重新调整为大堆
template<typename Record>//insert时arr[0]为空//arr[low],值为current下沉
void insert_heap(Record* arr, const Record& current, int low, int high) {
	int large = 2 * low + 1;//large 是 low 的左孩子

	while (large <= high) {//high为上界
		//不执行条件：overflow or 左孩子大于等于右孩子
		if (large < high && arr[large] < arr[large + 1]) {
			large++;//找左右孩子中，较大的一个
		}
		
		//如果父节点已经 >= 两个孩子节点的较大者，则break
		if (current >= arr[large]) {
			break;
		}
		//三节点中，parent不是最小时，将两个child中大的上浮到parent(最开始的parent值仍在current中)
		else {//current < arr[large], arr[large]是父节点即current和两个子节点最大的一个节点
			arr[low] = arr[large];//将最大的节点赋值给父节点
			low = large;//向两个孩子中较大的一端递归//更新low和large,给下一次迭代使用
			large = 2 * low + 1;
			//current是原来的arr[low]或者是被覆盖的最后一个元素，现在赋值给原来的arr[large]
		}
	}
	//如果不存在孩子节点了，则一开始的父节点current直接放在 arr[low]中 
	arr[low] = current;
	//print(arr, high);
}

template<typename Record>
void build_heap(Record* arr, int count) {
	int low;
	//count/2 - 1 的元素才有child
	for (low = count / 2 - 1; low >= 0; low--) {//从 count/2 - 1 递减1
		Record current = arr[low];
		insert_heap(arr, current, low, count - 1);
	}
}

template<typename Record>
void heap_sort(Record* arr, int count) {
	int last_unsorted;
	//call: build_heap
	build_heap(arr, count);
	print(arr, count);
	Record be_cover;//将被覆盖的，最后一个未排序的元素
	for (last_unsorted = count - 1; last_unsorted > 0; last_unsorted--) {//从count - 1递减到1
		be_cover = arr[last_unsorted];//记录即将被覆盖的最后一个未排序元素
		arr[last_unsorted] = arr[0];//每次都把大堆的堆顶，赋值给已排好序的部分的第一个元素
		//call: insert_heap
		insert_heap(arr, be_cover, 0, last_unsorted - 1);
		print(arr, count);
	}
}

int main() {
	int num_count;
	while(cin >> num_count){
		int* arr = new int[num_count];
		for(int i=0; i<num_count; i++){
			cin >> arr[i];
		}
		heap_sort(arr, num_count);
	}
}
```





### 拓扑排序 Top Sort

![](http://op4fcrj8y.bkt.clouddn.com/17-12-29/70882208.jpg)

-   In the field of computer science, a **topological sort** or **topological ordering** of a directed graph is a linear ordering of its vertices such that for every directed edge (u, v) from vertex *u* to vertex *v*, *u* comes before *v* in the ordering.
-   对一个有向无环图(Directed Acyclic Graph简称DAG)G进行拓扑排序，是将G中所有顶点排成一个线性序列，使得图中任意一对顶点u和v，若边(u,v)∈E(G)，则u在线性序列中出现在v之前
-   通常，这样的线性序列称为满足拓扑次序(Topological Order)的序列，简称拓扑序列。排序的过程称之为拓扑排序
-   显然，一个图会有多个合法的拓扑顺序。拓扑排序只要求给出其中的一种
-   决定一组存在依赖关系的事情的执行顺序，使得执行过程中不会发生冲突。--- 拓扑排序
-   判断一组存在相互依赖关系的事情是否存在冲突（在图中，循环依赖表现为有向环）。此问题也需要在拓扑排序的过程中进行进行检测



入度数组法

1.  使用一个入度数组统计图上每个节点的入度
2.  之后每一次都从剩余节点中移除入度为0的节点，同时修改该节点邻接节点的入度(节点被移除，从该节点出发的有向边也要被移除）。如果找不到入度为0的节点，说明图中存在环，拓扑排序失败
3.  重复(2)直到所有节点都被移除，此时移除节点的顺序就是一个拓扑序


```cpp
//入度数组法
//时间复杂度：O(|V| + |E|)
//空间复杂度: O(|V| + |E|)
#include <iostream>
#include <vector>
#include <list>
#include <queue>
#include <algorithm>
#include <functional>

using namespace std;


bool TopSort(const vector<list<int> >& graph, vector<int>& in_degree,
	const size_t task, vector<int>& top_sequence) {
	//最小堆
	priority_queue<int, std::vector<int>, std::greater<int> > que;
	top_sequence.clear();
	//首先将初始时入度为0的task入队，初始化优先队列
	for (size_t i = 1; i <= task; i++) {
		if (in_degree[i] == 0) {
			que.push(i);
		}
	}
	//循环：删除最小的0入度task及对应的边，添加新的0入度task（若有）
	while (!que.empty()) {
		int todo = que.top();
		que.pop();
		top_sequence.push_back(todo);
		for (list<int>::const_iterator itr = graph[todo].begin(); itr != graph[todo].end(); itr++) {
			in_degree[*itr]--;//删除出队task对应的边，更新边相连的task的入度
			if (in_degree[*itr] == 0) {//添加新的0入度task
				que.push(*itr);
			}
		}
	}

	if (top_sequence.size() == task)
		return true;
	return false;//存在环时，topsort的结果和task的计数不一致
}

int main() {
	size_t test_case;
	cin >> test_case;
	while (test_case--) {
		size_t task, relation;
		cin >> task >> relation;
		int from, to;
		vector<list<int> > graph(task + 1, list<int>());
		vector<int> in_degree(task + 1, 0);//[1, task]
		for (size_t i = 1; i <= relation; i++) {
			cin >> from >> to;
			graph[from].push_back(to);//记录: edge: (from, to)
			in_degree[to]++;//入度记录
		}
		vector<int> top_sequence;
		if (TopSort(graph, in_degree, task, top_sequence)) {
			for (size_t i = 0; i < top_sequence.size(); i++) {
				cout << top_sequence[i] << " ";
			}
			cout << endl;
		}
		else {
			cout << "No solution" << endl;
		}
	}
}
/*
Sample input:
1
5 5
3 4
4 1
3 2
2 4
5 3 
Sample output:
5 3 2 4 1  
*/
```











---

# 查找

-   在给定集合中找一个特定的key(查找键(search key))
-   






### 二分搜索 Binary Search 

-   又称折半查找 half-interval search logarithmic search binary chop
-   is a search algorithm that finds the position of a target value within a sorted array
-   优点: 比较次数少，查找速度快，平均性能好
-   缺点: 要求待查表为有序表，且插入删除困难
-   适用: 不经常变动而查找频繁的有序列表
-   时间复杂度: O(log2n)Binary search runs in at worst logarithmic time, making *O*(log *n*) comparisons, where n is the number of elements in the array
-   空间复杂度: constant (*O*(1)) space, meaning that the space taken by the algorithm is the same for any number of elements in the array



#### 二分搜索 解决每天吃巧克力数量不少于前一天吃的一半

```cpp
#include <algorithm>
#include <cstdio>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
using namespace std;

// N<=M<=100000

int cal(int n_day, int num) {  //天数，第一天吃的数量
    int need = 0;
    for (int i = 0; i < n_day; ++i) {
        need += num;
        num = (num + 1) >> 1;
    }
    return need;
}
int BinSearch(int n_day, int m) {
    if (n_day == 1) {
        return m;
    }
    int low = 1;
    int high = m;
    while (low < high) {
        int mid = (low + high + 1) >> 1;
        int need = cal(n_day, mid);
        if (need == m) {
            return mid;
        } else if (need > m) {
            high = mid - 1;
        } else {
            low = mid;
        }
    }
    return high;
}
int main() {
    int n_day, m;
    cin >> n_day >> m;
    cout << BinSearch(n_day, m) << endl;
    return 0;
}
```







---

# 字符串处理



#### 最长回文串

- 将字符串反转后，求反转前和反转后的最长公共子序列 Note: 不要求连续
- 使用的数据结构：长度数组
- 子问题空间中，总共只有`O(m*n)`个不同的子问题，因此，用动态规划算法`自底向上`地计算`最优值`能提高算法的效率

```cpp
#include <algorithm>
#include <iostream>
#include <string>
using namespace std;
const int ARR_MAX_LEN = 1005;
int record[ARR_MAX_LEN][ARR_MAX_LEN];

int getRemoveCount(string& ori_str) {
    record[0][0] = 0;
    record[0][1] = 0;
    record[1][0] = 0;
    int len = ori_str.length();
    string rvs_str = ori_str;

    reverse(rvs_str.begin(), rvs_str.end());
    // cout << len << " " << rvs_str.length() << rvs_str << endl;
    for (int i = 0; i < len; ++i) {
        for (int j = 0; j < len; ++j) {
            if (ori_str[i] == rvs_str[j]) {
                record[i + 1][j + 1] = record[i][j] + 1;
            } else {
                record[i + 1][j + 1] = max(record[i][j + 1], record[i + 1][j]);
            }
        }
    }
    return len - record[len][len];
}

int main() {
    string ori_str;
    while (cin >> ori_str) {
        cout << getRemoveCount(ori_str) << endl;
    }
    return 0;
}
```



#### 不申请额外空间 将大写字母放在字符串后面

- 需要保持相对顺序不变

```cpp
#include <algorithm>
#include <iostream>
#include <string>

using namespace std;

const int ARR_MAX_LEN = 1005;

void swap(string& ori_str, int l, int r) {
    char temp = ori_str[l];
    ori_str[l] = ori_str[r];
    ori_str[r] = temp;
}

void moveAUpcase(string& ori_str, int forward, int behind) {
    --behind;
    for (; forward < behind; ++forward) {
        swap(ori_str[forward], ori_str[forward + 1]);
        // cout << forward << " behind:" << behind << endl;
    }
}

void moveUpcase(string& ori_str) {
    int behind = ori_str.length();
    for (int idx = behind; idx >= 0; --idx) {
        if (ori_str[idx] >= 'A' && ori_str[idx] <= 'Z') {
            moveAUpcase(ori_str, idx, behind);
            --behind;
        }
    }
}
// AkleBiCeilD
// kleieilABCD
int main() {
    string ori_str;
    while (cin >> ori_str) {
        moveUpcase(ori_str);
        cout << ori_str << endl;
    }
    return 0;
}
```

#### 输出一组数中 最小值对和最大值对的数量(牛客网 未通过)

```cpp
#include <algorithm>
#include <cstdio>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
using namespace std;

const int N = 100000;

int main() {
    int arr[N];
    int len = 0;
    // ifstream fcin("in.txt");
    // stringstream ss;
    // ss << fcin.rdbuf();
    while (cin >> len) {  // scanf("%d", &len) != EOF
        // cout << "len == " << len << endl;
        for (int i = 0; i < len; ++i) {
            cin >> arr[i];  // scanf("%d", &arr[i]);
            // cout << i << "arr[i] " << arr[i] << endl;
        }
        sort(arr, &arr[len]);
        // printf("after sort ");
        // for (int i = 0; i < len; ++i) {
        //     printf("%d ", arr[i]);
        // }
        // printf("\n");
        // 求最大值对的个数
        int min_num = 1, max_num = 1;
        while (arr[min_num - 1] == arr[min_num]) {
            ++min_num;
        }
        while (arr[len - max_num] == arr[len - max_num - 1]) {
            ++max_num;
        }
        max_num = max_num * min_num;

        //求最小值对的个数
        int min_value = ~(1 << (sizeof(int) * 8 - 1));
        int last = 0;
        vector<int> vec;
        min_num = 1;
        for (int i = 1; i < len; ++i) {
            if (arr[i] - arr[i - 1] < min_value) {
                min_value = arr[i] - arr[i - 1];
                last = i;
                vec.clear();
                min_num = 1;
            } else if (arr[i] - arr[i - 1] == min_value) {
                if (i - 1 == last) {
                    last = i;
                    ++min_num;
                } else {
                    last = i;
                    min_num = 1;
                }
            } else {
                vec.push_back(min_num);
            }
        }
        for (int i = 0; i < vec.size(); ++i) {
            if (vec[i] > min_num) {
                min_num = vec[i];
            }
        }
        printf("%d %d\n", min_num, max_num);
    }
    return 0;
}
```









---

# 图问题






### Union-Find Sets并查集

-   并查集(Union-find Sets)
-   并查集（Union-find Sets）是一种非常精巧而实用的数据结构，它主要用于处理一些*不相交集合*的合并问题。一些常见的用途有求连通子图、求最小生成树的 Kruskal 算法和求最近公共祖先（Least Common Ancestors, LCA）
-   每个集合可能包含一个或多个元素，并选出集合中的某个元素作为**代表**。每个集合中具体包含了哪些元素是不关心的，具体选择哪个元素作为代表一般也是不关心的。我们关心的是，对于给定的元素，可以很快的找到这个元素所在的集合（的代表），以及合并两个元素所在的集合，而且这些操作的时间复杂度都是**常数级**的



并查集基础的三个步骤：

1.  makeSet(s)：建立一个新的并查集，其中包含 s 个单元素集合。
2.  unionSet(x, y)：把元素 x 和元素 y 所在的集合合并，要求 x 和 y 所在的集合不相交，如果相交则不合并。
3.  Find(x)：找到元素 x 所在的集合的代表，该操作也可以用于判断两个元素是否位于同一个集合，只要将它们各自的代表比较一下就可以了

```cpp
/*
求连通块
输入一个简单无向图，求出图中连通块的数目
输入的第一行包含两个整数n和m，n是图的顶点数，m是边数。1<=n<=100，0<=m<=10000。
以下m行，每行是一个数对u v，表示存在边(u,v)。顶点编号从1开始
单独一行输出连通块的数目
Sample input:
5 3
1 2
1 3
2 4
Sample output:
2
*/
#include <iostream>
#include <deque>

using namespace std;
//查找代表元,并压缩路径//recursion
int Find(int* precursor, int p) {
	if (p != precursor[p])
		precursor[p] = Find(precursor, precursor[p]);
	return precursor[p];
}
//把两个元素所在集合合并
void Union(int* precursor, int p, int q, int& count) {
	int p_id = Find(precursor, p);
	int q_id = Find(precursor, q);
	//cout <<"p q id: "<<p_id<<" "<<q_id<<endl;
	if (p_id == q_id) {//已是同一集合 do nothing
		return;
	}
	else {
		precursor[q_id] = p_id;//将两个集合并在一起
		count--;//集合数量计数--
	}
}

int main() {
	int precursor[101];
	int num, edge;
	cin >> num >> edge;
	for (int i = 1; i <= num; i++) {
		precursor[i] = i;
	}
	int from, to, count = num;//集合计数：count
	while (edge--) {
		cin >> from >> to;
		Union(precursor, from, to, count);
	}
	cout << count << endl;
}
```








### DFS

-   Depth-First-Search 深度优先搜索算法
-   一种用于遍历或搜索树或图的算法。属于盲目搜索
-   深度优先搜索是图论中的经典算法，利用深度优先搜索算法可以产生目标图的相应拓扑排序表，利用拓扑排序表可以方便的解决很多相关的图论问题，如最大路径问题



1. 首先以一个未被访问过的顶点作为起始顶点，沿当前顶点的边走到未访问过的顶点；
2. 当没有未访问过的顶点时，则回到上一个顶点，继续试探访问别的顶点，直到所有的顶点都被访问
3. 沿着某条路径遍历直到末端，然后回溯，再沿着另一条进行同样的遍历，直到所有的顶点都被访问过为止






某些路径搜索问题要求记录路径信息，对于DFS和BFS来说记录路径的信息的方法各不相同，这里总结如下(注意这里的节点不是简单的指图上的节点而是在搜索过程中到达的位置):

（1）DFS使用栈记录路径信息。从节点u到邻接节点v, 那就将边u v 入栈，如果发生回退，那就将栈顶元素出栈。 找到目标节点后，逆序打印栈所记录的路径信息，就能得到一条完整的路径。

（2）BFS记录信息比较麻烦，一般有两种方法: 

每一个节点都保存一个路径队列，如果从节点u到邻接节点v,  那么就先将u节点的路径队列复制到v节点，然后将边uv压入v节点的路径队列。找到目标节点后顺序打印队列所记录的路径信息，就能得到一条完整的路径。优点是简单实用，缺点是内存消耗大。

每一个节点都记录遍历过程中它的前继节点的指针或下标。此时不能直接使用STL提供的队列，因为它访问完一个节点后就会将那个节点删除，最好自己使用数组或vector实现一个不会删除出队元素的队列。找到目标节点后，从目标节点开始，逆序打印路径链表，就能得到一条完整的路径。




###### 迷宫路径







>   ​	写一个程序，先输入迷宫的维度M和N，然后输入这个M * N的迷宫，迷宫位置上的数值为0代表该位置可以通过，为1代表该位置有障碍不能通过，用深度优先搜索算法搜出一条从迷宫左上角到右下角的路径。规定搜索顺序为上、下、左、右。
>   如：
>   迷宫为2 * 2的：
>   00
>   00
>   搜索从左上角开始，到达右下角的路径应该是(0,0) (1,0) (1,1)
>
>   ###### Input
>
>   第一行是一个整数t，代表测试用例个数
>   接下来有t个迷宫，每个迷宫的格式如下：
>   第一行有两个整数M和N，中间用空格隔开，表示迷宫的维度，0 < M, N < 10
>   接下来有M行，每一行有N个元素，每个元素都是0或者1，注意元素之间是没有空格的
>
>   ###### Output
>
>   对于每一个用例，如果用深度优先搜索算法能搜索出路径，则输出搜索到的路径，路径的格式如下：
>   用坐标代表每个位置：(x,y)，注意是没有空格的，每两个坐标之间有一个空格(结尾无空格)
>   如：(0,0) (1,0) (1,1)表示从位置(0,0)走到位置(1,0)再走到位置(1,1)
>   如果不能搜索出路径，则输出no

```cpp
#include <iostream>
#include <string>
#include <deque>

using namespace std;

//Depth First Search to find a path
//pre: maze:0 connected; 1 barrier//(x,y) entrance, (x_boundary-1,y_boundary-1)exit
//post:path:path from entrance to exit, maze[i][j] means the distance from (x,y) entrance
bool DFS(int** maze, int** distance, int x, int y, const int x_boundary, const int y_boundary,
         	deque<pair<int, int> >& path, bool is_ini = false) {
	int next[4][2] = { { -1,0 },{ 1,0 },{ 0,-1 },{ 0,1 } };//up,down,left,right
	//initialization
	if (is_ini == false) {
		for (int i = 0; i < x_boundary; i++) {
			for (int j = 0; j < y_boundary; j++) {
				distance[i][j] = -1;//-1 means hasn't visit
			}
		}
		path.push_back(make_pair(x, y));
		distance[x][y] = 0;
		is_ini = true;
	}
	//function return: (x_boundary-1,y_boundary-1)exit
	if (x == x_boundary - 1 && y == y_boundary - 1) {
		//cout << "distance" << distance[x_boundary - 1][y_boundary - 1] << endl;
		return true;
	}
	//search four direction depend on sequence of next
	for (int i = 0; i < 4; i++) {
		int next_x = x + next[i][0], next_y = y + next[i][1];
		//boundary check//迷宫边界检查
		if (next_x < 0 || next_x >= x_boundary || next_y < 0 || next_y >= y_boundary) {
			continue;
		}
		//if the next position can be visited and has't visit 
		if (maze[next_x][next_y] == 0 && distance[next_x][next_y] == -1) {
			//distance count
			distance[next_x][next_y] = distance[x][y] + 1;
			//push next position
			path.push_back(make_pair(next_x, next_y));
			//recursive call, if path found, return true
			if (DFS(maze, distance, next_x, next_y, x_boundary, y_boundary, path, is_ini)) {
				return true;
			}
			//path not found, pop last position
			path.pop_back();
			//cancel visit
			distance[next_x][next_y] = -1;
		}
	}
	return false;
}

int main() {
	int test;
	cin >> test;
	while (test--) {
		int x_boundary, y_boundary;
		cin >> x_boundary >> y_boundary;

		int ** maze = new int*[x_boundary];
		for (int i = 0; i < x_boundary; i++) {
			maze[i] = new int[y_boundary];
		}
		int ** distance = new int*[x_boundary];
		for (int i = 0; i < x_boundary; i++) {
			distance[i] = new int[y_boundary];
		}

		for (int i = 0; i < x_boundary; i++) {
			string line;
			cin >> line;
			for (size_t j = 0; j < line.size(); j++) {
				maze[i][j] = line.at(j) - '0';
			}
		}

		deque<pair<int, int> > path;

		if (DFS(maze, distance, 0, 0, x_boundary, y_boundary, path) == false) {
			cout << "no" << endl;
		}
		else {
			while (path.size() > 1) {
				cout << '(' << path.front().first << ',' << path.front().second << ") ";
				path.pop_front();
			}
			if (path.size()) {
				cout << '(' << path.front().first << ',' << path.front().second << ")" << endl;
			}
		}
		//delete
		for (int i = 0; i < x_boundary; i++) {
			delete[] maze[i];
		}
		delete[] maze;

		for (int i = 0; i < x_boundary; i++) {
			delete[] distance[i];
		}
		delete[] distance;
	}
}
//input:
6
5 9
011111111
010000011
000111011
110000000
111111110

2 2
01
00

4 4
0011
0001
1110
1100

8 10
0001001000
0100000010
0001111111
0101000000
1001111101
1000100001
1110000101
1111111100

5 8
00000001
01010100
00011111
01000100
10010000

5 8
00000001
01010100
00011111
01000100
10010010
//output:
(0,0) (1,0) (2,0) (2,1) (2,2) (1,2) (1,3) (1,4) (1,5) (1,6) (2,6) (3,6) (3,7) (3,8) (4,8)
(0,0) (1,0) (1,1)
no
(0,0) (1,0) (2,0) (2,1) (2,2) (3,2) (4,2) (5,2) (5,3) (6,3) (6,4) (6,5) (5,5) (5,6) (5,7) (5,8) (6,8) (7,8) (7,9)
(0,0) (1,0) (2,0) (2,1) (2,2) (3,2) (3,3) (3,4) (4,4) (4,5) (4,6) (3,6) (3,7) (4,7)
no
```







### BFS

-    Breadth-First Search (**BFS**) is an algorithm for traversing or searching tree or graph data structures. 
-    广度优先搜索





```cpp
//BFS的queue非递归实现//代码非完全！！！
#include <queue>
#include <iostream>

#define MAX 10000

using namespace std;

int main() {

}
class Graph {
public:
	int num;
	int matrix[MAX][MAX];
};

void BFS() {
	Graph example;
	int i, nNode;
	queue<int> gQueue;
	int *visited = new int[example.num++];
	memset(visited, 0, sizeof(int)*(example.num + 1));

	cout << "BFS" << "------------------------------------" << endl;
	visited[initNode] = 1;
	gQueue.push(initNode);

	while (!gQueue.empty()) {
		nNode = gQueue.front();
		cout << " " << nNode;
		for (i = 1; i <= example.num; i++) {
			if (example.matrix[nNode][i] == 1 && visited[i] == 0) {
				gQueue.push(i);
				visited[i] = 1;
			}
		}
		gQueue.pop();
	}
	cout << endl << "BFS" << "------------------------------------" << endl;
}

```







### Dijkstra

> one of the shortest path first (SPF) algorithm

![](http://op4fcrj8y.bkt.clouddn.com/17-12-28/17879109.jpg)

-   Dijkstra's algorithm is an algorithm for finding the shortest paths between nodes in a graph。
-   Dijkstra算法是寻找图中两个节点的最短路径的算法
-   戴克斯特拉算法 贪婪算法 使用广搜 Backtracking




```cpp
//伪代码 pseudocode
function Dijkstra(G, w, s)//G:graph w:权数组 s:起点
	for each vertex v in V[G] //初始化
		d[v] := infinity//將各點的已知最短距離先設成無窮大
		previous[v] := undefined//各点的已知最短路径上的前趋都未知
	d[s] := 0 //起点到起点的距离为0
	S := s //S 保留所有已知最小 d[v] 值的顶点 v
	Q := set of all vertices//Q 则保留其他所有顶点，初始时为全体节点-起点
	while Q is not an empty set      //Dijkstra演算法主體
		u := Extract_Min(Q)//找到有最小d[u]值得顶点u,返回u并在Q中删除u
		S.append(u)  //将有最小d[u]得u添加到S
		for each edge outgoing from u as (u,v)//
			if d[v] > d[u] + w(u,v)  //拓展边(u,v)//w(u,v)为从u到v的路径长度
				d[v] := d[u] + w(u,v)  //更新路径长度到更小的那个和值
				previous[v] := u       //紀錄前驱頂點
```



```cpp
/*每组数据第一行包含两个正整数N和M（0<N<200，0<M<1000），分别代表现有城镇的数目和已修建的道路的数目。城镇分别以0,1,...,N-1编号
接下来M行道路信息。每一行有三个整数A,B,X（0<A,B<N,A!=B,0<X<10000）
表示城镇A和城镇B之间有一条长度为X的双向道路
再接下一行有两个整数S,T（0<=S,T<N），分别代表起点和终点
对于每组数据，请在一行里输出最短需要行走的距离。如果不存在从S到T的路线，就输出-1
*/
#include <iostream>  
#include <vector> 

using namespace std;

const int DISCONNECT = 1 << (sizeof(int) * 8 - 2);

vector<int> Dijkstra(vector<vector<int> > adj_arr, const int start) {
	int vertex_num = adj_arr.size();
	vector<bool> visit(vertex_num, false);//已经加入的点
	visit[start] = true;//已经加入的点一开始只有起始点
	vector<int> cast(vertex_num, DISCONNECT);//记录从已经加入的点到未加入点的最短距离
	//初始化cast
	for (int i = 0; i < vertex_num; i++) {
		cast[i] = adj_arr[start][i];
	}
	cast[start] = 0;
	for (int i = 1; i < vertex_num; i++) {
		int min_dis = DISCONNECT;
		int pos = start;
		//找到从已经加入的点到其余点的最短距离
		for (int j = 0; j < vertex_num; j++) {
			if (visit[j] == false && cast[j] < min_dis) {
				pos = j;
				min_dis = cast[j];
			}
		}
		visit[pos] = true;
		for (int j = 0; j < vertex_num; j++) {//refresh cast array
			if ((visit[j] == false) && (cast[j] > cast[pos] + adj_arr[pos][j])) {//
				cast[j] = cast[pos] + adj_arr[pos][j];//
			}
		}
	}
	return cast;
}

int main() {
	int vertex_num, edge_num;
	//cout << DISCONNECT << endl;
	while (cin >> vertex_num >> edge_num) {
		vector<vector<int> > adj_arr(vertex_num, vector<int>(vertex_num, DISCONNECT));
		int from, to, weight;
		for (int i = 0; i < edge_num; i++) {
			cin >> from >> to >> weight;
			if (weight < adj_arr[from][to]) {
				adj_arr[from][to] = weight;
				adj_arr[to][from] = weight;
			}
		}
		int start, end;
		cin >> start >> end;
		/*vector<int> temp = Dijkstra(adj_arr, start);
		cout << "temp: ";
		for (int i = 0; i < temp.size(); i++) {
			cout << temp[i] << " ";
		}
		cout << endl;*/
		int min_distance = Dijkstra(adj_arr, start).at(end);
		cout << ((min_distance == DISCONNECT) ? -1 : min_distance) << endl;
	}
	return 0;
}//input:
3 3
0 1 1
0 2 3
1 2 1
0 2
3 1
0 1 1
1 2
//output:
2
-1
```



### Floyd-Warshall

-   In computer science, the **Floyd–Warshall algorithm** is an algorithm for finding shortest paths in a weighted graph with positive or negative edge weights (but with no negative cycles).
-   弗洛伊德算法，解决带权且无负权回路的图的最短路径问题。也用于计算有向图的传递闭包
-   时间复杂度$$O(N^3)$$, 空间复杂度$$O(N^2)$$
-   


```cpp
#include <vector>
#include <algorithm>
using namespace std;
void Floyd(vector<vector<int> > arr) {
	int N = arr.size();
	for (int k = 1; k <= N; k++) {//注意: 跳转节点首先遍历
		for (int i = 1; i <= N; i++) {
			for (int j = 1; j <= N; j++) {
				arr[i][j] = min(arr[i][j], arr[i][k] + arr[k][j]);
			}
		}
	}
}
```



```cpp
// Floyd-Warshall algorithm
#include <iostream>
#define INF 10000000
using namespace std;

const int N = 5;
int arr[N + 2][N + 2];

int main() {
    for(int i = 1; i <= N; i++) {
        for(int j = 1; j <= N; j++)
            arr[i][j] = INF;

        arr[i][i] = 0;
    }

    arr[1][2] = 2;
    arr[1][5] = 6;
    arr[2][5] = 1;
    arr[5][3] = 6;
    arr[2][3] = 5;
    arr[5][1] = 2;
    arr[3][1] = 2;

    for(int k = 1; k <= N; k++)
        for(int i = 1; i <= N; i++)
            for(int j = 1; j <= N; j++)
                arr[i][j] = min(arr[i][j], arr[i][k] + arr[k][j]);

    cout << "Shortest distance matrix\n";

    for(int i = 1; i <= N; i++) {
        for(int j = 1; j <= N; j++)
            if(arr[i][j] == INF)
                cout << "INF\t";
            else
                cout << arr[i][j] << "\t";

        cout << endl;
    }

    return 0;
}
```



### Kruskal

-   It is a greedy algorithm in graph theory as it finds a minimum spanning tree for a connected weighted graph adding increasing cost arcs at each step.
-   克鲁斯卡尔Kruskal算法在图中存在相同权值的边时也有效
-   时间复杂度 $$O(E· log_2E)$$ , $$E$$为图中的边数


```cpp
//pseudocode
MST Kruskal(VertexSet V, EdgeSet E) {
	MST = V + {};//MST is a VertexSet V plus EdgeSet which has no edge
	for(int i=0; i<vertex_num-1; i++) {//加入n-1条边
		new_edge = min(u, v) && (MST + min(u, v)) has no cycle;
		MST += new_edge;
	}
	return MST;
}
```

>   判断边加入后会不会形成环可以考虑用Union-Find Sets

![](http://op4fcrj8y.bkt.clouddn.com/18-1-19/34589853.jpg)

![](http://op4fcrj8y.bkt.clouddn.com/18-1-19/62999062.jpg)




### Prim

-   **Prim's algorithm** is a greedy algorithm that finds a minimum spanning tree for a weighted undirected graph.This means it finds a subset of the edges that forms a tree that includes every vertex, where the total weight of all the edges in the tree is minimized. The algorithm operates by building this tree one vertex at a time, from an arbitrary starting vertex, at each step adding the cheapest possible connection from the tree to another vertex.
-   **普里姆算法**可在加权连通图里搜索最小生成树。意即由此算法搜索到的边子集所构成的树中，不但包括了连通图里的所有顶点，且其所有边的权值之和亦为最小
-   有些场合又称为DJP算法**、**亚尔尼克算法或普里姆－亚尔尼克算法
-   时间复杂度: 邻接矩阵 O(v^2^)  邻接表 O(e log ~2~  v)

描述：

从任一顶点开始，依靠已经加入的点，**用边扩展连接了的点**，直至连接全图的点

1.  input: weighted undirected graph, 顶点集合为V，边集合为E

2.  ini: Vertex_set = {x}，其中x为集合V中的**任一节点**,作起始点,Edge_set = {};

3.  while(Vertex_set != V) {

    1.  在集合E中选取权值最小的边(u, v)，其中u为集合Vertex_set 中的元素，v则是V中没有加入Vertex_set 的顶点(如果存在有多条具有相同权值的边，任选其一)
    2.  Vertex_set += v, Edge_set += (u, v);

    }

4.  output: 使用集合Vertex_set 和Edge_set 来描述所得到的minimum spanning tree





```cpp
#define MAXN 1000
#define INF 1 << 30
#define HAVE -1
int closest[MAXN], lowcost[MAXN], m;//m为节点的个数
int G[MAXN][MAXN];//邻接矩阵

int prim() {
	//ini lowcost
	for (int i = 0; i < m; i++) {
		lowcost[i] = INF;
	}
	//ini closest
	for (int i = 0; i < m; i++) {
		closest[i] = 0;
	}
	closest[0] = HAVE;//加入第一个点
	int num = 0, ans = 0, e = 0;//e为最新加入集合的点
	while (num < m - 1) {//加入m-1条边
		int min_cost = INF, miedge = -1;
		for (int i = 0; i < m; i++)
			if (closest[i] != -1) {
				int temp = G[e][i];
				if (temp < lowcost[i]) {
					lowcost[i] = temp;
					closest[i] = e;
				}
				if (lowcost[i] < min_cost) {
					miedge = i;
					min_cost = lowcost[miedge];
				}
			}
		ans += min_cost;
		e = miedge;
		closest[e] = HAVE;
		num++;
	}
	return ans;
}

int main() {

}
```























---

# 组合问题







---

# 几何问题







---

# 数值问题








### 快速幂



思考步骤：求A的p次方 //求 A^p^

1.  将power转换成二进制数 //11的二进制数是1011

2. 将  A^p^ 改写成 A 的 2^n^的连乘形式 //3^11^ == 3^0^  X  3^2^ X 3^8^ 

   //注意少了3^4^ 因为幂11的表示 2^2^ 的位上权重为0








###### 非递归+位运算

```c++
int pow4(int base_in, int power) {
	int ans = 1, base = base_in;
	while(power) {
//如果power的最低位是1//则ans * base //因为power决定base的2^n次方是否需要乘上 
		if(power&1) ans *= base;
//此处计算base的1次方，2次方，4次方，8次方，16次方，32次方... 
		base *= base;
//指数power右移一位
		power >>= 1;
	}
	return ans;
}
```





### 质数



###### 生成质数表



-   应用：输出第num个质数是什么

```c++
#include <iostream>
#include <cmath>//sqrt

#define MAXLEN 10000

using namespace std;

int main() {
	int iArrPrime[MAXLEN];
	iArrPrime[0] = 2;
	iArrPrime[1] = 3;
	int num = 0;
	cin >> num;//输入想要知道的第几个质数
	if (num == 1) {
		cout << iArrPrime[num - 1] << endl;
		return 0;
	}
	else if (num == 2) {
		cout << iArrPrime[num - 1] << endl;
		return 0;
	}
	for (int i = 2; i < num; i++) {
		int prime = iArrPrime[i - 1] + 2;
		bool flag = true;
		int j = 0;
		while (j < i) {
			if (prime%iArrPrime[j] == 0) {
				prime += 2;
				j = 0;
				continue;
			}
			else if (iArrPrime[j] > sqrt(prime)) {
				iArrPrime[i] = prime;
			}
			j++;
		}
	}
	cout << iArrPrime[num - 1] << endl;
	return 0;
}
```





#其余常见片段





### 约瑟夫环

-   约瑟夫问题 约瑟夫斯置换 Josephus problem

```cpp
/*队列模拟
小明家有N盏吊灯，围成一个圆圈，给这些吊灯按逆时针方向，分别编号为1至N。起初所有吊灯都是都是熄灭的
定了一个数X，并从1号吊灯开始，按逆时针从1至X循环往复地逐个数熄灭的吊灯，并且每次数到X，就将这盏熄灭的灯点亮
直到恰好只剩一盏灯仍然灭着。他将这盏灯的编号S记下来
定了一个数Y，从S号吊灯逆时针方向的相邻吊灯开始，逆时针从1至Y逐个数亮着的吊灯，每次数到Y，将亮着的灯熄灭
这个过程一直进行下去，直到恰好只剩一盏灯仍然亮着。他将这盏灯的编号T记下来
例如，如果有10盏灯，X为2，Y为3，那么第一轮从1号灯开始数，点亮灯的顺序为2,4,6,8,10,3,7,1,9，最后只剩一盏灯是熄灭的，即5号灯；第二轮从6号灯开始数，熄灭灯的顺序8,1,4,9,3,10,7,2，最后只剩一盏灯是亮着的，即6号灯。
现在给出N，X和Y，请你算一算第一轮后灭着的那盏灯的编号S，以及第二轮后亮着的那盏灯的编号T。
Input
本题有多组测试样例 EOF结束。每组样例有 2 行输入：
第一行包含1个整数：N（含义如上描述），第二行包含2个整数：X，Y（含义如上描述）。
0 < N ≤ 100
0 < X, Y ≤ 100
Output S T
*/
int main() {
	int num, x, y;
	//ifstream cin("in.txt");
	while(cin >> num >> x >> y){
		queue<int> light;
		for(int i=0; i<num; i++){
			light.push(i);//1~num
		}
		while(light.size() >= 2){
			for(int i=0; i<x-1; i++){
				int top = light.front();
				light.pop();
				light.push(top);
			}
			light.pop();
		}
		int pos = light.front();
		light.pop();
		cout << pos + 1 << " ";
		for(int i=1; i<num; i++){
			light.push((i+pos)%num);
			//cout << (i+pos)%num;
		}
		while(light.size() >= 2){
			for(int i=0; i<y-1; i++){
				int top = light.front();
				light.pop();
				light.push(top);
			}
			//cout << light.front() << " ";
			light.pop();
		}
		if(light.size()==0){
			cout << 1 << endl;
		}
		else{
			cout << light.front() + 1<< endl;
		}
		
	}
}//input
10
2 3
//output
5 6
```





###### 遍历整数各位



```c++
//取一个整数各位上面的数字
int j=0; int digit[100]={0};
while( num != 0 ){
	digit[j] = num%10;//取余即为取最后一个数字
	j++;
	num=num/10;
}
```



```c++
//求整数各个数位上的0~9各出现了几次
while( num != 0 ){
	digit[num%10]++;//digit[0-9]应先初始化为0//digit[10]={0};
	num = num/10;
}
```


