[TOC]







- cryptanalytics: 密码分析学，如何破解密码学的学科
- cryptography: 密码学，密码术，指密码技术的使用
- cryptology: 密码学，研究密码的学科，含密码术与密码分析
- crypto: 加密



---

# Cryptology 密码学

- encipher: 加密，把明文变换成密文的过程
- decipher: 解密，把密文变换成明文的过程
- Keyword: 密钥，用于加密、解密的一些特殊信息





### **Cryptosystem**

> cryptosystem, encryption scheme, 密码体制

Mathematically, a **cryptosystem** or **encryption scheme** can be defined as a **tuple** $${\displaystyle ({\mathcal {P}},{\mathcal {C}},{\mathcal {K}},{\mathcal {E}},{\mathcal {D}})}$$ with the following properties.

1. $${\mathcal  {P}}$$ is a set called the "plaintext space". Its elements are called plaintexts.
2. $${\mathcal {C}}$$ is a set called the "ciphertext space". Its elements are called ciphertexts.
3. $${\displaystyle {\mathcal {K}}}$$ is a set called the "key space". Its elements are called keys.
4. $${\mathcal  {E}}=\{E_{k}:k\in {\mathcal  {K}}\}$$ is a set of functions$$ {\displaystyle E_{k}:{\mathcal {P}}\rightarrow {\mathcal {C}}} $$. Its elements are called "encryption functions".
5. $${\displaystyle {\mathcal {D}}=\{D_{k}:k\in {\mathcal {K}}\}}  $$ is a set of functions $${\displaystyle D_{k}:{\mathcal {C}}\rightarrow {\mathcal {P}}}$$. Its elements are called "decryption functions".

For each $$e\in {\mathcal {K}}$$ , there is $$ d\in {\mathcal {K}}$$ such that $$D_{d}(E_{e}(p))=p$$ for all $${\displaystyle p\in {\mathcal {P}}}$$

Note; typically this definition is modified in order to distinguish an encryption scheme as being either a **symmetric-key**(对称密钥) or **public-key**(公钥 非对称密钥) type of cryptosystem.



一个密码体制**Cryptosystem**是满足以下条件的五元组: **P**: Plain text; **C**: Cipher text; **K**: Key; **E**: Encipher; **D**: Decipher.
$$
\begin{align*}
& 五元组(P, C, K, E, D)\\
& P: 明文空间，所有可能的明文组成的有限集\\
& C: 密文空间，所有可能的密文组成的有限集\\
& K: 密钥空间，所有可能的密钥组成的有限集\\
& 对每个k \in K, 都存在一个加密规则e_k \in E和相应的解密规则d_k \in D,\\
& 且对每对e_k:P \to C, d_k:C\to P,满足条件:\\
& 对每个明文x\in P, 均有d_k(e_k(x))=x\\
&------\\
& e_k:加密规则，加密函数，加密算法\\
& d_k:解密规则，解密函数，解密算法
\end{align*}
$$

> 如果密钥空间和明文空间一样大，那么这个加密方式就是一个置换。且加密方式必须保证是一个单射函数，即不同明文加密后不可对应相同密文

---

# 古典密码学

主要研究私钥，对称加密，古典密码主要依赖算法

通常来说，古典密码的明文空间大小与密文空间大小相同

古典密码学通常对字母做变换，以下例子不做特殊说明，默认明文空间为26个英文字母





---

### 代换密码  Substitution Cipher

以26个字母为名密文空间举例

代换密码：名文字母被不同的密文字母代替。

最大密钥空间：26! $$\approx$$ 2^88^

代换密码：



#### 单表代换密码

一旦密钥被选定，每个字母对应的数字都被加密变换成对应的唯一数字



##### 移位密码 Shift Cipher

- 代换密码的一种特殊情况
- 密钥空间: 26
- 

$$
令P=C=\Kappa=Z_{26}. 对0\le\Kappa\le25, \forall x,y \in Z_{26}, \text{define:}\\
e_K(x)=(x+K)\mod{26}\\
d_K(y)=(y-K)\mod{26}
$$

> 若取K=3，此密码体制通常叫做凯撒密码Caesar Cipher





##### 仿射密码 Affine Cipher

- 代换密码的一种特殊情况

$$
\Kappa = \{(a,b) \in \Z_{26}\times \Z_{26}: \gcd(a,26)=1\} \\
e_K(x) = (ax+b)\mod{26}\\
d_K(y)=a^{-1}(y-b)\mod{26}; a关于26的逆
$$



