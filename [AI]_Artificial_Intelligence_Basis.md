

[TOC]



---

# Introduction

- 1956年提出AI的概念





What Is A.I. ?

- The study of computer systems that attempt to model and apply the intelligence of the human mind.
- A branch of computer science dealing with the simulation of intelligent behavior in computers.
- The capability of a machine to imitate intelligent human behavior.



- Strong AI: a machine with a mind in exactly the same sense human beings have minds
- **Weak AI**: a machine with intelligent behavior
- Artificial general intelligence (AGI): a machine with the ability to apply intelligence to any problem
- Narrow AI: AI focused on one narrow task All currently existing AI systems are weak AI at most



## The History of AI

- 1943-70: Early excitement, great expectation
- 1943: Originated,  McCullouch and Pitts’  design  for Turing-complete “artificial neurons”. Formed the structural AI.
- 1950: Turing Test(图灵测试), proposed by A.M. Turing in 1950.
  - A human interrogator asks questions by typing
  - Answers are displayed on a screen.
  - The computer passes the test if the interrogator cannot reliably decide computer / person.
- 1955: Newell & Simon wrote a reasoning program: Logic Theorist,  proved theorems from Principia Mathematica.
- 1956: The field of AI research was born at  workshop at Dartmouth College.
- 1965: Robinson's complete algorithm for logical reasoning(逻辑推导).
- 1970-90s: “Knowledge is power”: knowledge-based:
  - 1974-80: So many difficulties that progress slowed, governments  cut off exploratory research in AI  —— AI “Winter”
  - 1980-87: Expert systems industry booms
- 1987-93: The Fifth-Generation Computer System (Japan) Project failed —— AI’s longer-lasting hiatus.
- 1990- : rise of machine learning ——“AI Spring”
  - “Knowledge” is learnt by computers primarily
  - Supervised learning, classification, regression …
  - Unsupervised learning, association rule learning ,clustering …
  - Deep learning, artificial neural networks
- 2010s : heavy industry investment in deep learning

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/1538243246(1).jpg)



## The Basic Content of AI Research

1. Cognitive modeling 认知模型: Cognitive modeling deals with simulating human problem-solving and mental processing in a computerized model. An important goal of cognitive science is to understand human cognition. 人工神经网络ANN / NN, 增强学习**Reinforcement Learning**, 
2. Knowledge representation(KR, KR^2^, DR&R) 知识表示: the field of artificial intelligence (AI) dedicated to representing information about the world in a form that a computer system can utilize to solve complex tasks such as diagnosing a medical condition or having a dialog in a natural language.
3. Automatic reasoning 自动推理: AI最早的应用。Its products include a large number of inferencing techniques and strategies. It uses deductive reasoning to tackle problems. Such as: Constructing formal mathematical proofs; Verifying that programs meet their specifications; Modelling human reasoning.
4. Machine learning 机器学习: Machine Learning is the science of getting computers to learn and act like humans do, and improve their learning over time in autonomous fashion, by feeding them data and information in the form of observations and real-world interactions. Tom Mitchell(1997): A computer program (vs human) is said to learn from experience E (e.g., labeled data ) with respect to some class of tasks T (e.g., classification) and performance measure P (e.g., precision  & recall ), if its performance at tasks in T, as measured by P, improves with experience E.

Supervised learning 监督学习: Given some example input output pairs , learn a function that maps from input to output.
Unsupervised learning 非监督学习: Final natural classes for examples.

Reinforcement learning 增强学习: determine what to do based on a series of rewards or punishments.



#### Schools of AI

Mainly three schools: 主要是三个流派

| 派别                    | 起源        | 擅长算法                         |
| ----------------------- | ----------- | -------------------------------- |
| Symbolists 符号主义     | 逻辑学 哲学 | Inverse deduction 逆演绎算法     |
| Connectionists 联结主义 | 神经科学    | Backpropagation 反向传播算法(BP) |
| Evolutionaries 进化主义 | 进化生物学  | Genetic programming 基因编程     |
| Bayesians 贝叶斯派      | 统计学      | Probabilistic inference 概率推理 |
| Analogizer 类推比较     | 心理学      | Kernel machines 核机器           |

1. 符号主义: 逻辑运算。专家系统
2. 联结主义: ANN, 深度学习，
3. 行为主义: 强化学习，控制领域(钱学森 工程控制学)，遗传算法。Actionism, also known as Evolutionism or Cybernetics, is an intelligent simulation method of behavior based on "perception-action"(知觉行为, 感知行为).
4. 贝叶斯: 常被前三个流派当作一种工具，邮件过滤。
5. 类推比较: 推荐系统，核心思想：新旧知识间的相似性。Recommender Systems. 

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/AI_bayes_formula.jpg)







遗传算法是解决搜索问题的一种通用算法，对于各种通用问题都可以使用。

搜索算法的共同特征为:

- 首先组成一组候选解
- 依据某些适应性条件测算这些候选解的适应度
- 根据适应度保留某些候选解，放弃其他候选解
- 对保留的候选解进行某些操作，生成新的候选解

