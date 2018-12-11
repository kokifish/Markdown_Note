[TOC]



---

n.b.  : a Latin phrase meaning "**note well**". 



#### Pearson correlation coefficient

> 皮尔森相关系数, Pearson correlation coefficient, 皮尔森积矩相关系数, Pearson product-moment correlation coefficient 

- 一种线性相关系数，反映两个变量线性相关程度的统计量
- **总体**相关系数 ：

$$
{\displaystyle \rho _{X,Y}={\mathrm {cov} (X,Y) \over \sigma _{X}\sigma _{Y}}={E[(X-\mu _{X})(Y-\mu _{Y})] \over \sigma _{X}\sigma _{Y}}}
$$



**样本相关系数**(样本皮尔逊系数)
$$
{\displaystyle r={\frac {\sum \limits {i=1}^{n}(X{i}-{\overline {X}})(Y{i}-{\overline {Y}})}{{\sqrt {\sum \limits _{i=1}^{n}(X{i}-{\overline {X}})^{2}}}{\sqrt {\sum \limits {i=1}^{n}(Y{i}-{\overline {Y}})^{2}}}}}}\\
{\displaystyle r={\frac {1}{n-1}}\sum \limits _{i=1}^{n}\left({\frac {X_{i}-{\overline {X}}}{\sigma _{X}}}\right)\left({\frac {Y_{i}-{\overline {Y}}}{\sigma _{Y}}}\right)}
$$

$$
{\frac {X{i}-{\overline {X}}}{\sigma _{X}}}\\
{\frac {X{i}-{\overline {X}}}{\sigma _{X}}}\\
\overline {X}  \\
\sigma _{X}
$$
分别是对$$X_{i}$$样本的标准分数、样本平均值和样本标准差 

总体和样本皮尔逊系数的绝对值小于或等于1 

如果样本数据点精确的落在直线上（计算样本皮尔逊系数的情况），或者双变量分布完全在直线上（计算总体皮尔逊系数的情况），则相关系数等于1或-1。

对称性：corr(X,Y) = corr(Y,X) 



**皮尔逊距离**: 度量的是两个变量X和Y，它可以根据皮尔逊系数定义成
$$
d_{X,Y}=1-\rho _{X,Y}
$$
皮尔逊系数落在[-1,1]，而皮尔逊距离落在[0,2]







### Degree



edge degree: $$ suppose k~ij~ is the edge degree of link e~ij~ , then
$$
k_{ij} = \sqrt {k_i\times k_j}
$$







------

#### Clustering coefficient 集聚系数

> clustering: [n.] 聚集，收集；分类归并 
>
> 集聚系数 群聚系数 集群系数。

描述一个图中顶点之间结集成团的程度的系数，一个点的邻接点之间相互连接的程度。

集聚系数：

1. 整体：给出一个图中整体的集聚程度的评估 
2. 局部：测量图中每一个结点附近的集聚程度 

##### Global Clustering Coefficient

> 整体集聚程度
>
> triplet: [n.] 三个一组；三连音符；三元组中的一个；三胞胎之一

A **triplet** is three nodes that are connected by either two (**open triplet**) or three (**closed triplet**) undirected ties.  A triangle graph therefore includes three closed triplets(一个三角形的图有三个闭三点组), one centered on each of the nodes (n.b. this means the three triplets in a triangle come from overlapping(重复的 重叠的) selections of nodes). 

整体集聚系数：一个图中所有闭三点组占所有连通三点组(包括开/闭)的比例。(也有定义为这个值的三倍，使得在完全图中的整体集聚系数等于1)
$$
C={\frac   {\mbox{number of closed triplets}}
{\mbox{number of all triplets (open and closed)}}}\\
C={\frac {3\times {\mbox{number of closed triangles}}}{\mbox{number of all triplets}}}
$$


##### Local Clustering Coefficient

> 局部集聚系数

局部集聚系数C(i)表示与它相连的点抱成团（完全子图）的程度。

