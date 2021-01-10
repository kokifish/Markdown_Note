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
- 1956: The field of AI research was born at  workshop at Dartmouth College. 达特茅斯会议
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

1. 符号主义: 逻辑主义，心理学派或计算机学派。逻辑运算。专家系统。功能模拟方法。
2. 联结主义: 仿生学派，心理学派。源于仿生学，特别是人脑的研究。ANN, 深度学习。结构模拟方法。
3. 行为主义: 进化主义，控制论学派。认为智能取决于感知和行动。强化学习，控制领域(钱学森 工程控制学)，遗传算法。Actionism, also known as Evolutionism or Cybernetics, is an intelligent simulation method of behavior based on "perception-action"(知觉行为, 感知行为). 行为模拟方法。
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





## Heuristic Search 启发式搜索

- Heuristic or informed search exploits additional knowledge about the problem that helps direct search to more promising paths.
- A heuristic function, h(n), provides an estimate of the cost of the path from a given node to the closest goal state. Must be zero if node represents a goal state



### A \* Search Algorithm

> A star Search Algorithm A\*搜尋演算法，A星演算法，A星算法

- 一种在图形平面上，有多个节点的路径，求出最低通过成本的算法。常用于游戏中的NPC的移动计算，或网络游戏的BOT的移动计算上
- 该算法综合了Best-First Search和Dijkstra算法的优点：在进行启发式搜索提高算法效率的同时，可以保证找到一条最优路径（基于评估函数）
- The secret to its success is that it combines the pieces of information that Dijkstra’s Algorithm uses (favoring vertices that are close to the starting point 倾向于选择靠近起始点的点) and information that Greedy Best-First-Search uses (favoring vertices that are close to the goal 倾向于选择靠近目标的点).
- In the standard terminology used when talking about A\*, **g(n)** represents the **exact cost** of the path from the starting point to any vertex n, and **h(n)** represents the **heuristic estimated cost** from vertex `n`to the goal. A\* balances the two as it moves from the starting point to the goal. Each time through the main loop, it examines the vertex n that has the **lowest** `f(n) = g(n) + h(n)`.
- g(n): **起始点**到当前点n的实际距离
- h(n): 从当前点n到**终点**的启发式估计距离
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

> K最近邻



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
p=2: Euclidean Distance 欧式距离: 空间中常用的距离 2-norm距离
$$
L_2(x_i, x_j) = (\sum_{l=1}^{n}|x_i^{(l)} - x_j^{(l)}|^2)^\frac{1}{2}
$$
p=无穷: 计算各维距离的最大值
$$
L_{\infin}(x_i, x_j) = \max_{l=1,2,...,n}|x_i^{(l)} - x_j^{(l)}|
$$





## Game

> 博弈



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



- 完整赋值: 每个变量都已赋值
- solution 解: CSP问题的解是相容的、完整的赋值
- generalized arc constraints 通用弧相容, 超弧相容: 将弧相容扩展到n元，不仅限于二元

We do not care about the sequence of moves needed to get to a goal state. We only care about finding a setting of the variables that satisfies the goal. 过程不重要，只看解



Thus CSPs can be solved by a specialized version of depth first search.

- We can build up to a solution by searching through the space of partial assignments. 
- Order in which we assign the variables does not matter --eventually they all have to be assigned. 
- If during the process of building up a solution we falsify a constraint, we can immediately reject all possible ways of extending the current partial assignment. 



### Forward Checking

- 一旦一个变量X被赋值，前向检查就检查每个通过约束与X相关的未赋值变量Y，将Y的值域中与X的赋值不相容的取值删去。
- Whenever a variable X is assigned, the forward-checking process establishes arc consistency for it: for each unassigned variable Y that is connected to X by a constraint, delete from Y′ s
  domain any value that is inconsistent with the value chosen for X. 





### Generalized Arc Consistency 

> GAC

A CSP is generalized arc consistent iff all of its constraints are generalized arc consistent.

```python
GAC(Level) #Maintain GAC Algorithm
    If all variables are assigned: #所有变量都被赋值
        PRINT Value of each Variable
        return or exit (return for more solutions, exit for only one solution)#返回或输出
    V := PickAnUnassignedVariable() #选择一个未赋值变量 V
    Assigned[V] := TRUE #标记该变量已经被赋值
    for d := each member of CurDom(V):#便利该变量的当前值域
        Value[V] := d #对V赋值
        Prune all values of V ≠ d from CurDom[V] #将当前值域的其他值剪枝
        for each constraint C whose scope contains V: #遍历包含V的约束C
            Put C on GACQueue#将C添加到 GACQueue
        if(GAC_Enforce() != DWO): #调用函数，会传入参数GACQueue
            GAC(Level+1) #all constraints were ok
        RestoreAllValuesPrunedFromCurDoms()#恢复之前被剪枝的值
    Assigned[V] := FALSE
    return
```

```python
GAC_Enforce()#GAC-Queue contains all constraints one of whose variables has had its domain reduced. At the root of the search tree. first we run GAC_Enforce with all constraints on GAC-Queue
	while GACQueue not empty:
    	C = GACQueue.extract()
        for V := each member of scope(C): #遍历C的域
            for d in CurDom[V]
                Find an assignment A for all other variables in scope(C) such that C(A U {V=d}) = True
                if A not found:
                    CurDom[V] = CurDom[V] – d
                    if CurDom[V] = empty set
                    	empty GACQueue
                        return DWO #return immediately
                    else:
                        push all constraints C’ such that V \in scope(C’) and C’ \notin GACQueue on to GACQueue
	return TRUE #while loop exited without DWO
```













---

# Uncertain Knowledge and Reasoning

> 不确定知识与推理

By weighing likelihoods(可能性) of events (probabilities), we can develop mechanisms(机制) for acting rationally(理性地) under uncertainty. 

## Bayesain Networks





> Density(of B): pick an element at random from the entire set. How likely is it that picked element is in the set B?

条件独立 conditional independence: In probability theory, two events A and B are **conditionally independent** given a third event Y precisely if the occurrence of A and the occurrence of B are independent events in their conditional probability distribution given Y.



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



### Machine Learning Map

![](<https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/AI_Machine_Learning_map.png>)



##### ROC & AUC

> ROC曲线：**接收者操作特征曲线**  **receiver operating characteristic curve** 
>
> AUC: **Area Under Curve** **ROC曲线下的面积**

ROC分析的是二元分类模型，即输出结果只有两种类别的模型。