在遗传算法中，上述几个特征以一种特殊的方式组合在一起:基于染色体群的并行搜索，带有猜测性质的选择操作、交换操作和突变操作。这种特殊的组合方式将遗传算法与其它搜索算法区别开来。





## 启发式搜索

- Heuristic or informed search exploits additional knowledge about the problem that helps direct search to more promising paths.
- A heuristic function, h(n), provides an estimate of the cost of the path from a given node to the closest goal state. Must be zero if node represents a goal state



### A \* Search Algorithm

> A star Search Algorithm A\*搜尋演算法，A星演算法，A星算法

- 一种在图形平面上，有多个节点的路径，求出最低通过成本的算法。常用于游戏中的NPC的移动计算，或网络游戏的BOT的移动计算上
- 该算法综合了Best-First Search和Dijkstra算法的优点：在进行启发式搜索提高算法效率的同时，可以保证找到一条最优路径（基于评估函数）
- The secret to its success is that it combines the pieces of information that Dijkstra’s Algorithm uses (favoring vertices that are close to the starting point 倾向于选择靠近起始点的点) and information that Greedy Best-First-Search uses (favoring vertices that are close to the goal 倾向于选择靠近目标的点).
- In the standard terminology used when talking about A\*, **g(n)** represents the **exact cost** of the path from the starting point to any vertex n, and **h(n)** represents the **heuristic estimated cost** from vertex `n`to the goal. A\* balances the two as it moves from the starting point to the goal. Each time through the main loop, it examines the vertex n that has the **lowest** `f(n) = g(n) + h(n)`.
- g(n): 起始点到当前点n的实际距离
- h(n): 从当前点n到终点的启发式估计距离
- f(n) = g(n) + h(n) : 主循环每次都选择最低的f(n)



- At one extreme, if `h(n)` is 0, then only `g(n)` plays a role, and A* turns into Dijkstra’s Algorithm, which is guaranteed to find a shortest path.
- If `h(n)` is always lower than (or equal to) the cost of moving from `n` to the goal, then A\* is guaranteed to find a shortest path. The lower `h(n)` is, the more node A\* expands, making it slower. h(n)恒小于等于实际距离时，A\* 可以保证搜索到最短路径，h(n)越小，A\* 扩展的点越多，运算越慢。
- If `h(n)` is exactly equal to the cost of moving from `n` to the goal, then A\* will only follow the best path and never expand anything else, making it very fast. Although you can’t make this happen in all cases, you can make it exact in some special cases. It’s nice to know that given perfect information, A\* will behave perfectly. h(n)恰好等于到终点的实际开销时，A\* 只扩展最佳路径。
- If `h(n)` is sometimes greater than the cost of moving from `n` to the goal, then A* is not guaranteed to find a shortest path, but it can run faster. h(n)有时大于到终点的实际开销时，无法保证搜索到最短路径。
- At the other extreme, if `h(n)` is very high relative to `g(n)`, then only `h(n)`plays a role, and A\* turns into Greedy Best-First-Search.

> Technically, the **A\*** algorithm should be called simply **A** if the heuristic is an underestimate of the actual cost. However, I will continue to call it **A\*** because the implementation is the same and the game programming community does not distinguish **A** from **A\***.



![AStar.gif](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/Astar_progress_animation.gif)
$$
{\displaystyle
{\begin{aligned}
& \text{--------------------------------------------------------------------------------------}\\
& \text{Algorithm: A Star Search Algorithm}\\
& \text{--------------------------------------------------------------------------------------}\\
& \text{input:}\\
& \qquad start\text{ :Start point;}\\
& \qquad goal\text{  :Goal point;}\\
& \text{output:}\\
& \qquad path\text{ :The path from start to goal;}\\
& -----------------------------\\
& closedSet := \emptyset\\
& start.g := 0 \\
& start.h := heuristic(start, goal) \\
& start.f := start.h + start.g\\
& openSet := \{start\}\\
& path := \text{\{empty list\}}\\
& frontier := \{(start, NULL)\}\\
&{\text{While(openSet not empty) do:}}\\

&\qquad cur := \text{the node with min }f \text{ in } openSet\\
&\qquad closedSet := closedSet \cup cur\\
&\qquad openSet := openSet - \{cur\}\\
&\qquad if(cur = goal):\\
&\qquad \qquad \text{Repeat: }\\
&\qquad \qquad \qquad path.push(cur)\\
&\qquad \qquad \qquad cur = frontier[cur]\\
&\qquad \qquad \text{Until}(cur = NULL)\\
&\qquad \qquad \text{return } path.reverse\\
&\qquad \text{for each } v \text{ of }cur.neighbors\\
&\qquad \qquad if(v \in closedSet):\\
&\qquad \qquad \qquad continue\\
&\qquad \qquad gTemp = cur.g + cost(cur, v) \\ 
&\qquad \qquad if(v \notin openSet):\\
&\qquad \qquad \qquad v.g = gTemp\\
&\qquad \qquad \qquad v.h = heuristic(v, goal)\\
&\qquad \qquad \qquad v.f = v.g + v.h\\
&\qquad \qquad \qquad openSet := openSet \cup v\\
&\qquad \qquad \qquad frontier[v] = cur\\
&\qquad \qquad if(v \in openSet \text{ and } v.g > gTemp):\\
&\qquad \qquad \qquad v.g = gTemp\\
&\qquad \qquad \qquad v.f = v.g + v.h\\
&\qquad \qquad \qquad frontier[v] = cur\\
& \text{End While}\\
 \end{aligned}}}
