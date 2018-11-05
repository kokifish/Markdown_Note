[TOC]



>   https://zh.wikipedia.org/wiki/%E6%95%B0%E5%AD%A6%E7%AC%A6%E5%8F%B7%E8%A1%A8 数学符号表



---

# 数论

> 数论 Number theory



## 整数可除性



- 整除，因数，倍数：



## 同余

- 同余：给定一个正整数m。两个整数a,b叫做 模m同余，









---

## 态射 morphism 

-   两个数学结构之间保持结构的一种**过程抽象**
-   最常见的这种过程的例子是在某种意义上保持结构的**函数**或**映射**

定义

一个范畴*C*由两个类给定：一个*对象*的类和一个*态射*的类。

有两个操作定义在每个态射上，域（domain，或源）和陪域（codomain，或目标）。

态射经常用从域到他们的陪域的箭头来表示，例如若一个态射*f*域为*X*而陪域为*Y*，它记为*f* : *X* → *Y*。所有从*X*到*Y*的态射的集合记为hom*C*(*X*,*Y*)或者hom(*X*, *Y*)

#### 映射

-   假如通过一个法则φ，对于任何一个A1×A2 ×…×An的元素（ a1，a2，…,an） （ai∈Ai），都能得到一个唯一的集合D的元素d，那么这个法则φ叫做集合A1×A2 ×…×An到集合D的一个映射。
-   元素d叫做元素（ a1，a2，…,an）在映射φ之下的象;
-   元素（ a1，a2，…,an）叫做元素d在映射φ之下的逆象
-   一个映射常用以下符号来描写
-     φ： （ a1，a2，…,an） →d= φ（ a1，a2，…,an）
-   一个A×B到D的映射叫做一个A×B到D的代数运算。一个代数运算用◦来表示，◦: (a,b) → d=◦(a,b)
    为方便起见, ◦(a,b)可以写成a◦b

---

# 近世代数

近世代数(modern algebra)又称抽象代数(abstract algebra)，研究对象是代数系统，即集合以及定义在其上的一个或若干个代数运算构成的系统

主要研究对象: 群 环 域 模 向量空间 格 域代数

具有二元运算的代数结构: 原群 拟群 幺半群 半群 群

若干个（有限或无限多个）固定事物的全体叫做一个集合。
 组成一个集合的事物叫做这个集合的元素（有时简称元）一个没有元素的集合叫空集合。
集合A和集合B的所有共同元素组成的集合叫做A和B的交集A∩B。
由至少属于A和B之一的一切元素组成的集合叫做A和B的并集A∪B。
令A~1~，A~2~，…,A~n~是n个集合，由一切从A~1~，A~2~，…,A~n~里顺序取出的元素组（ a~1~，a~2~，…,a~n~）（a~i~∈A~i~）所做成的集合叫做A~1~，A~2~，…,A~n~的积，记成A~1~×A~2~ ×…×A~n~



#### 二元运算

> https://zh.wikipedia.org/wiki/%E4%BA%8C%E5%85%83%E8%BF%90%E7%AE%97

- **二元运算**属于数学运算的一种。二元运算需要三个元素：二元运算符以及该运算符作用的两个变量
- 给定集合A，二元函数F:$$A\times A\rightarrow A$$ 称为集合A上的**二元运算**, An operation is a mapping that associates an element of the set to *every* pair of its elements. 给定集合A中两个元素a、b，则按顺序通常写为aFb。更多时候，二元运算会采用某种运算符而不是字母做为标记。
- 可以看出，“集合A上的二元运算”这样的提法暗示了该运算在A上封闭

-

---

## 群





#### 原群 Magma

-   原群有一个集合 *M* 和一个 *M* 上的二元运算 *M* × *M* → *M* 。此二元运算依定义是**封闭**的，且除此之外便没有其他公理被加在此运算中
-   原群的态射是一个函数 $${\displaystyle f:M\to N}$$ ，将原群 *M* 映射至原群 *N* 上，并保留其二元运算：$$f(x\;*_{M}\;y)=f(x)\;*_{N}\;f(y)$$ , 其中的 $${\displaystyle *_{M}}$$ 和 $${\displaystyle *_{N}}$$ 分别代表着在 *M* 和 *N* 上的二元运算




#### 拟群 Quasigroup

