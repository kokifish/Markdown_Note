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

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/AI_develop_process.jpg)



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

| 派别                    | 起源        | 擅长算法(Part)                   |
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



![AStar.gif](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/AI_Astar_progress_animation.gif)
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

> 这下面应该有张图 但是好像被我删掉了

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

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/AI_alpha_cutting.jpg)



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

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/AI_Single Layer Perceptron formula.png)





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

> recurrent neural network, 循环神经网络, 递归神经网络
>
> https://en.wikipedia.org/wiki/Recurrent_neural_network
>
> https://zhuanlan.zhihu.com/p/71732459

- 网络输入：RNN 网络的输入数据的维度通常是`[batch_size x seq_len x input_size]`，比CNN多序列长度`seq_len`
- 最原始的 RNN 公式：

$h_t=\tanh(w_{ih}x_t+b_{ih}+w_{hh}h_{(t−1)}+b_{hh})$

- 其中w: weigh; b: bias; $x_t$: input; $h_t$: hidden state
- 普通的神经网络只有$w_{ih}x_t+b_{ih}$, 而RNN多加了隐藏状态信息$w_{hh}h_{(t−1)}+b_{hh}$
- 普通网络是一次前向传播就得到结果，而RNN多了sequence维度，需要跑n次前向传播
- 反向传播，BP：与其他神经网络不通的是，RNN的误差需要在时间轴上进行

经过展开的RNN单元，unfolded(unrolled) basic recurrent neural network

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/AI_Unfolded_basic_recurrent_neural_network.png)

```python
# 使用numpy对RNN工作流程做总结
class RNN: # 省略很多其他操作
  def step(self, x, hidden): # update the hidden state
    hidden = np.tanh(np.dot(self.W_hh, hidden) + np.dot(self.W_xh, x)) # 输出只有一个hidden_state
    return hidden

rnn = RNN()
x = get_data() # x: [batch_size * seq_len * input_size]
seq_len = x.shape[1] # 序列长度
hidden_state = np.zeros() 初始化一个hidden_state，RNN中的参数没有包括hidden_state
for i in range(seq_len): # RNN工作流程，每次输入 x[:, i, :] 都是一个时间步长的数据
    hidden_state = rnn(x[:, i, :], hidden_state) # 同一个hidden_state会在循环中反复输入到网络中
```



- RNN结构共享一组(U, W, b)
- 在(U, W, b)不变的情况下，梯度在bp过程中不断连乘，数值不是越来越大就是越来越小，会出现梯度爆炸或梯度消失问题