$$




```cpp
function AStar(start,goal){
     closedset := the empty set //已经被估算的节点集合
     openset := set containing the initial node //将要被估算的节点集合，初始只包含start
     came_from := empty map //记录上一个节点
     g_score[start] := 0 //g(n): cost that move to current node
     h_score[start] := heuristic_estimate_of_distance(start, goal)//通过估计函数 估计h(start)
     f_score[start] := h_score[start] //f(n)=h(n)+g(n)，由于g(n)=0，所以省略
     while(openset is not empty){ //当将被估算的节点存在时，执行循环
         x := the node in openset having the lowest f_score[] value //在将被估计的集合中找到f(x)最小的节点
         if(x == goal) //若x为终点，执行返回路径
             return reconstruct_path(came_from, goal) //返回到x的最佳路径
         remove x from openset //将x节点从将被估算的节点中删除
         add x to closedset //将x节点插入已经被估算的节点
         for each y in neighbor_nodes(x) //循环遍历与x相邻节点
             if y in closedset //若y已被估值，跳过
                 continue
             tentative_g_score := g_score[x] + dist_between(x,y) //从起点到节点y的距离
 
             if y not in openset //若y不是将被估算的节点
                 tentative_is_better := true //暂时判断为更好
             elseif tentative_g_score < g_score[y] //如果起点到y的距离小于y的实际距离
                 tentative_is_better := true //暂时判断为更好
             else
                 tentative_is_better := false //否则判断为更差
             if tentative_is_better = true //如果判断为更好
                 came_from[y] := x //将y设为x的子节点
                 g_score[y] := tentative_g_score //更新y到原点的距离
                 h_score[y] := heuristic_estimate_of_distance(y, goal) //估计y到终点的距离
                 f_score[y] := g_score[y] + h_score[y]
                 add y to openset //将y插入将被估算的节点中
    }
    return failure
 }
 function reconstruct_path(came_from,current_node){
     if came_from[current_node] is set
         p = reconstruct_path(came_from,came_from[current_node])
         return (p + current_node)
     else
         return current_node
}
```



https://www.redblobgames.com/pathfinding/a-star/implementation.html#python-astar 上的python实现

```python
def heuristic(a, b):
    (x1, y1) = a
    (x2, y2) = b
    return abs(x1 - x2) + abs(y1 - y2)

def a_star_search(graph, start, goal):
    frontier = PriorityQueue()
    frontier.put(start, 0)
    came_from = {}
    cost_so_far = {}
    came_from[start] = None
    cost_so_far[start] = 0
    
    while not frontier.empty():
        current = frontier.get()

        if current == goal:
            break

        for next in graph.neighbors(current):
            new_cost = cost_so_far[current] + graph.cost(current, next)
            if next not in cost_so_far or new_cost < cost_so_far[next]:
                cost_so_far[next] = new_cost
                priority = new_cost + heuristic(goal, next)
                frontier.put(next, priority)
                came_from[next] = current

    return came_from, cost_so_far
```



#### Heuristics for grid maps 网格图启发法 距离测度

On a grid, there are well-known heuristic functions to use.

**Use the distance heuristic that matches the allowed movement:**