一个**拟群** (Q, ·) 是一个集合 Q 与一个二元运算 · 的结合(即一个原群)，满足对 Q 中的任意元素 a 和 b，都存在唯一的 Q 中元素 x 和 y，使得：
-   a·x = b 
-   y·a = b 
    这两个唯一的元素被记作：x = a \ b 和 y = b / a。其中"\" 和 "/"分别表示被二元运算所定义的“左除法”和“右除法”。拟群的公理化需要用到存在量词，因此也就需要建立在一阶逻辑之上



#### 幺拟群 圈 Loop

有单位元的拟群称作**幺拟群**或者**圈**loop





#### 半群 Semigroup

> 集合 + 二元运算(封闭性) + **结合律** = 半群

非空集合S和其上的二元运算 **·** (即映射· : S×S→S)。若 · 满足：

1. **封闭性**: ∀a, b ∈ G，a·b的结果也在G中(闭合公理已经由·是二元运算的条件所蕴含,可以不加以说明需要满足封闭性)
2. **结合律**：∀x, y, z ∈ S ，**(x·y)·z = x·(y·z)** **可结合性**(顺序不可变，因为没有交换律)

则称·在S上是可结合的，有序对(S,·)为**半群**，运算 · 称为该半群的**乘法**，简称S是一个半群



#### 幺半群 Monoid

>   含幺半群 单群 亚群 具幺半群 四分之三群
>
>   半群(封闭性 结合律) + **单位元** = 幺半群

**幺半群**是一个带有二元运算 ·: M × M → M 的集合 M，其符合下列公理：

1. **封闭性**: ∀a, b ∈ G，a·b的结果也在G中(闭合公理已经由·是二元运算的条件所蕴含,可以不加以说明需要满足封闭性)
2. **结合律**：对任何在 M 内的a, b, c, 有(a·b) c = a(bc) 。
3. **单位元**：存在一在 M 内的元素e，使得任一于 M内的 a 都会符合 a·e = e·a = a



#### 群 Group

> 集合 + 二元运算(封闭性) + 结合性(半群) + 单位元(含幺半群) + **逆元** = 群

群(G, · )是一个集合*G*，连同一个运算 · : G × G → G，运算 · 结合任何两个元素a和b而形成另一个元素，记为a·b。(G,·)是群必须满足叫做**群公理**的四个要求:

1.  **封闭性**: ∀a, b ∈ G，a·b的结果也在G中(闭合公理已经由·是二元运算的条件所蕴含,可以不加以说明需要满足封闭性)
2.  **结合性**: ∀a, b, c ∈ G，等式 (a·b)·c = a· (b·c)成立
3.  **单位元**: ∃e ∈ G, 对∀a ∈ G, e·a = a·e = a 成立
4.  **逆元**: ∀a ∈ G, ∃b ∈ S, a·b = b·a = e。(G中每个元素都有逆元)

群**不一定满足交换律**：进行群运算的次序是重要的。换句话说，把元素*a*与元素*b*结合，所得到的结果不一定与把元素*b*与元素*a*结合相同；亦即，a·b=b·a不一定成立

**群具有消去律**：用结合性，逆元来证明。

在群中(不是交换群)一般把单位元e用1代替。

e.g.

- 整数在加法+下构成群，单位元e=0;
- 有理数，实数，复数集在乘法×下构成群; (无限阶)
- 所有2×2矩阵在加法+下构成群，所有行列式不等于0的矩阵在乘法×下构成群
- 集合{T, F}在裸绩异或XOR下构成群，单位元e=F，T^-1^=T



##### 有限/无限群 群的阶

G中的**元素个数|G|**称为该**群的阶**
$$
群G的阶 = |G| = ord(G)
$$

设(G, · )是一个群，如果G是一个有限集合，则称G为**有限群**，否则为**无限群**。

有限群中每个元素的阶都是有限的，否则群就变成无限群了



##### 元素的幂 & 阶 & 逆元性质



**元素的幂**：在一个代数系统(G, · )中(一般讨论的是群)，元素a的**幂**a^n^(n为正整数)定义为：

- a^n^ = a·a·a…a (n个a进行运算)。约定 a^0^ = e

在交换群(加群) (G, + )中，定义中的a^n^ = e就是 na = 0



**元素的阶**：设(G, · )是一个群，e为单位元，a ∈ G，使得 a^n^ = e成立的最小正整数n称为**a的阶(order)**，也称周期(period)，记作o(a)，如果不存在这样的正整数，则称a的阶是**无限阶**的。单位元e的阶为1。
$$
n = \text{ord}{(a)} = |a| = o(a)\\
\text{Lagrange 推论:} \text{ord}{(a)}| ord(G) ; (ord(G): 群G的阶; |G|)
$$