局部集聚系数：C(i) : 所有与指定点i相连的顶点之间所连的边的数量，除以这些顶点之间(不含指定点i)可以连出的最大边数。

无向图：若节点$$v_i$$有$$k_i$$个邻居，则最多有$$\frac{k_i(k_i-1)}{2}$$条边(连成全连通图时)。则局部集聚系数定义为：
$$
C_i=\frac{2|\{ e_{jk} : v_j, v_k \in N_i, e_{jk}\in E \}|}{k_i(k_i-1)}
$$
有向图：多有$$k_i(k_i-1)$$条边(连成全连通图时)
$$
C_i=\frac{|\{ e_{jk} : v_j, v_k \in N_i, e_{jk}\in E \}|}{k_i(k_i-1)}
$$
$$C(i)\in [0,1]$$, C(i)越接近1，这个点附近的点越有抱团的趋势 



###### Network average clustering coefficient

> 网络平均集聚系数

As an alternative to the global clustering coefficient, the overall level of clustering in a network is measured by Watts and Strogatz as **the average of the local clustering coefficients of all the vertices n**. 网络平均集聚系数定义为局部集聚程度的等权平均
$$
\bar  {C}={\frac  {1}{n}}\sum_{i=1}^{{n}}C{i}.
$$
It is worth noting that this metric places more weight on the low degree nodes, while the transitivity ratio places more weight on the high degree node. 低度点的权重更大，而transitivity ratio的高度点权重更大

A graph is considered small-world, if the graph has a small mean-shortest path length that scales with the natural log of the number of nodes in the network, log(N). For example, a random graph is small-world, while a lattice is not, and scale-free graphs are often considered ultra-small world, as their mean-shortest path length scales with log (log (N)). 若一个图的平均最短路径长度与点数的关系大致为自然对数log(N)，则称为小世界网络。例如，随即图为小世界的，网格图则不是，通常无度图成为甚小世界，因为其平均最短路径长度约为log (log (N))






#### Degree Distribution

> 度分布

- 当随机地从网络中抽取一个节点时，与这个节点相连的节点数（叫做这个节点的度）d 的概率分布 
- 度分是对一个图（网络）中顶点（节点）度数的总体描述。对于随机图，度分布指的是图中顶点度数的概率分布。 

度分布则是对每个非负整数m，考察度数是m的顶点在所有顶点中占的比例
$$
度映射: d:\,v_{i}\mapsto d(v_{i})\quad i=1,2,\cdots ,n.\\
\forall m\in \mathbb {N} ,\,\,P:m\mapsto P(m)={\frac {\operatorname {Card} {v{i}\,|\,d(v{i})=m}}{n}}\\
\sum _{m\in \mathbb {N} }P(m)=1;(归一性)
$$
从顶点中等概率地随机抽取一个顶点，那么这个顶点度数为k的概率就是P(k)



##### Power-Law Distribution

> 幂律分布