- On a square grid that allows **4 directions** of movement, use Manhattan distance (L1).
- On a square grid that allows **8 directions** of movement, use Diagonal distance (L∞).
- On a square grid that allows **any direction** of movement, you might or might not want Euclidean distance (L2). If A* is finding paths on the grid but you are allowing movement not on the grid, you may want to consider [other representations of the map](https://www.redblobgames.com/pathfinding/grids/algorithms.html).
- On a hexagon grid that allows **6 directions** of movement, use Manhattan distance [adapted to hexagonal grids](https://www.redblobgames.com/grids/hexagons/#distances).





### KNN

K最近邻



#### 距离测度

基本公式:
$$
L_p(x_i, x_j) = (\sum_{l=1}^{n}|x_i^{(l)} - x_j^{(l)}|^p)^\frac{1}{p}
$$
常用距离:

p=1: Manhattan Distance 曼哈顿距离: 各维距离(边长)的加和
$$
L_1(x_i, x_j) = \sum_{l=1}^{n}|x_i^{(l)} - x_j^{(l)}|
$$
p=2: Euclidean Distance 欧式距离: 空间中常用的距离
$$
L_2(x_i, x_j) = (\sum_{l=1}^{n}|x_i^{(l)} - x_j^{(l)}|^2)^\frac{1}{2}
$$
p=无穷: 计算各维距离的最大值
$$
L_{\infin}(x_i, x_j) = \max_{l=1,2,...,n}|x_i^{(l)} - x_j^{(l)}|
$$





## Game





### Game Tree

Game properties:

- Two - players
- Discrete: Game states or decisions can be mapped on discrete values.
- Finite: There are only a finite number of states and possible decisions that can be made.
- Zero-sum(零和): Fully competitive. If one player wins, the other loses an equal amount.一个玩家赢的量等于其他玩家输的总和。 Note that some games don’t have this property.有些博弈并不满足零和条件
- Deterministic(确定性的): no chance involved. no dice(骰子), or random deals of cards, of coin flips(抛硬币), etc.
- Perfect information: all aspects of the state are fully observable(可观测的). e.g., no hidden cards.



- Rock, Paper, Scissors is a simple “one shot”(一次性) game. Single move each. In game theory: a strategic or normal form game(策略或范式博弈)
- Many games extend over multiple moves. Turn-taking: players act alternatively. e.g., chess, checkers, etc. In game theory: extensive form games(扩展形式博弈)
- We’ll focus on the extensive form. That’s where the computational questions emerge(浮现 暴露).

#### Two-Player Zero-Sum Game

**Minimax** (sometimes **MinMax** or **MM**) is a decision rule used in **artificial intelligence**, decision theory, **game theory**, statistics and philosophy for **minimizing the possible loss for a worst case (*max*imum loss) scenario**.最小化在最差情景下的可能损失，从对手给我选择的最差（min）局面中选出最好（max）的一个。 When dealing with gains, it is referred to as "maximin"—**to maximize the minimum gain**.对于收益，指的是最大化最小收益。 Originally formulated for **two-player zero-sum game theory**, covering both the cases where players take alternate moves and those where they make simultaneous(同时发生) moves, it has also been extended to more complex games and to general decision-making in the presence of uncertainty.

Definition:

- Two players **A (Max)** and **B (Min)**. 
- Set of **states S** (a finite set of states of the game)
- An **initial state** I ∈ S (where game begins)
- **Terminal positions** T ⊆ S (Terminal states of the game: states where the game is over)
- **Successors** 接班人 后续状态(or Succs) – a function that takes a state as input and returns a set of possible next states to whomever is due to move. 以一个状态为输入，输出所有可能的下一个状态的函数
- **Utility** (效益) or payoff (收益) function V : T → R. (a mapping from terminal states to real numbers that show how good is each terminal state for player A and bad for player B.) 

Intuition:

- Players alternate moves (starting with A, or Max). Game ends when some terminal t ∊ T is reached
- A game **state** 游戏状态: a state-player pair. (状态,玩家)对 Tells us what state we’re in and whose move it is. 描述状态和哪个玩家来下(哪个玩家准备来改变状态)。
- Utility function(效益函数, 收益函数) and terminals replace goals.
  A, or **Max**, wants to maximize the terminal payoff 
  B, or **Min**, wants to minimize the terminal payoff 
- Think of it as: A, or Max, gets V(t) and B, or Min, gets –V(t) for terminal node t. This is why it’s called zero (or constant) sum.

The **minimax value** of a player is the smallest value that the other players can force the player to receive, without knowing the player's actions; equivalently, it is the largest value the player can be sure to get when they *know* the actions of the other players.

demo: Nim: informal description: We begin with a number of piles of matches. In one’s turn one may remove any number of matches from one pile.每一轮玩家可以移除一堆中的任意数量个火柴。 The last person to remove a match loses.最后一个移除火柴的人输掉比较。

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/1540482033(1).jpg)

In zero-sum games, the minimax solution is the same as the Nash equilibrium. 零和游戏中，minimax结果和纳什均衡的结果一样



### The MiniMax Strategy

The **maximin value** of a player is the highest value that the player can be sure to get without knowing the actions of the other players; equivalently, it is the lowest value the other players can force the player to receive when they know the player's action. Its formal definition is:
$$
\underline {v_{i}}=\max _{a_{i}}\min_{a_{-i}}{v_{i}(a_{i}, a_{-i})}
$$




- Assume that the other player will always play their best move.假设其他玩家一直都选择最佳的。 you always play a move that will minimize the payoff that could be gained by the other player.自己只选择最小化对手收益，最大化自身收益的选择。 By minimizing the other player’s payoff, you maximize your own.
- Note that if you know that min will play poorly in some circumstances, there might be a better strategy than MiniMax (i.e., a strategy that gives you a better payoff). 注意，如果你知道min在某些状态下会玩的很差，将可能有一个比MiniMax更好的策略。



- Build **full game tree** (all leaves are terminals). Root is start state, edges are possible moves, etc. Label terminal nodes with utilites.

- Back values up the tree. 对Game Tree回溯赋值

  U(t) is defined for all terminals (part of input)
  **U(n) = min {U(c) : c is a child of n}** if n is a **Min** node. Min node: Min来下的节点
  **U(n) = max {U(c) : c is a child of n}** if n is a **Max** node. Max node: Max 来下的节点

- The values labeling each state are the values that Max will achieve in that state if both Max and Min play their best moves. 每个状态标记的值是Max在Max和Min都进行最佳选择时的收益。
  Max plays a move to change the state to the highest valued min child.
  Min plays a move to change the state to the lowest valued max.

- If Min plays poorly, Max could do better, but never worse.
  If Max, however knows that Min will play poorly, there might be a strategy of play for Max than MiniMax.

MiniMax will expand O(b^d^) states, which is both a BEST and WORST case scenario.



### Alpha Beta Pruning

> Alpha Beta剪枝

**Alpha-beta剪枝**是一种搜索算法，用以减少极小化极大算法（Minimax算法）搜索树的节点数。这是一种对抗性搜索算法，主要应用于机器游玩的二人游戏(e.g.井字棋、象棋、围棋)。当算法评估出某策略的后续走法比之前策略的还差时，就会停止计算该策略的后续发展。该算法和极小化极大算法所得结论相同，但剪去了不影响最终决定的分枝

It is not necessary to examine entire tree to make correct MiniMax decision 

Assumption: After generating value for only some of n’s children we can prove that we’ll never reach n in a MiniMax strategy. So we needn’t generate or evaluate any further children of n.


- Two types of pruning (cuts): 
- 1. pruning of max nodes (α-cuts). 在Max准备下的节点剪枝
  2. pruning of min nodes (β-cuts). 在Min准备下的节点剪枝



每一个节点都会由 alpha 和 beta 两个值来确定一个范围 [alpha, beta]，alpha 值代表的是下界，beta 代表的是上界。每搜索一个子节点，都会按规则对范围进行修正。Max 节点可以修改 alpha 值，min 节点修改 beta 值。

如果出现了 beta <= alpha 的情况，则不用搜索更多的子树了，未搜索的这部分子树将被忽略，这个操作就被称作**剪枝（pruning）**



#### Cutting Max Nodes (Alpha Cuts)

At a Max node n: (方形表示Max node, 圆形表示Min node)

- Let β be the lowest value of n’s siblings examined so far (siblings to the left of n that have already been searched). β设为节点n的兄弟节点的目前为止的最低值
- Let α be the highest value of n’s children examined so far (changes as children examined). α设为n的子节点的最高值。
- While at a Max node n, if α becomes ≥ β we can stop expanding the children of n. 在Max node时，搜索过程中当α  ≥ β时停止展开n的子节点。Min will never choose to move from n’s parent to n since it would choose one of n’s lower valued siblings first. Min不会从n的父节点移动到n，因为相比n，n有兄弟节点的取值小于等于移动到n后，Max的最佳取值(即移动到n后Min的收益)。

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/1540489095(1).jpg)