设(G, · )是群，如果G中除了单位元外所有元素都是**二阶**的，则(G, · )是**交换群**





##### 交换群 abel群 加群

> 群(结合性 单位元 逆元) + **交换律** = 交换群

称**群**(G, · )是一个**交换群**(**abel群**)，如果G中的运算(结合法) · 满足：

- **交换律**：∀a, b ∈ G，a · b = b · a



- 通常把交换群中的运算称为**加法运算**，故交换群又称为**加群。**其中单位元称为**零元**，记为**0**。x(x ∈ G)的**逆元**称为**负元**，记作 **-x**



##### 循环群

- 若一个群的每一个元素都是G的某一个固定元素a的乘方，我们把G叫做**循环群**，我们也说**G是由元素a所生成的**，并且用符号G = (a)来表示。a叫做G的一个**生成元**
- 定义：任意的 b ∈ G, 都存在a ∈ G 和一个整数i，都有 b=ai，我们把a 叫群的生成元。记G=\<a\>.
- Euler 函数$$\phi$$(N) ：不超过N且和N互素的元素的个数。

定理：
- 循环群G=(a)的任何子群都是循环群
- 任意的d |#(a) ， 都唯一存在一个阶为d的子群
- 如果#(a)=m， 那么#(a^k^)=ord( a^k^ )=m/（k，m）
- 任意d |#(a) , (a)中存在$$\phi$$(d)个阶为d 的元素
- 如果#(a)=m，那么(a)中有$$\phi$$(m)个生成元
- 素数阶的循环群的任何非恒等元都是生成元



##### 子群

- 设G是一个群，若H是G的一个非空子集且同时H在和G一样的**单位元**与**代数运算**下是一个群，则H称为G的一个子群



---

## 环 Ring

> 环(R, +, ·) = (R, +)为交换群(结合性 单位元 逆元 交换律) + (R, ·)为半群(结合律); 含有两种运算

设(R, +, ·)是代数系统，若(R, +)是**交换群**，(R, ·)是**幺半群**，乘法 · 对于加法 + 是可分配的(即∀x, y, z ∈ R, 均有 x · (y+z) = (x·y) + (x·z), (y+z) · x = (y·x) + (z·x) )，则称(R, +, ·)是环。

e.g.

- 全体整数构成的集合对于普通加法和乘法来说作成一个环
- 全体有理数构成的集合对于普通加法和乘法来说作成一个环
- n阶实方阵全体在矩阵的加和和乘法下构成一个环



#### 交换环 Commutative Ring

> 环(加法满足 结合性 单位元 逆元 交换律) + (R, ·)的乘法**可交换** = 交换环; commutative ring

**交换环**：如果环中**乘法**也是**可交换**的，则称之为**交换环**

- 一般都假定环中至少有两个元素





- **整环(domain)**：设(R, +, ·)是一个环，R $$\neq$${0}，**可交换**，**无零因子**，则称(R, +, ·)是一个整环



#### 除环 Division Ring

> 反对称体 skew field

除环(division ring)**：设(R, +, ·)是一个环，如R中至少有两个元素0和1，**(R^+^, · ) 构成**乘法群**，则称(R, +, ·)是一个除环

> R^+^ = R - {0}; R除了0以外的集合

Division rings differ from fields only in that their multiplication is not required to be **commutative**(可交换的).

---

## 域 Field

> 域是**可交换环**; 

域定义：如果一个环(R, +, ·)既是除环也是可交换环，称这个环为**域**

域是整环

有限整环是域



域定义：Formally, a **field** is a set *F* together with two operations called addition and multiplication. An operation is a mapping that associates an element of the set to *every* pair of its elements. The result of the addition of *a* and *b* is called the *sum* of *a* and *b* and denoted *a* + *b*. Similarly, the result of the multiplication of *a* and *b* is called the *product* of *a* and *b*, and denoted *ab* or *a*⋅*b*. These operations are required to satisfy the following properties, referred to as **field axioms**(域公理). (In the following definitions, *a*, *b* and *c* are arbitrary elements of the field *F*.)