ROC空间将伪阳性率（FPR）定义为 *X* 轴，真阳性率（TPR）定义为 *Y* 轴。一系列的(fp rate, tp rate)或者写成(FPR, TPR)，为二维笛卡尔坐标系中的坐标点

将**同一模型每个阈值** 的 (FPR, TPR) 座标都画在ROC空间里，就成为**特定模型的ROC曲线** 

- **当阈值设定为最高时，必得出ROC座标系左下角的点 (0, 0)**，没有样本被预测为阳性
- **当阈值设定为最低时，必得出ROC座标系右上角的点 (1, 1)** ，没有样本被预测为阴性
- **随着阈值调低，ROC点** 往右上（或右／或上）移动，或不动；但**绝不会往左下(或左／或下)移动**



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

> 神经网络与深度学习
>
> 神经网络 是人工神经网络ANN(Artificial Neural Networks)的简称

- A neural network is a nonlinear large-scale adaptive dynamic system composed of a large number of processing units.神经网络是由大量处理单元组成的大规模非线性自适应动态系统. It is based on the results of modern neuroscience research. It attempts to design a new machine to simulate the information processing ability of the human brain by simulating the brain neural network processing and memorizing information. At the same time, the study of this neural network will further deepen the understanding of thinking and intelligence.

In 1986, Rumellhart, McClelland and Hinton Propose: Parallel and Distributed Processing

PDP Model: Parallel Distributed Processing Model



### **B**ack **P**ropagation

> 反向传播算法

1. Feed-forward computation 
2. Backpropagation to the output layer 
3. Backpropagation to the hidden layer 
4. Weight updates



### Activation Function

- Nonlinear: Stronger fitting ability. 更强的拟合能力
- Differentiability: Error Back Propagation. 误差反向传导
- Monotonic: Convex function. 凸面的函数
- $$f(x) \approx x$$: Efficient training
- Range of outputs: Limited: Stable; Unlimited: Efficient.



##### Sigmoid

$$
\sigma(x) = \frac{1}{1+e^{-x}}
$$



##### tanh

$$
\tanh(x)
$$



##### ReLU

- 原始的ReLU是小于0的为0，大于零的不改变原始值

$$
\max(0,x)
$$

- Leaky ReLU

$$
\max(0.1x, x)
$$

##### Maxout

$$
\max(w_{1}^{T}x + b_{1}, w_{2}^{T}x+b_{2})
$$

##### Softmax

- 接受n维向量，输出一个概率分布，值越小的，概率越小，值越大概率越大，输出的向量为n维，各元素之和为1

$$
\mathbf{Softmax}(x_i) = \frac{\exp(x_i)}{\sum_{j}\exp(x_j)}
$$

- LogSoftmax: 在Softmax基础上取log。输出值全为负值。log_softmax essential does log(softmax(x)), but the practical implementation is different and more efficient while doing the same operation. 实际实现不同且更高效。

$$
\mathbf{LogSoftmax}(x_i)=\log(\frac{\exp{(x_i)}}{\sum_{j}\exp{(x_j)}})
$$



### Optimizer

> 优化器 训练优化器

#### SGD

> Stochastic gradient descent 随机梯度下降 incremental gradient descent 增量梯度下降

- 非常基础的优化器

## Perceptron

> 感知机 感知器

### Single Layer Perceptron

> 单层感知机

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/Single%20Layer%20Perceptron%20formula.png)





## AutoEncoder

> 自编码机 自动编码器 在无监督学习中用于有效编码 

- 一种数据压缩算法，其中数据的压缩和解压缩函数是数据相关的，有损的，从样本中自动学习的。跟数据相关程度很高，意味着训练出来的自编码机只能压缩与训练数据相似的数据集
- An **autoencoder** is a type of artificial neural network used to learn efficient data codings in an unsupervised manner.
- 在大部分提到自编码机的场合，压缩和解压缩的函数都是通过神经网络实现的。
- 自编码的目的是对一组数据学习出一种表示（也称表征，编码），通常用于降维



1. Encoder: 将大数据集压缩成小的数据集
2. Decoder: 将压缩后的小的数据集还原成大的数据集

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/AI_AutoEncoder_general.png)



### Undercomplete Autoencoder

> 欠完备自编码机

从自编码器获得有用特征的一种方法是限制 h的维度比 x 小，这种编码维度小于输入维度的自编码器称为欠完备（undercomplete）自编码器。学习欠完备的表示将强制自编码器捕捉训练数据中最显著的特征。

输入为D维，编码后为K维

- Undercomplete: K < D ( “bottleneck”)
- Related to PCA





### Sparse Autoencoder

> 稀疏自编码机

可以有大量的隐藏层单元，但仅有一小部分会被激活。

allow large number of hidden units, but only a small number of hidden units are allowed to active at the same time.

- 稀疏性参数 sparsity parameter : rho, typically a small value close to zero (ρ=0.05).

当前真实稀疏性与稀疏性参数之间使用KL散度，加入到惩罚中。



### Denoising Autoencoder

> 去噪自编码机 降噪自编码机

Motivation: representation should be robust to introduction of noise

在样本x上添加随机高斯噪声，

A denoising autoencoder is trained to map a corrupted input $$\tilde x$$ back to original input x. 去噪自编码机训练来将损坏了的x映射到原本的x上。



### Variational Autoencoder

> VAE 变分自编码机; Variational [adj.] 变化的；因变化而产生的；[生物] 变异的
>
> Vanilla n. 香子兰，香草 adj. 香草味的
>

- Vanilla Autoencoders are not suitable for generative models, they attempt to “replicate”  input rather than generate a new one.
- Variational Autoencoder provides a **probabilistic** manner for describing an input(image) in latent space(隐空间).



## Convolutional Neural Network 

> CNN 卷积神经网络





### convolution

1. input: 接受输入h @ m x n (通道数为h, 图片长宽为m n)
2. (Optional)padding: 对图像进行边缘padding, 各边都增加padding个像素. m += 2 x padding; n += 2 x padding. 
3. 卷积核卷积: 每个卷积核对每一个channel进行卷积。每个卷积核输出一个h @ l x c的图(result)。l = (m-k)/stride + 1; c = (n-k)/stride + 1.
4. feature map: 对于每个卷积核卷积出来的result, 将每一个channel(共h个channel)对应坐标的值相加。Size变化: h@ l x c → l x c. 此时立方体形的result被压成二维的feature map矩形，若有h’个卷积核，则最终输出的图像形状为 h’ @ l x c

卷积过程中，输入层有多少个通道channels，滤波器(卷积核)就要有多少个通道，但是滤波器的数量是任意的，滤波器的数量决定了卷积后 feature map 的通道数





