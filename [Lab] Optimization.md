[TOC]





---

# Mathematical optimization



## MOP 

> multi-objective optimization problem MOP 多目标优化问题





###### Pareto Non-Dominated Set 

> 帕累托非支配解集

$$
S: 可行域\\
f_i(x) = 优化问题的第i(i = 1, 2, ..., m)个目标函数; m为目标函数个数\\
$$

Pareto支配: (最小化问题时)u is dominated by v: u被v支配(v的适应度更好), v支配u
$$
\forall i = 1, 2, ..., m, f_i(u) \ge f_i(v), and\\
\exists j = 1, 2,...,m, f_j(u) > f_j(v), it's\ v\prec u(v支配u，v适应度更好)
$$



> Pareto frontier, Pareto Front, Pareto set 帕累托解集

The **Pareto frontier** is the set of all Pareto efficient allocations, conventionally shown graphically. It also is variously known as the **Pareto front** or **Pareto set**.

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

**变异：** 在每个分量上面加上**零均值、某一方差**的高斯分布的变化产生新的个体。这个某一方差就是变异程度 

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

## Multi-Objective Optimization

> Multiobjective Evolutionary Algorithm, 多目标进化算法







#### MOSA

>  multi-objective simulated annealing 多目标模拟退火算法

To date, there are several widely used MOSA algorithms such as SMOSA, UMOSA, PSA, WMOSA, and PDMOSA. They are all able to deliver respectable performance under different conditions.



##### KBAMOSA

> knowledge-based archive multi-objective simulated annealing
>
> 《A knowledge-based archive multi-objective simulated annealing algorithm to optimize series–parallel system with choice of redundancy strategies》





#### MOEA/D

>  基于分解的多目标进化算法



#### NSGA-Ⅱ

> Nondominated Sorting Genetic Algorithm Ⅱ 非支配排序基因算法
>
> elitist strategy 精英策略
>
> 致力于解决: O(MN^3^)时间复杂度，非精英机制，非精英机制 

- Tournament Selection with two candidates. Crowding measure.
- O(MN^2^)     M: Number of objectives   N: the population size



#### MA-RSF~MA~

> Memetic Algorithm - enhance the Robustness of Scale-Free networks against Malicious Attacks

Algorithm 1 Population Initialization 种群初始化

Input: 

$$\Omega$$: Population size;

$$G_0$$ Initial scale-free network;

Output: 

$$ P^1 = \{G_1^1, G_2^1, ..., G_\Omega^1\}$$

for i = 1 to M do

	在$$G_i^1$$中随机选择两个边$$e_{kl}, e_{mn}$$(k,l,m,n互异), 且$$e_{km}, e_{ln}\notin G_i^1$$
	
	移除$$e_{kl}, e_{mn}$$, 增加$$e_{km}, e_{ln}$$
	
	if( $$G_i^1$$ is not connected ): 撤销前两步操作，恢复原来的$$G_i^1$$; end if

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





#### MOEA-RSF~MMA~

> MutiObject Memetic Algorithm - enhance the Robustness of Scale-Free networks against Multiple Malicious Attacks



Algorithm 1: $$R^D_n$$-Sampling Phase 取样







---

# GOAL

1. 10%host (发送/接收data) 90%routers (transfer)的复杂网络
2. 探索其多目标优化问题
   1. 鲁棒性（拓扑）
   2. 容量（考虑传送信息能力的问题）



- 是否为负相关（皮尔森系数）
- 




Capacity:

$$
L(i) = \sum_{s\ne t \in V_h}\frac{\sigma_{st}(i)}{\sum_{j\in V} \sigma_{st}(j)}; V_h: \text{hosts set}, V: \text{all nodes}\\
C_h(i)=(1+\alpha_h)L(i)\\
C_r(j)=(1+\alpha_r)L(j)\\
\alpha_h = \alpha_r =0.5\\
C(i) = \frac{k(i)^{\alpha}}{\sum_{j\in V}k(j)^{\alpha}}; k(i): \text{degree of node i}\\
---\\
L_0 = \min_{i\in V}(\frac{R(i)}{U(i)(1+\alpha)})\\
$$

Robustness:

$$
R = \frac{N_{host}^{lcc}}{N_{host}}\\
R = \frac{1}{N}\sum_{Q=1}^{N}s(Q)\\
s(Q) = \text{host count of the connected component with the most host / original host count}
$$

