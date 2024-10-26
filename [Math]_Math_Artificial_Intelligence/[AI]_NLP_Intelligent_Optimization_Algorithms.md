







---

# Intelligent Optimization Algorithms

> 智能优化算法
>
> IOAS







### Pareto Non-Dominated Set

> 帕累托非支配解集

$$
S: 可行域\\
f_i(x) = 优化问题的第i(i = 1, 2, ..., m)个目标函数; m为目标函数个数\\
$$

Pareto支配: (最大化问题时)u is dominated by v: u被v支配(v的适应度更好), v支配u
$$
\forall i = 1, 2, ..., m, f_i(u) \le f_i(v), and\\
\exists j = 1, 2,...,m, f_j(u) < f_j(v), it's\ v\prec u(v\text{ dominate }u，v适应度更好)\\
$$



> Pareto frontier, Pareto Front, Pareto set 帕累托解集

The **Pareto frontier** is the set of all Pareto efficient allocations, conventionally shown graphically. It also is variously known as the **Pareto front** or **Pareto set**.

Pareto Optimal Ser(Non-dominated set)

![](http://op4fcrj8y.bkt.clouddn.com/18-7-26/7941622.jpg)



Pareto ranking scheme: 

- Goldberg Method: All non-dominated individuals should have the same reproductive potential. 非支配解有相同的生殖能力
- Fonseca and Fleming Method: The rank of each individual is defined by (1+p) where p is the number of individuals in the population that dominate it. Non-dominated  individuals are having the same rank(非支配解重要性相同), while dominated ones are penalized.(被支配的解有惩罚)





---

## Algorithm



- Enumerative Methods: Exhaustive
- Deterministic Methods: Calculus(微积分学) based, Convex(凸面体) Optimization, Linear Programming
- Stochastic(随机 猜测) Methods
  - Random walk
  - Simulated annealing 模拟退火
  - Tabu search
  - Swarm algorithms: Ant Colony 蚁群, Artificial Bee Colony, Particle Swarm Optimization
  - Evolutionary algorithms: evolutionary programming, evolution strategies, genetic algorithms, ...



### Simulated Annealing  (SA)

> 模拟退火算法; Annealing [n.] 热处理;低温退火;磨炼; v.退火;磨炼(anneal的ing)

![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/AI_SA_animation.gif)

模拟退火算法所得解依概率收敛到全局最优解

目标为寻找状态s使得能量函数 E(s) 最小（最小化问题）

1. 初始化：s = s0; 生成一个可行解作为迭代输入。定义kmax
2. main loop：迭代过程
   1. 温度T = temperature(k/kmax) #温度随k增大而降低 #也有的以接受新解的次数为基准，或迭代次数
   2. 新解 snew = neighbor(s) #在当前解的临近解空间随机生成一个新解
   3. 计算能量差Δt = E(snew) - E(s) #能量差<0则新解更好
   4. 若新解更好则接受新解(Δt < 0)，否则以概率exp(-Δt / T) 接受新解#温度越低则接受概率越小，即越到末尾，接受差解的概率越小
   5. 若接受新解，k = k+1
3. 输出最终解s



```python
s = s0  #设定目前状态为s0
e = E(s)  #其能量E (s0)
k = 0 #评估次数k(迭代次数)
while k < kmax and e > emax: #若还有时间（评估次数k还不到kmax）且结果还不够好（能量e不够低）则：
    sn = neighbour(s) #隨機選取一临近状态sn
    en = E(sn) #sn的能量为E(sn)
    if random() < P(e, en, temp(k/kmax)):#決定是否移至鄰近狀態sn
        s = sn #移至临近状态sn
        e = en 
    k = k + 1 #评估完成，次数k加一
return s
```





> 爬山算法 **Hill Climbing** ：每次都从临近解空间选择一个最优解最为当前解，容易陷入局部最优解中。是完完全全的贪心算法。而模拟退火算法加入了随机因素，以一定概率接受比当前解要差的解，故有可能跳出局部最优解。



### 差异进化算法

> 差分进化算法 差异进化算法 微分进化算法 Differential Evolution



---

## 群体智能优化算法 



### Ant Colony Optimization (ACO) 蚁群

> 蚁群算法



### Particle Swarm  Optimization (PSO) 粒子群优化

> 微粒群算法

利用群体中的个体对信息的共享从而使得整个群体的运动在问题求解空间中产生从无序到有序的演化过程，从而获得问题的最优解

所有的粒子都具有一个位置向量$$X_i$$（粒子在解空间的位置）和速度向量（决定下次飞行的方向和速度），并可以根据目标函数来计算当前的所在位置的适应值（fitness value）。在每次的迭代中，种群中的粒子除了根据自身的“经验”（历史位置）进行学习以外，还可以根据种群中最优粒子的“经验”来学习，从而确定下一次迭代时需要如何调整和改变飞行的方向和速度。就这样逐步迭代，最终整个种群的粒子就会逐步趋于最优解

速度向量迭代公式 ：
$$
V_i=w(t)V_i+c_1r_1(Pbest_i−X_i)+c_2r_2(Gbest−X_i)\\
V_i=w(t)V_i+U(0,c_1)(Pbest_i−X_i)+U(0,c_2)(Gbest−X_i)
$$
位置向量迭代公式：
$$
X_i = X_i + V_i
$$

- $$Pbest_i, Gbest$$: 分别代表**粒子i的历史最佳位置向量**和种群历史最佳位置向量 
- $$w(t)$$: PSO惯性权重 inertia weight, [0,1], 一般采用自适应的方法，e.g. 初始w=0.9使PSO全局优化能力强，随迭代次数增加w递减使局部优化能力增强，迭代结束时w=0.1, 0.4?
- $$c_1, c_2$$: 学习因子，一般设置为1.4961，2.05???
- $$r_1, r_2$$: [0,1]的随机值
- $$U(0, c_1)$$: $$[0, c_1]$$的均匀分布 uniform distribution。

1. 初始化：以一定方法初始化n个个体的位置向量$$X_i$$和方向向量$$V_i$$，并作为个体局部最优位置向量$$Pbest_i$$，计算个体fitness，选择适应度最高的个体的位置向量作为$$Gbest$$
2. main loop: 迭代次数 k < kmaxx
   1. 据速度向量迭代公式更新速度向量$$V_i$$
   2. 据位置向量迭代公式更新位置向量$$X_i$$
   3. 更新每个个体局部最优位置向量$$Pbest_i$$和全局历史最佳位置向量$$Gbest$$。
3. 迭代终止时输出最佳位置向量$$Gbest$$。





### Artificial Bee Colony Algorithm (ABC) 人工蜂群算法





## Evolution Algorithm (EA) 进化算法

> Evolution Algorithm 进化算法

A kind of stochastic global optimization methods inspired by the biological mechanism(机制, 机理) of evolution(进化) and heredity(遗传).

```c
//pseudocode of single object or multi-object Evolution Algorithm
pop[N]=ini_population(N);//initialization of population pop.
population Evolution_Algorithm(){
	Evaluate(pop);//Evaluate the fitness of all individual(solution) in pop
	while(termination criteria are not satisfied){//propagation loop
		offspring = Crossover(pop);//typically global search
        //offspring: population with size M.(typically M==N)
        offspring[i] = Mutation(offspring[i] for i in [0,M));
        //or Mutation(offspring + pop)//typically local search
        Evaluate(offspring);//Evaluate the fitness
        pop = Kill_to_N(offspring + pop);
        //kill some bad individuals,keep population pop size = N
    }
    return pop;//if(single object){return the best;}
               //else{return the non-dominated solution set}
}
```



#### roulette wheel selection

> 轮盘赌选择法

$$
p_i = \frac{f_i}{\sum_{j=1}^N f_j};f_i: \text{fitness of individual i}
$$







### Genetic Algorithm (GA) 遗传算法

> 遗传算法 genetic algorithm (GA)

- 计算数学中用于解决最佳化的搜索算法，进化算法的一种。借鉴于进化生物学。
- 本质是高效，并行，全局搜索的方法，可以在搜索过程中自动获取和累积有关搜索空间的知识，并自适应地控制搜索过程以求得最佳解

算法大致过程描述:

1. 创建初始种群(一个染色体集合 chromosome set，每个chromosome由参数编码而成)
2. loop: 繁殖下一代
   1. 计算每个个体的适应度fit
   2. 对个体进行fit排序
   3. 基因交叉
   4. 基因变异
3. 判断是否满足停止规则，不满足则重复<2>

```cpp
// GA structure
Genetic Algorithm () {
    Initialize_population();// initialization phase
    Evaluate_population();
    while not terminated do {// begin GA cycle
        Selection();
        Crossover();
        Mutate();
        Evaluate_offspring();
        Replacement();
    }
}
```

Parents are selected proportional to (or depends on) how good they are for the problem (measured by fitness). 父代被选择的概率与适应度成比例

> - Chromosome 染色体: Coded form of a trial solution
> - Fitness: A (positive) value assigned to a chromosome as a measure of its goodness
> - Parent: Member of the current generation being selected for generating new chromosome
> - Offspring: New chromosome generated from parent by crossover and mutation
> - Generations: Successively created populations (iterations)

Q: Solutions are easily crowded together. 解容易挤在一起
A: Approaches for improvement

- Derate(减免) the fitness of crowded solutions: Fitness sharing
- Prevent formation of similar solution: crossover with surrogate(代理)
- Reduce chances for similar parents: Tournament selection(锦标赛选择)
- New Operators: Jumping Gene operations(跳跃基因操作)

交叉：交换两个个体的基因，三种方式：

- **离散重组**。先随机选择两个父代个体，然后将**其分量进行随机交换**，构成子代新个体的各个分量，从而得出如下新个体。
- **中值重组**。这种重组方式也是先随机选择两个父代个体，然后将父代个体**各分量的平均值**作为子代新个体的分量，构成的新个体为。
- **混杂重组**。这种重组方式的特点在于父代个体的选择上。混杂重组时先**随机选择一个固定的父代个体**，然后针对子代个体**每个分量**再从父代群体中随机选择第二个父代个体。也就是说，第二个父代个体是经常变化的。至于父代两个个体的组合方式，既可以采用离散方式，也可以来用中值方式，甚至可以把中值重组中的1/2改为[0,1]之间的任一权值



### Evolution Strategy (ES) 进化策略

> 进化策略
>
> https://blog.csdn.net/u014248127/article/details/79143437

总遵循**零均值、某一方差**的高斯分布N(0, $$\delta^2$$)的变化产生新的个体，然后保留好的个体

1. 问题: 寻找实值n维矢量x，使函数F(x)取极值。不失一般性，设此程序为极小化过程。（**确定问题**）
2. 初始化：从各维的可行范围内随机选取亲本xi，i＝1，…，p的初始值。初始试验的分布一般是均匀分布。（**初始化种群**）
3. 进化：对两个个体进行**交叉重组**；通过对于x的每个分量**增加零均值和预先选定的标准差的高斯随机变量**，从每个亲本xi产生子代x’i。（**交叉、变异**）
4. 选择：通过将误差F(xi)和F(x’i)，i＝1，…，p **进行排序**，选择并决定哪些矢量保留。具有最小误差的p个矢量变成下一代的新亲本。（**把父亲和儿子放在一起用适应度排序，保留好的**）。
5. 重复进化和选择直到达到收敛

**变异：** 在每个分量上面加上**零均值、某一方差**的高斯分布的变化产生新的个体。这个某一方差就是变异程度 

**变异程度：**变异程度并不是一直不变化的，算法开始的时候变异程度比较大，当接近收敛后，变异程度会开始减小 

**选择：**进化策略的选择有两种：

1. **(μ+λ)选择**是从μ个父代个体及λ个子代新个体中确定性地择优选出μ个个体组成下一代新群体；以保证最优个体存活，使群体的进化过程呈单调上升趋势，但(μ+λ)选择保留旧个体，有时是局部最优解
2. **(μ, λ)选择**是从λ个子代新个体中确定性地择优桃选μ个个体(要求λ＞μ)组成下一代群体，每个个体只存活一代，随即被新个体顶替。实践证明，**(μ, λ)-ES优于(μ+λ)-ES，(μ, λ)-ES已成为当前进化策略的主流**







### Neuro Evolution 神经进化

> Neuro Evolution



### Memetic Algorithm (MA) 文化基因算法

> MA, 文化基因算法. 一种优化算法
>
> https://en.wikipedia.org/wiki/Memetic_algorithm wiki
>
> https://kknews.cc/news/y2x2zk.html matlab code

- 建立在模拟文化进化基础上的优化算法,它实质上是一种基于种群的全局搜索和基于个体的局部启发式搜索的结合体。全局搜索算子类似于GA, 局部搜索算子强调个体的提升(加速收敛速率)。
- 用局部启发式搜索来模拟由大量专业知识支撑的变异过程





---

## Multi-Objective Optimization Problem 

> multi-objective optimization problem MOP 多目标优化问题
>
> Multiobjective Evolutionary Algorithm, 多目标进化算法
>
> https://github.com/kokifish/MOEA-Net-HL   多目标进化算法在复杂网络上的应用案例







### MOSA

>  multi-objective simulated annealing 多目标模拟退火算法

To date, there are several widely used MOSA algorithms such as SMOSA, UMOSA, PSA, WMOSA, and PDMOSA. They are all able to deliver respectable performance under different conditions.



#### KBAMOSA

> knowledge-based archive multi-objective simulated annealing
>
> 《A knowledge-based archive multi-objective simulated annealing algorithm to optimize series–parallel system with choice of redundancy strategies》





### MOEA/D

>  基于分解的多目标进化算法



### NSGA-Ⅱ

> Nondominated Sorting Genetic Algorithm Ⅱ 非支配排序基因算法
>
> elitist strategy 精英策略
>
> 致力于解决: O(MN^3^)时间复杂度，非精英机制

- Tournament Selection with two candidates. Crowding measure.
- O(MN^2^)     M: Number of objectives   N: the population size



### MA-RSF~MA~

> Memetic Algorithm - enhance the Robustness of Scale-Free networks against Malicious Attacks

Algorithm 1 Population Initialization 种群初始化

Input: 

$$\Omega$$: Population size;

$$G_0$$ Initial scale-free network;

Output: 

$$ P^1 = \{G_1^1, G_2^1, ..., G_\Omega^1\}$$

for i = 1 to M do

$$
在G_i^1中随机选择两个边e_{kl}, e_{mn}(k,l,m,n互异), 且e_{km}, e_{ln}\notin G_i^1\\
	移除e_{kl}, e_{mn}, 增加$$e_{km}, e_{ln}\\
	if( G_i^1 \text{ is not connected} ):
		撤销前两步操作，恢复原来的G_i^1;
	end if
$$

end for
$$
V^{G_{c1}}_i =\{j | e_{ij} \in E^{G_{c1}}\} \\
V^{G_{c2}}_i =\{j | e_{ij} \in E^{G_{c2}}\} \\
\bar V^{G_{c1}}_i = V^{G_{c1}}_i  - (V^{G_{c1}}_i \cap V^{G_{c2}}_i) \\
\bar V^{G_{c2}}_i = V^{G_{c2}}_i  - (V^{G_{c1}}_i \cap V^{G_{c2}}_i) \\
$$

- $$V^{G_{c1}}_i$$ are the sets of neighbors of node i in $$G_{c1}$$



Algorithm 2 Crossover Operator 交叉算子

Input:
Gp1 and Gp2: Two parent chromosomes;
pc : Crossover rate;
Output:
Gc1 and Gc2: Two child chromosomes;
Gc1 ← Gp1, Gc1 ← Gp1;
for i = 1 to N do
	if (U(0, 1) < $$p_c$$ ) // U(0, 1) is a uniformly distributed random real number in [0, 1];
		计算 $$\bar V^{G_{c1}}_{i}$$ and $$\bar V^{G_{c2}}_{i}$$ ;
		for each node j $$\in V^{G_{c1}}$$ i do
			随机选择节点 k $$\in V^{G_{c2}}_{i}$$ ;
			移除$$e_{ij}$$ from $$G_{c1}$$ and $$e_{ik}$$ from Gc2; //交叉操作
			增加$$e_{ik}$$ to $$G_{c1}$$ and $$e_{ij}$$ to $$G_{c2}$$; //交叉操作
			随机选择另一条边 $$e_{kl}$$ that node k connects in $$G_{c1}$$ and $$e_{jl} \notin G_{c1}$$;
			移除$$e_{kl}$$ , 增加 $$e_{jl}$$ in $$G_{c1}$$;
			随机选择另一条边 $$e_{jm}$$ that node j connects in $$G_{c2}$$ and $$e_{km} \notin G_{c2}$$;
			移除 $$e_{jm}$$ , 增加 $$e_{km}$$ in $$G_{c2}$$;
			$$\bar V^{G_{c2}}_i = \bar V^{G_{c2}}_i - \{k\}$$;
		end for;
	end if ;
end for;

Algorithm 3 Local Search Operator 局部搜索算子



Algorithm 4 MA–RSF~MA~





### MOEA-RSF~MMA~

> MutiObject Memetic Algorithm - enhance the Robustness of Scale-Free networks against Multiple Malicious Attacks



Algorithm 1: $$R^D_n$$-Sampling Phase 取样









---

# NLP



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



#### overfitting & underfitting

>   过拟合与欠拟合

-   过拟合overfitting: 调试一个模型时，使用过多参数，太过受非法数据(噪声)影响，导致过度拟合当前模型，而不能适应更加一般的情况。
-   "the production of an analysis that corresponds too closely or exactly to a particular set of data, and may therefore fail to fit additional data or predict future observations reliably"
-   过拟合有关因素: 参数个数，训练数据集，模型结构

![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/AI_overfitting.png)

>   绿色线曲线(curve): overfitted model; black line: regularized model; 虽然绿色曲线更加适合当前数据集，但是对于未知的数据，绿色线可能有更高的误差。



-   欠拟合underfitting: 与过拟合相反，拟合不足。



### Activation Function

-   用来加入**非线性因素**以解决线性模型无法 解决的问题

###### threshold

-   threshold function，大于某个值输出1（被激活），小于等于则输出0（没有激活）



###### Sigmoid

$$
f(x)=S(x)={\frac {1}{1+e^{-x}}}={\frac {e^{x}}{e^{x}+1}},\\
f^{'}(x) = f(x)(1-f(x))
$$





### gradient 梯度

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





### Heuristic

>   heuristic [adj.]启发式的 探索的 [n.]启发式教育法

-   In computer science, artificial intelligence, and mathematical optimization, a **heuristic** (from Greek εὑρίσκω "I find, discover") is a technique designed for solving a problem more quickly when classic methods are too slow(启发式算法用于解决传统算法太慢的问题), or for finding an approximate(近似的) solution when classic methods fail to find any exact solution(当传统算法无法找到精确解时用于寻找近似解).



元启发式算法(Meta-heuristic algorithms)

-   可以适应很多问题的算法
-   遗传算法、模拟退火算法、粒子群算法、蚁群算法、禁忌搜索

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



### 全连接前馈神经网络模型demo

输入：256个像素点；输出：数字是[1, 10]的概率分布

![](http://op4fcrj8y.bkt.clouddn.com/18-6-19/64226892.jpg)

-   给定(图片，目标输出)数据对集合作为训练用的数据(例如图中的图片对应1)，在下图的特例中，深度学习的目标是找到一个函数使得输出的概率分布Q和期望的真实的概率分布P的相对熵$$H(P,Q)$$最小。整体目标是找到一个函数，使得全局损失(Total Loss)最小$$L = \sum _{r=1}^Rl_r$$。而找到这样一个最佳函数后，就会获得神经网络的对应的参数$$\theta$$(使得全局损失$$L$$最小)

![](http://op4fcrj8y.bkt.clouddn.com/18-6-19/1141211.jpg)







## RNNLM



## Bag-of-Words



## CBOW

>   https://blog.csdn.net/mytestmy/article/details/26969149 算法 