### Lenet 5

- LeNet-5是用于手写字体的识别的一个经典CNN

详解请参照: https://blog.csdn.net/d5224/article/details/68928083

1. C1: 6个特征卷积核，卷积核大小选择5x5，得到6个特征图，每个特征图大小为32-5+1=28, 即神经元的个数为6@28x28=784
2. S2: Max Subsampling. 最大池化下采样，池化kernel size=2x2，输出为6@14x14
3. C3: 卷积层，卷积核大小为5x5，新图片长宽为14-5+1=10



- LeNet-5使用Sigmoid和Tanh函数来获取非线性输出，现在常使用的非线性函数是ReLU
- LeNet-5是在池化层之后引入了非线性，现在一般是在卷积层后通过激活函数获取非线性，在池化层后不再引入非线性





## GAN



#### Paper: Learning from Simulated and Unsupervised Images through Adversarial Training

Abstract: puzzle: expensive annotations 
=> train models on synthetic images(合成图)
=> gap: synthetic and real image distributions 
=> How to reduce? 
=> Apple: Simulated + Unsupervised(S+U) learning (“模拟+无监督”学习);
similar to Generative Adversarial Networks (GANs, 生成对抗网络);

Motivation: 减少生成图和真实图片之间的差别

input: synthetic images instead of random vectors. 使用合成图作为输入而非随机向量

合成图片通常不够真实，导致神经网络过度拟合合成图像中不真实的细节部分。而提高模拟器生成的合成图像的质量难度很大，所以提出“模拟+无标签”学习，目的是使用未标注的真实数据的模拟器提高合成图像的真实性。

Idea of SimGAN:

模拟器生成合成图，在Refiner网络中改善合成图真实性，用类似于GAN网络的方法训练Refiner。使用完全卷积神经网络(fully convolutional neural network)，在像素水平操作，保留图像全局结构。

Key Modifications:

1. self-regularization term 自正则化：为保留合成图的注释信息(label, annotation)，用自正则化损失弥补对抗性损失。(用于Machine Learning等)
2. local adversarial loss 局部对抗性损失：判别器接受图的局部区域，而非整张图，每张图片将产生多个局部对抗性损失，以避免伪影问题。
3. updating the discriminator using a history of refined images 使用精炼过的图片更新判别器：用精炼图像而非当前Refiner中现有的图像强化判别器(Discriminator)，以提高训练稳定性。

Contributions:







## RNN



- RNN结构共享一组(U, W, b)
- 在(U, W, b)不变的情况下，梯度在bp过程中不断连乘，数值不是越来越大就是越来越小，会出现梯度爆炸或梯度消失问题



## LSTM

> Long Short-Term Memory LSTM 长短期记忆网络

RNN梯度爆炸的问题我们可以通过gradient clipping的方法来进行优化，但梯度消失问题依然是难点。因此，有学者提出了LSTM和GRU（LSTM的简化版）来尽量避免梯度消失的问题，以及让RNN获得长记忆的能力

- 传统的RNN无法长期记忆信息，由于梯度消失等原因。
- LSTM用于解决RNN梯度消失的问题，有长记忆和短记忆。
- LSTM拥有从cell中擦除、写入和读出信息的功能。
- LSTM由gates来控制上述操作，这些门（向量）长度也是n。在每一个时间步长上，门的每一个元素都可以是open(1)，也可以是closed(0)，或在之间。
- 门（gates）是动态变化的，计算出来的
- 遗忘门 输出门 输入门 都有各自的(U, W, b)















------

# PyTorch

> Python的深度学习框架

以前是Lua语言下的模块Torch，2016被移植到Python上，可以和Tensor flow一拼高下



```python
import torch
import numpy as np

np_data = np.arange(6).reshape((2, 3))
torch_data = torch.from_numpy(np_data)# np array to torch tensor
tensor2array = torch_data.numpy()# torch tensor to np array
print(
    '\nnumpy array:', np_data, # [[0 1 2], [3 4 5]]
    '\ntorch tensor:', torch_data,#0  1  2 \n 3  4  5[torch.LongTensor of size 2x3]
    '\ntensor to array:', tensor2array,# [[0 1 2], [3 4 5]]
)
```



## Installation

```python
# 改变链接中的cu101可以改变CUDA版本
# 相应更改 torch==1.4.0 torchvision==0.5.0 可以实现下载某个版本的CUDA对应的不同版本的 torch torchvision
pip install torch==1.4.0 torchvision==0.5.0  -f https://download.pytorch.org/whl/cu101/torch_stable.html
```



#### Tensor

> Pytorch 0.4后，Variable和Tensor基本没有差别了
>
> https://blog.csdn.net/xholes/article/details/81667211

```python
import torch
import torch.nn as nn
import torch.utils.data as Data

torch.from_numpy(y_train).long()#numpy array => tensor => long tensor
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



#### Optimizer

```python
import torch
import torch.utils.data as Data
import torch.nn.functional as F
import matplotlib.pyplot as plt

# torch.manual_seed(1)    # reproducible

LR = 0.01
BATCH_SIZE = 32
EPOCH = 12

# fake dataset
x = torch.unsqueeze(torch.linspace(-1, 1, 1000), dim=1)
y = x.pow(2) + 0.1*torch.normal(torch.zeros(*x.size()))

# plot dataset
plt.scatter(x.numpy(), y.numpy())
plt.show()

# put dateset into torch dataset
torch_dataset = Data.TensorDataset(x, y)
loader = Data.DataLoader(dataset=torch_dataset, batch_size=BATCH_SIZE, shuffle=True, num_workers=2,)