#### 多表代换密码

一般来说，多表代换密码比单表代换密码更为安全一些





##### 维吉尼亚密码 Vigenere Cipher

- 以m个明文字为一组进行移位变换，一次加密m个明文字母
- 密钥空间: 26^m^
- 多表代换密码，流密码
- 每个密钥K相当于一个长度为m的字母串，称为密钥字

$$
e_K(x_1,x_2,...,x_m) = (x_1+k_1, x_2+k_2,...,x_m+k_m)\\
d_K(y_1,y_2,...,y_m) = (y_1-k_1, y_2-k_2,...,y_m-k_m)
$$



###### 解密

Kasiski测试法: 两个相同明文段若被加密成相同的密文段，则他们的间距为密钥长度的整数倍。

Kasiski测试法工作流程: 搜索长度至少为3的相同的密文段，记下离起初点最近的相同密文段的距离，将距离记为d1,d2,d3,...,dn，可以猜测密钥长度为这些di的最大公因子的因子
$$
重合指数定义: 设\vec x = x_1 x_2...x_n是一条n个字母的串，\vec x的重合指数记为I_c(\vec x),定义为\vec x中两个随机元素相同的概率\\
f_0, f_1, f_2,...,f_{25}: 分别表示A, B,...,Z在\vec x中出现的频数;共有\binom{n}{2}种方法选择\vec x中的任两个元素\\
重合指数:\qquad I_c(\vec x) = \frac{\sum_{i=0}^{25}\binom{f_i}{2}}{\binom{n}{2}} = \frac{\sum_{i=0}^{25}f_i(f_i -1)}{n(n-1)}
$$


重合指数法: 猜测密钥长度为m，按照密钥长度对密文进行分组(共m组)，每一组计算重合指数，如果对于此时的m的取值，m个重合指数都比较接近于0.065，则通常该m的取值就是密钥长度。

随机文本的重合指数约为

```cpp
//英语文本的词频统计: 根据英语文本的词频可以计算得重合指数约为0.065
map<char, float> map_alphabet_p;

void ini_map_alphabet_p(map<char, float>& map_alphabet_p) {
    map_alphabet_p.insert(std::pair<char, float>('A', 0.082));
    map_alphabet_p.insert(std::pair<char, float>('B', 0.015));
    map_alphabet_p.insert(std::pair<char, float>('C', 0.028));
    map_alphabet_p.insert(std::pair<char, float>('D', 0.043));
    map_alphabet_p.insert(std::pair<char, float>('E', 0.127));
    map_alphabet_p.insert(std::pair<char, float>('F', 0.022));
    map_alphabet_p.insert(std::pair<char, float>('G', 0.020));
    map_alphabet_p.insert(std::pair<char, float>('H', 0.061));
    map_alphabet_p.insert(std::pair<char, float>('I', 0.070));
    map_alphabet_p.insert(std::pair<char, float>('J', 0.002));
    map_alphabet_p.insert(std::pair<char, float>('K', 0.008));
    map_alphabet_p.insert(std::pair<char, float>('L', 0.040));
    map_alphabet_p.insert(std::pair<char, float>('M', 0.024));
    map_alphabet_p.insert(std::pair<char, float>('N', 0.067));
    map_alphabet_p.insert(std::pair<char, float>('O', 0.075));
    map_alphabet_p.insert(std::pair<char, float>('P', 0.019));
    map_alphabet_p.insert(std::pair<char, float>('Q', 0.001));
    map_alphabet_p.insert(std::pair<char, float>('R', 0.060));
    map_alphabet_p.insert(std::pair<char, float>('S', 0.063));
    map_alphabet_p.insert(std::pair<char, float>('T', 0.091));
    map_alphabet_p.insert(std::pair<char, float>('U', 0.028));
    map_alphabet_p.insert(std::pair<char, float>('V', 0.010));
    map_alphabet_p.insert(std::pair<char, float>('W', 0.023));
    map_alphabet_p.insert(std::pair<char, float>('X', 0.001));
    map_alphabet_p.insert(std::pair<char, float>('Y', 0.020));
    map_alphabet_p.insert(std::pair<char, float>('Z', 0.001));
}
```



