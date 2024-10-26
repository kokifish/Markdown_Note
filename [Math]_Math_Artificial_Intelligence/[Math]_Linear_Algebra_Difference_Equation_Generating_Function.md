[TOC]



---

# Linear Algebra





## Matrix Multiplication

![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Math_Matrix_multiplication.svg)

![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Math_Matrix_multiplication2.svg)


$$
{\displaystyle \mathbf {A} ={\begin{pmatrix}a_{11}&a_{12}&\cdots &a_{1n}\\a_{21}&a_{22}&\cdots &a_{2n}\\\vdots &\vdots &\ddots &\vdots \\a_{m1}&a_{m2}&\cdots &a_{mn}\\\end{pmatrix}},\quad \mathbf {B} ={\begin{pmatrix}b_{11}&b_{12}&\cdots &b_{1p}\\b_{21}&b_{22}&\cdots &b_{2p}\\\vdots &\vdots &\ddots &\vdots \\b_{n1}&b_{n2}&\cdots &b_{np}\\\end{pmatrix}}}\\
C = AB\\
{\displaystyle \mathbf {C} ={\begin{pmatrix}c_{11}&c_{12}&\cdots &c_{1p}\\c_{21}&c_{22}&\cdots &c_{2p}\\\vdots &\vdots &\ddots &\vdots \\c_{m1}&c_{m2}&\cdots &c_{mp}\\\end{pmatrix}}}\\
{\displaystyle c_{ij}=a_{i1}b_{1j}+a_{i2}b_{2j}+\cdots +a_{in}b_{nj}=\sum _{k=1}^{n}a_{ik}b_{kj},}
$$

- an example:

$$
{\displaystyle {\overset {4\times 2{\text{ matrix}}}{\begin{bmatrix}{a_{11}}&{a_{12}}\\\cdot &\cdot \\{a_{31}}&{a_{32}}\\\cdot &\cdot \\\end{bmatrix}}}{\overset {2\times 3{\text{ matrix}}}{\begin{bmatrix}\cdot &{b_{12}}&{b_{13}}\\\cdot &{b_{22}}&{b_{23}}\\\end{bmatrix}}}={\overset {4\times 3{\text{ matrix}}}{\begin{bmatrix}\cdot &c_{12}&c_{13}\\\cdot &\cdot &\cdot \\\cdot &c_{32}&c_{33}\\\cdot &\cdot &\cdot \\\end{bmatrix}}}}\\
{\displaystyle {\begin{aligned}c_{12}&={a_{11}}{b_{12}}+{a_{12}}{b_{22}}\\c_{33}&={a_{31}}{b_{13}}+{a_{32}}{b_{23}}\end{aligned}}}
$$





## Special Matrix



##### Positive-definite matrix

-   一个*n*×*n*的实对称矩阵 $${\displaystyle M}$$是**正定**的，当且仅当对于所有的非零实系数向量*z*，都有*z*^T^$${\displaystyle M}$$z > 0。其中*z*^T^表示*z*的转置





##### Laplacian matrix

> 拉普拉斯矩阵, 基尔霍夫矩阵,  **Laplacian matrix,** **admittance matrix**, **Kirchhoff matrix**, **discrete Laplacian**
>
> 表示图的一种矩阵 

定义: L为拉普拉斯矩阵，D为图的度矩阵(对角阵)，W为图的邻接矩阵(对角线元素为0)
$$
L = D - W
$$







---

## terminology



###### Rank











###### Vector Space

-   **向量空间**是现代数学中的一个基本概念。是线性代数研究的基本对象
-   向量空间的一个直观模型是向量几何，几何上的向量及相关的运算即向量加法，标量乘法，以及对运算的一些限制如封闭性，结合律，已大致地描述了“向量空间”这个数学概念的直观形象


在现代数学中，“向量”的概念不仅限于此，满足下列公理的任何数学对象都可被当作向量处理。譬如，实系数多项式的集合在定义适当的运算后构成向量空间，在代数上处理是方便的。单变元实函数的集合在定义适当的运算后，也构成向量空间，研究此类函数向量空间的数学分支称为泛函分析



给定域*F*，*F*上的向量空间*V*是一个集合set，其上定义了两种二元运算：

-   **向量加法** + : *V* × *V* → *V*，把*V*中的两个元素 **u** 和 **v** 映射到*V*中另一个元素，记作 **u + v**；
-   **标量乘法** · : *F* × *V* → *V*，把*F*中的一个元素 *a* 和 *V* 中的一个元素**u**变为*V*中的另一个元素，记作 *a* **·u**。

*V*中的元素称为向量，相对地，*F*中的元素称为标量。而集合*V*才构成一个向量空间（对*F*中的任意元素*a*、*b*以及*V*中的任意元素**u**、**v**、**w**都成立）



| 公理            | 说明 u v w 为向量空间V中的向量                      |
| ------------- | ---------------------------------------- |
| 向量加法的结合律      | **u** + (**v** + **w**) = (**u** + **v**) + **w** |
| 向量加法的交换律      | **u** + **v** = **v** + **u**            |
| 向量加法的单位元      | 存在一个叫做**零向量**的元素 **0** ∈ V，使得对任意**u** ∈ V都满足 **u** + **0** = **u** |
| 向量加法的逆元素      | 对任意**v** ∈ V都存在其逆元素 −**v** ∈ V使得 **v** + (−**v**) = **0** |
| 标量乘法与标量的域乘法相容 | a(b · **v**) = (ab) · **v**              |
| 标量乘法的**单位元**  | 域F存在**乘法单位元1**满足 1 **v** = **v**         |
| 标量乘法对向量加法的分配律 | a·(**u** + **v**) = a·**u** + a·**v**    |
| 标量乘法对域加法的分配律  | (a + b)·**v** = a·**v**+ b·**v**         |

