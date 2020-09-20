[TOC]





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

若$$K_X(t_1, t_2) = 0$$，称$$X(t_1)$$和$$X(t_2)$$是不相关的

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
- **首达概率**：由i出发经n步首次到达j的概率：({$$f_{ij}^{(n)}, n\ge 1$$}构成一概率分布)

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
其中$$e = (1,1,...,1)^T$$为J维列矢量，$$\pi$$为平稳分布列矢量

$$\lim_{k\rightarrow \infty} P^k $$是一个每行都相同（都等于$$\pi ^T$$）的矩阵

对于**遍历**的马尔科夫链，无论初始状态概率分布如何，当转移步数足够大时，概率状态分布总会趋于**平稳分布**，与初始状态概率分布无关。平稳分布的状态j的概率：$$\lim_{n\rightarrow \infty} p_{ij}^{(n)} = \pi_j=\frac{1}{\mu_j}$$



#### 可数马尔可夫链



#### 连续时间马尔可夫链



---

## 最优停时

-   



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


事件发生**时间间隔序列**：将强度为$$\lambda(\lambda>0)$$的Poisson过程{$$X(t), t\ge 0$$}，各次事件发生的间隔时间$$X_n$$(n=1,2,…)服从参数为$$\lambda$$的指数分布：**$$X_n$$的概率密度为$$\lambda e^{-\lambda t}$$**。(与指数分布的关系)

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

# 隐马尔可夫过程 HMM

> Hidden Markov Model, HMM 隐性马尔可夫模型 隐马尔可夫模型 
>
> 统计模型，它用来描述一个含有隐含未知参数的马尔可夫过程。常被用来解决有未知条件的数学问题
>
> 状态不是直接可见的，但能观察到某些受状态影响

- 在正常的马尔可夫模型中，状态对于观察者来说是直接可见的。这样状态的转换概率便是全部的参数
- 而在隐马尔可夫模型中，状态并不是直接可见的，但受状态影响的某些变量则是可见的。每一个状态在可能输出的符号上都有一概率分布。因此输出符号的序列能够透露出状态序列的一些信息

HMM的状态变迁示意图：

![HMM状态变迁](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/HMM_xt_to_xtplus1_yt_and_ytplus1.png)

`x(t+1)`和`x(t)`有关，`x(t)`和`x(t-1)`有关，而每个`y(t)`只和`x(t)`有关

- 隐藏变量 hidden variable: 指图中的x(t)，是观察者无法得知的变量
- x(t)之间的关系：假设隐藏状态的值对应到的空间有$N$个元素，也就是说在时间 $t$ 时，隐藏状态会有$N$种可能，同样，$t+1$也会有$N$种可能的值，所以从$t$到$t+1$间的关系会有$ N^{2}$种可能
- 每组x(t), y(t)之间的关系：若观察到的$y(t)$有$M$种可能的值，则从$x(t)$到$y(t)$的输出模型复杂度为$O(NM)$。如果$y(t)$是一个$M$维的向量，则从$x(t)$到$y(t)$的输出模型复杂度为$O(NM^{2})$
- 



HMM有三个典型(canonical)问题:

1. 预测(filter)：已知模型参数和某一特定输出序列，求最后时刻各个隐含状态的概率分布，即求$ {\displaystyle P(x(t)\ |\ y(1),\dots ,y(t))}{\displaystyle P(x(t)\ |\ y(1),\dots ,y(t))}$. 通常使用前向算法解决.

2. 平滑(smoothing)：已知模型参数和某一特定输出序列，求中间时刻各个隐含状态的概率分布，即求$ {\displaystyle P(x(k)\ |\ y(1),\dots ,y(t)),k<t}{\displaystyle P(x(k)\ |\ y(1),\dots ,y(t)),k<t}$. 通常使用前向-后向算法解决.

3. 解码(most likely explanation): 已知模型参数，寻找最可能的能产生某一特定输出序列的隐含状态的序列. 即求 ${\displaystyle P([x(1)\dots x(t)]|[y(1)\dots ,y(t)]),}{\displaystyle P([x(1)\dots x(t)]|[y(1)\dots ,y(t)])}$ , 通常使用Viterbi算法解决.

> 此外，已知输出序列，寻找最可能的状态转移以及输出概率.通常使用Baum-Welch算法以及Viterbi algorithm解决. 另外,最近的一些方法使用联结树算法来解决这三个问题









## Viterbi 维特比算法

> 一种动态规划算法
>
> https://en.wikipedia.org/wiki/Viterbi_algorithm

- 用于寻找最有可能产生观测事件序列的**维特比路径**——隐含状态序列，特别是在马尔可夫信息源上下文和隐马尔可夫模型中



- 病人连续三天看医生，医生发现第一天他感觉正常，第二天感觉冷，第三天感觉头晕。Viterbi求解最可能导致这一观察序列的状态序列：

```python
# python 3 code, Viterbi demo # 第一天正常，第二天冷，第三天头晕，求最有可能的状态序列
states = ('Healthy', 'Fever')  # 状态（不可观测）
observations = ('normal', 'cold', 'dizzy')  # 观测到的输出
start_probability = {'Healthy': 0.6, 'Fever': 0.4}  # 起始概率
transition_probability = {'Healthy': {'Healthy': 0.7, 'Fever': 0.3}, 'Fever': {
    'Healthy': 0.4, 'Fever': 0.6}, }  # 转移概率
emission_probability = {'Healthy': {'normal': 0.5, 'cold': 0.4, 'dizzy': 0.1}, 'Fever': {
    'normal': 0.1, 'cold': 0.3, 'dizzy': 0.6}, }  # 放射概率


# Helps visualize the steps of Viterbi.
def print_dptable(V):
    print("        ", end="")
    for i in range(len(V)):
        print("%7d" % i, end=" ")
    print()

    for y in V[0].keys():
        print("%.5s: " % y, end=" ")
        for t in range(len(V)):
            print("%.7s" % ("%f" % V[t][y]), end=" ")
        print()


def viterbi(obs, states, start_p, trans_p, emit_p):
    V = [{}]
    path = {}

    for y in states:  # Initialize base cases (t == 0)
        V[0][y] = start_p[y] * emit_p[y][obs[0]]
        path[y] = [y]

    for t in range(1, len(obs)):  # Run Viterbi for t > 0
        V.append({})
        newpath = {}

        for y in states:
            (prob, state) = max(
                [(V[t-1][y0] * trans_p[y0][y] * emit_p[y][obs[t]], y0) for y0 in states])
            V[t][y] = prob
            newpath[y] = path[state] + [y]

        path = newpath  # Don't need to remember the old paths

    print_dptable(V)
    (prob, state) = max([(V[len(obs) - 1][y], y) for y in states])
    return (prob, path[state])


def example():
    return viterbi(observations, states, start_probability, transition_probability, emission_probability)


print(example())

```

> 需注意编程过程中可能出现的，p很小时会导致的下溢问题。技巧：使用对数概率，算法结束时通过适当幂运算获得精确结果