确定密钥长度后，对每一组分密文串进行移位密码分析
$$
n: 密文长度\\
m: 密钥长度(分析得出)\\
n^{'} = \frac{n}{m}\\
\vec y_i=y_iy_{m+i}y_{2m+i}...;(i\in[1,m])\\
f_0, f_1, ...,f_{25}分别表示串\vec y_i中字母A,B,...,Z出现的频数\\
概率分布:\frac{f_0}{n^{'}}, \frac{f_1}{n^{'}}, ...,\frac{f_{25}}{n^{'}}\\
移k_i位后的概率分布:\frac{f_{k_i}}{n^{'}}, \frac{f_{1+k_i}}{n^{'}}, ...,\frac{f_{25+k_i}}{n^{'}}\\
定义 M_g = \sum_{i=0}^{25}\frac{p_i f_{i+g}}{n^{'}}\\
若g正好为密钥k_i,则M_g \approx \sum_{i=0}^{25}p_i^2=0.065\\
$$




##### 希尔密码 Hill Cipher

- 多表代换密码
- Hill密码算法的基本思想是将n个明文字母通过线性变换，将它们转换为n个密文字母。解密只需做一次逆变换即可。
- m个一组，进行矩阵运算，密文字是明文字的线性组合

$$
\Kappa = \{定义在\Z_{26}上的m\times m可逆矩阵\}\\
e_K(x)=x\mathbf{K}\\
d_K(y)=y\mathbf{K^{-1}}\\
均在\Z_{26}上进行的
$$



- 完全隐藏了字符(对)的频率信息
- 密钥空间较大，在忽略密钥矩阵K可逆限制条件下，|K|=26^n×n^
- 惟密文攻击相对较难。线性变换的安全性很脆弱，易被已知明文攻击击破



###### 仿射希尔密码

$$
密钥K由(L,b)组成，L为Z_{26}上的可逆矩阵(m\times m)，b\in (Z_{26})^m
$$







---

### 置换密码  Permutation Cipher

> 换位密码

- 保持明文的所有字母不变，只是利用置换打乱了明文字母的位置和顺序。
- 通过改变明文消息各元素的相对位置，但明文消息元素本身的取值或内容形式不变。它是对明文L长字母组中的字母位置进行重新排列，而每个字母本身并不改变
- 置换密码在实质上是Hill密码的特例，是Hill密码置换矩阵为每一行每一列都刚好有一个1，其余为0的稀疏矩阵
- 不能抗击已知明密文攻击





### 流密码 Stream Cipher

- 产生一个密钥流z=z~1~z~2~...,然后使用如下规则来加密x=x~1~x~2~...; y=y~1~y~2~...=e~z1~(x~1~)e~z2~(x~2~)...;

根据密钥流是否依赖明文流，可将流密码分为两种:

1. 同步流密码，就是生成的密钥流独立于明文流
2. 自同步流密码，异步流密码，每个密钥字符都从以前密文的固定n个字符中导出





## 密码体制的分类

对称密码体制主要分为分组密码和流密码

对称密码的两个基本运算：代换和置换(Substitution & permutation)

依据对信息元素的处理方式分类：

1. 序列(流)密码
2. 分组(块)密码

一个密码体制的明文必要分组长度n
若为1，则称该密码为序列（流）密码，否则（即n>1）称该密码为分组（块）密码

对称密码的两个基本设计原则:扩散（Diffusion):明文的统计结构被扩散消失到密文的长程统计特性 ,使得明文和密文之间的统计关系尽量复杂 混乱(confusion)：使得密文的统计特性与密钥的取值之间的关系尽量复杂

经典密码算法特点

- 要求的计算强度小
- DES之前
- 以字母表为主要加密对象
- 替换和置换技术
- 数据安全基于算法的保密
- 密码分析方法基于明文的可读性以及字母和字母组合的频率特性



# Math Background





#### 特殊素数

梅森(Mersenne)素数: 2p-1, p is prime



广义梅森素数: 2p  ± a, p is prime（a是小奇数）



费马素数Fn:
$$
Fn = 2^{2^{n}}+1
$$
 (当 n取0、1、2、3、4时，这个式子对应值分别为3、5、17、257、65537，费马发现这五个数都是素数)



孪生素数: p, p+2都是素数





## Shannon Theories



安全分类: 

1. Computational Security 计算安全性:如果使用最好的算法攻破一个密码体制需要至少N次操作，这里的N是一个特定的非常大的数字，我们可以定义这个密码体制是计算安全的。没有一个已知的实际的密码体制在这个定义下可以被证明安全。人们经常经过几种特定的攻击类型来研究计算上的安全性。对一种类型的攻击是安全的，并不表示对其他类型的攻击是安全的
2. Provable Security 可证明安全性: 将密码体制的安全性归结为某个经过深入研究的数学难题。这种途径只是说明了安全和另一个问题是相关的，并没有完全证明是安全的。这和证明一个问题是NP完全的有些类似：证明给定的问题和任何其他的NP完全问题的难度是一样的，但没有完全证明这个问题的计算难度。
3. Unconditional Security 无条件安全性: 对攻击者的计算量没有限制。即使提供了无穷的计算资源，也是无法被攻破的。讨论安全性时，与攻击类型（手段）有关。惟密文攻击下无条件安全的密码体制是存在的。









## 完善保密的定义和性质

定义: 一个密码体制具有完善保密性，如果对于任意的x $$\in$$ P和 y $$\in$$ C, 都有 $$P[x|y] = P[x]$$ .  也就是说，给定密文y，明文x的后验概率等于明文的先验概率。通俗地讲，完善保密性就是攻击者不能通过观察密文获得明文的任何信息。 

> 先验概率：在考虑"观测数据"前(例如密文)，能表达p不确定性的概率分布
>
> 后验概率：给出某数据，该不确定量的条件分布

为简单起见，这里将注意力集中在C=P的密码体制：这种类型的密码体制称为**内嵌式密码体制 Endomorphic Cryptosystem**.

设S~1~ = (P , P , K~1~ , E~1~ , D~1~ ), S~2~ = (P , P , K~2~ , E~2~ , D~2~ )是两个具有相同明文空间(密文空间)的内嵌式密码体制，那么S~1~和S~2~的乘积密码体制$$S_1 \times S_2$$定义为
$$
(\mathcal{P},\mathcal{P},\mathcal{K_1} \times \mathcal{K_2},\mathcal{E},\mathcal{D})
$$




## 乘积密码 Product Cipher

通过结合两个或更多置换的方式制造比单独的加密方式更安全的密码以抵抗密码分析。乘积密码往往结合的是简单的置换/代换算法。其想法由克劳德·香农提出，在他决定性的论文“加密系统的通信理论”中首次提到。



#### 乘法密码 Multiplicative Cipher

密码体制: 乘法密码 Multiplicative Cipher







## Elliptic Curve Cryptography

> Elliptic Curve Cryptography (ECC) 椭圆曲线密码学; Curve n. 曲线;弯曲;曲线球; Elliptic adj. 椭圆形的;省略的; 
>
> National Institute of Standards and Technology (NIST)

ECC的主要优势是在某些情况下它比其他的方法使用更小的密钥——比如RSA加密算法——提供相当的或更高等级的安全。ECC的另一个优势是可以定义群之间的双线性映射，基于Weil对或是Tate对；双线性映射已经在密码学中发现了大量的应用，例如基于身份的加密。不过一个缺点是加密和解密操作的实现比其他机制花费的时间长





# 分组密码与高级加密标准

> 对称密码体制的发展趋势将以分组密码为重点。分组密码算法通常由密钥扩展算法和加密（解密）算法两部分组成。密钥扩展算法将b字节用户主密钥扩展成r个子密钥。加密算法由一个密码学上的弱函数f与r个子密钥迭代r次组成。混乱和密钥扩散是分组密码算法设计的基本原则。抵御已知明文的差分和线性攻击，可变长密钥和分组是该体制的设计要点。

大多数分组密码都是乘积密码，乘积密码通常伴随一系列置换与代换操作，常见的乘积密码是迭代密码。

设K是一个确定长度的随机二元密钥，用K来生成Nr个轮密钥(也叫子密钥)K^1^,…,K^Nr^。

密钥编排方案：轮密钥列表(K^1^,…,K^Nr^)就是密钥编排方案。由K经一个固定的，公开的算法生成

轮函数g: 以轮密钥(K^r^)和当前状态w^r-1^作为它的两个输入。下一个状态定义为w^r^=g(W^r-1^, K^r^)。

初态w^0^: 定义为明文x

密文y: 定义为经过所有Nr轮后的状态



## 代换-置换网络 SPN

> SPN: Substitution Permutation Network

SPN是一类特殊的迭代密码。

设l和m都是正整数，明文和密文都是长为lm的二元向量，即lm是该密码的分组长度。一个SPN包括两个变换：
$$
\pi_S : \{0, 1\}^l \rightarrow \{0,1 \}^l\\
\pi_P : \{1,...,lm\} \rightarrow \{1,...,lm\}
$$
都是置换，

- $$\pi_S$$: 置换$$\pi_S$$叫做S盒，用一个l比特的向量替代另一个l比特的向量
- $$\pi_P$$: 置换$$\pi_P$$

$$
{\begin{aligned}
&SPN(x, \pi_S, \pi_P, (K^1, ..., K^{Nr+1}))\\
&\text{----------------------------------------------}\\
& w^0 = x\\
& \text{for } r = 1 \text{ to } Nr - 1://前Nr-1轮\\
& \qquad u^r = w^{r-1} \oplus K^r //混入key\\
& \qquad \text{for } i = 0 \text{ to } m://\pi_S代换 \\
& \qquad \qquad  v^r_{<i>} = \pi_S(u^r_{<i>}) \\
& \qquad w^r = (v^r_{\pi_P(1)}, ..., v^r_{\pi_P(lm)})//\pi_p置换,lm长的串改变1的位置 \\
& u^{Nr} = w^{Nr-1} \oplus K^{Nr}//最后一轮开始，混入密钥\\
& \text{for } i=1 \text{ to } m://\pi_S代换\\
& \qquad v^{Nr}_{<i>} = \pi_S(u^{Nr}_{<i>})\\
& y = v^{Nr}\oplus K^{Nr+1}//混入密钥\\
& \text{output}: y\\
\end{aligned}}
$$







## 数据加密标准 DES

DES是一种特殊类型的迭代密码，叫做Feistel型密码。Feistel型密码中，每个状态u^i^被分成相同长度的两半L^i^, R^i^。

DES轮函数g形式, Feistel型密码轮函数
$$
{\begin{aligned}
& g(L^{i-1}, R^{i-1}, K^i) = (L^i, R^i)\\
& L^i = R^{i-1}\\
& R^i = L^{i-1} \oplus f(R^{i-1}, K^i)\\
& f不需要满足任何单射条件，因为Feistel型轮函数肯定可逆:\\
& L^{i-1} = R^{i} \oplus f(L^{i}, K^{i})\\
& R^{i-1} = L^{i}
\end{aligned}}
$$

DES是16轮的Feistel型密码，分组长度为64，用一个56bit的密钥来加密一个64bit的明文串，并获得一个64bit的密文串。

初始置换IP: 在进行16轮加密之前，先对明文做一个固定的初始置换IP，记为$$IP(x) = L^0R^0$$，在16轮加密之后，对比特串$$L^{16}R^{16}$$做逆置换IP^-1^来给出密文y，$$y = IP^{-1}(R^{16}L^{16})$$，注意要交换L^16^和R^16^. IP和IP^-1^的使用并没有任何密码学意义，所以在讨论DES安全性时常常忽略。





## 高级加密标准 AES

> **A**dvanced **E**ncryption **S**tandard, **Rijndael加密法**, 一种区块加密标准，高级加密标准Rijndael加密法

严格地说，AES和Rijndael加密法并不完全一样（虽然在实际应用中两者可以互换），因为Rijndael加密法可以支持更大范围的区块和密钥长度：**AES的区块长度固定为128比特，密钥长度则可以是128，192或256比特**；而Rijndael使用的密钥和区块长度均可以是128，192或256比特。加密过程中使用的密钥是由Rijndael密钥生成方案产生



### AES描述

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/1540263149(1).jpg)

各轮AES加密循环(除最后一轮)均包含4个步骤:

1. SubBytes: state中每个元素均用S盒进行代换，该步在加密过程中提供非线性。 In the `SubBytes` step, each byte $${\displaystyle a_{i,j}}$$ in the *state* array is replaced with a `SubByte` $${\displaystyle S(a_{i,j})}$$ using an 8-bit substitution box. This operation provides the non-linearity in the cipher. The S-box used is derived from the multiplicative inverse over GF(2^8^), known to have good non-linearity properties.
2. ShiftRows: 第一行不变，第二行左移1 byte(一格)，第三行左移2 bytes，第四行左移3 bytes
3. MixColumns: 列混合
4. AddRoundKey: 扩展密钥只参与了这一步。



![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/810px-AES-SubBytes.svg.png)

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/810px-AES-ShiftRows.svg.png)

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/810px-AES-MixColumns.svg.png)

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/810px-AES-AddRoundKey.svg.png)



### AES工作模式



# Hash

> Hash function 散列函数 散列算法 哈希函数
>
> 一种从任何数据中创建小的数字“指纹”的方法

密码学上的Hash函数可为数据完整性提供保障。可当作“指纹”来验证数据的完整性。假设h是一个Hash函数，x是数据。设x是任意长度的二元串，相应的指纹为y=h(x)。通常指纹也被称为消息摘要，其通常为一个长度为160 bit的二元串。

一个Hash族是满足下列条件的四元组(X,Y,K,H):

1. X是所有可能的消息的集合
2. Y是由所有可能的消息摘要或认证标签构成的有限集
3. $$\mathcal{K}$$是密钥空间，是所有可能的密钥构成的有限集
4. 对每个$$K\in \mathcal{K}$$，存在一个Hash函数$$h_K \in H, h_K: X \rightarrow Y$$.

如果$$h_K(x)=y$$，则对(x, y)$$\in \mathbf{X} \times  \mathbf{Y}$$称为在密钥K瞎是有效的。令$$\mathbf{F^{X,Y}}$$为所有从X到Y的函数集合。假定|X|=N, |Y|=M, 则显然$$\mathbf{F^{X,Y}} = M^N$$. 任何Hash函数族$$\mathbf{F} \subseteq \mathbf{F^{X,Y}}$$被称为一个**(N, M) - Hash族**。

两种Hash函数: 单一固定的Hash函数，以及带密钥的Hash函数族

一个带密钥的Hash函数通常用来作为消息认证码，即MAC

- 不带密钥的Hash函数，消息摘要必须被安全地存放，不能被篡改。
- 带密钥的Hash函数，可以在不安全信道同时传送数据和认证标签。

## Hash函数的安全性

对以下三个问题都是难解的，那么一个Hash函数被认为是安全的

- 原像Preimage: **Preimage Arrack**
  对于Hash函数h: $$\mathbf{X} \rightarrow \mathbf{Y}, \text{and }y \in \mathbf{Y} $$
  找出$$x \in \mathbf{X}$$使得$$h(x) = y$$

不能有效解决原像问题的Hash函数通常称为单向的或者**原像稳固**的。

- 第二原像: 次原像攻击， Birthday Attack
  对于Hash函数h: $$\mathbf{X} \rightarrow \mathbf{Y}, \text{and }x \in \mathbf{X} $$
  找出$$x^{'} \in \mathbf{X}$$使得$$h(x^{'}) = h(x)$$

不能有效解决第二原像问题的Hash函数通常称为**第二原像稳固**的。

- 碰撞: **collision**
  对于Hash函数h: $$\mathbf{X} \rightarrow \mathbf{Y}$$
  找出$$x, x^{'} \in \mathbf{X}, s.t. x \neq x^{'} \text{ and }h(x) = h(x^{'})$$

碰撞问题是问是否能找到两组不同的明文，他们的hash code相同。不能有效解决碰撞问题的Hash函数通常称为**碰撞稳固**的。

一个理想的Hash函数的概念：如果Hash函数h设计得好，对给定的x，求出函数h在点x的值应该是得到h(x)的唯一有效方法，几时其他的值h(x1),h(x2)…已经计算出来。



### 随机谕示模型及其算法


$$
{\begin{aligned}
& \text{Find-Preimage}(h, y, Q)\\
& \text{Ramdomly select }X_0 \subseteq X, |X_0| = Q\\
& \text{for each }x \in X_0 \text{ do}\\
& \qquad \text{if } h(x) = y\\
& \qquad \qquad \text{then return }x\\
& \text{return }failure\\
\end{aligned}}
$$

- 定理：对任意的$$X_0 \subseteq X, |X_0|=Q$$, 该算法的平均情况成功率是$$\epsilon = 1-(1-1/M)^Q$$





解决碰撞问题比解决原像问题和第二原像问题要容易。



## 迭代Hash函数

压缩函数: 有限定义域上的Hash函数

迭代Hash函数: 将一个压缩函数(记为compress)延拓为具有无限定义域的Hash函数h











### SHA-1

> Secure Hash Algorithm 1 安全散列算法1

一种密码散列函数，美国国家安全局设计，并由美国国家标准技术研究所(NIST)发布为联邦数据处理标准(FIPS)。SHA-1可以生成一个被称为消息摘要的160 bits (20 bytes)散列值Hash code，散列值通常的呈现形式为40个十六进制数

可将一个最大2^64^bit的消息，转换成一串160 bit的消息摘要；其设计原理相似于MIT教授Ronald L. Rivest所设计的密码学散列算法MD4和MD5





![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/365px-SHA-1.png)