#### Cutting Min Nodes (Beta Cuts)

At a Min node n:

- Let α be the highest value of n’s sibling’s examined so far (fixed when evaluating n)
- Let β be the lowest value of n’s children examined so far (changes as children examined) 
- If β becomes ≤ α we can stop expanding the children of n. Max will never choose to move from n’s parent to n since it would choose one of n’s higher value siblings first.
- In general, at a Min node n, if β becomes ≤ α value of an ancestor Max node, then we can stop expanding n. 在Min节点n，如果β ≤ 祖先节点(Max node)的α，则停止展开n，因为在祖先节点处，Max会选择最高的子树(例如图中的7)，而不会选择β=3的当前节点n。

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/AI_Alpha_Beta_Cut_GameTree.png)



## Constraint Satisfaction Problems

> 约束满足问题 约束补偿问题 

CSPs是人工智能和运筹学 的热门主题,因为它们公式中的规律，提供了共同基础来分析、解决很多看似不相关的问题。 CSPs通常呈现高复杂性, 需要同时透过启发式搜索 和 联合搜索 的方法，来在合理的时间内解决问题。 布尔可满足性问题 (SAT), 可满足性的理论 (SMT)和回答集程序设计 (ASP) 可以算是某种程度上的约束满足问题



# Uncertain Knowledge and Reasoning

> 不确定知识与推理

By weighing likelihoods(可能性) of events (probabilities), we can develop mechanisms(机制) for acting rationally(理性地) under uncertainty. 

> Density(of B): pick an element at random from the entire set. How likely is it that picked element is in the set B?

conditional independence: In probability theory, two events A and B are **conditionally independent** given a third event Y precisely if the occurrence of A and the occurrence of B are independent events in their conditional probability distribution given Y.



### Expectation-Maximization Algorithm

> 最大期望算法 Expectation-maximization algorithm 期望最大化算法

- 在统计计算中，**最大期望(EM)算法**是在概率模型中寻找参数最大似然估计或者最大后验估计的算法，其中概率模型依赖于无法观测的隐性变量
- EM是一个在已知部分相关变量的情况下，估计未知变量的迭代技术

1. 随即给出模型参数的估计，初始化分布参数
2. loop直到收敛:
   1. E step: 根据隐含数据的假设值，给出当前的参数的极大似然估计
   2. M step: 重新给出未知变量的期望估计。应用于缺失值



1. 给出模型参数假设，初始化概率分布的参数
2. loop: 直到模型参数可以认为不变，或者达到设定的最大迭代次数
   1. E: 根据当前参数，计算出隐变量的概率分布
   2. M: 根据隐变量的概率分布，计算模型参数的期望估计，替换原本的模型参数