对一般域*F*，*V*记为*F*-**向量空间**。若*F*是实数域ℝ，则*V*称为**实数向量空间**；若*F*是复数域ℂ，则*V*称为**复数向量空间**；若*F*是有限域，则*V*称为**有限域向量空间**



###### Invertible matrix

>   可逆矩阵 非奇异矩阵

-   In linear algebra, an *n*-by-*n* square matrix **A** is called **invertible** (also **nonsingular** or **nondegenerate**) if there exists an *n*-by-*n* square matrix **B** such that AB = BA = I~n~
-   若方阵A满足条件det(A) ≠ 0，则称A为**非奇异方阵**，否则称为**奇异方阵**
-   n阶方阵A是非奇异方阵的充要条件是A可逆，即**可逆方阵 = 非奇异方阵**




>   不可逆的矩阵成为奇异矩阵



###### Symmetric Matrices

>   对称矩阵

-   元素以主对角线为对称轴对应相等的矩阵

---

## Determinants

>   行列式

-   **行列式** Determinant 是数学中的一个函数，将一个 n*n 的矩阵A映射到一个标量，记作det(A)或|A|
-   



$$
二阶方阵的行列式\\
detA = a_{11}a_{22} - a_{12}a_{21} \\
\mathbf{A} =
\left( \begin{array}{A}
a_{11} &a_{12} \\
a_{21}&a_{22} \\
\end{array} \right)
$$




$$
将三阶方阵A用第一行展开计算行列式 \\
detA =a_{11}·detA_{11} - a_{12}·detA_{12} + a_{13}·detA_{13}\\
\mathbf{A} =
\left( \begin{array}{A}
a_{11} &a_{12} & a_{13}\\
a_{21} &a_{22} &a_{23}\\
a_{31} &a_{32} &a_{33}\\
\end{array} \right)\\
\mathbf{A}_{12}是划掉A的第一行和第二列后得到的子矩阵
$$





## Eigenvalues and Eigenvectors

>   特征值 特征向量

-   对于一个给定的矩阵$$\displaystyle A$$，它的**特征向量**(eigenvector，**固有向量**,**本征向量**)$$\displaystyle v$$ 经过这个线性变换之后，得到的新向量仍然与原来的$${\displaystyle v}$$ 保持在**同一条直线**上，但其长度或方向也许会改变。即

-   $${\displaystyle Av=\lambda v}$$

-   $$\lambda$$为标量，即特征向量的长度在该线性变换下缩放的比例，称$$\displaystyle \lambda $$ 为其**特征值**(本征值)

-   




###### Vandermonde Matrix

-   范德蒙矩阵是一个各行(row 横向)呈现出几何级数关系的矩阵(同一行中，每一项都是前一项的k倍)


$$
\mathbf{Vandermonde Matrix} =
\left( \begin{array}{Vandermonde Matrix}
1 & \alpha_{1} & \alpha_{1}^{2} & \ldots & \alpha_{1}^{n-1} \\
1 & \alpha_{2} & \alpha_{2}^{2} & \ldots & \alpha_{2}^{n-1} \\
\vdots & \vdots & \vdots & \ddots  & \vdots\\
1 & \alpha_{m} & \alpha_{m}^{2} & \ldots & \alpha_{m}^{n-1} \\
\end{array} \right)
$$





![Vandermonde Matrix](http://op4fcrj8y.bkt.clouddn.com/18-4-16/77407270.jpg)









---

## Matrix Factorications

-   矩阵分解



### LU





---

# Difference Equation

-   **递推关系(recurrence relation)**，也就是**差分方程(difference equation)**，是一种递推地定义一个序列的方程：序列的每一项目是定义为**前一项的函数**
-   所谓解一个递推关系式，也就是求其**解析解**，即关于*n*的非递归函数
-   差分(**difference**): 相邻两个数据之间的差，也就是变化量，用Δ来表示: Δy~t~ =y~t+1~ – y~t~

递推关系式例子:

-   等比数列: x~0~ = a, x~1~ = x~0~ + d,  x~2~ = x~1~ + d ... x~n~ = x~n-1~ + d
-   等比数列: x~0~ = a, x~1~ = x~0~·q, x~2~ = x~1~·q ... x~n~ = x~n-1~·q
-   阶乘: 0! = 1, n! = n · (n-1)!
-   斐波那契数列: 

>   离散数学课本 p514



---

# Generating Function

-   某个序列(a~n~)的**母函数**(**生成函数** Generating function)是一种形式幂级数，其每一项的系数可以提供关于这个序列的信息。使用母函数解决问题的方法称为**母函数方法**
-   母函数可分为很多种，包括**普通母函数**、**指数母函数**、**L级数**、**贝尔级数**和**狄利克雷级数**。对每个序列都可以写出以上每个类型的一个母函数。构造母函数的目的一般是为了解决某个特定的问题，因此选用何种母函数视乎序列本身的特性和问题的类型   