```python
# Created on 2019年6月2日 # 疑似使用tf1.x
# 用tensorflow实现一个直白的RNN，用这个RNN实现对正弦曲线的刻画：y_t = f(y_t-T-1, ..., y_t-1)
# 网络结构是RNN层+多元线性回归。
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
import random
# 超参数设置
batch_size = 11  # 训练的时候，一般使用批量梯度下降来加快收敛；有时候也会使用这个策略来避免内存或者现存不足导致的内存溢出
rnn_node_num = 50  # RNN神经元个数
input_dim = 1  # 输入数据的维度
T = 20  # 序列的长度，这里每次会向网络输入一个长20的序列
output_dim = 1  # 输出的维度
lr = 0.0001  # 学习率
step_num = 1  # 训练时,遍历数据集的次数

def gernerate_data(): # 生成训练数据，取值范围是[-1,1]。
    data = [np.sin(i / 20) for i in range(0, 1000)] # plt.plot(data)    plt.show()
    X = []
    Y = []
    for i in range(len(data) - T - 1):
        X.append(data[i: i + T])  # 输入的序列
        Y.append(data[i + T])  # 输出的取值
    return np.array(X), np.array(Y)

class TFRNN():
    def __init__(self, rnn_node_num, input_dim, output_dim, T=10, learning_rate=0.001):
        self.T = T  # 循环的次数，即时间步数 # 序列长度 seq_len
        self.lr = learning_rate  # 学习率
        self.input_dim = input_dim  # 输入序列的元素的维度
        # 假如输入是气温序列，那么元素就是一个个气温取值，维度是1；假如是字向量，元素就是一个个向量，维度是字向量的长度
        self.rnn_node_num = rnn_node_num  # RNN的神经元的个数。这里只有一层
        self.output_dim = output_dim
        self.init_dynamic_graph() # 创建网络

    def init_dynamic_graph(self):# 初始化一个计算图
        self.X = tf.placeholder(dtype=tf.float32, shape=[None, self.T, self.input_dim]) # 设置计算图的输入
        self.Y = tf.placeholder(dtype=tf.float32, shape=[None, self.output_dim])
        self.batch_size = tf.placeholder(dtype=tf.float32, shape=[1])

        self.rnn_cell = tf.nn.rnn_cell.BasicRNNCell(self.rnn_node_num) # 设置RNN层的结构
        init_state = tf.zeros(shape=[self.batch_size[0], self.rnn_cell.state_size])
        output, states = tf.nn.dynamic_rnn(self.rnn_cell, self.X, initial_state=init_state)

        # 多元线性回归，把RNN层的self.rnn_node_num个输出综合起来
        self.W = tf.Variable(tf.random_normal([self.rnn_node_num, self.output_dim]))
        self.b = tf.Variable(tf.zeros([self.output_dim]))
        self.final_output = tf.matmul(output[:, -1, :], self.W) + self.b  # 多元线性回归

        # 把正确答案和模型的计算值都拉直，然后计算最小二乘损失值
        Y_ = tf.reshape(self.Y, [-1])
        output_ = tf.reshape(self.final_output, [-1])
#         self.loss = -tf.reduce_mean(tf.multiply(output_, tf.log(Y_)))#分类时使用的损失函数
        self.loss = tf.reduce_mean(tf.square(output_ - Y_))  # 回归任务常用的损失函数
        self.train = tf.train.GradientDescentOptimizer(self.lr).minimize(self.loss) # 设置优化函数
        self.sess = tf.Session() # 启动上面定义的计算图
        self.sess.run(tf.initialize_all_variables())

    def fit(self, X, Y): # 把训练数据喂给计算图，驱动计算图的优化动作
        loss, _, final_output = self.sess.run([self.loss, self.train, self.final_output], feed_dict={
                                              self.X: X, self.Y: Y, self.batch_size: [X.shape[0]]})
        return loss, final_output

    def predict(self, X): # 把数据喂给计算图，把输出值获取出来
        final_output = self.sess.run([self.final_output], feed_dict={
                                     self.X: X, self.batch_size: [X.shape[0]]}) 
        return final_output

if __name__ == '__main__':
    X, Y = gernerate_data() # 生成训练数据
    model = TFRNN(rnn_node_num, input_dim, output_dim, T=T, learning_rate=lr) # 初始化模型
    loss_list = []
    for step in range(step_num): # 开始训练
        for i in range(0, X.shape[0] - batch_size, batch_size):
            X_batch = X[i: i + batch_size]
            Y_batch = Y[i: i + batch_size]
            X_batch = np.array(X_batch).reshape([-1, T, input_dim])
            Y_batch = np.array(Y_batch).reshape([-1, 1])
            loss_v, final_output = model.fit(X_batch, Y_batch) #  # 把训练数据喂给计算图，驱动计算图的优化动作
            loss_list.append(loss_v)
    plt.plot(loss_list)
    plt.show()  # 展示损失值的变化趋势
```







## LSTM

> Long Short-Term Memory LSTM 长短期记忆网络

RNN梯度爆炸的问题我们可以通过gradient clipping的方法来进行优化，但梯度消失问题依然是难点。因此，有学者提出了LSTM和GRU（LSTM的简化版）来尽量避免梯度消失的问题，以及让RNN获得长记忆的能力

- 传统的RNN无法长期记忆信息，由于梯度消失等原因。
- LSTM用于解决RNN梯度消失的问题，有长记忆和短记忆。
- LSTM拥有从cell中擦除、写入和读出信息的功能。
- LSTM由gates来控制上述操作，这些门（向量）长度也是n。在每一个时间步长上，门的每一个元素都可以是open(1)，也可以是closed(0)，或在之间。
- 门（gates）是动态变化的，计算出来的
- 遗忘门 输出门 输入门 都有各自的(U, W, b)

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/AI_LSTM_cell_color.png)

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/AI_LSTM_cell_black_white.png)