# Machine Learning

机器学习的主要方法:

1. 监督学习 supervised learning: 有数据和标签
2. 非监督学习 unsupervised learning: 只有数据，没有标签
3. 半监督学习 : 结合监督学习和非监督学习
4. 强化学习 reinforcement learning: 从经验中总结强化提升
5. 遗传算法 genetic algorithm: 





##### ROC & AUC

> ROC曲线：**接收者操作特征曲线**  **receiver operating characteristic curve** 
>
> AUC: **Area Under Curve** **ROC曲线下的面积**

ROC分析的是二元分类模型，即输出结果只有两种类别的模型。

ROC空间将伪阳性率（FPR）定义为 *X* 轴，真阳性率（TPR）定义为 *Y* 轴。一系列的(fp rate, tp rate)或者写成(FPR, TPR)，为二维笛卡尔坐标系中的坐标点

将**同一模型每个阈值** 的 (FPR, TPR) 座标都画在ROC空间里，就成为**特定模型的ROC曲线** 

- **当阈值设定为最高时，必得出ROC座标系左下角的点 (0, 0)**，没有样本被预测为阳性
- **当阈值设定为最低时，必得出ROC座标系右上角的点 (1, 1)** ，没有样本被预测为阴性
- **随着阈值调低，ROC点** 往右上（或右／或上）移动，或不动；但**绝不会往左下(或左／或下)移动**



AUC（确切的说，应该是AUROC）被定义为**ROC曲线下的面积**，显然这个面积的数值不会大于1。**AUC值越大的分类器，正确率越高** 







### Cluster Analysis 

> 聚类分析, 群集分析

- 把相似的对象通过**静态分类**的方法分成不同的组别或者更多的**子集**（subset），这样让在同一个子集中的成员对象都有相似的一些属性
- 一般把数据聚类归纳为一种**非监督式学习** 



常用的几个距离计算方法：

- 欧式距离（2-norm距离）
- 曼哈顿距离（Manhattan distance, 1-norm距离）
- infinity norm
- 马氏距离
- 余弦相似性
- 汉明距离





---

# Neural Networks and Deep Learning









## AutoEncoder

> 自编码机 自动编码器 在无监督学习中用于有效编码 

- 一种数据压缩算法，其中数据的压缩和解压缩函数是数据相关的，有损的，从样本中自动学习的。
- An **autoencoder** is a type of artificial neural network used to learn efficient data codings in an unsupervised manner.
- 在大部分提到自编码机的场合，压缩和解压缩的函数都是通过神经网络实现的。
- 自编码的目的是对一组数据学习出一种表示（也称表征，编码），通常用于降维



1. Encoder: 将大数据集压缩成小的数据集
2. Decoder: 将压缩后的小的数据集还原成大的数据集

### Undercomplete Autoencoder

> 欠完备自编码机

从自编码器获得有用特征的一种方法是限制 h的维度比 x 小，这种编码维度小于输入维度的自编码器称为欠完备（undercomplete）自编码器。学习欠完备的表示将强制自编码器捕捉训练数据中最显著的特征。

### Sparse Autoencoder

> 稀疏自编码机





### Denoising Autoencoder

> 去噪自编码机



### Variational Autoencoder

> 变分自编码机



------

# PyTorch

> Python的深度学习框架

以前是Lua语言下的模块Torch，2016被移植到Python上，可以和Tensor flow一拼高下



```python
import torch
import numpy as np

np_data = np.arange(6).reshape((2, 3))
torch_data = torch.from_numpy(np_data)
tensor2array = torch_data.numpy()
print(
    '\nnumpy array:', np_data, # [[0 1 2], [3 4 5]]
    '\ntorch tensor:', torch_data, #  0  1  2 \n 3  4  5[torch.LongTensor of size 2x3]
    '\ntensor to array:', tensor2array,# [[0 1 2], [3 4 5]]
)
```



#### Variable

在 Torch 中的 Variable 就是一个存放会变化的值的地理位置. 里面的值会不停的变化.

```python
import torch
from torch.autograd import Variable # torch 中 Variable 模块

# 先生鸡蛋
tensor = torch.FloatTensor([[1,2],[3,4]])
# 把鸡蛋放到篮子里, requires_grad是参不参与误差反向传播, 要不要计算梯度
variable = Variable(tensor, requires_grad=True)# requires_grad: need gradient or not

print(tensor)
"""
 1  2
 3  4
[torch.FloatTensor of size 2x2]
"""

print(variable)
"""
Variable containing:
 1  2
 3  4
[torch.FloatTensor of size 2x2]
"""
t_out = torch.mean(tensor*tensor)       # x^2
v_out = torch.mean(variable*variable)   # x^2
print(t_out)
print(v_out)    # 7.5
v_out.backward()    # 模拟 v_out 的误差反向传递

# v_out = 1/4 * sum(variable*variable) 这是计算图中的 v_out 计算步骤
# 针对于 v_out 的梯度就是, d(v_out)/d(variable) = 1/4*2*variable = variable/2 求偏导的结果

print(variable.grad)    # 初始 Variable 的梯度
'''
 0.5000  1.0000
 1.5000  2.0000
'''


print(variable)     #  Variable 形式
"""
Variable containing:
 1  2
 3  4
[torch.FloatTensor of size 2x2]
"""

print(variable.data)    # tensor 形式
"""
 1  2
 3  4
[torch.FloatTensor of size 2x2]
"""

print(variable.data.numpy()) # numpy 形式。注意需要先索引到data后才是tensor形式
"""
[[ 1.  2.]
 [ 3.  4.]]
"""
```