# default network
class Net(torch.nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.hidden = torch.nn.Linear(1, 20)   # hidden layer
        self.predict = torch.nn.Linear(20, 1)   # output layer

    def forward(self, x):
        x = F.relu(self.hidden(x))      # activation function for hidden layer
        x = self.predict(x)             # linear output
        return x

if __name__ == '__main__':
    # different nets
    net_SGD         = Net()
    net_Momentum    = Net()
    net_RMSprop     = Net()
    net_Adam        = Net()
    nets = [net_SGD, net_Momentum, net_RMSprop, net_Adam] #记录不同网络(同一模板)

    # different optimizers #生成不同的优化器
    opt_SGD = torch.optim.SGD(net_SGD.parameters(), lr=LR)
    opt_Momentum = torch.optim.SGD(net_Momentum.parameters(), lr=LR, momentum=0.8)
    opt_RMSprop = torch.optim.RMSprop(net_RMSprop.parameters(), lr=LR, alpha=0.9)
    opt_Adam = torch.optim.Adam(net_Adam.parameters(), lr=LR, betas=(0.9, 0.99))
    optimizers = [opt_SGD, opt_Momentum, opt_RMSprop, opt_Adam]

    loss_func = torch.nn.MSELoss() #均方差误差函数
    losses_his = [[], [], [], []] # record loss

    # training
    for epoch in range(EPOCH):
        print('Epoch: ', epoch)
        for step, (b_x, b_y) in enumerate(loader): # for each training step
            for net, opt, l_his in zip(nets, optimizers, losses_his):
                output = net(b_x)              # get output for every net
                loss = loss_func(output, b_y)  # compute loss for every net
                opt.zero_grad()                # clear gradients for next train
                loss.backward() # backpropagation, compute gradients
                opt.step() # apply gradients
                l_his.append(loss.data.numpy()) # loss recoder

    labels = ['SGD', 'Momentum', 'RMSprop', 'Adam']
    for i, l_his in enumerate(losses_his):
        plt.plot(l_his, label=labels[i])
    plt.legend(loc='best')
    plt.xlabel('Steps')
    plt.ylabel('Loss')
    plt.ylim((0, 0.2))
    plt.show()
```





#### Build NN

```python
torch.optim #包含很多optimizer #e.g. SGD, Adom
```





## Digest Of Pytorch Package Reference

> https://pytorch.org/docs/stable/index.html



### torch.nn



#### Conv2d

> `torch.nn.Conv2d`(*in_channels*, *out_channels*, *kernel_size*, *stride=1*, *padding=0*, *dilation=1*, *groups=1*, *bias=True*)

- Applies a 2D convolution over an input signal composed of several input planes.

parameters:

- in_channels 输入通道数: 例如输入的是rgb图像(对于第一层卷积层)，则通道数应为3
- out_channels 输出通道数: 输出的通道数
- kernel_size 核大小: 
- stride 步幅: step/movement
- padding 填充: 对输入图像边缘的补零
- dilation 扩大: controls the spacing between the kernel points. 卷积核元素之间的间距
- groups:
- bias 偏置(bool, optional): If `True`, adds a learnable bias to the output. Default: `True`

The parameters `kernel_size`, `stride`, `padding`, `dilation` can either be:

- a single `int` – in which case the same value is used for the height and width dimension. 单个int表示宽高均为传入的int
- a `tuple` of two ints – in which case, the first int is used for the height dimension, and the second int for the width dimension. 传入tuple分别表示高、宽

> ### Note
>
> Depending of the size of your kernel, several (of the last) columns of the input might be lost, because it is a valid **cross-correlation**, and not a full cross-correlation. It is up to the user to add proper padding. 根据核大小，可能会丢失输入的(最后)几列。应该由用户来添加适当的padding。



## Study Case



### Classifier

```python
import torch
import torch.nn.functional as F
import matplotlib.pyplot as plt

# torch.manual_seed(1)    # reproducible

# make fake data #制造实验数据###############################
n_data = torch.ones(100, 2)# type:Tensor; torch.Size([100, 2]); 全为1
x0 = torch.normal(2*n_data, 1) # class0 x data (tensor), shape=(100, 2)#正态分布化
y0 = torch.zeros(100)          # class0 y data (tensor), shape=(100, 1)
x1 = torch.normal(-2*n_data, 1) # class1 x data (tensor), shape=(100, 2)#正态分布化
y1 = torch.ones(100)            # class1 y data (tensor), shape=(100, 1)
x = torch.cat((x0, x1), 0).type(torch.FloatTensor)  # FloatTensor = 32-bit floating
y = torch.cat((y0, y1), ).type(torch.LongTensor)    # LongTensor = 64-bit integer
print(type(x), x.shape) # <class 'torch.Tensor'>, torch.Size([200, 2])
print(type(y), y.shape) # <class 'torch.Tensor'>, torch.Size([200])
print(type(y[0]), type(x[0]), type(x[0][0]), type(x[0][0].data), x[0][0], x[0][0].data)
#(all Tensor)  Tensor, Tensor, Tensor, Tensor, tensor(3.2958), tensor(3.2958)
# The code below is deprecated in Pytorch 0.4. Now, autograd directly supports tensors
# x, y = Variable(x), Variable(y) # No needed for pytorch 1.0

# plt.scatter(x.data.numpy()[:, 0], x.data.numpy()[:, 1], c=y.data.numpy(), s=100, lw=0, cmap='RdYlGn')
# #s:scalar or array_like, shape (n, ) #linewidths : scalar or array_like.The linewidth of the marker edges.
# #cmap : Colormap。A Colormap instance or registered colormap name.cmap is only used if c is an array of floats.
# plt.show()


class Net(torch.nn.Module):
    def __init__(self, n_feature, n_hidden, n_output):
        super(Net, self).__init__()
        self.hidden = torch.nn.Linear(n_feature, n_hidden)   # hidden layer
        self.out = torch.nn.Linear(n_hidden, n_output)   # output layer

    def forward(self, x):
        x = F.relu(self.hidden(x)) # activation function for hidden layer
        x = self.out(x)
        return x

net = Net(n_feature=2, n_hidden=10, n_output=2)     # define the network
print(net)  # net architecture #输出网络结构

optimizer = torch.optim.SGD(net.parameters(), lr=0.01)
loss_func = torch.nn.CrossEntropyLoss()  # the target label is NOT an one-hotted
# 在回归时使用的是MSELoss 均方差 #多分类问题常用交叉熵，计算的是概率
# 例如输出的是[0.1, 0.2, 0.7]表示预测是第一类的概率是0.1，第二类是0.2,第三类是0.7
plt.ion() # something about plotting # interactive model on

for t in range(100):
    out = net(x) # input x and predict based on x #使用网络进行预测
    print(out[0], type(out), out.shape, type(out[0]), out[0].shape, F.softmax(out[0]))#调用softmax转化为概率
    #tensor([ 1.1094, -0.5418], grad_fn=<SelectBackward>) Tensor,Size([200, 2]); Tensor,Size([2])
    loss = loss_func(out, y) # must be (1. nn output, 2. target), the target label is NOT one-hotted

    optimizer.zero_grad() # clear gradients for next train#清除梯度
    loss.backward() # backpropagation, compute gradients #BP过程，计算梯度
    optimizer.step() # apply gradients #将梯度施加到神经网络上

    if(t % 2 == 0):
        # plot and show learning process
        plt.cla()#Clear the current axes.
        prediction = torch.max(out, 1)[1]
        pred_y = prediction.data.numpy()#tensor.data后才可以转换为numpy的array
        target_y = y.data.numpy()
        plt.scatter(x.data.numpy()[:, 0], x.data.numpy()[:, 1], c=pred_y, s=100, lw=0, cmap='RdYlGn')
        accuracy = float((pred_y == target_y).astype(int).sum()) / float(target_y.size)
        plt.text(1.5, -4, 'Accuracy=%.2f' % accuracy, fontdict={'size': 20, 'color':  'red'})
        plt.pause(0.1)

plt.ioff()
plt.show()
```



### AutoEncoder

```python
# -*- coding: utf-8 -*-
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

# 超参数 Hyper parameter
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
    train_loader = Data.DataLoader(dataset=train_data, batch_size=BATCH_SIZE, shuffle=True)#创建DataLoader

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



### Convolutional Neural Network 

> CNN 卷积神经网络







### DQN

- 共三个文件，其中`atari_wrappers.py`来自openai官网，对atari游戏环境进行配置；`DQN_Net_Buffer.py`定义网络模型，经验池；`DQN.py`为训练主过程

```python
# DQN.py
# 使用DQN 玩atari的pong游戏
# 含Agent定义 DQN训练过程
from atari_wrappers import make_atari, wrap_deepmind
import torch.nn.functional as F
import torch
import gym
import random
import os
import sys
import math
import glob
import numpy as np
import matplotlib.pyplot as plt
import time
from DQN_Net_Buffer import DQN, Memory_Buffer

saveStdOut = None
file_log = None

class DQNAgent:
    def __init__(self, in_channels=1, action_space=[], USE_CUDA=False, memory_size=10001,
                epsilon=1, lr=1e-4):
        self.epsilon = epsilon  # 选择随机策略的概率
        self.action_space = action_space  # action的空间
        self.memory_buffer = Memory_Buffer(memory_size) # 经验池
        # 初始化Agent的网络结构
        self.DQN = DQN(in_channels=in_channels, num_actions=action_space.n)
        self.DQN_target = DQN(in_channels=in_channels, num_actions=action_space.n)
        self.DQN_target.load_state_dict(self.DQN.state_dict()) # same
        self.USE_CUDA = USE_CUDA # 是否使用CUDA
        if self.USE_CUDA:
            self.DQN = self.DQN.cuda()
            self.DQN_target = self.DQN_target.cuda()
        self.optimizer = torch.optim.RMSprop(self.DQN.parameters(),
                                             lr=lr, eps=0.001, alpha=0.95)

    def observe(self, lazyframe):
        # 将环境给出的observation(np.array)转换为torch tensor # from Lazy frame to tensor
        state = torch.from_numpy(lazyframe._force().transpose(2, 0, 1)[None] / 255).float()
        if self.USE_CUDA:
            state = state.cuda()
        return state

    def value(self, state):
        # 给出state即atari game中的一帧图像 对应的每个action的价值Q value
        q_values = self.DQN(state)
        return q_values

    def act(self, state, epsilon=None):
        # 通过epsilon-greedy policy选出action
        # epsilon 的概率采用随机action 1-epsilon的概率选择具有最大 Q(s,a) 的 action
        if epsilon is None:
            epsilon = self.epsilon
        # q_values.shape = (1, 6)
        q_values = self.value(state).cpu().detach().numpy()
        if random.random() < epsilon:  # 命中epsilon概率 采用随机策略
            aciton = random.randrange(self.action_space.n)
        else:  # 命中 1-epsilon 选择最大的q_value所对应的action
            aciton = q_values.argmax(1)[0]
        return aciton

    def compute_td_loss(self, states, actions, rewards, next_states, is_done, gamma=0.99):
        # 计算 temporal difference loss # 时间差分法(无模型的方法)
        # TDLoss = R_t + \gamma * Q(s_{s+1}, a_{t+1}) - Q(s_s, a_t)
        actions = torch.tensor(actions).long()  # shape: [batch_size]
        rewards = torch.tensor(rewards, dtype=torch.float)  # same
        is_done = torch.tensor(is_done).bool()  # shape: [batch_size]
        if self.USE_CUDA:
            actions = actions.cuda()
            rewards = rewards.cuda()
            is_done = is_done.cuda()
        # 计算当前所有状态states的q value预测值
        predicted_qvalues = self.DQN(states)
        # 选择actions对应的q values
        predicted_qvalues_for_actions = predicted_qvalues[range(states.shape[0]), actions]

        # 预测的下一 states 对应的所有actions 的 q values
        predicted_next_qvalues = self.DQN_target(next_states)
        # 用预测的下一状态对应的q values最大值作为下一状态的q values
        next_state_values = predicted_next_qvalues.max(-1)[0]
        # 计算目标q values
        target_qvalues_for_actions = rewards + gamma * next_state_values
        target_qvalues_for_actions = torch.where(is_done, rewards, target_qvalues_for_actions)

        # 计算 均方差误差
        loss = F.smooth_l1_loss(predicted_qvalues_for_actions, target_qvalues_for_actions.detach())
        return loss

    def sample_from_buffer(self, batch_size):
        # 从buffer中采样过往的经验
        states, actions, rewards, next_states, dones = [], [], [], [], []
        for _ in range(batch_size):
            idx = random.randint(0, self.memory_buffer.size() - 1)
            data = self.memory_buffer.buffer[idx]
            frame, action, reward, next_frame, done = data
            states.append(self.observe(frame))
            actions.append(action)
            rewards.append(reward)
            next_states.append(self.observe(next_frame))
            dones.append(done)
        return torch.cat(states), actions, rewards, torch.cat(next_states), dones

    def learn_from_experience(self, batch_size):
        # 根据已有经验学习
        if self.memory_buffer.size() > batch_size:
            states, actions, rewards, next_states, dones = self.sample_from_buffer(batch_size)
            td_loss = self.compute_td_loss(states, actions, rewards, next_states, dones)
            self.optimizer.zero_grad()
            td_loss.backward()  # bp backward
            for param in self.DQN.parameters():
                param.grad.data.clamp_(-1, 1)
            self.optimizer.step()
            return td_loss  # !
        else:
            if self.USE_CUDA:
                torch.FloatTensor([0]).cuda()
            else:
                return torch.FloatTensor([0])


def epsilon_by_frame(idx, epsilon_max, epsilon_min, eps_decay):
    # e-greedy decay # epsilon 衰变 返回对应idx下的 epsilon value
    return epsilon_min + (epsilon_max - epsilon_min) * math.exp(-1.0 * idx / eps_decay)

def moving_average(a, n=3):
    ret = np.cumsum(a, dtype=float)
    ret[n:] = ret[n:] - ret[:-n]
    return ret[n - 1:] / n

def draw_training(frame_idx, rewards, path):
    # 绘制每个 episode 的 total reward 变化曲线
    plt.title("total frame %s. mean reward(last 100 games): %s" %
              (frame_idx + 1, np.mean(rewards[-100:])))
    plt.plot(moving_average(rewards, 20))
    plt.savefig("./" + path + "/reward.jpg")
    # plt.show()

def draw_epsilon(frames, epsilon_max, epsilon_min, eps_decay, path):
    # 绘制 epsilon 的变化曲线
    plt.title("epsilon curve(max=%s,min=%s,eps_decay=%s,frames=%s)"
        % (epsilon_max, epsilon_min, eps_decay, frames))
    plt.plot([epsilon_by_frame(i, epsilon_max, epsilon_min, eps_decay) for i in range(frames)])
    plt.savefig("./" + path + "/epsilon curve.jpg")

def log_to_file(path, time_id):
    # 将程序输出到log文件中
    global saveStdOut
    global file_log
    saveStdOut = sys.stdout

    path = os.path.join(os.path.abspath("."), path)  # 绝对路径 + 相对路径
    folder = os.path.exists(path)  # 判断是否存在
    if not folder:  # 判断是否存在文件夹如果不存在则创建为文件夹
        os.makedirs(path)  # makedirs 创建文件时如果路径不存在会创建这个路径
        print("[DEBUG] new folder ", path, " created")
    else:
        print("[DEBUG] folder ", path, " exits")

    # 绝对路径 + time id为文件名
    file_log = open((os.path.join(path, str(time_id) + str(".log"))), "w")
    sys.stdout = file_log

def cancel_log():
    # 取消输出到文件
    sys.stdout = saveStdOut
    file_log.close()

if __name__ == "__main__":  # run: python DQN.py
    USE_CUDA = torch.cuda.is_available()
    env = make_atari("PongNoFrameskip-v4")
    env = wrap_deepmind(env, scale=False, frame_stack=True)
    # === 超参数 START ==================================
    batch_size = 32  # default = 32
    learning_rate = 0.0002  # 学习率 # default = 0.0005
    frames = 1000000  # 游戏给出的总帧数 用作停止条件 # default = 1000000 10^6
    epsilon_max = 1  # 最大epsilon epsilon为采用随机选择action策略的概率 # default = 1
    epsilon_min = 0.01  # 最小epsilon # default = 0.01
    eps_decay = 50000  # epsilon衰减系数 # default = 50000
    gamma = 0.99  # 遗忘系数 # default = 0.99
    interval_update_DQNtar = 1000  # 更新DQN_target的间隔 # default = 1000
    interval_print = 1000  # debug输出间隔 frame数 # default = 1000
    learn_start = 10000  # 到多少frame后开始学习 # default = 10000
    # === 超参数 END ==================================

    start_time = time.time()
    print("start:", time.asctime(time.localtime(start_time)), " id=",
            int(start_time), " CUDA:", USE_CUDA)
    # 保存 log pictures video 文件的目录
    path = ("pong_" + str(float(learning_rate)) + "_batchSize_" + str(batch_size) + 
            "_epsDecay_" + str(eps_decay) + "_frames_" + str(frames))
    log_to_file(path, int(start_time))  # === 开始写log # 该调用会创建文件夹
    draw_epsilon(frames, epsilon_max, epsilon_min, eps_decay, '')
    
    print("start:", time.asctime(time.localtime(start_time)), " CUDA:", USE_CUDA)
    print("batch_size= ", batch_size, " learning_rate= ", learning_rate, " frames= ",
        frames, " epsilon_max=", epsilon_max, " epsilon_min=", epsilon_min, " eps_decay=",
        eps_decay, " gamma=", gamma)

    action_space = env.action_space  # action 空间 用于记录数量
    state_channel = env.observation_space.shape[2]  # 状态 state 数量
    # state_channel=4  action_space=Discrete(6) env.observation_space.shape=(84, 84, 4)
    # env.action_space.n = 6 action状态数
    # 创建DQN Agent
    agent = DQNAgent(in_channels=state_channel, action_space=action_space, USE_CUDA=USE_CUDA, lr=learning_rate)
    frame = env.reset()

    episode_reward = 0  # 记录当前 episode 的 reward
    all_rewards = []  # 记录所有 episode 的 reward
    losses = []
    episode_count = 0  # 记录当前 episode 数

    for i in range(frames):
        # 计算当前epsilon的值
        epsilon = epsilon_by_frame(i, epsilon_max, epsilon_min, eps_decay)
        cur_state = agent.observe(frame)  # 从atari游戏的帧观测出当前状态
        action = agent.act(cur_state, epsilon)  # 对当前状态依据e-greedy计算应采取的action
        next_frame, reward, done, _ = env.step(action)  # 采用了该action后的...
        # reward: 1表示赢了，-1表示输了 在出现第21次|reward|=1时，done=True表示21局打完
        episode_reward += reward  # 将该动作产生的reward累加起来
        # 记录经验至buffer中
        agent.memory_buffer.push(frame, action, reward, next_frame, done)
        frame = next_frame  # 更新frame
        loss = 0
        if agent.memory_buffer.size() >= learn_start:  # 如果已经开始学习
            loss = agent.learn_from_experience(batch_size)  # 从经验中学习
            losses.append(loss)

        if i % interval_print == 0 and i > 0:
            if len(all_rewards) >= 10:
                recent_reward_mean = np.mean(all_rewards[-10:])
            else:
                recent_reward_mean = -21
            print("frames: %5d, reward: %5f, loss: %4f, epsilon: %5f, episode: %4d"
                % (i, recent_reward_mean, loss, epsilon, episode_count))

        if i % interval_update_DQNtar == 0:  # 将 DQN_target 更新为当前 DQN
            agent.DQN_target.load_state_dict(agent.DQN.state_dict())

        if done:  # 游戏每完成一次(指打完21局) 则episode+1 将episode_reward置0
            frame = env.reset()  # 重新开始游戏
            all_rewards.append(episode_reward)  # 该21局的最终reward [-21, 21]
            episode_reward = 0
            episode_count += 1

    torch.save(agent.DQN.state_dict(), "./" + path + "/DQN_dict.pth.tar")
    torch.save(agent.DQN.state_dict(), "DQN_dict.pth.tar")
    # 绘制reword曲线
    draw_training(i, all_rewards, path)

    print("[End] Total time: ", (time.time() - start_time) / 3600, "hours")
    cancel_log()  # === 结束log记录
    print("[End] Total time: ", (time.time() - start_time) / 3600, "hours")
    # 录制视频 # force=True 表示如果有之前的视频 则覆盖保存
    env = gym.wrappers.Monitor(env, "./" + path, force=True)
    frame = env.reset()
    for i in range(10000):
        cur_state = agent.observe(frame)
        action = agent.act(cur_state, epsilon=0)
        next_frame, reward, done, _ = env.step(action)
        frame = next_frame
        if done:
            break
```



```python
# DQN_Net_Buffer.py
# 使用DQN 玩atari的pong游戏 # 附属文件 需要被DQN.py (main文件) 调用
# 定义DQN网络结构 经验缓存 Memory_Buffer
import torch.autograd as autograd
import torch.nn.functional as F
import torch.nn as nn
import torch.optim as optim
import numpy as np
import random

class DQN(nn.Module):
    # 实现论文中的DQN: Human-level control through deep reinforcement learning
    def __init__(self, in_channels=4, num_actions=5):
        # in_channels: 输入通道数 即最近的frame的数量
        # num_actions: action-value的数量 与游戏里的action一一对应
        super(DQN, self).__init__()
        self.conv1 = nn.Conv2d(in_channels, 32, kernel_size=8, stride=4)
        self.conv2 = nn.Conv2d(32, 64, kernel_size=4, stride=2)
        self.conv3 = nn.Conv2d(64, 64, kernel_size=3, stride=1)
        self.fc4 = nn.Linear(7 * 7 * 64, 512)
        self.fc5 = nn.Linear(512, num_actions)

    def forward(self, x):
        x = F.relu(self.conv1(x))
        x = F.relu(self.conv2(x))
        x = F.relu(self.conv3(x))
        x = F.relu(self.fc4(x.reshape(x.size(0), -1)))
        return self.fc5(x)  # <class 'torch.Tensor'>, maybe: torch.Size([1, 6])

class Memory_Buffer(object):
    # 经验池 # 经验缓存
    def __init__(self, memory_size=1000):
        self.buffer = []
        self.memory_size = memory_size
        self.next_idx = 0

    def push(self, state, action, reward, next_state, done):
        # 存储经验样本
        data = (state, action, reward, next_state, done)
        if len(self.buffer) <= self.memory_size:  # buffer not full
            self.buffer.append(data)
        else:  # buffer is full
            self.buffer[self.next_idx] = data
        self.next_idx = (self.next_idx + 1) % self.memory_size

    def sample(self, batch_size): # 获取经验样本
        states, actions, rewards, next_states, dones = [], [], [], [], []
        for _ in range(batch_size):
            idx = random.randint(0, self.size() - 1)
            data = self.buffer[idx]
            state, action, reward, next_state, done = data
            states.append(state)
            actions.append(action)
            rewards.append(reward)
            next_states.append(next_state)
            dones.append(done)
        return np.concatenate(states), actions, rewards, np.concatenate(next_states), dones

    def size(self):
        return len(self.buffer)
```

```python
# 附属文件 需要被DQN.py (main文件) 调用
import numpy as np
from collections import deque
import gym
from gym import spaces
import cv2
cv2.ocl.setUseOpenCL(False)


class NoopResetEnv(gym.Wrapper):
    def __init__(self, env, noop_max=30):
        """Sample initial states by taking random number of no-ops on reset.
        No-op is assumed to be action 0.
        """
        gym.Wrapper.__init__(self, env)
        self.noop_max = noop_max
        self.override_num_noops = None
        self.noop_action = 0
        assert env.unwrapped.get_action_meanings()[0] == 'NOOP'

    def reset(self, **kwargs):
        """ Do no-op action for a number of steps in [1, noop_max]."""
        self.env.reset(**kwargs)
        if self.override_num_noops is not None:
            noops = self.override_num_noops
        else:
            noops = self.unwrapped.np_random.randint(1, self.noop_max + 1)  # pylint: disable=E1101
        assert noops > 0
        obs = None
        for _ in range(noops):
            obs, _, done, _ = self.env.step(self.noop_action)
            if done:
                obs = self.env.reset(**kwargs)
        return obs

    def step(self, ac):
        return self.env.step(ac)

class FireResetEnv(gym.Wrapper):
    def __init__(self, env):
        """Take action on reset for environments that are fixed until firing."""
        gym.Wrapper.__init__(self, env)
        assert env.unwrapped.get_action_meanings()[1] == 'FIRE'
        assert len(env.unwrapped.get_action_meanings()) >= 3

    def reset(self, **kwargs):
        self.env.reset(**kwargs)
        obs, _, done, _ = self.env.step(1)
        if done:
            self.env.reset(**kwargs)
        obs, _, done, _ = self.env.step(2)
        if done:
            self.env.reset(**kwargs)
        return obs

    def step(self, ac):
        return self.env.step(ac)

class EpisodicLifeEnv(gym.Wrapper):
    def __init__(self, env):
        """Make end-of-life == end-of-episode, but only reset on true game over.
        Done by DeepMind for the DQN and co. since it helps value estimation.
        """
        gym.Wrapper.__init__(self, env)
        self.lives = 0
        self.was_real_done = True

    def step(self, action):
        obs, reward, done, info = self.env.step(action)
        self.was_real_done = done
        # check current lives, make loss of life terminal,
        # then update lives to handle bonus lives
        lives = self.env.unwrapped.ale.lives()
        if lives < self.lives and lives > 0:
            # for Qbert sometimes we stay in lives == 0 condition for a few frames
            # so it's important to keep lives > 0, so that we only reset once
            # the environment advertises done.
            done = True
        self.lives = lives
        return obs, reward, done, info

    def reset(self, **kwargs):
        """Reset only when lives are exhausted.
        This way all states are still reachable even though lives are episodic,
        and the learner need not know about any of this behind-the-scenes.
        """
        if self.was_real_done:
            obs = self.env.reset(**kwargs)
        else:
            # no-op step to advance from terminal/lost life state
            obs, _, _, _ = self.env.step(0)
        self.lives = self.env.unwrapped.ale.lives()
        return obs

class LossLifePunishEnv(gym.Wrapper):
    def __init__(self, env, train="True", fire_reset=False):
        """Make end-of-life have a -1 reward when training. 
        When evaluation, end-of-life have 0 reward, but perform no-op step to advance from terminal/lost life state
        if fire_reset = True, performs fire action to reset when life is loss
        """
        if train:
            self.loss_life_punishment = -1
        else:
            self.loss_life_punishment = 0

        gym.Wrapper.__init__(self, env)
        self.lives = 0
        self.fire_reset = fire_reset

    def step(self, action):
        obs, reward, done, info = self.env.step(action)
        # check current lives, make loss of life terminal,
        # then update lives to handle bonus lives
        lives = self.env.unwrapped.ale.lives()
        if lives < self.lives and lives > 0:
            # set reward to -1 when life is loss
            reward += self.loss_life_punishment
            # no-op step to advance from terminal/lost life state
            obs, _, _, _ = self.env.step(0)
            if self.fire_reset:
                obs, _, done, _ = self.env.step(1)
        self.lives = lives
        return obs, reward, done, info

    def reset(self, **kwargs):
        return self.env.reset(**kwargs)

class MaxAndSkipEnv(gym.Wrapper):
    def __init__(self, env, skip=4):
        """Return only every `skip`-th frame"""
        gym.Wrapper.__init__(self, env)
        # most recent raw observations (for max pooling across time steps)
        self._obs_buffer = np.zeros((2,)+env.observation_space.shape, dtype=np.uint8)
        self._skip = skip

    def step(self, action):
        """Repeat action, sum reward, and max over last observations."""
        total_reward = 0.0
        done = None
        for i in range(self._skip):
            obs, reward, done, info = self.env.step(action)
            if i == self._skip - 2:
                self._obs_buffer[0] = obs
            if i == self._skip - 1:
                self._obs_buffer[1] = obs
            total_reward += reward
            if done:
                break
        # Note that the observation on the done=True frame
        # doesn't matter
        max_frame = self._obs_buffer.max(axis=0)

        return max_frame, total_reward, done, info

    def reset(self, **kwargs):
        return self.env.reset(**kwargs)

class ClipRewardEnv(gym.RewardWrapper):
    def __init__(self, env):
        gym.RewardWrapper.__init__(self, env)

    def reward(self, reward):
        """Bin reward to {+1, 0, -1} by its sign."""
        return np.sign(reward)

class WarpFrame(gym.ObservationWrapper):
    def __init__(self, env, width=84, height=84, grayscale=True, dict_space_key=None):
        """
        Warp frames to 84x84 as done in the Nature paper and later work.
        If the environment uses dictionary observations, `dict_space_key` can be specified which indicates which
        observation should be warped.
        """
        super().__init__(env)
        self._width = width
        self._height = height
        self._grayscale = grayscale
        self._key = dict_space_key
        if self._grayscale:
            num_colors = 1
        else:
            num_colors = 3
        new_space = gym.spaces.Box(low=0, high=255,
            shape=(self._height, self._width, num_colors), dtype=np.uint8)
        if self._key is None:
            original_space = self.observation_space
            self.observation_space = new_space
        else:
            original_space = self.observation_space.spaces[self._key]
            self.observation_space.spaces[self._key] = new_space
        assert original_space.dtype == np.uint8 and len(original_space.shape) == 3

    def observation(self, obs):
        if self._key is None:
            frame = obs
        else:
            frame = obs[self._key]
        if self._grayscale:
            frame = cv2.cvtColor(frame, cv2.COLOR_RGB2GRAY)
        frame = cv2.resize(frame, (self._width, self._height), interpolation=cv2.INTER_AREA)
        if self._grayscale:
            frame = np.expand_dims(frame, -1)
        if self._key is None:
            obs = frame
        else:
            obs = obs.copy()
            obs[self._key] = frame
        return obs

class FrameStack(gym.Wrapper):
    def __init__(self, env, k):
        """Stack k last frames.
        Returns lazy array, which is much more memory efficient.
        See Also
        --------
        baselines.common.atari_wrappers.LazyFrames
        """
        gym.Wrapper.__init__(self, env)
        self.k = k
        self.frames = deque([], maxlen=k)
        shp = env.observation_space.shape
        self.observation_space = spaces.Box(low=0, high=255, shape=(
            shp[:-1] + (shp[-1] * k,)), dtype=env.observation_space.dtype)
        
    def reset(self):
        ob = self.env.reset()
        for _ in range(self.k):
            self.frames.append(ob)
        return self._get_ob()

    def step(self, action):
        ob, reward, done, info = self.env.step(action)
        self.frames.append(ob)
        return self._get_ob(), reward, done, info

    def _get_ob(self):
        assert len(self.frames) == self.k
        return LazyFrames(list(self.frames))

class ScaledFloatFrame(gym.ObservationWrapper):
    def __init__(self, env):
        gym.ObservationWrapper.__init__(self, env)
        self.observation_space = gym.spaces.Box(
            low=0, high=1, shape=env.observation_space.shape, dtype=np.float32)

    def observation(self, observation):
        # careful! This undoes the memory optimization, use
        # with smaller replay buffers only.
        return np.array(observation).astype(np.float32) / 255.0

class LazyFrames(object):
    def __init__(self, frames):
        """This object ensures that common frames between the observations are only stored once.
        It exists purely to optimize memory usage which can be huge for DQN's 1M frames replay
        buffers.
        This object should only be converted to numpy array before being passed to the model.
        You'd not believe how complex the previous solution was."""
        self._frames = frames
        self._out = None

    def _force(self):
        if self._out is None:
            self._out = np.concatenate(self._frames, axis=-1)
            self._frames = None
        return self._out

    def __array__(self, dtype=None):
        out = self._force()
        if dtype is not None:
            out = out.astype(dtype)
        return out

    def __len__(self):
        return len(self._force())

    def __getitem__(self, i):
        return self._force()[i]

    def count(self):
        frames = self._force()
        return frames.shape[frames.ndim - 1]

    def frame(self, i):
        return self._force()[..., i]

def make_atari(env_id, max_episode_steps=None):
    env = gym.make(env_id)
    assert 'NoFrameskip' in env.spec.id
    env = NoopResetEnv(env, noop_max=30)
    env = MaxAndSkipEnv(env, skip=4)
    return env

def wrap_deepmind(env, episode_life=False, clip_rewards=False, frame_stack=False, scale=False):
    # Configure environment for DeepMind-style Atari.
    if episode_life:
        env = EpisodicLifeEnv(env)
    if 'FIRE' in env.unwrapped.get_action_meanings():
        env = FireResetEnv(env)
    env = WarpFrame(env)
    if scale:
        env = ScaledFloatFrame(env)
    if clip_rewards:
        env = ClipRewardEnv(env)
    if frame_stack:
        env = FrameStack(env, 4)
    return env
```





