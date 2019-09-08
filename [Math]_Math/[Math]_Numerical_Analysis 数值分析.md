[TOC]





## 插值法

-   插值一般是在只知道一些离散的插值节点以及对应函数值的情况下，利用这些插值节点及相应函数值，构造出一个在插值节点满足一定条件(例如函数值相等)的插值函数

###### 龙格现象

-   在数值分析领域中，**龙格现象**是在一组**等间插值点**上使用具有**高次多项式**的多项式插值时出现的**区间边缘处**的**振荡**问题



解决龙格现象的方法:

-   使用**切比雪夫节点**代替等距点可以减小震荡，在这种情况下，随着多项式阶次的增加最大误差逐渐减小。这个现象表明高阶多项式通常不适合用于插值。使用分段多项式**样条**可以避免这个问题。如果要减小插值误差，那么可以增加构成样条的多项式的数目，而不必是增加多项式的阶次


#### 均差(差商)及其性质

>   均差字面含义(瞎猜的): 平均的差值，所以要用值的差(y~k+1~ - y~k~)除以导致这个值的差的自变量的变化量(x~k+1~ - x~k~)
>
>   微商是均差(差商)的极限形式(自变量x的变化趋于无穷小)

-   均差也称为差商

$$
f(x)关于点x_{0},x_{k}的一阶均差： f[x_{0}, x_{k}]= \frac{f(x_{k})  - f(x_{0}) } { x_{k} - x_{0} }\\
f(x)关于点x_{0},x_{1},x_{k}的二阶均差： f[x_{0}, x_{1},  x_{k}]= \frac{f[x_{0}, x_{k}] - f[x_{0}, x_{1}]) } { x_{k} - x_{1} }\\
f(x)的k阶均差： f[x_{0}, x_{1}, \ldots ,x_{k}]= \frac{f[x_{0}, \ldots, x_{k-2}, x_{k}] - f[x_{0}, x_{1},\ldots, x_{k-1}] } { x_{k} - x_{k-1} }\\
$$

-   注意观察式子，等式右边取反后，上下对应的补齐了缺项

对称性：





#### Lagrange polynomials

>   拉格朗日插值多项式

In numerical analysis, **Lagrange interpolation polynomials** are used for polynomial interpolation(多项式插值).