#### Activation Function

```python
import torch #relu sigmoid tanh可以直接在这使用
import torch.nn.functional as F     # 激励函数都在这
from torch.autograd import Variable
import matplotlib.pyplot as plt

# 做一些假数据来观看图像 # Fake data
x = torch.linspace(-5, 5, 200)  # x data (tensor), shape=(100, 1)
x = Variable(x)
x_np = x.data.numpy()   # 换成 numpy array, 出图时用

# 几种常用的 激励函数
y_relu = torch.relu(x).data.numpy() #relu直接在torch中
y_sigmoid = torch.sigmoid(x).data.numpy()
y_tanh = torch.tanh(x).data.numpy()
y_softplus = F.softplus(x).data.numpy()
# y_softmax = F.softmax(x)  softmax 比较特殊, 不能直接显示, 不过他是关于概率的, 用于分类

### 可视化
plt.figure(1, figsize=(8, 6))
plt.subplot(221)
plt.plot(x_np, y_relu, c='red', label='relu')
plt.ylim((-1, 5))
plt.legend(loc='best')

plt.subplot(222)
plt.plot(x_np, y_sigmoid, c='red', label='sigmoid')
plt.ylim((-0.2, 1.2))
plt.legend(loc='best')

plt.subplot(223)
plt.plot(x_np, y_tanh, c='red', label='tanh')
plt.ylim((-1.2, 1.2))
plt.legend(loc='best')

plt.subplot(224)
plt.plot(x_np, y_softplus, c='red', label='softplus')
plt.ylim((-0.2, 6))
plt.legend(loc='best')

plt.show()
```





#### Build NN

```python
torch.optim #包含很多optimizer #e.g. SGD, Adom
```





### Study Case



#### AutoEncoder

