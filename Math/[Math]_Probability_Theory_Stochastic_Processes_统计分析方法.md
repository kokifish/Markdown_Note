[TOC]



https://en.wikipedia.org/wiki/Markov_chain#Reducibility wiki







---

## 矩母函数

> moment-generating function，矩生成函数，动差生成函数。动差又称为矩

定义：称$$e^{tX}$$的数学期望$$M_X(t) = \varphi(t) = E[e^{tX}]$$为$$X$$的矩母函数
$$
M_{X}(t)=\int _{{-\infty }}^{\infty }e^{{tx}}f(x)\,{\mathrm  {d}}x\\
=\int _{{-\infty }}^{\infty }\left(1+tx+{\frac  {t{2}x{2}}{2!}}+\cdots \right)f(x)\,{\mathrm  {d}}x\\
=1+tm_{1}+{\frac {t^{2}m_{2}}{2!}}+\cdots
$$
其中 $$ m_{i} $$是第*i*个矩。$$ M_{X}(-t)$$是*f*(*x*)的双边拉普拉斯变换 

求原点矩：对矩母函数逐次求导并计算在t=0点的值：(一阶导为一阶原点矩)

$$\operatorname {E}\left(X^{n}\right)=M_{X}^{{(n)}}(0)=\left.{\frac  {{\mathrm  {d}}^{n}M_{X}(t)}{{\mathrm  {d}}t^{n}}}\right|_{{t=0}}$$

和的矩母函数：n个相互独立的随机变量之和的矩母函数等于它们的矩母函数之积

设相互独立的随机变量$$X_1, X_2,..., X_r$$的矩母函数分别为$$\varphi_1(t), \varphi_2(t), ..., \varphi_r(t)$$,则其和$$Y = X_1+ X_2+...+ X_r$$的矩母函数为 $$\varphi_Y(t) =\varphi_1(t) \varphi_2(t) ... \varphi_r(t)$$

---

# 概率论



---

## 随机变量及其分布



#### 泊松分布



#### 指数分布

> 负指数分布

