





[TOC]





- vertex vertices 节点
- traverse 遍历




在计算机科学中，**抽象化**（Abstraction）是将数据与程序，以它的语义来呈现出它的外观，但是隐藏起它的实现细节。抽象化是用来减少程序的复杂度，使得程序员可以专注在处理少数重要的部分。一个电脑系统可以分区成几个抽象层（Abstraction layer），使得程序员可以将它们分开处理

抽象与抽象层

抽象就是把一个问题或模型，以不同规则或方法所得出的不同的解（求解方法和解本身即**抽象层**），这些不同的解可以组合并还原成问题或模型的本身。

抽象的意义是可以忽略不是求解过程中必需的**解**。例如要用计算机程序去模拟“人”，在描述了人的动作（饮食、思考、移动等）匹配设计要求后（如可完整表达“人”在坐下时候的动作），其他“人”的细节（躯干、器官、细胞活动乃至人际关系）都可以忽略，以集中设计需要的功能，并减低程序的复杂度

为了使抽象的成品（算法）不会出现问题，要注意抽象时是否漏掉重要特征





---

# Data structure 数据结构

>   In computer science, a **data structure** is a particular way of organizing data in a computer so that it can be used efficiently.

### 常见的数据结构

-   [数组](https://zh.wikipedia.org/wiki/%E9%99%A3%E5%88%97)（Array）
-   [堆栈](https://zh.wikipedia.org/wiki/%E5%A0%86%E7%96%8A)（Stack）
-   [队列](https://zh.wikipedia.org/wiki/%E9%9A%8A%E5%88%97)（Queue）
-   [链表](https://zh.wikipedia.org/wiki/%E9%93%BE%E8%A1%A8)（Linked List）
-   [树](https://zh.wikipedia.org/wiki/%E6%A0%91_(%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84))（Tree）
-   [图](https://zh.wikipedia.org/wiki/%E5%9B%BE)（Graph）
-   [堆](https://zh.wikipedia.org/wiki/%E5%A0%86_(%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84))（Heap）
-   [散列表](https://zh.wikipedia.org/wiki/%E6%95%A3%E5%88%97%E8%A1%A8)（Hash）






-   遍历: 按一定顺序访问完一个数据结构中的所有元素

---

# Stack 栈

推入(push) 弹出(pop)

LIFO, Last In First Out



###### 硬件堆栈

- 架构层次上的堆栈通常被用以申请和访问内存
- 大多数CPU都有用作堆栈指针的寄存器


### 逆波兰表达式





---

# Queue 队列

-   队列是只允许在表的前端(front)进行删除操作，而在表的后端(rear)进行插入操作的线性表。队列的修改按照先进先出(First In First Out, FIFO)的原则进行，是操作受限的线性表
-   按照存储表示方法，可将队列分为顺序队列和链式队列
-   队列支持的基本操作包括：入队，出队、访问队首元素、访问队尾元素、判断队列空、访问队列中的元素个数





---

# Linked List 链表

-   一种线性表，但不会按线性的顺序存储数据，而是在每一个节点里存到下一个节点的指针
-   不必须按顺序存储，链表在插入的时候可以达到O(1)的复杂度，但查找一个节点或者访问特定编号的节点则需要O(n)的时间
-   链表通常由一连串节点组成，每个节点包含任意的实例数据(data fields)和一或两个用来指向上一个/或下一个节点的位置的链接("links")
-   单向链表，双向链表，循环链表



### 单向链表

-   又称单链表
-   包含两个域，信息域和指针域。链接指向列表中的下一个节点，最后一个节点指向NULL



### 双向链表

-   每个节点有两个连接：一个指向前一个节点，而另一个指向下一个节点。(首尾指向NULL)



### 循环链表

-   循环链表中第一个节点之前就是最后一个节点，反之亦然







































---

# Tree 树

-   In computer science, a **tree** is a widely used abstract data type (ADT)(抽象数据类型)—or data structure implementing this ADT—that simulates(模拟) a hierarchical(分级) tree structure, with a root value and subtrees of children with a parent node, represented as a set of linked nodes.(一组链接节点)

### binary tree 二叉树






- 根结点 Root

  在第一节点层的结点 (唯一)The top node in a tree.

- 树的结点

  包含一个数据元素及若干指向子树的分支

- 祖先结点 Ancestor

  从根到该结点的所经分支上的所有结点A node reachable by repeated proceeding from child to parent.

- 子孙节点 Descendant

  以某结点为根的子树中任一结点都称为该结点的子孙节点. A node reachable by repeated proceeding from parent to child.

- 结点层

  根结点的层定义为1；根的孩子为第二层结点，依此类推. 

- 树的深度

  树中最大的结点层

- 结点的度 Degree

  结点子树的个数 The number of sub trees of a node.

- Depth

  The depth of a node is the number of edges from the tree's root node to the node.

- 树的度

  树中最大的结点度

- 叶子结点 Leaf (less commonly called External node) A node with no children.也叫终端结点，是度为 0 的结点

- 分枝结点Branch (Internal node)

  A node with at least one child. 度不为0的结点

- 满二叉树

  深度为k，且有2^k-1个节点称之为满二叉树

- Edge

  连接两个节点 The connection between one node and another.




1.根二叉树(Rooted Binary Tree)：
​    有一个根结点，每个结点至多有两个孩子。
2.满二叉树(Full Binary Tree)：
​    要么是叶子结点(结点的度为0)，要么结点同时具有左右子树(结点的度为2)。
3.完全二叉树(Complete Binary Tree)：
​    每层结点都完全填满，在最后一层上如果不是满的，则只缺少右边的若干结点。
4.完美二叉树(Perfect Binary Tree)
​    所有的非叶子结点都有两个孩子，所有的叶子结点都在同一层。即每层结点都完全填满。
5.无限完全二叉树(Infinite Complete Binary Tree)：
​    每个结点都有两个孩子，结点的层数是无限的。
6.平衡二叉树(Balanced Binary Tree)：
​    也称为AVL树，它是一棵空树或它的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉树



系统地访问有序根树每个顶点的过程成为遍历算法。



###### 先序遍历 preorder

> 先序 中序 后序是在左右子树访问的相对顺序不变的前提下(先左后右)，按中间的(根)节点的访问顺序来划分的

对一棵二叉树的前序遍历，先访问根结点，再访问左子树，然后访问右子树。NLR

>   N(Node)、L(Left subtree)、R(Right subtree)	为根、根的左子树和根的右子树

```c++
void preorder(Treenode *p) {//snippet//前序遍历 PreorderTraversal 先根遍历
	if (p != NULL){
		visit(p);//visit泛指要对节点进行的操作
		preorder(p->left);
		preorder(p->right);
	}
}
```

```cpp
template <class Entry>//snippet
void preorder(Node<Entry> *root, void (*Visit)(Entry &)){
    if(root){
        visit(root->entry);
        preorder(root->left, Visit);
        preorder(root->right, Visit);
    }
}
```



###### 中序遍历 inorder

对一棵二叉树的中序遍历，先访问左子树，再访问根结点，然后访问右子树。LNR
```c++
void inorder(Treenode *p) {//snippet//InorderTraversal
    if (p != NULL){
        inorder(p->left);
        visit(p);//visit泛指要对节点进行的操作
        inorder(p->right);
    }
}
```





###### 后序遍历 postorder

对一棵二叉树的后序遍历，先访问左子树，再访问右子树，然后访问根结点。LRN
```c++
void postorder(Treenode *p) {//snippet//PostorderTraversal  
    if (p != NULL){
        postorder(p->left);
        postorder(p->right);
        visit(p);//visit泛指要对节点进行的操作
    }//这种后序遍历的方法可以在二叉树析构时对各个节点delete
}
```



###### 层遍历 levelorder

>   从上至下按层次遍历二叉树



```cpp
#include <iostream>//snippet: warning: no delete, memory trash
#include <queue> 

using namespace std;

template <class Entry>
class TreeNode {
public:
	TreeNode(Entry entry) : entry(entry), left(nullptr), right(nullptr) {}
	Entry entry;
	TreeNode *left, *right;
};

//void(*Visit)(Entry &) call back function
template <class Entry>
void Visit(Entry & entry) {
	cout << entry << " ";
}

//二叉树层遍历 pre: root, call back function: void(*func_ptr)(Entry &)
template <class Entry>
void LevelOrder(TreeNode<Entry> *root, void(*Visit)(Entry &)) {
	if (root == nullptr) {
		return;
	}
	queue<TreeNode<Entry>*> q_node;
	q_node.push(root);
	//记录原来那一层的 node 个数
	int ori_size = q_node.size();
	//while循环每次 refresh 层节点的数量，层节点个数为零跳出
	while (ori_size = q_node.size(), ori_size != 0) {
		//从左到右依次将 child node 入队，遍历整层
		for (int i = 0; i < ori_size; i++) {
			//将即将出队的节点的两个孩子入队(仅在有孩子的时候) 
			if (q_node.front()->left) {//push left child
				q_node.push(q_node.front()->left);
			}
			if (q_node.front()->right) {//push right child
				q_node.push(q_node.front()->right);
			}
			//call back function
			Visit(q_node.front()->entry);
			q_node.pop();
		}
		cout << endl;
	}
}

//get height: 获取二叉树的高度//post: return (int)height;
template <class Entry>
int getHeight(TreeNode<Entry>* root) {
	if (root == NULL) {
		return 0;
	}
	int l_height = getHeight(root->left);
	int r_height = getHeight(root->right);
	return (l_height > r_height) ? (l_height + 1) : (r_height + 1);
}

//普通二叉搜索树BST的insert
template <class Entry>
void Insert(TreeNode<Entry> *& root, const Entry & entry) {
	if (root == nullptr) {
		root = new TreeNode<Entry>(entry);
		return;
	}
	if (entry < root->entry) {
		Insert(root->left, entry);
	}
	else if (entry > root->entry) {
		Insert(root->right, entry);
	}
}

int main() {
	TreeNode<float>* root = nullptr;
	Insert(root, (float)1.0);//!!!Q:不加强制类型转换报错//未找到匹配的重载函数 模板参数Entry不明确，未能从 double 为 const Entry & 推导模板参数
	Insert(root, (float)0.0);
	Insert(root, (float)4.0);
	Insert(root, (float)3.0);
	Insert(root, (float)2.0);
	Insert(root, (float)5.0);
	LevelOrder(root, Visit);
	cout << "height: " << getHeight(root) << endl;
	system("PAUSE");
}//output:
1
0 4
3 5
2
height: 4
```

>   





###### 高度

>   获取二叉树高度的函数模板在层遍历的代码中已给出



### 满二叉树 Full Binary Tree

-   除最后一层无任何子节点外，每一层上的所有结点都有两个子结点二叉树





### 完全二叉树 Complete Binary Tree

-   底层连续集中在左边，其余层满节点
-   叶节点只能出现在最下层和次下层，并且最下面一层的结点都集中在该层最左边的若干位置的二叉树
-   完全二叉树是效率很高的数据结构，堆是一种完全二叉树或者近似完全二叉树，所以效率极高，像十分常用的排序算法、Dijkstra算法、Prim算法等都要用堆才能优化，几乎每次都要考到的二叉排序树的效率也要借助平衡性来提高，而平衡性基于完全二叉树





### 二叉查找树 binary search tree



>   二叉查找树(Binary Search Tree)，又被称为二叉搜索树

1.  若任意节点的左子树不空，则左子树上所有结点的值均小于它的根结点的值
2.  任意节点的右子树不空，则右子树上所有结点的值均大于它的根结点的值
3.  任意节点的左、右子树也分别为二叉查找树
4.  没有键值相等的节点(no duplicate nodes)




### AVL tree

> AVL树 高度平衡树

- 在计算机科学中，**AVL树**是最先发明的**自平衡二叉查找树**
- 在AVL树中任何节点的两个子树的高度最大差别为1，所以它也被称为**高度平衡树**
- 查找、插入和删除在平均和最坏情况下的时间复杂度都是 O(log n)
- 增加和删除可能需要通过一次或多次**树旋转**来重新平衡这个树
- 节点的**平衡因子**是它的左子树的高度减去它的右子树的高度（有时相反）
- 带有平衡因子1、0或 -1的节点被认为是平衡的。带有平衡因子 -2或2的节点被认为是不平衡的，并需要重新平衡这个树




```cpp
#include <iostream>

using namespace std;

template <class Entry>
struct AvlNode {
	AvlNode(Entry entry, AvlNode<Entry>* left = nullptr, AvlNode<Entry> *right = nullptr, int bf = 0)
		:entry(entry), left(nullptr), right(nullptr), bf(bf) {	}
	Entry entry;
	AvlNode<Entry> *left;
	AvlNode<Entry> *right;
	int bf;// balance factor 平衡因子
};

//get height: 获取二叉树高度
template <class Entry>
int getHeight(const AvlNode<Entry>* root) {
	if (root == nullptr) {
		return 0;
	}
	int l_height = getHeight(root->left);
	int r_height = getHeight(root->right);
	return (l_height > r_height) ? (l_height + 1) : (r_height + 1);
}

//get balance factor, post: return balance factor
template <class Entry>
int getBf(const AvlNode<Entry>* root) {
	return getHeight(root->left) - getHeight(root->right);
}


//left rotation: RR情况 单左旋 //pass by reference
template <class Entry>
void LeftRotation(AvlNode<Entry>*& root) {
	if (root == nullptr || root->right == nullptr) {
		return;
	}
	AvlNode<Entry>* right_tree = root->right;
	root->right = right_tree->left;
	right_tree->left = root;
	root = right_tree;
}

//right rotation: LL情况 单右旋 //pass by reference
template <class Entry>
void RightRotation(AvlNode<Entry>*& root) {
	if (root == nullptr || root->left == nullptr) {
		return;
	}
	AvlNode<Entry>* left_tree = root->left;
	root->left = left_tree->right;
	left_tree->right = root;
	root = left_tree;
}

//left & right rotation: LR情况，左旋后右旋//pass by reference
template <class Entry>
void LeftRightRotation(AvlNode<Entry>*& root) {
	if (root == nullptr || root->left == nullptr || root->left->right == nullptr) {
		return;
	}
	LeftRotation(root->left);//left rotation //next level
	RightRotation(root);//right rotation//current level
}

//right & left rotation: RL情况，右旋后左旋//pass by reference
template <class Entry>
void RightLeftRotation(AvlNode<Entry>*& root) {
	if (root == nullptr || root->right == nullptr || root->right->left == nullptr) {
		return;
	}
	RightRotation(root->right);//right rotation //next level
	LeftRotation(root);//left rotation//current level
}



//AVL insert: 将entry插入到AVL树//root pass by reference
template <class Entry>
void AVL_insert(AvlNode<Entry> *& root, const Entry entry) {
	if (root == nullptr) {//空树情况 
		root = new AvlNode<Entry>(entry);
		return;
	}
	//insert in left tree
	if (entry < root->entry) {
		AVL_insert(root->left, entry);
		root->bf = getBf(root);
		if (root->bf == 2) {
			if (entry < root->left->entry) {//LL
				RightRotation(root);
			}
			else {//LR
				LeftRightRotation(root);
			}
		}
	}
	//insert in right tree
	else if (entry > root->entry) {
		AVL_insert(root->right, entry);
		root->bf = getBf(root);
		if (root->bf == -2) {
			if (entry > root->right->entry) {//RR
				LeftRotation(root);
			}
			else {//RL
				RightLeftRotation(root);
			}
		}
	}
}

//AVL search: 查找AVL树里面是否有元素entry，有则返回该结点指针，没有则nullptr
template <class Entry>
AvlNode<Entry>* AVL_Search(AvlNode<Entry> *& root, const Entry entry) {
	if (root == nullptr) {
		return nullptr;
	}
	root->bf = getBf(root);
	AvlNode<Entry>* loop_ptr = root;
	while (loop_ptr) {
		if (loop_ptr->entry < entry) {
			loop_ptr = loop_ptr->right;
		}
		else if (loop_ptr->entry > entry) {
			loop_ptr = loop_ptr->left;
		}
		else {//loop_ptr->entry == entry
			loop_ptr->bf = getBf(loop_ptr);
			return loop_ptr;
		}
	}
	return nullptr;
}

int main() {
	AvlNode<int>* root = nullptr;
	AVL_insert(root, 0);
	AVL_insert(root, -1);
	AVL_insert(root, -2);//after insert -2, LL cause RightRotation
	cout << root->entry << endl;
	cout << AVL_Search(root, -1)->bf << endl;
	system("PAUSE");
}//output:
-1
0
```



### B tree

-   自平衡的树 多路搜索树

子树的键值要完全小于或大于或介于父节点之间的键值

关键字集合分布在整棵树中

任何一个关键字出现且只出现在一个结点中

搜索有可能在非叶子结点结束

其搜索性能等价于在关键字全集内做一次二分查找

自动层次控制



### B+ tree

-   对于B+树，其结点结构与B-tree相同，不同的是各结点的关键字和可以拥有的子结点数。如m阶B+树中，每个结点至多可以拥有m个子结点。非根结点至少有[m/2]个子结点，而关键字个数比B-tree多一个，为[m/2]~m



-   B树中同一键值不会出现多次，并且它有可能出现在叶结点，也有可能出现在[非叶](https://baike.baidu.com/item/%E9%9D%9E%E5%8F%B6)结点中。而B+树的键一定会出现在叶结点中，并且有可能在非叶结点中也有可能重复出现，以维持B+树的平衡
-   因为B树键位置不定，且在整个树结构中只出现一次，虽然可以节省存储空间，但使得在插入、删除操作复杂度明显增加。B+树相比来说是一种较好的折中。
-   B树的查询效率与键在树中的位置有关，最大时间复杂度与B+树相同(在叶结点的时候)，最小时间复杂度为1(在根结点的时候)。而B+树的时间复杂度对某建成的树是固定的






### RB tree 红黑树

- 一种自平衡二叉查找树self-balancing binary search tree
- 可以在O(log n)时间内做查找，插入和删除，(n是树中元素的数目)




![](http://op4fcrj8y.bkt.clouddn.com/18-1-19/25735278.jpg)



1.  每个节点不是红色就是黑色

2.  根节点为黑色

3.  如果节点为红，其子节点必须为黑，如果节点为黑，则随意

4.  任一节点到树尾端的任何路径(比如从根节点到任意一个叶节点),所含的黑节点数量相同

- 根据规则４，新增节点必须为红色
- 根据规则３，新增节点的父节点必须为黑
- 当新节点根据一般二叉树搜索规则到达其插入点，却未能符合上述条件时，就必须调整节点颜色和旋转树形。注意经过调整后，叶节点可能为黑色

---

# Graph 图

-   无向图G的**极大连通子图**称为G的**连通分量**( Connected Component)。任何连通图的连通分量只有一个，即是其自身(因为不存在另一个连通的子图包含的点和边比它本身还要多)
-   非连通的无向图有多个连通分量(拆分为若干个连通的无向图,注意把能连通的点边都放在一个连通子图中)
-   只有连通图(即只有一个连通分量)才有**极小连通子图**概念，极小连通图包含图中所有顶点，和比顶点数少一的边，不成环

---

# Heap 堆





-   堆通常是一个可以被看做一棵树的数组对象

-   堆的实现通过构造**二叉堆**（binary heap），实为二叉树的一种；由于其应用的普遍性，当不加限定时，均指该数据结构的这种实现。这种数据结构具有以下性质。

    -   任意节点小于（或大于）它的所有后裔，最小元（或最大元）在堆的根上（**堆序性**）。
    -   堆总是一棵完全树。即除了最底层，其他层的节点都被元素填满，且最底层尽可能地从左到右填入。

    将根节点最大的堆叫做**最大堆**或**大根堆**，根节点最小的堆叫做**最小堆**或**小根堆**。常见的堆有二叉堆、斐波那契堆等

















---

# Hash 离散表