```python
# -*- coding: utf-8 -*-
# author: 黄海宇 student id: 16337087  email:hyhuang1024@outlook.com
# 将MNIST数据集读入后，训练自编码机，并且用自编码机编码后的数据训练分类器，对预测集数据做预测
import os
import time
import struct
import numpy as np
import matplotlib.pyplot as plt
import torch
import torch.nn as nn
import torch.utils.data as Data
from torch.autograd import Variable
from sklearn.neighbors import KNeighborsClassifier

# 超参数 parameter
EPOCH = 10 #对数据整体训练的次数
BATCH_SIZE = 128 #批训练的大小
LEARNING_RATE = 0.002

path = './mnist'

def load_mnist(path, kind='train'):
    # Load MNIST data from `path`
    labels_path = os.path.join(path, '%s-labels-idx1-ubyte' % kind)
    images_path = os.path.join(path, '%s-images-idx3-ubyte' % kind)
    with open(labels_path, 'rb') as lbpath:
        magic, n = struct.unpack('>II', lbpath.read(8))
        labels = np.fromfile(lbpath, dtype=np.uint8)

    with open(images_path, 'rb') as imgpath:
        magic, num, rows, cols = struct.unpack('>IIII', imgpath.read(16))
        images = np.fromfile(imgpath, dtype=np.uint8).reshape(len(labels), 784)

    return images, labels  # images: n x m: n:样本数量; m: 784=28*28

# 自编码机
class AutoEncoder(nn.Module):  # 继承自torch.nn.Module
    #定义所有的层属性
    def __init__(self):  # 该行和下一行是官方步骤
        super(AutoEncoder, self).__init__()  # 继承AutoEncoder到self: Module

        # 压缩 encoder
        self.encoder = nn.Sequential( #Sequential: 一层一层的神经层搭建,快速搭建
            nn.Linear(28*28, 196), #para1: 输入的神经元数量; para2: 输出的神经元的数量
            nn.ReLU(), #激励层
            nn.Linear(196, 64),
            nn.ReLU(),
            nn.Linear(64, 16),
            nn.ReLU(),
            nn.Linear(16, 8),
        )
        # 解压 decoder
        self.decoder = nn.Sequential(
            nn.Linear(8, 16),
            nn.ReLU(),
            nn.Linear(16, 64),
            nn.ReLU(),
            nn.Linear(64, 196),
            nn.ReLU(),
            nn.Linear(196, 28*28),
            nn.Sigmoid(),# 该激励函数使得输出值在[0,1]
        )

    # 前向传递的过程 #一层层搭建层与层的关系链接
    def forward(self, x):  # x:输入信息,data
        encoded = self.encoder(x)
        decoded = self.decoder(encoded)
        return encoded, decoded


if __name__ == '__main__':
    X_train, y_train = load_mnist(path)

    ### 动态显示过程，显示数据集中第一个出现的0,1,2,...,9
    fig, ax = plt.subplots( nrows=2, ncols=10, sharex=True, sharey=True, figsize=(6, 2))
    idx_l = [np.where(y_train==i)[0][0] for i in range(10)] # 0,1,2,...,9第一次出现的坐标
    # print(idx_l, len(idx_l))
    ax = ax.flatten()
    for i in range(10):
        img = X_train[idx_l[i]].reshape(28, 28)
        ax[i].imshow(img, cmap='Greys', interpolation='nearest')
        ax[10+i].imshow(img, cmap='Greys', interpolation='nearest')
    ax[0].set_xticks([]);ax[0].set_yticks([])
    plt.tight_layout()
    plt.ion()#打开互动模式，就是边显示边修改
    plt.draw(); plt.pause(0.05)
    #####################

    X_train = X_train.astype(np.float32) /255 # to float, to [0,1]
    X_train, y_train = torch.from_numpy(X_train), torch.from_numpy(y_train)# to tensor
    print('X_train:', type(X_train), X_train.shape, 'y_train:', type(y_train))

    autoencoder = AutoEncoder() # 创建自编码机
    gpuFLAG = torch.cuda.is_available() # True: use cuda; False: cuda NOT used.
    # gpuFLAG = False
    if(gpuFLAG):
        autoencoder = autoencoder.cuda()
        X_train = X_train.cuda()
        y_train = y_train.cuda()
    print('AutoEncoder structure:', autoencoder)
    # 优化器优化神经网络的参数 #1st para: 需要优化的参数; lr: learning rate, 学习速率
    optimizer = torch.optim.Adam(autoencoder.parameters(), lr=LEARNING_RATE)
    # 误差计算函数，Loss Function #MSELoss：Mean Square Error 均方差
    loss_func = nn.MSELoss()

    train_data = Data.TensorDataset(X_train, y_train)
    # print('train_data:', type(train_data))
    train_loader = Data.DataLoader(dataset=train_data, batch_size=BATCH_SIZE, shuffle=True)

    t = time.process_time()

    # epoch: 对数据整体训练的次数
    for epoch in range(EPOCH):
        for step, (x, batch_label) in enumerate(train_loader):
            batch_x = x.view(-1, 28*28)#转换数据的维度
            batch_y = x.view(-1, 28*28)
            encoded, decoded = autoencoder(batch_x)  # 往autoencoder中放入输入信息

            loss = loss_func(decoded, batch_y)  # 损失函数计算，均方误差
            optimizer.zero_grad()  # 将所有参数的梯度都清空0 #否则保存的梯度会是上一次的梯度
            loss.backward() # 反向传递，计算出梯度
            optimizer.step() # 以给定的学习速率，反向传递计算出来的梯度，优化参数
            if(step % BATCH_SIZE == 0):
                if(gpuFLAG):
                    loss = loss.cpu()
                print('[Training] epoch:',epoch,', loss:', loss.data.numpy())

                for i in range(10): # 动态更新显示的0~9, 显示解码后的显示效果
                    _, decoded_data = autoencoder(X_train[idx_l[i]])
                    if(gpuFLAG):
                        decoded_data = decoded_data.cpu()
                    ax[10+i].clear()
                    ax[10+i].imshow(np.reshape(decoded_data.data.numpy(), [28,28]), cmap='Greys')
                    ax[10+i].set_xticks([]); ax[10+i].set_yticks([])
                plt.draw();plt.pause(0.1)
    print('[Train End] AutoEncoder train success! Train Time Used:', time.process_time()-t)
    for i in range(10):
        _, decoded_data = autoencoder(X_train[idx_l[i]])
        if(gpuFLAG):
            decoded_data = decoded_data.cpu()
        ax[10+i].clear()
        ax[10+i].imshow(np.reshape(decoded_data.data.numpy(), [28,28]), cmap='Greys')
        ax[10+i].set_xticks([]); ax[10+i].set_yticks([])
    plt.draw();plt.pause(0.1)
    plt.ioff()
    plt.show()

    # 分类过程 # 训练 training
    encodedX, _ = autoencoder(X_train)#对训练集进行编码
    if(gpuFLAG):
        encodedX = encodedX.cpu()
        y_train = y_train.cpu()
    x_train = encodedX.data.numpy() # to numpy array
    y_train = y_train.data.numpy()
    knn = KNeighborsClassifier() #创建训练器
    knn.fit(x_train, y_train) #训练分类器

    # 测试过程
    X_test, y_test = load_mnist(path,'t10k') # load: 测试集与测试标签
    X_test = torch.from_numpy(X_test.astype(np.float32) /255)
    if(gpuFLAG):
        X_test = X_test.cuda()
    encodedX, _ = autoencoder(X_test)#对测试集进行编码
    if(gpuFLAG):
        encodedX = encodedX.cpu()
    X_test = encodedX.data.numpy()
    #用测试集数据进行预测 #(测试集输入, 测试集输出)进行评分，输出准确度
    print('Prediction Accuracy:' ,knn.score(X_test, y_test))
```