1. **封闭性**: ∀a, b ∈ F，a·b ∈ F, a+b ∈ F
2. **结合律**(*Associativity* ): ∀a, b, c ∈ F, (a·b) · c = a · (b·c); (a+b) + c = a + (b+c);
3. **交换律**(Commutativity): ∀a, b ∈ F，a · b = b · a, a + b = b + a
4. 乘法对加法的**分配律**(Distributivity of multiplication over addition): a · (b+c) = (a·b) + (a·c)
5. 加法和乘法**单位元**(Additive and multiplicative identity): ∃0, 1 ∈ F, 0 ≠ 1; a+0 = a; a·1 = a
6. 加法**逆元**(Additive inverses): ∀a ∈ F, ∃ -a ∈ F, a + (-a) = 0 (加法单位元)
7. 乘法**逆元**(Multiplicative inverses): ∀a ≠0, a ∈ F, ∃ a^-1^ ∈ F, a · a^-1^ = 1 (乘法单位元)







#### 有限域

> 一个元素个数有限的域称为有限域，或者**伽罗瓦域, 伽罗华域 Galois field**

有限域中元素的个数为一个素数，或者一个素数的幂，记为GF(p)或GF(p^n^). (p for prime)

- 有限域中运算满足**交换律、结合律、和分配律**
- 加法的单位元是0,乘法的单位元是1，每个非零元素都有一个唯一的乘法逆元\

域F~P~ ：用Z~P~ 表示， P是一个素数。所有的素数P阶的域都同构于Z~P~

特征：任意的a ∈ A，满足 na=0的最小的自然数n 叫做A的特征

定理：任何一个有限域都有一个素特征

任何一个有限域都可以表示成 GF(P)　或者GF(P^n^)，Ｐ是一个素数。 GF(P^n^)叫做GF(P)的n次扩域，它可以表示成定义在GF(P)上一个n维的向量空间。

子域： GF(P^n^)的子域只有GF(P^m^)，m｜n



#### 伽罗华域 Galois Fields

The polynomials Z~p~[x] mod p(x)  Where  p(x) ∈ Z~p~[x],  p(x) is **irreducible**(不可约的), and deg(p(x)) = n (i.e. n+1 coefficients)  form a finite field. Such a field has p^n^ elements.

These fields are called Galois Fields or GF(p^n^).
The special case n = 1 reduces to the fields Z~p~
The multiplicative group of GF(p^n^)/{0} is **cyclic** (adj. 环的；循环的；周期的).





# Polynomial Arithmetic

> 多项式计算
>
> Polynomial Arithmetic with Modulo Coefficients: 系数以…为模的多项式计算

when computing value of each coefficient do calculation modulo some value could be modulo any prime but we are most interested in mod 2
i.e. all coefficients are 0 or 1
e.g. let f(x) = x^3^ + x^2^ and g(x) = x^2^ + x + 1
f(x) + g(x) = x^3^ + x + 1
f(x) x g(x) = x^5^ + x^2^



## Polynomial Arithmetic with Modulo Coefficients

多项式除法，多项式模运算：

can write any polynomial in the form:
f(x) = q(x) g(x) + r(x)
can interpret r(x) as being a remainder
r(x) = f(x) mod g(x)
if have no remainder say g(x) divides f(x)

##### Irreducible Polynomial

**不可约多项式**: if g(x) has no divisors other than itself & 1 say it is **irreducible** (or **prime**) polynomial polynomial arithmetic modulo an irreducible polynomial with coefficients in the field Z~p~ forms a field

不可约多项式: Definition: An **irreducible polynomial** is one that is not a product of two other polynomials both of degree greater than 0. (Analogous to a prime number. 类似于素数)



### GF(2^n^)

系数为0, 1 bits.The coefficients are bits {0,1}.

For example, the elements of GF(2^8^) can be represented as a byte, one bit for each term, and GF(2^64^) as a 64-bit word. (e.g., x6 + x4 + x + 1 = 01010011). Addition over Z~2~ corresponds to xor.
Just take the xor of the bit-strings (bytes or words in practice). This is dirt cheap

#### Multiplication over GF(2^n^)

If n is small enough can use a table of all combinations(乘法结果表，行列代表参与乘法的操作数，中间元素对应结果).
The size will be 2^n^ x 2^n^ (e.g. 64K for GF(2^8^)).
Otherwise, use standard shift and add (xor)



#### Reduction(Mod)





#### Inversion over GF(2^n^)

If n is small just store in a table(逆元对照表).
Table size is just 2^n^. For larger n, use Euclid’s algorithm. This is again easy to do with shift and xors.