k: the  node degree, $$\lambda$$: the scaling exponent
$$
P(k) \backsim k^{-\lambda}
$$
![](http://op4fcrj8y.bkt.clouddn.com/18-7-25/51029543.jpg)



#### Assortativity

> 网络科学导论 4.2.4

如果总体上度大的顶点倾向于连接度大的顶点，那么就称网络的度正相关的，或者成网络是**同配**的；如果总体上度大的顶点倾向于连接度小的顶点，那么就称网络的度负相关的，或者成网络是**异配**的

Assortative Coefficient: 同配系数

The *assortativity coefficient* is the **Pearson correlation coefficient** of degree between pairs of linked nodes. 





### Betweenness Centrality

> 介数中心性，介数

节点的介数中心性刻画了节点i对于网络中节点对之间沿着最短路径传输信息的控制能力。

节点的介数 Betweenness:
$$
B_l = \sum_{ij}\sigma_{ij}(l)\\
\sigma_{ij}(l) = i到j经过了节点l的最短路径数量
$$






node betweenness centrality: 节点i的centrality:
$$
c_l^{BC} = \sum_{i\neq j \in V} \frac{p_{ij}^l}{p_{ij}}\\
p_{ij}: 节点i到j的最短路径数\\
p_{ij}^l: i到j的最短路径中经过了点l的数量\\
$$
edge betweenness centrality:
$$
c_{e_{kl}}^{BC} =  \sum_{i\neq j \in V} \frac{p_{ij}^{e_{kl}}: }{p_{ij}}\\
p_{ij}^{e_{kl}}: i到j的最短路径中经过了边e_{kl}的数量\\
$$



### Closeness Centrality

> Closeness Centrality, 接近中心性，接近数

$$d_i$$: 该节点到网络中所有节点的距离的平均值，某种程度上反应节点i在网络中的相对重要性。

$$CC_i$$: 节点i的接近中心性，定义为$$d_i$$的倒数。数值越小，节点i越靠近网络边缘，越大，越靠近网络中心
$$
d_i = \frac{1}{N}\sum_{j=1}^Nd_{ij}\\
CC_i =  \frac{1}{d_i} = \frac{N}{\sum_{j=1}^N d_{ij}}
$$










### k-shell

> k-壳分解方法 k-shell decomposition method

将度为1的点去掉(包括与这些点相连的边)，若又出现了度为1的点，则继续去掉，直至图中没有度为1的点为止，这些被去掉的点以及它们之间的边称为1-壳(1-shell)。有时，度为0的孤立点成为0-shell



### Eigenvector Centrality

> 特征向量中心性

一个节点的重要性既取决于邻居节点的数量(degree)也取决于邻居节点的重要性



---

# Random Graph

**ER model**: ER模型是指在给定 *n* 个顶点后，规定每两个顶点之间都有 *p* 的概率连起来$$0\leqslant p\leqslant 1$$，而且这些判定之间两两无关。这样得到的随机图一般记作$$G_{n}^{p}$$或$$ER_{n}(p)$$

**内积模型**: 对每一个顶点指定一个实系数的向量，而两个顶点之间是否连接的概率则是它们的向量的内积的函数。一般来说，可以定义任意两个顶点之间相连的概率，这个概率也被称为**边概率**。定义更广泛的随机图模型的方法是定义所谓的网络概率矩阵。这个矩阵的系数就是边概率，因此详细刻画了随机图的模型 



------

# Small-World Networks

> 小世界网络

大部分节点彼此不相连，但绝大部分节点之间的路径较短。用图论的话描述：小世界网络是一个由大量顶点构成的图，其中任意两点之间的平均路径长度比顶点数量小得多。//万维网、公路交通网、脑神经网络、基因网络都呈现小世界网络的特征

**WS model: **小世界网络最早是由邓肯·瓦茨（Duncan Watts）和斯蒂文·斯特罗加茨（Steven Strogatz）在1998年引进的，将**高集聚系数**和**低平均路径长度**作为特征，提出了一种新的网络模型，一般就称作瓦茨-斯特罗加茨模型（**WS模型**），这也是最典型的小世界网络的模型 





------

# Scale-Free Networks

> 无标度网络

集散分布，大部分的节点只有比较少的连接，而少数节点有大量的连接。由于不存在特征度数，因此得名“无尺度” 。

当节点意外失效或改变时，对网络的影响一般很小，只有很小的概率会发生大的影响，但当有集散节点受到影响时，网络受到的影响会比随机网络大得多。 
$$
P(k)=k^{-\gamma}\\
2\le\gamma \le 3;  (\text{power law})
$$




**BA model**: barabasi albert





### The Onion Structure

The onion structure is a network where nodes with almost the same degree are connected

A “onionlike” topology consist of a core of highly connected nodes hierarchically surrounded by rings of nodes with decreasing degree. In each ring most of the nodes are of the same degree.