## GNN

> 图神经网络（Graph Neural Networks，GNN）
>
> https://zhuanlan.zhihu.com/p/75307407  图神经网络（Graph Neural Networks，GNN）综述

- 在本文中，我们将图神经网络划分为五大类别
1. 图卷积网络, Graph Convolution Networks, GCN
2. 图注意力网络, Graph Attention Networks, **GAT**
3. 图自编码器,  Graph Autoencoders:
4. 图生成网络, Graph Generative Networks:
5. 图时空网络, Graph Spatial-temporal Networks:



### GCM

> 图卷积网络（Graph Convolution Networks，GCN）

GCN方法又可以分为两大类，

1. 基于谱 spectral-based:
2. 基于空间 spatial-based: 



#### Spatial-based Graph Convolutional Networks

> 基于空间的图卷积网络

- 基于空间的图卷积神经网络的思想主要源自于传统卷积神经网络对图像的卷积运算，不同的是基于空间的图卷积神经网络是基于节点的空间关系来定义图卷积的。



- 一种共同的实践是将多个图卷积层叠加在一起。根据卷积层叠的不同方法，基于空间的GCN可以进一步分为两类：recurrent-based和composition-based的空间GCN。recurrent-based的方法使用相同的图卷积层来更新隐藏表示，composition-based的方法使用不同的图卷积层来更新隐藏表示





### Graph Attention Networks

> 图注意力网络（Graph Attention Networks）

注意力机制如今已经被广泛地应用到了基于序列的任务中，它的优点是能够放大数据中最重要的部分的影响。这个特性已经被证明对许多任务有用，例如机器翻译和自然语言理解。如今融入注意力机制的模型数量正在持续增加，图神经网络也受益于此，它在聚合过程中使用注意力，整合多个模型的输出，并生成面向重要目标的随机行走

#### Graph Attention Network (GAT)

- 图注意力网络（GAT）是一种基于空间的图卷积网络，它的注意机制是在聚合特征信息时，将注意机制用于确定节点邻域的权重









#### Gated Attention Network (GAAN)

- 门控注意力网络（GAAN）还采用了多头注意力机制来更新节点的隐藏状态。然而，GAAN并没有给每个head部分配相等的权重，而是引入了一种自注意机制，该机制为每个head计算不同的权重





#### Graph Attention Model (GAM)

- 图形注意力模型（GAM）提供了一个循环神经网络模型，以解决图形分类问题，通过自适应地访问一个重要节点的序列来处理图的信息





### Graph Autoencoders

- 图自动编码器是一类图嵌入方法，其目的是利用神经网络结构**将图的顶点表示为低维向量**



目前基于GCN的自编码器的方法主要有：

- Graph Autoencoder (GAE)
- Adversarially Regularized Graph Autoencoder (ARGA)

图自编码器的其它变体有：

- Network Representations with Adversarially Regularized Autoencoders (NetRA)
- Deep Neural Networks for Graph Representations (DNGR)
- Structural Deep Network Embedding (SDNE)
- Deep Recursive Network Embedding (DRNE)







### Graph Spatial-Temporal Networks

> 图时空网络

图时空网络同时捕捉时空图的时空相关性。时空图具有全局图结构，每个节点的输入随时间变化。例如，在交通网络中，每个传感器作为一个节点连续记录某条道路的交通速度，其中交通网络的边由传感器对之间的距离决定。图形时空网络的目标可以是预测未来的节点值或标签，或者预测时空图标签。最近的研究仅仅探讨了GCNs的使用，GCNs与RNN或CNN的结合，以及根据图结构定制的循环体系结构。

目前图时空网络的模型主要有

Diffusion Convolutional Recurrent Neural Network (DCRNN)

CNN-GCN

Spatial Temporal GCN (ST-GCN)

Structural-RNN