$$
若n次多项式l_{j}(x)(f = 0,1,\dots,n)在n+1个节点x_{0}<x_{1}<...<x_{n}(不要求等距)上满足:\\
l_j(x_k)=\left\{
\begin{aligned}
1,\ & k = j,\\
0,\ & k \ne j ,\\
\end{aligned} j,k = 0,1,...,n,\right. \\
则称这n+1个n次多项式l_0(x),l_1(x),\dots,l_n(x)为节点x_0, x_1, \dots x_n上的n次插值基函数\\

n次插值基函数 : l_{k}(x) = \dfrac{(x-x_{0})\dots(x-x_{k-1})(x-x_{k+1})\dots (x-x_{n})}
{(x_{k}-x_{0})...(x_{k}-x_{k-1})(x_{k}-x_{k+1})\dots(x_{k}-x_{n}) }  ,(k\in[0, n], k\in Z)\\

\blacktriangleright\blacktriangleright\blacktriangleright\ 拉格朗日插值多项式: L_{n}(x) = \sum_{k=0}^{n} y_{k}l_{k}(x) \ \diamondsuit \bullet \\
---\\
拉格朗日插值多项式另一种表示方法: \\

引入记号:\omega_{n+1}(x)=(x-x_0)(x-x_1)\dots(x-x_n),共n+1项\\
可以求得: \omega^{'}_{n+1}(x_k)=(x_k-x_0)(x_k-x_1)\dots(x_k-x_n),共n+1项\\
故可改写拉格朗日插值多项式: L_{n}(x) =\sum_{k=0}^{n} y_{k}\dfrac{\omega_{n+1}(x)}
{(x-x_k)\omega^{'}_{n+1}(x_k)},\ (k\in[0, n], k\in Z)\\
插值基函数: l_k(x) =  \dfrac{\omega_{n+1}(x)}
{(x-x_{k})\omega^{'}_{n+1}}  \\
---\\
\omega^{'}_{n+1}(x_k)证明:
\omega_{n+1}(x)=(x-x_k)·(x-x_0)(x-x_1)\dots(x-x_{k-1})(x-x_k+1)\dots(x-x_n)\\
\omega^{'}_{n+1}(x_k)=(1)·[(x-x_0)(x-x_1)\dots(x-x_{k-1})(x-x_k+1)\dots(x-x_n)]\\
+(x-x_k)·[(x-x_0)(x-x_1)\dots(x-x_{k-1})(x-x_k+1)\dots(x-x_n)^{'}]\\
=(x-x_0)(x-x_1)\dots(x-x_{k-1})(x-x_k+1)\dots(x-x_n),共n项
$$





-   $$f(x) = \frac{1}{1+x^2}$$ 的拉格朗日插值函数求解的python版//令插值节点为-5，-4，-3，-2，-1，0，1，2，3，4，5，在这些节点处Lagrange插值

```python
#author: 黄海宇 student_id = 16337087 信息安全专业 SDCS SYSU
#f(x) = 1/(1+x**2)
#令插值节点为-5，-4，-3，-2，-1，0，1，2，3，4，5，在这些节点处Lagrange插值

# itplt: interpolation, prcs: precise
import numpy as np
import matplotlib.pyplot as plt

prcs_ist_x = list(range(-5, 6)) #插值节点
prcs_ist_y = [1/(1+x**2) for x in range(-5,6)]

#计算拉格朗日插值函数的基函数，返回np.poly1d
def cal_base_func(x_list:list, x_k):
    base_func = np.poly1d([1]) #拉格朗日插值多项式的基函数
    if(x_k not in x_list):
        return base_func

    for x in x_list:
        if (x_k != x):
            cpm_poly = np.poly1d([1, -x])/ float(x_k - x)
            base_func *=  cpm_poly
    return base_func

Lagrange_func = np.poly1d([0]) #最后用于存储拉格朗日插值多项式
for index in range(0, len(prcs_ist_x)):
    base_func = cal_base_func(prcs_ist_x, prcs_ist_x[index])#call cal_base_func, 计算基函数
    Lagrange_func += prcs_ist_y[index] * base_func

print(Lagrange_func) #插值函数

#误差计算 算法为区间[-5,5]内101个等距分布点处的误差绝对值的平均值
prcs_x = np.linspace(-5, 5, 101) #插值节点
prcs_y = (1 /(prcs_x**2 +1))
itplt_y = Lagrange_func(prcs_x)
mean_error = 0.0
itr_prcs = iter(prcs_y)
itr_itplt = iter(itplt_y)

while True:
    try:
        y1 = next(itr_prcs)# 获得下一个值
        y2 = next(itr_itplt)
        mean_error += abs(y1 - y2)
    except StopIteration:
        break
mean_error /= 101
print("拉格朗日插值法的误差: ", mean_error)


###matplotlib.pyplot绘图
plt.figure(num = 1, figsize=(12,6))
plt.grid(False)
x_ticks = np.linspace(-10, 10, 21) #起始值，终止值，点数
plt.xticks(x_ticks)
plt.xlim(-6, 6)
plt.ylim(-1, 2)
plt.title("Lagrange polynomials")
plt.xlabel("x") # x轴label
plt.ylabel("y") # y轴label

###坐标更改
ax = plt.gca() # gca = 'get current axis'
ax.spines['right'].set_color('none') #spines:脊柱,这里指轴,函数图像框的四条边
ax.spines['top'].set_color('none') #使上边的框颜色透明
ax.xaxis.set_ticks_position('bottom') #将x坐标轴用bottom的坐标轴代替
ax.spines['bottom'].set_position(('data', 0))
ax.yaxis.set_ticks_position('left')
ax.spines['left'].set_position(('data', 0))

###matplotlib.pyplot原函数绘图
prcs_x = np.linspace(-6, 6, 1000)
prcs_y = (1 /(prcs_x**2 +1))
plt.plot(prcs_x, prcs_y, color="black", linewidth=1)

###matplotlib.pyplot插值函数绘图
itplt_x = np.linspace(-6, 6, 1000)
plt.plot(itplt_x, Lagrange_func(itplt_x), color="red", linewidth=1.5)

plt.show() #显示图像

```











#### Newton Polynomial







#### Hermite interpolation

>   埃尔米特插值

-   **埃尔米特(Hermite)插值**: 在给定的节点处，不但要求插值多项式的函数值与原函数值相同。同时还要求在插值节点处，插值多项式的**一阶直至指定阶的导数值**，也与被插函数的相应阶导数值相等
-   Hermite插值在不同的节点，提出的插值条件个数可以不同，若在某节点x\_{i}，要求插值函数多项式的函数值，一阶导数值，直至m~i-1~阶导数值均与被插函数的函数值相同及相应的导数值相等。我们称x~i~为m~i~重插值点节因此，Hermite插值应给出两组数，一组为插值$${\displaystyle \{x_{i}\}_{i=0}^{n}}$$节点，另一组为相应的重数标号$${\displaystyle \{m_{i}\}_{i=0}^{n}}$$
-   若$${\displaystyle \sum _{i=0}^{n}m_{i}=N+1}$$ ，这就说明了给出的插值条件有$${\displaystyle N+1}$$个，为了保证插值多项式的存在唯一性，这时的Hermite插值多项式应在$${\displaystyle P_{n}}$$上求得


##### 二重Hermite插值

>   一般来说，n+1个插值节点都是二重节点时(函数值与一阶导相等)，需要满足2n+2个条件，构造出2n+1次的埃尔米特插值

-   在插值节点$${\{x_i\}}^n_{i=0}$$ 上，函数值与一阶导数值相等

-   给定的插值节点 $${\{x_i\}}^n_{i=0}$$ 均为二重节点，更具体些， $${\displaystyle f(x)\in C^{2}([a,b])}$$ ，及插值节点$${\{x_i\}}^n_{i=0}$$，若有 $${\displaystyle H_{2n+1}(x)\in P_{2n+1}}$$ 满足 

    $$H_{2n+1}(x_i)=f(x_i)$$，  $$ {\displaystyle H^{'}_{2n+1}(x_i) = f^{'}(x_i), i=0, 1,..., n, } $$，

    就称H~2n+1~(x)为*f*(*x*) 关于插值节点 $${\{x_i\}}^n_{i=0}$$ 的二重Hermite插值多项式


二重Hermite插值多项式(2n+1次Hermite插值多项式)满足形式:

-   $$ {\displaystyle H_{2n+1}(x) = \sum ^n_{i=0}f(x_i)\alpha_i(x) + \sum^n_{i=0}f^{'}(x_i)\beta_i(x)} $$

>    在拉格朗日插值函数的基础上添加对导数的约束

构造Hermite插值的关键是构造基函数$$\alpha_i(x), \beta_i(x)$$，需要满足以下约束条件:
$$
\alpha_j(x_k)=\left\{
\begin{aligned}
1,\  k = j,\\
0,\  k \ne j ,\\
\end{aligned}\  j, k=0,1,...,n;\ \alpha^{'}_i(x)=0\right. \\
 \beta^{'}_j(x_k) = \left\{
  \begin{aligned}
 1,\  k = j,\\
0,\  k \ne j ,\\
  \end{aligned}\ j, k=0,1,...,n;\  \beta_j(x_k) = 0\right.\\
$$

>   $$\alpha^{'}_i(x)永远为0,\ \beta_j(x) 永远为0$$

$$
\blacktriangleright\blacktriangleright\blacktriangleright \ H_{2n+1}(x) = \sum ^n_{k=0} (l_k)^2[ (x_k - x)(2\alpha_k y_k-y^{'}_k)+y_k ]\ \\
y_k = y(x_k),\ y^{'}_k = y^{'}(x_k)\\
l_k(x)为拉格朗日插值函数基函数:\\
l_{k}(x) = \dfrac{(x-x_{0})\dots(x-x_{k-1})(x-x_{k+1})\dots (x-x_{n})}
{(x_{k}-x_{0})...(x_{k}-x_{k-1})(x_{k}-x_{k+1})\dots(x_{k}-x_{n}) }  ,(k\in[0, n], k\in Z)\\
\alpha_k = \sum ^n_{j=0,j\ne k}\frac{1}{x_k-x_j}
$$



两点三次Hermite插值：插值节点为$$x_{k},x_{k+1}$$,要求在两个插值结点上原函数值与一阶导函数值相等

$$
H_3(x) = (1+2\frac{x-x_k}{x_{k+1} -x_k})(\frac{x-x_{k+1}}{x_k-x_{k+1}})^2 y_k
+(1+2\frac{x-x_{k+1}}{x_{k} -x_{k+1}})(\frac{x-x_{k}}{x_{k+1}-x_{k}})^2y_{k+1}\\
+(x-x_k)(\frac{x-x_{k+1}}{x_k-x_{k+1}})^2m_k
+(x-x_{k+1})(\frac{x-x_{k}}{x_{k+1}-x_{k}})^2m_{k+1}\\
m_k = f'(x_{k}),m_{k+1} = f'(x_{k+1})
$$


#### Spline interpolation

>   样条插值。分段线性插值=线性样条插值
>
>   piecewise Cubic Hermite spline 分段三次Hermite样条
>
>   Piecewise Cubic Spline Interpolating 分段三次样条插值

-   **样条插值**是使用一种名为样条的特殊**分段多项式**进行插值的形式。样条插值可以使用低阶多项式样条实现较小的插值误差，避免了使用高阶多项式所出现的龙格现象
-   ​




#####  Piecewise Cubic Spline Interpolating

>   分段三次样条插值 每一段的与原函数的值，一阶二阶导的值都相等的样条插值

对n+1个插值节点$${\{x_i\}}^n_{i=0}$$ ，可以用n段三次多项式在数据点之间构建三次样条，若有S(x)满足如下形式:
$$
S(x)=\left\{{\begin{matrix}
S_{0}(x),\ x\in [x_{0},x_{1}]\\
S_{1}(x),\ x\in [x_{1},x_{2}]\\
\cdots \\
S_{{n-1}}(x),\ x\in [x_{{n-1}},x_{n}]
\end{matrix}}\right.
$$
则S(x)可以表示对函数f进行插值的**样条函数**，需要满足：

1.  插值特性，S(x~i~)=f(x~i~)
2.  样条相互连接，S~i-1~(x~i~) = S~i~(x~i~), i=1,...,n-1 //在插值点左右两段的插值函数值在插值点相等
3.  两次连续可导，S'~i-1~(xi) = S'~i~(x~i~)以及S''~i-1~(x~i~) = S''~i~(x~i~), i=1,...,n-1.//一阶二阶导均在插值点左右分段插值函数处相等

由于每个**三次多项式需要四个条件才能确定**曲线形状，所以对于组成*S*的*n*个三次多项式来说，这就意味着需要4*n*个条件才能确定这些多项式。但是，插值特性只给出了*n* + 1个条件，内部数据点给出*n* + 1 − 2 = *n* − 1个条件，总计是4*n* − 2个条件。我们还需要另外两个条件，根据不同的因素我们可以使用不同的条件。





不知道原函数解析式，只有离散的插值点时：假定有n+1个数据节点作为插值节点$${\{x_i\}}^n_{i=0}$$, 以及对应的n+1个函数值$${\{y_i\}}^n_{i=0}$$

1.  计算步长$$h_i = x_{i+1}-x_{i},\ (i = 0, 1, …, n-1)$$
2.  将数据节点和指定的首位端点条件带入矩阵方程
3.  解矩阵方程，求得**二次微分**值$$M_i$$。该矩阵为三对角矩阵
4.  计算三次样条插值函数的系数
5.  在每个子区间中，创建方程

###### 逆推的构造方法

三次样条插值的推导方法参考链接: //https://www.bb.ustc.edu.cn/jpkc/xiaoji/szjsff/jsffkj/chapt1_6_1.htm //https://blog.csdn.net/zb1165048017/article/details/48311603
$$
设二次微商值M_{i} = f^{''}(x_{i}), i = 0,1,...,n(实际上最后用差商); \\
步长h_{i} = x_{i+1}-x_{i},可得(若插值节点为等距节点,h = h_0 =... =h_{n-1})\\
\because S^{''}(x)在[ x_{i}, x_{i+1} ]上是线性函数 (\because S(x)在每一段上是三次函数)\\
\therefore 根据拉格朗日插值函数的思想，可以构造出\\
S^{''}(x) = \frac{ x-x_{i+1} }{x_{i} - x_{i+1}} M_{i}  + \frac{ x-x_{i} }{x_{i+1} - x_{i}} M_{i+1}
= \frac{ x_{i+1} - x}{h_{i}} M_{i}  + \frac{ x-x_{i} }{h_{i}} M_{i+1}\\
上式对x分别积分一次、两次得:\\
S^{'} = \frac{ -(x_{i+1} - x)^{2} }{2h_{i}} M_{i}  + \frac{ (x-x_{i})^2 }{2h_{i}} M_{i+1} + c\\
S = \frac{ (x_{i+1} - x)^{3} }{6h_{i}} M_{i}  + \frac{ (x-x_{i})^3 }{6h_{i}} M_{i+1} + cx+d \ (可以整理得到下式)\\
S = \frac{ (x_{i+1} - x)^{3} }{6h_{i}} M_{i}  + \frac{ (x-x_{i})^3 }{6h_{i}} M_{i+1} + C(x_{i+1} - x) + D(x-x_{i})\\
将S(x_{i}) = y_{i}, S(x_{i+1}) = y_{i+1}带入上式，可得\\
C =  \frac{ y_{i} }{h_{i}}  - \frac{h_{i} M_{i} }{6}, \ D =  \frac{ y_{i+1} }{h_{i}}  - \frac{h_{i} M_{i+1} }{6}\\
\therefore S = \frac{ (x_{i+1} - x)^{3} }{6h_{i}} M_{i}  + \frac{ (x-x_{i})^3 }{6h_{i}} M_{i+1} +  (\frac{ y_{i} }{h_{i}}  - \frac{h_{i} M_{i} }{6}) (x_{i+1} - x) + (\frac{ y_{i+1} }{h_{i}}  - \frac{h_{i} M_{i+1} }{6}) (x-x_{i}) \blacktriangleleft \\
\therefore S^{'} = \frac{ -(x_{i+1} - x)^{2} }{2h_{i}} M_{i}  + \frac{ (x-x_{i})^2 }{2h_{i}} M_{i+1} + \frac{ y_{i+1} - y_{i}}{h_{i}} -  \frac{h_{i}( M_{i+1}-M_{i} )}{6}\\
在[x_{i},x_{i+1}]上: S^{'}(x_{i}+0) = -\frac{h_i M_i}{3} - \frac {h_i M_{i+1}}{6} + \frac {y_{i+1}-y_i}{h_i}\\
在[x_{i-1},x_{i}]上: S^{'}(x_{i}-0) = \frac{h_{i-1} M_{i-1}}{6} + \frac {h_{i-1} M_{i}}{3} + \frac {y_{i}-y_{i-1}}{h_{i-1}}\\
S^{'}(x_{i}+0) = S^{'}(x_{i}-0) \Longrightarrow \mu_iM_{i-1} + 2M_i + \lambda_i M_{i+1} = d_i,\ i = 1, 2,...,n-1.\\
其中: \mu_i = \frac{h_{i-1}}{h_{i-1}+h_i}, \lambda_i = \frac {h_i}{h_{i-1} + h_i},\\
d_i = 6 \frac {f[x_i, x_{i+1}] - f[x_{i-1}, x_i]}{h_{i+1} + h_{i}} = 6f[x_{i-1}, x_i, x_{i+1}] = 6 \frac{\frac{y_{i+1} - y_i}{h_i} - \frac{y_{i} - y_{i+1}}{h_{i-1}}}{h_{i+1} + h_{i}}\\
当使用第一类边界条件时，即已知两端的一阶导数值 S^{'}(x_0)=f^{'}_0, S^{'}(x_n) = f^{'}_n, 可得\\
S^{'}(x_0 +0) = f^{'}_0 \Longrightarrow -\frac{h_0 M_0}{3} - \frac {h_0 M_{0+1}}{6} + \frac {y_{1}-y_0}{h_0} = f^{'}_0,\  (f[x_0, x_1]= \frac {y_{1}-y_0}{h_0})\\
\Longrightarrow 2M_0 + M_1 = \frac {6}{h_0}(f[x_0, x_1] - f^{'}_0),\\
S^{'}(x_n -0) = f^{'}_n\Longrightarrow M_{n-1} + 2M_n = \frac {6}{h_{n-1}}(f^{'}_n - f[x_{n-1}, x_n]),\\
若令\lambda_0 = 1, \mu_n = 1, d_0 = \frac {6}{h_0}(f[x_0, x_1] - f^{'}_0), d_n = \frac {6}{h_{n-1}}(f^{'}_n - f[x_{n-1}, x_n])\\
则可以得到一个线性方程组，写成矩阵形式:\\
\left[ \begin{matrix}
   2 & \lambda_0 & & \\
   \mu_1 & 2 & \lambda_1 & \\
  & \ddots & \ddots & \ddots \\
  & & \mu_{n_1} & 2 & \lambda_{n-1}\\
   & & & \mu_{n_1} & 2 \\
  \end{matrix} \right] 
  
  \left[ \begin{matrix}
  M_0\\
  M_1\\
  \vdots \\
  M_{n-1}\\
  M_n\\
  \end{matrix} \right]   = 
  \left[ \begin{matrix}
  d_0\\
  d_1\\
  \vdots \\
  d_{n-1}\\
 d_n\\
  \end{matrix} \right] .\\
  解矩阵得到M_i, 带入S_i的解析式中，即可得到每个子区间上的三次样条插值函数\\
$$













---

## 函数逼近与快速傅里叶变换











### 正交多项式



##### Legendre polynomials

>   勒让德多项式







##### Chebyshev polynomials

>   切比雪夫多项式

-   **切比雪夫多项式**是与棣莫弗定理有关，以递归方式定义的一系列**正交多项式序列**。 通常，第一类切比雪夫多项式以符号T~n~表示， 第二类切比雪夫多项式用U~n~表示。切比雪夫多项式 T~n~ 或 U~n~ 代表 *n* 阶多项式
-   切比雪夫多项式在逼近理论中有重要的应用。这是因为第一类切比雪夫多项式的根(被称为切比雪夫节点)可以用于多项式插值。相应的插值多项式能最大限度地降低**龙格现象**，并且提供多项式在**连续函数**的最佳一致逼近

![切比雪夫多项式](http://op4fcrj8y.bkt.clouddn.com/18-6-2/78139152.jpg)



**第一类切比雪夫多项式**由以下递推关系确定

$$T_0(x) = 1 $$

$${\displaystyle T_{1}(x)=x\,}$$

$${\displaystyle T_{n+1}(x)=2xT_{n}(x)-T_{n-1}(x)}$$


母函数为:

$$\sum_{n=0}^{\infty}T_n(x) t^n = \frac{1-tx}{1-2tx+t^2}$$


**第二类切比雪夫多项式**由以下递推关系给出

$$U_0(x) = 1 \,$$

$${\displaystyle U_{1}(x)=2x\,}$$

$${\displaystyle U_{n+1}(x)=2xU_{n}(x)-U_{n-1}(x).\,}$$


母函数为:

$$\sum_{n=0}^{\infty}U_n(x) t^n = \frac{1}{1-2tx+t^2}$$



T~n~ 和U~n~ 都是区间[−1,1] 上的**正交多项式系**.(带权)

第一类切比雪夫多项式带权$$\frac{1}{\sqrt{1-x^2}}$$
$$
\int_{-1}^1 T_n(x)T_m(x)\,\frac{dx}{\sqrt{1-x^2}}=\left\{
\begin{matrix}
0 &: n\ne m~~~~~\\
\pi &: n=m=0\\
\pi/2 &: n=m\ne 0
\end{matrix}
\right.
$$



可先令*x=* cos(θ) 利用 *Tn* (cos(θ))=cos(nθ)便可证明.

类似地，第二类切比雪夫多项式带权$$\sqrt{1-x^2}$$


$$
\int_{-1}^1 U_n(x)U_m(x)\sqrt{1-x^2}\,dx = 
\begin{cases}
0     &: n\ne m\\
\pi/2 &: n=m
\end{cases}
$$

其正交化后形成的随机变量是 Wigner 半圆分布.



###### Chebyshev nodes

>   切比雪夫节点

-   两类的*n*次切比雪夫多项式在区间[−1,1]上都有*n* 个不同的根, 称为**切比雪夫根**, 有时亦称做**切比雪夫节点** ，因为是多项式插值时的 *插值点* . 从三角形式中可看出T~n~ 的*n*个根分别是
-   $$x_i = \cos\left(\frac{2i-1}{2n}\pi\right) \mbox{ , } i=1,\ldots,n.$$
-   类似地， U~n~ 的*n*个根分别是：
-   $$x_i = \cos\left(\frac{i}{n+1}\pi\right) \mbox{ , } i=1,\ldots,n.$$



---

## 数值积分 数值微分

>   精确的积分: 
>
>   牛顿-莱布尼兹(Newton-Leibniz)公式$$\int^{b}_{a} f(x)dx = F(b) - F(a), 其中F^{'}=f$$
>
>   对于原函数不能用初等函数表达，或者表达困难的，需要采用不精确的积分来近似，即数值积分

机械求积：把积分区间分成很多个小区间，每个小区间取一个合适的f(x)，类似于求多个小矩形的面积，求得积分(积分区间形成的大矩形)
$$
在积分区间[a, b]上取a = x_0 < x_1 < x_2<...<x_{n-1}<x_{n}=b, x_k称为求积节点\\
用求积系数(伴随节点x_k的权)A_k为权，对f(x_k)加权求和\\
构造出机械求积公式\ \int^{b}_{a}f(x)dx \approx \sum^n_{k=0}A_k ·f(x_k)\\
权A_k仅仅与节点x_k的选取有关，不依赖于被积函数f(x)的具体形式\\
若A_k >0 \ (k=0, 1, 2, ..., n),则机械求积公式是稳定的
$$


插值型求积公式：用容易计算积分而又与原来的函数“相近”的函数来代替原来的函数
$$
在积分区间[a, b]给定一组节点a = x_0 < x_1 < x_2<...<x_{n-1}<x_{n}=b,\\
且已知函数f(x)在这些节点上的值y_0 = f(x_0), y_1=f(x_1),...y_n=f(x_n)\\
作插值函数L_n(x) = \sum_{k=0}^{n} y_{k}l_{k}(x)//拉格朗日插值函数\\
取I_n \approx\int^{b}_{a} L_n(x)dx = \int^{b}_{a} \sum_{k=0}^{n} y_{k}l_{k}(x) = \sum_{k=0}^{n}\int^{b}_{a}l_{k}(x)dx·y_{k}\\
构造出插值型求积公式I_n = \sum_{k=0}^{n}A_k f(x_k)\\
求积系数A_k = \int^{b}_{a}l_{k}(x)dx, k=0, 1, ...,n
$$







###### 代数精度

-   如果一个求积公式对于次数不超过m的多项式均能准确地成立，但对于m+1次多项式不能准确成立，则称该求积公式具有**m次代数精度**(代数精确度)




##### 牛顿-柯特斯公式

>   牛頓－寇次公式 Newton–Cotes formulas

-   一种插值型公式

$$
设将积分区间[a, b]划分为n等份，步长h=\frac{b-a}{n}\\
选取等距节点x_k = a+kh构造出插值型求积公式\\
I_n  = \int^{b}_{a} f(x)dx \approx (b-a)\sum^{n}_{k=0} C^{(n)}_{k} f(x_k) \ 牛顿-柯特斯(Newton-Cotes)公式\\

= (b-a)\frac  {1}{n}\int _{0}^{n}\prod^{n} _{{j=0,k\neq j}}{\frac  {t-j}{k-j}}·f(x_k)dt \ (展开柯特斯系数写成插值形式)\\
柯特斯系数 C_{{k}}^{{(n)}}={\frac  {1}{n}}\int _{0}^{n}\prod _{{k\neq j}}{\frac  {t-j}{k-j}}dt={\frac  {(-1)^{{n-k}}}{n\cdot k!(n-k)!}}\int _{0}^{n}\prod _{{k\neq j}}(t-j)dt\ (k = 0,1,...,n)\\
另一种推导方式:\\
\int _{a}^{b}f(x)\,dx\approx \sum _{{i=0}}^{n}w_{i}\,f(x_{i})\\
\int _{a}^{b}f(x)\,dx\approx \int _{a}^{b}L(x)\,dx=\int _{a}^{b}\left(\sum _{i=0}^{n}f(x_{i})\,l_{i}(x)\right)\,dx=\sum _{i=0}^{n}f(x_{i})\underbrace {\int _{a}^{b}l_{i}(x)\,dx} _{w_{i}}
$$



-   n = 8时柯特斯系数$$C_{{k}}^{{(n)}}$$出现负值，$$n\geqslant10时，C_{{k}}^{{(n)}}$$均出现负值，故$$n\geqslant 8$$的Newton–Cotes formulas是不用的
-   阶n为偶数时，Newton–Cotes formulas至少有n+1次代数精度





###### 梯形公式

-   n=1时的牛顿-柯特斯公式，代数精度为1

$$
梯形公式:\\
\int^{b}_{a} f(x)dx \approx \frac{b-a}{2}[f(a) + f(b)]\\
中矩形公式，矩形公式:\\
\int^{b}_{a}f(x)dx \approx (b-a)f(\frac{b-a}{2})
$$



###### 辛普森(Simpson)公式

-   n=2时的牛顿-柯特斯公式，代数精度n+1=3

$$
S_1 = S =\frac{b-a}{6}[f(a) + 4f(\frac{b-a}{2}) + f(b)]\\
=\frac{h}{6}[f(a) + 4f(\frac{b-a}{2}) + f(b)] \ ;h为步长，在这里就是积分区间长度b-a
$$



###### 柯特斯(Cotes)公式

-   n=4时的牛顿-柯特斯公式，代数精度n+1=5
-   将积分区间[a, b]划分为4等份，步长$$h=\frac{b-a}{5}$$, 插值节点为$$\{x_k\}^5_{k=0}$$

$$
C =\frac{b-a}{90}[7f(x_0)+32f(x_1)+12f(x_x)+32f(x_3)+7f(x_4)]
$$





##### 复合求积公式

-   在每个子区间(通常等分)上使用低阶的求积公式，称为复合求积法



###### 复合梯形公式

-   将区间[a, b]划分为n等分，形成n+1个插值节点，在每个子区间采用梯形公式

$$
I = \int^{b}_{a} f(x) dx = \sum^{n-1}_{k=0} \int^{x_{k+1} }_{x_{k}} f(x) dx = \frac{h}{2} \sum^{n-1}_{k=0}[f(x_{k}) + f(x_{k+1})] + R_n(f)\\
记T_{n}为复合梯形公式:\\
T_{n} = \frac{h}{2} \sum^{n-1}_{k=0}[f(x_{k}) + f(x_{k+1})] = \frac{h}{2} [f(a)+2\sum^{n-1}_{k=1} f(x_k)+f(b) ]\\
$$

###### 复合辛普森公式

-   将区间[a, b]划分为n等分，形成n+1个插值节点，步长$$h=\frac{(b-a)}{n}$$ 在每个子区间采用梯形公式，记$$x_{k+1/2} = x_k +\frac{1}{2}h$$

$$
I =\int^{b}_{a} f(x) dx = \sum^{n-1}_{k=0} \int^{x_{k+1} }_{x_{k}} f(x) dx = \frac{h}{6} \sum^{n-1}_{k=0}[f(x_{k}) + 4f(x_{k+1/2})+f(x_{k+1})] + R_n(f)\\
记S_{n}为符合辛普森求积公式:\\
S_{n} = \frac{h}{6} \sum^{n-1}_{k=0} [f(x_{k}) + 4f(x_{k+1/2})+f(x_{k+1})]\\
=  \frac{h}{6}[f(a)+4\sum^{n-1}_{k=0} f(x_{k+1/2}) +2\sum^{n-1}_{k=1}f(x_k)+f(b)]
$$







##### 龙贝格求积公式





##### 高斯求积公式

-   高斯求积公式是一种机械求积公式
-   一般n+1个节点的求积公式的代数精度最高为2n+1次



$$
若具有n+1个插值节点的机械求积公式\int^{b}_{a}f(x)dx \approx \sum^n_{k=0}A_k ·f(x_k)\\
有2n+1次代数精度，则称节点x_k(k=0, 1,...,n)为求积节点，上式为高斯型求积公式\\
$$

节点$$a\le a_0<x_1<...<x_n \le b$$是高斯点的充分必要条件是以这些节点为零点的多项
$$w_{n+1}(x) = (x-x_0)(x-x_1)...(x-x_n)$$
与任何次数不超过$$n$$的多项式$$p(x)$$带权$$\rho (x)$$正交，即
$$\int^{b}_{a} \rho (x) · p(x)w_{n+1}(x)dx 0$$



###### 高斯-勒让德求积公式

-   积分区间在[-1,1]上的，高斯点为勒让德多项式零点的高斯求积公式

$$
在高斯求积公式的基础上，取权函数\rho (x)=1, 积分区间为[-1, 1], 得到 \\
高斯-勒让德求积公式 \int^{1}_{-1}f(x)dx \approx \sum^n_{k=0}A_k ·f(x_k)\\
勒让德多项式是[-1,1]上的正交多项式，故勒让德多项式P_{n+1}(x)的零点就是上式的高斯点\\
一点高斯-勒让德求积公式 \int^{1}_{-1}f(x)dx \approx 2f(0)\\
两点高斯-勒让德求积公式 \int^{1}_{-1}f(x)dx \approx f(-\frac {1}{\sqrt {3}}) + f(\frac {1}{\sqrt {3}})\\
三点高斯-勒让德求积公式 \int^{1}_{-1}f(x)dx \approx \frac {5}{9} f(-\frac {\sqrt {15}}{5}) + \frac {8}{9} f(0) + \frac {5}{9} f(\frac {\sqrt {15}}{5}) \\
$$



| n    | n+1个高斯点$$x_k$$                           | 对应高斯点的求积系数$$A_{k}$$             |
| ---- | ---------------------------------------- | ------------------------------- |
| 0    | 0                                        | 2                               |
| 1    | $$\pm \frac{1}{\sqrt{3}} ,(\pm0.5773503)$$ | 1                               |
| 2    | $$\pm \frac{\sqrt{15}}{5},(\pm0.7745967)$$ , 0 | 5/9   8/9                       |
| 3    | $$\pm0.8611363, \pm0.3399810$$           | 0.3478549, 0.6521452            |
| 4    | $$\pm 0.9061798, \pm 0.5384693$$ , 0     | 0.2369269, 0.4786287, 0.5688889 |



---

## 解线性方程组的迭代法



##### Conjugate gradient method

>   共轭梯度法

-   ​

设我们要求解下列线性系统



其中 $${\displaystyle n\times n}$$ 矩阵 $${\displaystyle A}$$ 是**对称**的(即 $${\displaystyle A^{T}=A}$$)，**正定**的(即 $${\displaystyle \forall {\vec {x}}\neq 0,{\vec {x}}^{T}A{\vec {x}}>0}$$)，并且是**实系数**的。 将系统的唯一解记作 $${\displaystyle x_{*}}$$

经过一些简化，可以得到下列求解 $${\displaystyle Ax=b}$$ 的算法，其中 $${\displaystyle A}$$ 是**实对称正定**矩阵
$$
{\displaystyle
{\begin{aligned}&\mathbf {r}_{0}:=\mathbf {b} -\mathbf {Ax}_{0}//列向量\\
&\mathbf  {p}_{0}:=\mathbf {r}_{0} //列向量\\
&k:=0\\
&{\text{repeat:}}\\
&\qquad \alpha _{k}:={\frac {\mathbf {r} _{k}^{\mathsf {T}}\mathbf {r} _{k}}{\mathbf {p} _{k}^{\mathsf {T}}\mathbf {Ap} _{k}}}\\
&\qquad \mathbf {x}_{k+1}:=\mathbf {x} _{k}+\alpha _{k}\mathbf {p} _{k}\\
&\qquad \mathbf {r}_{k+1}:=\mathbf {r} _{k}-\alpha _{k}\mathbf {Ap} _{k}\\
&\qquad {\hbox{if }}r_{k+1}{\text{ is sufficiently small, then exit loop}}\\
&\qquad \beta _{k}:={\frac {\mathbf {r} _{k+1}^{\mathsf {T}}\mathbf {r} _{k+1}}{\mathbf {r} _{k}^{\mathsf {T}}\mathbf {r} _{k}}}\\
&\qquad \mathbf {p}_{k+1}:=\mathbf {r} _{k+1}+\beta _{k}\mathbf {p} _{k}\\
&\qquad k:=k+1 \\
&{\text{end repeat}}\\ 
& 结果为{x}_{k+1}\\
 \end{aligned}}}
$$





---

## 非线性方程与方程组的数值解法

- 讨论非线性方程的求解必须强调$$x$$的定义域，即$$x$$的求解区间$$[a, b]$$，一般非线性问题不存在直接求解公式，故没有直接方法求解，需要使用迭代法求解。



### 方程求根与二分法

- 根、零点：单变量方程$$f(x)=0, x \in R, f(x) \in C[a, b], [a, b]$$可以是无穷区间 ，如果实数$$x^*$$满足$$f(x^*) =0$$，则称$$x^*$$是$$f(x)=0$$的根，或称是$$f(x)$$的零点。



##### 二分法

- 



### 不动点迭代法及其收敛性

将$$f(x)=0, x \in R, f(x) \in C[a, b]$$，改写成等价形式$$x=\varphi (x)$$，$$f(x^*) =0 \Leftrightarrow x^* = \varphi (x^*)$$，称$$x^*$$为函数$$\varphi (x)$$的一个不动点。求$$f(x)$$的零点等价于求$$\varphi (x)$$的不动点。
$$
选择一个初始近似值x_0，带入可得x_1=\varphi (x_0)\\
反复计算x_{k+1} = \varphi(x_k), k=0, 1, ...(不动点迭代法，显式的计算公式)\\
若\forall x_0 \in [a, b]，由x_{k+1} = \varphi(x_k)得到的序列\{x_k\}有lim_{k\to \infin} x_k = x^*,称x_{k+1} = \varphi(x_k)收敛\\
$$




### 牛顿法 





