若连续型随机变量X的概率密度为
$$
f(x) = \left\{{\begin{matrix}
\lambda e^{-\lambda x} , x > 0, \\
0,其他,
\end{matrix}}\right.
$$
其中$$\lambda$$> 0为常数，则称X服从参数为$$\lambda$$的**指数分布**,$$\frac{1}{\theta} = \lambda$$为率参数，每单位时间内发生某事件的次数的均值。

服从指数分布的随机变量X的分布函数为
$$
F(x) = \left\{{\begin{matrix}
1 - e^{-\lambda x} , x > 0, \\
0,其他,
\end{matrix}}\right.
$$

- 期望：$$\theta = \frac{1}{\lambda}$$
- 方差：$$\theta ^2$$
- 

---

## 多维随机变量及其分布



---

## 随机变量的数字特征



---

## 样本及抽样分布



###### 抽样分布



###### 样本k阶(原点)矩/中心矩

- 样本平均值：$$\bar X = \frac{1}{n} \sum_{i=1}^{n}X_i$$, (等权加权求和)
- 样本方差：
- 样本标准差：
- 样本k阶(原点)矩：$$A_k = \frac{1}{n} \sum_{i=1}^{n}X_i^k,k=1,2,...; n\rightarrow\infin时, =E(X^k)$$
- 样本k阶中心矩：$$B_k = \frac{1}{n} \sum_{i=1}^{n}(X_i-\bar X)^k,k=2,3,...; $$





---

## 参数估计



---

# 随机过程

自然界变化的过程可以分为确知过程和随机过程两大类

1. 确知过程: 每次观测所得结果都相同，都是时间t的一个确定的函数，具有确定的变化规律
2. 随机过程: 每次观测所得结果都不同，都是时间t的不同函数，观测前又不能预知观测结果，没有确定的变化规律

随机过程 Stochastic Process 定义: 

定义一(随机过程是样本函数的集合): 设随机试验E的样本空间为 S = {e}，对其每一个元素 e~i~ (i = 1, 2, …) 都以某种法则确定一个样本函数 x(t, e~i~) 由全部元素{e}所确定的一族样本函数 X(t, e) 称为随机过程,简记为 X(t)

定义二(随机过程是随机变量的集合): 设有一个过程 X(t)，若对于每一个固定的时刻t~j~ (j = 1, 2, …)，X(t~j~)是一个随机变量，则 X(t) 称为随机过程

> 当t固定，e固定时， X(t) 是一个确定值；
>
> 当t固定，e可变时， X(t) 是一个随机变量； 
>
> 当t可变，e固定时， X(t) 是一个确定的时间函数； 
>
> 当t可变，e可变时， X(t) 是一个随机过程； 

一维概率分布: 

- 连续随机过程:

  概率**分布函数**: $$F_X(x, t) = P\{X(t)\le x\}$$

  概率**密度函数**: $$f_X(x, t) = \frac{\partial F_X(x, t)}{\partial x}$$, (X的概率分布函数对x求偏导即为X的概率密度函数)

- (离散)随机序列:

  概率**分布函数**: $$F_X(x, n) = P\{X(n)\le x\}$$

  概率**密度函数**: $$f_X(x, n) = \frac{\partial F_X(x, n)}{\partial x}$$


## 随机过程的数字特征

连续随机过程：
- 均值 mean：$$\mu_X(t) = m_X(t) = E\{X(t)\} = \int^{+\infin}_{-\infin} x f_X(x, t)dx$$
- 方差： $$D[X(t) ] = \delta^2_X(t) = E\{[X(t) - m_X(t)]^2\} =  E[X^2(t)] - E^2[X(t)] =  E[X^2(t)] - m^2_X(t) $$
- $$E[X^2(t)] = \delta^2_X(t) + m^2_X(t)$$
- **自相关函数 auto-correlation function**: $$R_X(t_1, t_2) = E\{X(t_1)X(t_2)\} = \int^{+\infin}_{-\infin}\int^{+\infin}_{-\infin}x_1 x_2 f_X(x_1,x_2, t_1,t_2)dx_1dx_2$$
- **(自)协方差**($$t_1=t_2=t$$ 时为方差) **auto-covariance function**：$$cov(X(t_1), X(t_2)) = K_X(t_1, t_2) = \gamma_X(t_1, t_2) $$,$$= E\{[X(t_1) - m_X(t_1)][X(t_2) - m_X(t_2)]\} = R_X(t_1, t_2) - \mu_X(t_1)\mu_X(t_2) $$
- $$\gamma_X(t_1, t_2) = R_X(t_1, t_2) - \mu_X(t_1)\mu_X(t_2)$$
- 互协方差函数：$$\gamma_{XY}(t_1, t_2) = K_{XY}(t_1, t_2) = E\{[X(t_1) - m_X(t_1)][Y(t_2) - m_Y(t_2)]\} $$
- 互相关函数：$$ R_{XY}(t_1, t_2) = E\{X(t_1)Y(t_2)\}$$
- $$\gamma_{XY}(t_1, t_2) = R_{XY}(t_1, t_2) - \mu_X(t_1)\mu_Y(t_2)$$


若 $$R_X(t_1, t_2) = 0$$，则称$$X(t_1)$$和$$X(t_2)$$是相互正交的

若$$K_X(t_1, t_2) = 0​$$，称$$X(t_1)​$$和$$X(t_2)​$$是不相关的

若$$f_X(x_1,x_2, t_1,t_2) =  f_X(x_1,t_1)f_X(x_2,t_2)$$, 则称随机过程在$$t_1$$, $$t_2$$时刻的状态是相互独立的



离散随机过程：
- 均值:$$m_X(t) = \mu_X(t) = E\{X(t)\} = \sum_i^Nx_i(t)p_i(t)$$
- 方差:$$ D[X(t) ] = \delta^2_X(t) = E\{[X(t) - m_X(t)]^2\} =  \sum_i^N[x_i(t) - m_X(t)]^2p_i(t) =E[X^2(t)] = \delta^2_X(t) + m^2_X(t)$$
- 自相关函数 autocorrelation function:$$R_X(t_1, t_2) = E\{X(t_1)X(t_2)\} = \sum_i^N \sum_j^N x_i(t_1)x_j(t_2)p_{ij}(t_1, t_2)$$
- 协方差:$$K_X(t_1, t_2) = E\{[X(t_1) - m_X(t_1)][X(t_2) - m_X(t_2)]\}$$,$$= \sum_i^N \sum_j^N [x_i(t_1) - m_X(t_1)][x_j(t_2) - m_X(t_2)]p_{ij}(t_1, t_2) $$



---

## 平稳过程



#### 严平稳过程

> 严平稳过程的有限维分布关于时间是平移不变的



#### 宽平稳过程

> 简称平稳过程

设随机过程{$$X(t), t\in T$$}，如果$$X(t)$$满足：

1. $$X(t)$$是二阶矩过程
2. 均值函数为常熟，即$$\mu_X(t) = E[X(t)] = \mu$$
3. 协方差函数$$\gamma_X(t_1, t_2)$$仅依赖时间差$$\tau = t_1 - t_2$$，即$$\gamma_X(t_1, t_2) =  E\{[X(t_1) - m_X(t_1)][X(t_2) - m_X(t_2)]\} = E[X(t_1)X(t_2)] - \mu^2 = \gamma(\tau)$$

则称X(t)为宽平稳过程，简称平稳过程

> 第三点等价描述：自相关函数$$R_X(t_1, t_2)$$仅与时间差$$\tau = t_1 - t_2$$有关. 即$$R_X(t_1, t_2) = E\{X(t_1)X(t_2)\}  = R_{XX} (\tau)$$

自相关函数的最大值：$$|R_{XX} (\tau)| \le R_{XX} (0)$$, 即自相关函数$$R_{XX} (\tau)$$在$$\tau$$=0时取得最大值

自相关函数的偶函数性：$$R_{XX} (\tau) = R_{XX} (-\tau)$$

协方差函数最大值：$$|\gamma(\tau)| \le \gamma(0)$$, 即协方差函数在$$\gamma(\tau)$$在$$\tau$$=0时取得最大值

协方差函数的偶函数性：$$\gamma(\tau)= \gamma(-\tau)$$



---

# Markov过程

> 参数可以离散或连续，状态也可以离散或连续



---

## 马尔可夫链

> 马尔可夫过程通常分为三类：
>
> 1. 马尔可夫链：时间、状态都是离散的马尔科夫过程
> 2. 连续时间马尔可夫链：时间连续，状态离散
> 3. 马尔科夫过程：时间、状态都是连续的

-   **马尔可夫链**(Markov chain), 又称**离散时间马尔可夫链** (discrete-time Markov chain, **DTMC**)
-   为状态空间中经过从一个状态到另一个状态的转换的随机过程







##### 马尔可夫性 无记忆性

> 马尔可夫性即无后效性

马尔可夫性：下一状态的概率分布只能由当前状态决定，在时间序列中它前面的事件均与之无关



###### C-K方程



#### Time-Homogeneous Markov Chain

>   时齐马尔可夫链

-   时齐性：转移概率与时间无关: $$P\{X_n = i_n |X_0=i_0, ..., X_{n-1}=i_{n-1} \} = p(i_{n-1}, i_n)$$; 公式表明，任何时刻，从$$i_{n-1}$$转移到$$i_n$$的概率相等。





###### 可达 互通 可约

-   **可达**的 accessible: A state $$j$$ is said to be **accessible** from a state $$i$$ (written $$i\rightarrow j$$) if a system started in state $$i$$ has a non-zero probability of transitioning into state $$j$$ at some point. Formally, state $$j$$ is accessible from state $$i$$ if there exists an integer $$n_{ij} \ge 0$$ such that

$$\exists n_{ij} \ge0,  {\displaystyle \Pr(X_{n_{ij}}=j\mid X_{0}=i)=p_{ij}^{(n_{ij})}>0.} \Longleftrightarrow i\rightarrow j, i到j可达$$

-   **互通**的 communicate: A state $$i$$ is said to **communicate** with state $$j$$ (written $$i \leftrightarrow j$$ if both $$i \rightarrow j$$ and $$j \rightarrow i$$.(双向可达则为互通)
-   **互通类** communicating class: A **communicating class** is a maximal set of states *C* such that every pair of states in *C* communicates with each other(每对状态都是互通的 最大的状态集合). Communication is an equivalence relation(等价关系), and communicating classes are the equivalence classes of this relation.
-   A communicating class is **closed** if the probability of leaving the class is zero, namely if *i* is in *C* but $$j$$ is not, then $$j$$ is not accessible from $$i$$. The set of communicating classes forms a **directed, acyclic** graph by inheriting the arrows from the original state space. A communicating class is closed if and only if it has no outgoing arrows in this graph.
-   A state $$i$$ is said to be **essential** or **final** if for all $$j$$ such that $$i$$ → $$j$$ it is also true that $$j→ i$$. A state $$i$$ is **inessential** if it is not essential. A state is **final** if and only if its communicating class is closed.
-   **不可约**的 irreducible: A Markov chain is said to be **irreducible** if its state space is a single communicating class; in other words, if it is possible to get to any state from any state.(马尔可夫链不可约 = **只有一个互通类**; 亦即任何状态到任何状态都是可达的，亦即任意两个状态都是互通的)

可达和互通关系都具有传递性。



###### 周期性

-   状态i的周期$$d=G.C.D\{n: p^{(n)}_{ii}>0\}$$    (D.C.D 最大公约数 greatest common divisor)如果d>1，就称状态i为周期的，d为周期，如果d=1，就称i为非周期的



###### 首达概率&常返性

> 一个状态i，可以是常返或非常返，常返分为正常返和零常返

- **首达时间**：首次返回i的时间$$T = \min\{n>0; X_n =i\}$$.
- **首达概率**：由i除法经n步首次到达j的概率：({$$f_{ij}^{(n)}, n\ge 1$$}构成一概率分布)

$$f_{ij}^{(n)} = P\{X_{m+v}\neq j,1\le v\le n-1,X_{m+n}=j |X_m=i \},(n\ge 1)$$

规定$$f_{ij}^{(0)} = 0$$; (f for first); $$p_{ij}^{(0)} =0,(i\neq j); p_{ii}^{(0)} = 1$$

- **首达概率之和**：$$f_{ii} = \sum_{n=1}^\infin f_{ij}^{(n)}$$

从i出发不返回i的概率为 $$p = 1- f_{ii}$$

- **常返**：首达概率之和为1. $$f_{ii}$$=1，称状态i为**常返**的
- **非常返**：$$f_{ii}$$<1，称状态i为**非常返**的
- **平均返回时间$$\mu_i$$**：从i出发回到i的平均步数(首达时间的期望，用首达概率作权)：

$$\mu_i = \sum_{n=1}^\infin nf_{ii}^{(n)}$$

- **正常返**：若$$\mu_i < \infty $$，则称常返态i为**正常返**的
- **零常返**：若$$\mu_i = \infty $$，则称常返态i为**零常返**的



- 状态的**遍历**：状态i**正常返**，且**非周期**，则为**遍历**
- **吸收态**：状态i遍历，且$$f_{ij}^{(1)} = 1$$，则为**吸收态**，此时$$\mu_i =1$$。(吸收态：到了该状态就永远不会离开)

状态i为常返的$$\Leftrightarrow \sum_{n=0}^\infty p_{ii}^{(n)} = \infty$$

状态i为非常返的$$\Leftrightarrow \sum_{n=0}^\infty p_{ii}^{(n)} = \frac{1}{1-f_{ii}}$$,此时$$\lim_{n\rightarrow \infty} p_{ii}^{(n)} =0$$

若状态j为非常返或零常返，则对$$\forall i \in S,$$有$$\lim_{n\rightarrow \infty} p_{ij}^{(n)} =0$$

若状态j为正常返且周期为d，则对$$\forall i \leftrightarrow j,i\in S$$, 有$$\lim_{n\rightarrow \infty} p_{ij}^{(nd)} =\frac{d}{\mu_j}$$





###### 平稳分布&极限分布

> 平稳分布(稳态分布)：在这个分布的马尔可夫链的概率分布永远不变。

**平稳分布**：若对任意整数m, n,马氏链的状态分布满足
$$
p(x_m =i) = p(x_n=i) = \pi_i, i=1,...,J
$$
其中，$$\pi_i$$与时刻无关，则称{$$\pi_i$$}为**平稳分布**，或**稳态分布**。其中$$J$$为状态数。

对于平稳分布有：$$\pi^T = \pi^TP$$。其中，$$\pi = (\pi_1, \pi_2, …, \pi_J)^T$$为**平稳分布列矢量**。

定理：如果一个遍历有限状态马氏链的转移概率矩阵为P，那么 
$$
\lim_{k\rightarrow \infty} P^k = e\pi^T
$$
其中$$e = (1,1,...,1)^T​$$为J维列矢量，$$\pi​$$为平稳分布列矢量

$$\lim_{k\rightarrow \infty} P^k $$是一个每行都相同（都等于$$\pi ^T$$）的矩阵

对于**遍历**的马尔科夫链，无论初始状态概率分布如何，当转移步数足够大时，概率状态分布总会趋于**平稳分布**，与初始状态概率分布无关。平稳分布的状态j的概率：$$\lim_{n\rightarrow \infty} p_{ij}^{(n)} = \pi_j=\frac{1}{\mu_j}​$$



#### 可数马尔可夫链



#### 连续时间马尔可夫链



---

## 最优停时

-   ​



-   $$f(k)$$对应于每个状态的收益函数，表示当该马尔可夫链到达这一状态后停止时的收益。表示每一轮游戏的收益
-   令$$v(k)$$表示假设在选择最优策略且第一轮点数为k时玩家的收益
-   令$$u(k)$$表示玩家掷到k点，然后采用最优策略继续游戏的期望收益



---

## 鞅 Martingale

> 已知过去某一时刻*s*以及之前所有时刻的观测值，若某一时刻*t*的观测值的**条件期望**等于过去某一时刻*s*的观测值，则称这一随机过程是鞅 

离散鞅定义：称随机序列{$$X_n$$},$$n=0,1,…,n\ge 0$$, 为**离散鞅序列**(简称**鞅**)，若对任意$$X_n$$有

1. $$E[|X_n|] < \infty$$
2. $$E(X_{n+1} | X_0, …, X_N) = X_n$$

**无后效性**：$$E(X_{n+1}|X_0, …,X_n) = X_n$$. 已知时刻n以及它之前的值 $$X_0, …, X_n$$，那么n+1时刻的值$$X_{n+1}$$对$$X_0, …, X_n$$的条件期望$$E(X_{n+1}|X_0, …,X_n)$$与时刻n以前的值无关，并且等于$$X_n$$.

离散熵的定义：设{$$X_n$$}{$$Y_n$$},$$n=0,1,…,n\ge 0$$为两个随机序列，称{$$X_n$$}关于{$$Y_n$$}为鞅(简称{$$X_n$$}为鞅)，若对任意$$X_n$$有：

1. $$E[|X_n|] < \infty$$
2. $$X_n$$是$$Y_0, …, Y_n$$的函数
3. $$E(X_{n+1}|Y_0, …,Y_n) = X_n$$. (与无后效性的等式类似)

定理：{$$X_n$$}关于{$$Y_n$$}是鞅的充要条件为：对任意非负整数m, n(m>n)有$$E(X_{n}|Y_0, …,Y_n) = X_n$$

常数序列{$$C_n$$}为鞅，其中$$c_n =c, E(c_{n+1}|Y_0, ..., Y_n) = E(c|Y_0, ..., Y_n) = c = c_n$$

若{$$X_n$$}为鞅，则对任意$$n\ge 0$$,有$$E(X_n) = E(X_0)$$即$$X_n$$的数学期望$$E(X_n)$$是一常数$$E(X_0)$$

设{$$Y_n$$}, $$n=0,1,…,n\ge 0$$为独立随机序列，$$Y_0 = 0$$且$$\forall n \ge 0$$有$$E(Y_n) = \mu =0$$,令$$X_n = \sum_{k=0}^n Y_k$$，则{$$X_n$$}关于{$$Y_n$$}是鞅

若$$X$$关于$$F_n$$可测，则$$E(X|F_n) = X$$

若$$X$$与$$F_n$$相互独立，则$$E(X|F_n) = E(X)$$

设$$X$$及$$XY$$的期望存在，且$$Y$$为$$F_n$$可测，则$$E[XY|F_n] = Y[X|F_n]$$





---

## 计数过程

随机过程{$$N(t), t\ge 0$$}称为计数过程，如果N(t)满足0到t时刻某一特定事件A发生的次数，它具备以下以下两个特点：

1. $$N(t)\ge 0$$且取值为整数；
2. s<t时，$$N(s)\le N(t)$$，且$$N(t) - N(s)$$表示(s, t]时间内事件A发生的次数



独立增量计数过程：

对于$$t_1<t_2<…<t_n, N(t_2) - N(t_1), 有N(t_3) - N(t_2), … , N(t_n) - N(t_{n-1})$$独立

平稳增量计数过程：

在(t, t+s]内(s>0)，事件A发生的次数 N(t+s) - N(t) 仅与时间间隔s有关，而与初始时刻t无关



---

## Poisson 过程

> **时间连续**，**状态离散**的随机过程。泊松过程。独立平稳增量过程，不是平稳过程。Poisson 过程过程本身不是平稳过程，其增量是平稳过程.
>
> Poisson 过程是更新过程.是事件发生的时间间隔为独立同指数分布的更新过程
>
> 更新过程的参数可以为离散的,也可以为连续的.但状态是离散的.它是计数过程.

定义：计数过程{$$X(t), t\ge 0$$}称为参数为$$\lambda(\lambda>0)$$的Poisson过程，如果：

1. X(0) = 0
2. X(t)是**独立**增量过程
3. 在任一长度为t的区间中，事件A发生的次数服从参数 $$\lambda$$t(> 0)的**泊松分布**，即对任意s, t $$\ge$$ 0，有$$P\{X(t+s)-X(s) = n\} = e^{-\lambda t} \frac{(\lambda t)^n}{n!}, n=0,1,2,...$$; t为时间差，s为起始时间，n为增量

定义：计数过程{$$X(t), t\ge 0$$}称为参数为$$\lambda(\lambda>0)$$的Poisson过程，如果：

1. X(0)=0
2. X(t)是**平稳**、**独立**增量过程
3. X(t)满足下列两式:   ($$\lambda > 0$$)
   $$P\{X(t+h)-X(t) = 1\} = \lambda h + o(h); $$
   $$P\{X(t+h)-X(t) \ge 2\} = o(h)$$



对于参数为$$\lambda(\lambda>0)$$的Poisson过程{$$X(t), t\ge 0$$}，有以下等式成立
$$
平稳独立增量过程:h为时间差, t为起始时间, n为增量\\
P\{X(t+h) - X(t) = n\} = P\{X(h)= n\} = P\{X(h) - X(0) = n\} =e^{-\lambda h} \frac{(\lambda h)^n}{n!}\\
e.g. P\{X(t+h) - X(t) = 1\} = P\{X(h) - X(0) = 1\} = e^{-\lambda h}\lambda h\\
$$


事件发生**时间间隔序列**：将强度为$$\lambda(\lambda>0)​$$的Poisson过程{$$X(t), t\ge 0​$$}，各次事件发生的间隔时间$$X_n​$$(n=1,2,…)服从参数为$$\lambda​$$的指数分布：**$$X_n​$$的概率密度为$$\lambda e^{-\lambda t}​$$**。(与指数分布的关系)

在已知$$X(t) = n$$的条件下，时间发生时刻$$T_1, T_2, …, T_n$$的联合分布密度为$$f(t_1, t_2,…, t_n) = \frac{n!}{t^n}$$. e.g. 设N(t)是参数为$$\lambda$$的Poisson过程,事件发生时刻$$W_1, W_2$$在已知N(t)=2的条件下的联合概率密度为$$\frac{2}{t^2}$$.



转移概率：Poisson过程{$$X(t), t\ge 0$$}的转移概率矩阵$$P(t) = (p_{ij}(t))$$为：$$p_{ij}(t)$$表示经过时间t从i到j的概率
$$
p_{ij}(t) = \left\{{\begin{matrix}
e^{-\lambda t} \frac{(\lambda t)^{j-i}}{(j-i)!}, 当j-i \ge 0 \\
0,其他
\end{matrix}}\right.
$$



#### 数字特征

$$P\{X(t) - X(0) = n\} =e^{-\lambda t} \frac{(\lambda t)^n}{n!}$$

设{$$X(t), t\ge 0$$}是参数为$$\lambda(\lambda>0)$$的poisson过程，$$X(t)$$的相关数字特征为：

- 均值：$$E[X(t)] = \lambda t$$
- 方差：$$D[X(t)] = \lambda t$$
- 自相关函数：$$R_X(s, t) = E[X(s)X(t)] =\lambda^2st + \lambda\min(s, t);(E[X(s)]E[X(t)]  = \lambda s\lambda t)$$
- 协方差：$$\gamma(s,t) = E[X(s)X(t)] - E[X(s)]E[X(t)] = \lambda\min(s, t)$$

> 所以实际问题中，可以先计算均值/方差获得$$\lambda t$$后再代入泊松分布的概率公式中计算



---

## Brown 运动

> 布朗运动过程 布朗运动 Brownian motion  维纳过程 Wiener process 
>
> 参数连续，状态连续的**马尔可夫过程**。独立平稳增量过程。本身不是平稳过程。
>
> 随机游动的极限形式

记号：{$$B(t), t\ge 0$$}、{$$W(t), t\ge 0$$}

定义：称实随机过程{$$W(t), t\ge 0$$}是参数为$$\sigma^2$$的**Wiener过程**，如果

1. $$W(0) = 0$$, (初始状态为0)
2. {$$W(t), t\ge 0$$}是**平稳的独立增量过程**
3. $$\forall 0\le s < t, W(t) - W(s) \sim N(0, \sigma^2(t-s))$$
4. 路径是连续的，即函数$$t \rightarrow W_t$$是一个t的连续函数



若$$\sigma=1$$，称之为**标准布朗运动**。若$$\sigma \neq 1$$，则{$$\frac {X(t)}{\sigma}, t\ge 0$$}为标准布朗运动。

如果没有假定$$B(0) = 0$$,即$$B(0) =x$$，称之为**始于x的布朗运动**，记为$$B^x(t)$$，显然$$B^x(t) - x = B^0(t)$$

- 对称性：$$-W$$也是一个Brown运动
- 自相似性：对任意的常数a>0和固定的时间指标t>0,有$$W (at)=a^{1/2}W(t)$$
- 时间可逆性：$$B (t)=W (T)-W (T-t)$$则$$\{B (t), 0\le t \le T\}$$也是一个Brown运动
- 平移不变性：$$B(t)=W(t+a)-W(a)，t\ge 0,a$$是常数，则B(t)是Brown运动
- 尺度不变性：$$\{\frac {W(ct)}{\sqrt{c}}, t\ge 0\}$$(c>0)是Brown运动
- **马氏性**：Brown运动是马氏过程。
- 增量具有正态性：$$B(t) - B(s) \sim N(0, t-s), s<t$$
- 增量是独立的：$$B(t) - B(s)$$与$$B(u)$$独立，这里$$u<s<t$$
- 路径连续性：$$B(t), t\ge 0$$是t的连续函数
- 空间齐次性：布朗运动过程具有空间齐次性



- **空间齐次性**：设{$$X(t), t\ge 0$$}是随机过程，如果它的有限维分布是**空间平移不变**的，即
$$P\{X(t_1)\le x_1, X(t_2)\le x_2,…,  X(t_n)\le x_n|X(0) = 0\} $$
$$= P\{X(t_1)\le x_1+x, X(t_2)\le x_2+x,…,  X(t_n)\le x_n+x|X(0) = x\}$$，则称此过程为**空间齐次**的。

#### 数字特征

{$$W(t), t\ge 0$$}是参数为$$\sigma^2$$的**Wiener过程**, 则

- $$\forall t>0, W(t)\sim N(0, \sigma^2t)$$
- $$m_W(t) = 0, D_W(t) = \sigma^2t,R_W(s, t) = C_W(s, t) = \sigma^2 \min(s, t);s,t\ge0$$





---

# 统计分析 数据分析方法

> Statistical Analysis
>
> 主要参照的教材为《数据分析方法》 梅长林









---

## 主成分分析与典型相关分析



### 主成分分析 PCA

> **Principal Components Analysis**
>
> SVD分解(说法不同仅因角度不同) singular Value Decomposition

- 分析、简化数据集的技术。经常用于减少数据集的维数，同时保持数据集中的对方差贡献最大的特征。这是通过保留低阶主成分，忽略高阶主成分做到的
- 通过对协方差矩阵进行特征分解，以得出数据的主成分(特征向量)与它们的权值(特征值)。PCA是最简单的以特征量分析多元统计分布的方法
- PCA的数学定义是：一个正交化线性变换，把数据变换到一个新的坐标系统中，使得这一数据的任何投影的第一大方差在第一个坐标（称为第一主成分）上，第二大方差在第二个坐标（第二主成分）上，依次类推



#### 均值向量与协方差矩阵

> covariance matrix 协方差矩阵 离差矩阵 方差-协方差矩阵

- 协方差矩阵 i, j 位置的元素是第 i 个与第 j 个随机向量（即随机变量构成的向量）之间的协方差。这是从标量随机变量到高维度随机向量的自然推广

随机向量X的**均值向量**: 设X= (X~1~, X~2~, … X~p~)^T^, E(X~i~)=μ~i~, (i=1,2,…p) 存在X的**均值向量**:
$$
E(\vec X) = \left[
 \begin{matrix}
 E(X_1)\\
 E(X_2)\\
 \vdots\\
 E(X_p)\end{matrix} \right]
  = \left[
 \begin{matrix}
\mu_1\\
\mu_2\\
 \vdots\\
\mu_p\end{matrix} \right] = \vec\mu
$$
协方差矩阵的第(i,j)項（第(i,j)項是一个协方差）被定义为如下形式: 用大Sigma表示
$$
\displaystyle \Sigma_{ij}=\mathrm{cov} (X_{i},X_{j})=\mathrm {E} {\begin{bmatrix}(X_{i}-\mu_{i})(X_{j}-\mu_{j})\end{bmatrix}}
$$
n维随机**向量X**的**协方差阵**: 半正定(非负定)，对称，大多数情况下是正定的
$$
\Sigma = D(X) = \mathrm{cov}(\mathbf{X}, \mathbf{X}) = \mathrm {E} \left[\left(\mathbf{X} -\mathrm{E} [\mathbf {X} ]\right)\left(\mathbf{X} -\mathrm{E} [\mathbf{X} ]\right)^{\rm {T}}\right]\\
= \begin{bmatrix}  \mathrm{E}[(X_1 - \mu_1)(X_1 - \mu_1)] & \mathrm{E}[(X_1 - \mu_1)(X_2 - \mu_2)] & \cdots & \mathrm{E}[(X_1 - \mu_1)(X_n - \mu_n)] \\ 
\mathrm{E}[(X_2 - \mu_2)(X_1 - \mu_1)] & \mathrm{E}[(X_2 - \mu_2)(X_2 - \mu_2)] & \cdots & \mathrm{E}[(X_2 - \mu_2)(X_n - \mu_n)] \\ 
\vdots & \vdots & \ddots & \vdots \\  \mathrm{E}[(X_n - \mu_n)(X_1 - \mu_1)] & \mathrm{E}[(X_n - \mu_n)(X_2 - \mu_2)] & \cdots & \mathrm{E}[(X_n - \mu_n)(X_n - \mu_n)] \end{bmatrix}
$$
矩阵中的第(i,j)个元素是Xi与Xj的协方差。这个概念是对于标量随机变数方差的一般化推广。称  |Cov(X,X)| 为X的广义方差，它是协方差矩阵的行列式
$$
\Sigma = \mathrm{E}(\mathbf{X X^\top}) - \mathbf{\mu}\mathbf{\mu^\top} 
$$

随机向量X和Y的协方差阵: 设X= (X1, X2, … Xn)^T^, Y= (Y1, Y2, … Yp)^T^, 它们的协方差矩阵是一个n×p的矩阵，其矩阵元素为 Cov(Xi, Yj)。若Cov(X,Y)=0, 称X和Y不相关

##### 运算性质

$$
X = (X_1, X_2, … X_n)^T, Y= (Y_1, Y_2, … Y_p)^T; A,B为常数矩阵\\
\mathrm{E}(AX) = A \mathrm{E}(X), \mathrm{E}(AXB)=A\mathrm{E}(X)B\\
\mathrm{D}(AX) = A \mathrm{D}(X)A^T = A\Sigma A^T\\
\mathrm{cov}(AX, BY) = A \mathrm{cov}(X,Y)B^T\\
\mathrm{E}(X^T A X) = tr(A \Sigma) + \mu^T A \mu\\
$$





---

## 判别分析 Discriminatory Analysis

> Discriminatory Analysis, 将未知类别的样品进行归类判别

判别分析又称为线性判别分析（Linear Discriminant Analysis）产生于20世纪30年代，是利用已知类别的样本建立判别模型，为未知类别的样本判别的一种统计方法

- 马氏距离不受量纲的影响，还可以排除变量之间的相关性的干扰，缺点是夸大了变化微小的变量的作用

> https://blog.csdn.net/u010167269/article/details/51627338 马氏距离reference

### 距离判别

> Mahalanobis Distance 马氏距离

样本间**马氏平方距离**，样本到总体G的**马氏平方距离**，总体G1和总体G2间的**马氏平方距离**：
$$
d^2(\mathbf{x}, \mathbf{y}) = (\mathbf{x} - \mathbf{y})^{T}\mathbf{\Sigma^{-1}}(\mathbf{x}-\mathbf{y})\\
d^2(\mathbf{x}, G) = (\mathbf{x} - \mathbf{\mu})^{T}\mathbf{\Sigma^{-1}}(\mathbf{x}-\mathbf{\mu})\\
d^2(G_1, G_2) = (\mu_1 - \mathbf{\mu_2})^{T}\mathbf{\Sigma^{-1}}(\mu_1-\mathbf{\mu_2})\\
$$
样本间**马氏距离**，样本到总体G的**马氏距离**：
$$
d(\mathbf{x}, \mathbf{y}) = [(\mathbf{x} - \mathbf{y})^{T} \mathbf{\Sigma^{-1}} (\mathbf{x}-\mathbf{y})]^{\frac{1}{2}}\\
d(\mathbf{x}, G) = [(\mathbf{x} - \mathbf{\mu})^{T} \mathbf{\Sigma^{-1}} (\mathbf{x}-\mathbf{\mu})]^{\frac{1}{2}}\\
$$


**距离判别准则**：使用马氏距离，样本到哪个总体的均值向量马氏距离越小，就属于哪个总体
$$
\left\{ \begin{matrix} 
\mathbf{x} \in G_1, \text{if }d(\mathbf{x}, G_1) \le d(\mathbf{x}, G_2) \\
\mathbf{x} \in G_2, \text{if }d(\mathbf{x}, G_1) > d(\mathbf{x}, G_2) 
\end{matrix}
\right.
$$

#### 两个总体的距离判别

- 当数据资料仅来自于两个p维总体的样本观测值时(训练样本)，设G1的样本容量为n1，G2的样本容量为n2

两个总体的均值向量的估计值：
$$
\hat{\mathbf{\mu_1}} = \frac{1}{n_1}\sum_{i=1}^{n_1}\mathbf{x_i^{(1)}} = \mathbf{\bar{x}^{(1)}}\\
\hat{\mathbf{\mu_2}} = \frac{1}{n_2}\sum_{i=1}^{n_2}\mathbf{x_i^{(2)}} = \mathbf{\bar{x}^{(2)}}\\
$$
两个训练样本的**协方差矩阵**各为：
$$
\mathbf{S_1} = \frac{1}{n_1-1}\sum_{i=1}^{n_1}(\mathbf{x_i^{(1)}} - \mathbf{\bar x^{(1)}})(\mathbf{x_i^{(1)}} - \mathbf{\bar x^{(1)}})^{T}\\
\mathbf{S_2} = \frac{1}{n_2-1}\sum_{i=1}^{n_1}(\mathbf{x_i^{(2)}} - \mathbf{\bar x^{(2)}})(\mathbf{x_i^{(2)}} - \mathbf{\bar x^{(2)}})^{T}
$$
当两个总体的协方差矩阵相等时，即$$\mathbf{\Sigma_1} = \mathbf{\Sigma_2} = \mathbf{\Sigma} $$ 时，$$\mathbf{\Sigma}$$的一个联合估计为：
$$
\mathbf{S} = \mathbf{\hat{\Sigma}}=\frac{(n_1 - 1)\mathbf{S_1} + (n_2 - 1)\mathbf{S_2}}{n_1 + n_2 -2}
$$

#### 多个总体的距离判别

设有k个总体，计算新样品x到各总体的马氏距离，比较这k个距离，判定x属于其马氏距离最小的总体。



当假设k个总体的协方差矩阵相等时，总体协方差矩阵的一个联合估计为：
$$
\mathbf{S} = \mathbf{\hat{\Sigma}} = \frac{1}{n-k}[(n_1 - 1)\mathbf{S_1} + (n_2 - 1)\mathbf{S_2} + ...+(n_k - 1)\mathbf{S_k}]
$$





### Bayes判别





---

## 聚类分析 Cluster Analysis

> 聚类分析 群集分析 Cluster analysis

- 聚类是把相似的对象通过静态分类的方法分成不同的组别或者更多的子集 subset，这样让在同一个子集中的成员对象都有相似的一些属性，常见的包括在坐标系中更加短的空间距离等
- 一般把数据聚类归纳为一种**无监督**式学习

聚类分析分为两种类型：

1. 按样品聚类
2. 按变量(指标)聚类

聚类分析与判别分析：聚类分析和判别分析都是研究分类的，但是聚类分析一般寻求客观的分类方法，在进行聚类分析之前，对总体到底有几种类型并不知道，判别分析则是总体分类已给定，在总体分布或来自总体训练样本基础上，对当前的新样品判定它们世俗与哪个总体。聚类分析与判别分析有一定联系：判别分析中的训练样本往往是从聚类分析得到的。



#### 距离测量

- 曼哈顿距离 Manhattan Distance, 1-norm距离 L~1~距离, 绝对距离: 各维距离(边长)的加和

$$
d(x_i, x_j) = \sum_{k=1}^{p}|x_{ik} - x_{jk}|
$$

- 欧式距离 2-norm距离, L~2~距离: 

$$
d(x_i, x_j) = [\sum_{k=1}^{p}(x_{ik} - x_{jk})^{2}]^{\frac{1}{2}}
$$

- Minkowski 距离: m>=1, 又称L~m~距离，L~2~距离即欧式距离

$$
d(x_i, x_j) = [\sum_{k=1}^{p}(x_{ik} - x_{jk})^{m}]^{\frac{1}{m}}
$$



- Chebyshev 距离
- 方差加权距离
- 马氏距离
- 余弦相似度
- 汉明距离



### 快速聚类法

> 动态聚类法

- 首先将样本粗糙地分类，然后再依据样品间的距离按一定规则逐步调整，直至不能调整为止。
- 快速聚类法适合于样品数目较大的数据集的聚类分析，但需要事先指定分类的数目，此数目对最终分类结果有较大影响

选择初始聚点:

1. 经验选择: 根据经验选择k个样品(观察)作为初始聚点
2. 人为分类: 将n个样品认为分为k类，以每类的均值向量(重心)作为聚点
3. 最小最大原则:
   1. 设将n个样品分成k类，先选择所有样品中相距最远的两个样品$$x_{i_1}, x_{i_2}$$作为初始聚点，即$$d(x_{i_1}, x_{i_2}) = d_{i_1 i_2} = \max{\{d_{ij} \}}$$
   2. 若已经选择了$$l$$个聚点($$l<k$$), 则l+1聚点$$x_{i_{l+1}}$$根据以下公式选择:

$$
\min{\{ d(x_{i_{l+1}}, x_{i_r}), r=1,2,...,l \}} = \max{\{ \min{[d(x_j, x_{i_r}), r=1,2,...,l ]} ,j\neq i_1,...,i_l\}}
$$



### *k*-means clustering

> k-平均聚类算法

- NP Hard, 但存在高效的启发式算法

将n个样本分为k类
$$
\begin{align}
& k\text{-means Algorithm} \notag\\
& \text{----------------------------------------------------------}\notag\\
& \mathbf{L}^{(0)} = \{x_{1}^{(0)}, x_{2}^{(0)}, ..., x_{k}^{(0)}\} \notag\\
& G_{i}^{(0)} = \{x:d(x,x_{i}^{(0)}) \le d(x,x_{j}^{(0)}), j=1,2,...,k \and j \neq i \}, i=1,2,...,k \notag\\
& \mathbf{G}^{(0)} = \{G_{1}^{(0)},G_{2}^{(0)},...,G_{k}^{(0)} \} \notag\\
& m=0, \mathbf{G}^{(-1)} = \mathbf{G}^{(0)} \notag\\

& \text{While } (\mathbf{G}^{(m)} \neq \mathbf{G}^{(m-1)}) \text{ do:}  \notag\\
& \qquad m = m+1  \notag\\
& \qquad x_{i}^{(m)} = \frac{1}{n_{i}} \sum_{x_{l}\in G_{i}^{(m-1)} } x_{l}, i=1,2,...,k \notag\\
& \qquad \mathbf{L}^{(m)} = \{x_{1}^{(m)}, x_{2}^{(m)}, ..., x_{k}^{(m)}\} \notag\\
& \qquad G_{i}^{(m)} = \{x:d(x,x_{i}^{(m)}) \le d(x,x_{j}^{(m)}), j=1,2,...,k \and j \neq i \}, i=1,2,...,k \notag\\
& \qquad \mathbf{G}^{(m)} = \{G_{1}^{(m)},G_{2}^{(m)},...,G_{k}^{(m)} \} \notag\\
& \text{Return }\mathbf{G}^{(m)} = \{G_{1}^{(m)},G_{2}^{(m)},...,G_{k}^{(m)} \} \notag\\
\end{align}
$$





##  因子分析

> factor analysis 1904 Charles Spearman

- 因子分析模型是主成分分析的推广，也是利用降维的思想，由研究原始变量相关矩阵内部的依赖关系出发，把一些具有错综复杂的变量归结为少数几个综合因子的一种多变量统计分析方法
- 相比主成分分析，因子分析更倾向于描述原始变量之间的相关关系，因此因子分析的出发点是原始变量的相关矩阵。
- 根据相关性大小，把原始变量分组，使得同组内的变量之间相关性较高，而不同组的变量间相关性较低。

Charles Spearman 发现过程: 在协方差矩阵中，除了涉及对角线(全为1)的以外，任意两列的元素大致成比例。故指出每一科科目的考试成绩都遵循: 用常数加权了的公共因子F加上一个仅对第i门科目有影响的特殊因子。Xi 为第i门科目标准化后的考试成绩，均值为0，方差为1
$$
X_i = a_i F + e_i\\
\frac{\mathbf{cov}(X_i, X_j)}{\mathbf{cov}(X_i, X_k)} = \frac{a_j}{a_k}; i\neq j\neq k.\\
\mathbf{var}(X_i) = \mathbf{var}(a_i F +e_i) = \mathbf{var}(a_i F) + \mathbf{var}(e_i) = a_i^{2}\mathbf{var}(F)+\mathbf{var}(e_i) = a_i^{2}+\mathbf{var}(e_i)
$$

因为ai是一个常数，F与ei相互独立，且F和Xi的方差均被假定为1，于是有
$$
1 = a_i^{2} + \mathbf{var}(e_i)
$$

- 因子载荷：常数ai的意义就在于其平方表示了公共因子F解释Xi方差的比例，因此称为因子载荷，而$$a_i^2$$称为共同度。

推广至变量Xi受到m个共同因子的影响:
$$
X_i = a_{i1}F_1 + a_{i2}F_2 + ... + a_{im}F_m + e_i\\
\mathbf{var}(X_i) = a_{i1}^{2} + a_{i2}^{2} + ... + a_{im}^{2} + \mathbf{var}(e_i)=1\\
$$

- 共同度：$$a_{i1}^{2} + a_{i2}^{2} + ... + a_{im}^{2}$$ 表示公共因子解释Xi方差的比例，称为Xi的共同度
- 特殊度，剩余方差：$$\mathbf{var}(e_i)$$ 可被称为Xi的特殊度或剩余方差，表示Xi的方差中与公共因子无关的部分



### 一般因子分析模型

设有n个样品，每个样品观测p个指标，这p个指标之间有较强的相关性（只有拥有较强的相关性才能提取出“公共”因子）。为便于研究，消除由于观测量纲的差异及数量级不同所造成的影响，对样本观测数据进行标准化处理，使标准化后的变量均值为0，方差为1。把原始变量及标准化后的变量向量用 $$\mathbf{X}$$ 表示，用 $$F_1, F_2,...,F_m;(m<p)$$ 表示标准化的公共因子。

若满足下列条件:

1. $$\mathbf{X} = (X_1, X_2, ..., X_p)^{T}$$ 是可观测随机变量，且均值向量$$E(\mathbf{X}) = \mathbf{0}$$, 协方差矩阵$$cov(\mathbf{X}) = \mathbf{\Sigma}$$, 且协方差矩阵$$\Sigma$$与相关阵R相等。
2. $$F=(F_1, F_2,...,F_m)^{T}, (m<p)$$ 是不可观测的变量，其均值向量$$E(\mathbf{F}) = \mathbf{0}$$, 协方差矩阵$$cov(\mathbf{X}) = \mathbf{I}$$, 即向量F的各分量是**相互独立**的
3. $$\mathrm{\varepsilon} = (\varepsilon_1, \varepsilon_2, ...,\varepsilon_p)^{T}$$ 与F相互独立，且$$E(\mathbf{\varepsilon}) = \mathbf{0}$$ , $$\mathrm{\varepsilon}$$的协方差矩阵 $$\Sigma_{\varepsilon}$$ 是对角方阵

$$
\mathbf{cov}(\mathbf{\varepsilon}) = \Sigma_{\varepsilon} = 
\begin{bmatrix}  \sigma_{11}^{2} & 0 & ... & 0 \\ 
0 & \sigma_{22}^{2} & \cdots & 0 \\ 
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \sigma_{pp}^{2} \end{bmatrix}
$$

即 $$\mathrm{\varepsilon}$$ 得各分量之间也是相互独立得，则模型
$$
\left\{ \begin{matrix} 
\mathrm{X_1} = a_{11}F_1 + a_{12}F_2 + ... + a_{1m}F_m + \varepsilon_1 \\
\mathrm{X_2} = a_{21}F_1 + a_{22}F_2 + ... + a_{2m}F_m + \varepsilon_2 \\
...\\
\mathrm{X_p} = a_{p1}F_1 + a_{p2}F_2 + ... + a_{pm}F_m + \varepsilon_p \\
\end{matrix}
\right.
$$
称为**因子模型**。矩阵形式为:
$$
\mathbf{X} = \mathbf{AF} + \mathbf{\varepsilon}\\
\mathbf{A} = \begin{bmatrix}  a_{11} & a_{12} & ... & a_{1m} \\ 
a_{21} & a_{22} & \cdots & a_{2m} \\ 
\vdots & \vdots & \ddots & \vdots \\
a_{p1} & a_{p2} & \cdots & a_{pm} \end{bmatrix}
$$
公共因子相互独立且不可测，是在原始变量得表达式中都出现的因子。公共因子F的含义需要结合实际问题具体意义确定

各特殊因子之间以及特殊因子与所有公共因子之间是相互独立的。

因子载荷: 矩阵A中的元素$$a_{ij}$$称为因子载荷，绝对值越大($$|a_{ij}| \le 1$$)，表明 $$X_i$$ 与 $$F_j$$ 的相依程度越大，或称公共因子 $$F_j$$ 对于 $$X_i​$$ 的载荷量越大。

- **因子载荷** $$a_{ij}$$ 的统计意义: 是 $$X_i$$ 与 $$F_j$$ 的协方差，而由于 $$X_i$$ 与 $$F_j$$ 都是均值为0，方差为1的变量，因此也是 $$X_i$$ 与 $$F_j$$ 的相关系数。

$$
\mathrm{cov}(X_i, F_j) = \mathrm{cov}(\sum_{j=1}^{m} a_{ij}F_j + \varepsilon_i, F_j) = \mathrm{cov}(\sum_{j=1}^{m} a_{ij}F_j, F_j) + \mathrm{cov}(\varepsilon_i, F_j) = a_{ij}
$$

- 变量共同度与剩余方差：共同度考虑的是所有公共因子$$F_1, F_2,...,F_m$$与某一个原始变量Xi的关系
- **共同度**：A中第i行元素的平方和。$$h_{i}^{2} = a_{i1}^{2} + a_{i2}^{2} + ... + a_{im}^{2}$$ 为变量 $$X_i$$ 的共同度，记为 $$h_{i}^{2}(i=1,2,...,p)$$ , 记$$\mathrm{var}(\varepsilon_{i}) = \sigma_{i}^{2}$$, 称为剩余方差

$$
\mathrm{X_i} = 1 = h_{i}^{2} + \mathrm{var}(\varepsilon_i) = h_{i}^{2} + \sigma_{i}^{2}\\
$$

上式表明共同度$$h_{i}^{2}$$与**剩余方差**$$\sigma_{i}^{2}$$有互补关系，$$h_{i}^{2}​$$越大，表明Xi对公共因子的依赖程度越大，公共因子能解释Xi方差的比例越大，因子分析的效果越好。

- 公共因子$$F_j$$的方差贡献：考虑某个公共因子$$F_j$$与所有原始变量$$X_1,X_2,...,X_p$$的关系

$$
g_{j}^{2} = a_{1j}^{2} + a_{2j}^{2} + ... + a_{pj}^{2}, (j=1,2,...,m)
$$

上式表示的是公共因子Fj对于X的每一分量$$X_i (i=1,2,...,p)$$所提供的方差的总和，称为公共因子Fj对原始向量X的方差贡献，是衡量公共因子相对重要性的指标。

### 因子载荷求解

主要步骤：

1. 确定因子载荷
2. 因子旋转: 对公共因子进行线性组合，以期找到意义更为明确，实际意义更明显的公共因子。
3. 计算因子得分

#### 主成分法

在进行因子分析之前对数据进行一次主成分分析PCA，然后把前几个主成分作为未旋转的公共因子。但是PCA所得的特殊因子$$\varepsilon_1, \varepsilon_2, ..., \varepsilon_p$$ 之间并不互相独立，不完全符合因子模型的假设前提。



#### 因子旋转

对初始公共因子进行线性组合，即进行因子旋转，以期找到意义更为明确，实际意义更明显的公共因子。

1. 正交旋转：初始载荷矩阵A右乘一正交阵，新的公共因子仍然保持彼此独立的性质
2. 斜交旋转：放弃因子之间彼此独立这个限制，实际意义更容易解释。

正交旋转和斜交旋转都应该使新的因子载荷系数要么尽可能接近于0，要么尽可能远离0。接近0的载荷$$a_{ij}$$表明Xi与Fj的相关性很弱，绝对值比较大的$$a_{ij}$$表明公共因子Fj在很大程度上解释了Xi的变化。



#### 因子得分

因子得分就是公共因子$$F_1,F_2,...,F_m$$在每一个样品点上的得分。

因子模型中，公共因子的个数少于原始变量的个数，且公共因子使不可观测的隐变量，载荷矩阵A不可逆，因而不能直接求得公共因子用原始变量表示的精确线性组合。解决方法之一使用回归的思想求出线性组合系数的估计值，即建立如下以公共因子为因变量，初始变量为自变量的回归方程：
$$
F_j = \beta_{j1}X_1 + \beta_{j2}X_2 + ... + \beta_{jp}X_p, j = 1,2,..,m
$$
此处因为初始变量与公共因子变量均为标准化变量，所以回归模型中不存在常数项。

因子得分系数矩阵 component score coefficient matrix 使用原始变量表示标准化主成分(公因子)的系数矩阵

#### 主成分分析与因子分析的区别

PCA中的剩余的主成分相等于因子分析中的 $$\varepsilon$$ , 且因子分析中的因子为不可测变量

1. PCA中不需要有一些专门假设，因子分析则需要一些假设。因子分析的假设包括：各个公共因子之间不想管，特殊因子之间不相关，公共因子和特殊因子之间不相关。
2. 提取主因子的方法不仅有主成分法，还有主轴因子法、最小二乘法、极大似然法、$$\alpha$$因子提取法等，基于这些不同算法得到的结果一般也不同。而PCA只能用主成分法提取。



### 因子分析的步骤

1. 根据研究问题选取原始变量。
2. 对原始变量进行标准化并求其相关阵，分析变量之间的相关性。
3. 求解初始公共因子及因子载荷矩阵。
4. 因子旋转
5. 计算因子得分
6. 根据因子得分值进行进一步分析。

