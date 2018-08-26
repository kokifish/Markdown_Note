[TOC]
---

>   https://iksinc.online/tag/continuous-bag-of-words-cbow/ word2vec 举例说明，CBOW，skip-gram简要说明
>
>   https://zhuanlan.zhihu.com/p/26306795 知乎，目测有错
>
>   https://blog.csdn.net/u012654154/article/details/75005921 
>
>   https://blog.csdn.net/Scythe666/article/details/75446570 Deep Learning 台湾的，梗概性，易懂，凝练
>
>   https://www.zhihu.com/question/23765351 softmax特点 作用
>
>   https://blog.csdn.net/supercally/article/details/54234115 同上
>
>   https://juejin.im/entry/5a6af990f265da3e283a3b42 Word2vec改进，发展史？？



###### overfitting & underfitting

>   过拟合与欠拟合

-   过拟合overfitting: 调试一个模型时，使用过多参数，太过受非法数据(噪声)影响，导致过度拟合当前模型，而不能适应更加一般的情况。
-   "the production of an analysis that corresponds too closely or exactly to a particular set of data, and may therefore fail to fit additional data or predict future observations reliably"
-   过拟合有关因素: 参数个数，训练数据集，模型结构

![](http://op4fcrj8y.bkt.clouddn.com/18-6-22/569954.jpg)

>   绿色线曲线(curve): overfitted model; black line: regularized model; 虽然绿色曲线更加适合当前数据集，但是对于未知的数据，绿色线可能有更高的误差。



-   欠拟合underfitting: 与过拟合相反，拟合不足。



##### Activation Function

-   用来加入**非线性因素**以解决线性模型无法 解决的问题

###### threshold

-   threshold function，大于某个值输出1（被激活），小于等于则输出0（没有激活）



###### Sigmoid

$$
f(x)=S(x)={\frac {1}{1+e^{-x}}}={\frac {e^{x}}{e^{x}+1}},\\
f^{'}(x) = f(x)(1-f(x))
$$





##### gradient 梯度

>   梯度 gradient, 斜度; 求导的扩展 //方向导数相关的可以参照数学分析解题指南P272
>
>   对于单变量实指函数，梯度即为导数，故导数可以看作是梯度的特例。

-   是向量，指向标量场**增长最快**的方向(需指定方向的长度)。

$$
梯度的绝对值 = 长度为1的方向中 函数最大的增加率\\
|\nabla f| = \max_{|v|=1}\{\nabla _{v}f\}, \nabla _{v}: 方向导数\\
1.标量函数\varphi的梯度记为: \nabla \varphi 或grad\varphi; \nabla(nabla)表示向量微分算子\\
三维直角坐标中: \nabla \varphi = \begin{pmatrix}
{\frac{\partial \varphi}{\partial x}},  {\frac{\partial \varphi}{\partial y}}, {\frac{\partial \varphi}{\partial z}}
\end{pmatrix}\\
2.以n×1实向量x为变元的实标量函数f(x)相对于x的梯度为n×1列向量\\
\nabla_{\boldsymbol{x}} f(\boldsymbol{x})\overset{\underset{\mathrm{def}}{}}{=} \left[ \frac{\partial f(\boldsymbol{x})}{\partial x_1}, \frac{\partial f(\boldsymbol{x})}{\partial x_2},\cdots,\frac{\partial f(\boldsymbol{x})}{\partial x_n} \right]^T=\frac{\partial f(\boldsymbol{x})}{\partial \boldsymbol{x}}\\
3.以m\times n实矩阵A为输入的，实标量函数 {\displaystyle {\boldsymbol {f}}({\boldsymbol {A}})}相对于A的梯度为m\times n矩阵(梯度矩阵)\\
\nabla_{\boldsymbol{A}} \boldsymbol f(\boldsymbol{A})\overset{\underset{\mathrm{def}}{}}{=}
\begin{bmatrix}
\frac{\partial f(\boldsymbol{A})}{\partial a_{11}} &\frac{\partial f(\boldsymbol{A})}{\partial a_{12}} & \cdots & \frac{\partial f(\boldsymbol{A})}{\partial a_{1n}}      \\
\frac{\partial f(\boldsymbol{A})}{\partial a_{21}} &\frac{\partial f(\boldsymbol{A})}{\partial a_{22}} & \cdots & \frac{\partial f(\boldsymbol{A})}{\partial a_{2n}}      \\
\vdots &\vdots & \ddots & \vdots \\
\frac{\partial f(\boldsymbol{A})}{\partial a_{m1}} &\frac{\partial f(\boldsymbol{A})}{\partial a_{m2}} & \cdots &\frac{\partial f(\boldsymbol{A})}{\partial a_{mn}}     \\
\end{bmatrix}=\frac{\partial \boldsymbol{f}(\boldsymbol{A})}{\partial \boldsymbol{A}}
$$



梯度的demo:
$$
\varphi=2x+3y^2-\sin (z):\\ \nabla \varphi = \begin{pmatrix}
{\frac{\partial \varphi}{\partial x}},  {\frac{\partial \varphi}{\partial y}}, {\frac{\partial \varphi}{\partial z}}\end{pmatrix} 
= \begin{pmatrix} {2},  {6y}, {-\cos (z)} \end{pmatrix}\\
$$


###### Gradient descent

>   梯度下降法 Gradient descent , 最速下降法


-   一阶最优化算法。梯度下降法：要使用梯度下降法找到一个函数的**局部极小值**，必须向函数上当前点的梯度的**反方向**的规定步长距离点进行迭代搜索。梯度上升法：相反地，向梯度正方向进行迭代，会接近函数的局部极大值点。//注意梯度下降法找到的是局部极小值，不可保证为全局最小值


![](http://op4fcrj8y.bkt.clouddn.com/18-6-20/85127746.jpg)

上图蓝色线为$${\displaystyle F(\mathbf {x} )}$$的等高线。如果实值函数$${\displaystyle F(\mathbf {x} )}$$在点$${\displaystyle \mathbf {a} }$$处可微且有定义，那么函数$${\displaystyle F(\mathbf {x} )}$$在$${\displaystyle \mathbf {a} }$$相反的方向 $${\displaystyle -\nabla F(\mathbf {a} )}$$ 下降最快。因而，如果

$${\mathbf  {b}}={\mathbf  {a}}-\gamma \nabla F({\mathbf  {a}})$$

对于$${\displaystyle \gamma >0}$$为一个够小数值时成立($$\gamma \to 0^+$$)，那么$${\displaystyle F(\mathbf {a} )\geq F(\mathbf {b} )}$$

可以从函数$${\displaystyle F}$$的局部极小值的初始估计$${\displaystyle \mathbf {x} _{0}}$$出发，并考虑如下序列 $${\displaystyle \mathbf {x} _{0},\mathbf {x} _{1},\mathbf {x} _{2},\dots }$$使得
$$\mathbf{x}_{n+1}=\mathbf{x}_n-\gamma_n \nabla F(\mathbf{x}_n),\ n \ge 0$$

因此可得到 $$F({\mathbf  {x}}_{0})\geq F({\mathbf  {x}}_{1})\geq F({\mathbf  {x}}_{2})\geq \cdots ,$$

如果顺利，$$\lim_{n \to \infty} x_n = 期望的极值$$。步长$$\gamma$$可变



缺点:

1.  靠近极小值时速度减慢
2.  直线搜索可能会产生一些问题
3.  可能会"Z字型"地下降




###### SGD

>   Stochastic Gradient Descent 随机梯度下降法

-   每次从训练集中随机选择一个样本来进行学习，速度快，可以进行在线更新。
-   优化波动：更新时，可能不会按照正确的方向进行，会产生优化波动(扰动)。优化波动可能会导致原本方向为收敛向局部最优解，变成收敛向全局最优解。同时也会导致迭代次数增多，收敛速率变慢。





#### Heuristic

>   heuristic [adj.]启发式的 探索的 [n.]启发式教育法

-   In computer science, artificial intelligence, and mathematical optimization, a **heuristic** (from Greek εὑρίσκω "I find, discover") is a technique designed for solving a problem more quickly when classic methods are too slow(启发式算法用于解决传统算法太慢的问题), or for finding an approximate(近似的) solution when classic methods fail to find any exact solution(当传统算法无法找到精确解时用于寻找近似解).



元启发式算法(Meta-heuristic algorithms)

-   可以适应很多问题的算法
-   遗传算法、模拟退火算法、粒子群算法、蚁群算法、禁忌搜索

###### genetic algorithm

>   

---


## NN / ANN

>   Artificial Neural Network ANN 人工神经网络，简称神经网络 Neural Network NN,类神经网络

典型神经网络有以下部分：

1.  结构 Architecture: 指定网络中的变量及其拓扑关系。\\e.g. 神经网络中的变量可以是神经元连接的权重(weights)和神经元的激励值(activities of the neurons)
2.  激励函数 Activity Rule: 一般激励函数依赖于网络中的权重（即该网络的参数）
3.  学习规则 Learning Rule: 指定网络中的权重如何随着时间推进而调整。This *learning* process typically amounts to modifying the weights and thresholds of the variables within the network

神经细胞层: 是一群彼此之间互不连接的神经元，它们仅跟其它神经细胞层有连接

---

## NNLM

>   Neural Network Language Model(NNLM) 神经网络语言模型



###### 全连接前馈神经网络模型demo

输入：256个像素点；输出：数字是[1, 10]的概率分布

![](http://op4fcrj8y.bkt.clouddn.com/18-6-19/64226892.jpg)

-   给定(图片，目标输出)数据对集合作为训练用的数据(例如图中的图片对应1)，在下图的特例中，深度学习的目标是找到一个函数使得输出的概率分布Q和期望的真实的概率分布P的相对熵$$H(P,Q)$$最小。整体目标是找到一个函数，使得全局损失(Total Loss)最小$$L = \sum _{r=1}^Rl_r$$。而找到这样一个最佳函数后，就会获得神经网络的对应的参数$$\theta$$(使得全局损失$$L$$最小)

![](http://op4fcrj8y.bkt.clouddn.com/18-6-19/1141211.jpg)







## RNNLM



## Bag-of-Words



## CBOW

>   https://blog.csdn.net/mytestmy/article/details/26969149 算法 

![](http://op4fcrj8y.bkt.clouddn.com/18-6-21/38143827.jpg)



