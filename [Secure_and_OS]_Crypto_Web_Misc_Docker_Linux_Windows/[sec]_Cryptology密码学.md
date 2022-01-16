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



### 安全性分类

安全分类: 

1. **Computational Security 计算安全性**:如果使用最好的算法攻破一个密码体制需要至少N次操作，这里的N是一个特定的非常大的数字，我们可以定义这个密码体制是计算安全的。**没有一个已知的实际的密码体制在这个定义下可以被证明安全**。人们经常经过几种特定的攻击类型来研究计算上的安全性。对一种类型的攻击是安全的，并不表示对其他类型的攻击是安全的
2. **Provable Security 可证明安全性**: 通过**归约**的方式为安全性提供证据。将密码体制的安全性归结为某个经过深入研究的数学难题。这种途径只是说明了安全和另一个问题是相关的，并没有完全证明是安全的。这和证明一个问题是NP完全的有些类似：证明给定的问题和任何其他的NP完全问题的难度是一样的，但没有完全证明这个问题的计算难度。
3. **Unconditional Security 无条件安全性**: 对攻击者的**计算量没有限制**。即使提供了无穷的计算资源，也是无法被攻破的。讨论安全性时，与攻击类型（手段）有关。惟密文攻击下无条件安全的密码体制是存在的。









## 完善保密的定义和性质

定义: 一个密码体制具有完善保密性，如果对于任意的x $$\in$$ P和 y $$\in$$ C, 都有 $$P[x|y] = P[x]$$ .  也就是说，**给定密文y，明文x的后验概率等于明文的先验概率**。通俗地讲，完善保密性就是攻击者不能通过观察密文获得明文的任何信息。 

> 先验概率：在考虑"观测数据"前(例如密文)，能表达p不确定性的概率分布
>
> 后验概率：给出某数据，该不确定量的条件分布

- 假设移位密码的26个密钥都是以相同的概率1/26使用的，则对于任意的明文概率分布，移位密码具有完善保密性。(证明见《密码学原理与实践 第三版》p40)

定理：假设密码体制(P, C, K, E, D)满足|K| = |C| = |P|。该密码体制是完善保密的，**当且仅当**每个密钥被使用的概率都是1/|K|，并且对于任意的x $$\in$$ P, y $$\in$$ C, 存在唯一的密钥K使得$$e_K(x)=y$$

- 一次一密密码体制：一个具有完善保密性的密码体制




## 乘积密码 Product Cipher

通过结合两个或更多置换的方式制造比单独的加密方式更安全的密码以抵抗密码分析。乘积密码往往结合的是简单的置换/代换算法。其想法由克劳德·香农提出，在他决定性的论文“加密系统的通信理论”中首次提到。

为简单起见，这里将注意力集中在C=P的密码体制：这种类型的密码体制称为**内嵌式密码体制 Endomorphic Cryptosystem**.

设S~1~ = (P , P , K~1~ , E~1~ , D~1~ ), S~2~ = (P , P , K~2~ , E~2~ , D~2~ )是两个具有相同明文空间(密文空间)的内嵌式密码体制，那么S~1~和S~2~的乘积密码体制$$S_1 \times S_2$$定义为
$$
(\mathcal{P},\mathcal{P},\mathcal{K_1} \times \mathcal{K_2},\mathcal{E},\mathcal{D})
$$


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

- $$\pi_S$$: (Substitution)代换$$\pi_S$$叫做S盒，用一个l比特的向量替代(代换)另一个l比特的向量
- $$\pi_P$$: (Permutation)置换$$\pi_P$$

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

> **A**dvanced **E**ncryption **S**tandard, **Rijndael加密法**, 高级加密标准，Rijndael加密法

- 一种区块加密标准，1997.1.2 NIST开始遴选DES替代者的工作。2001.12.4(美)联邦记录中作为FIPS197公布
- 迭代型密码，论数Nr依赖于密钥长度

严格地说，AES和Rijndael加密法并不完全一样（虽然在实际应用中两者可以互换），因为Rijndael加密法可以支持更大范围的区块和密钥长度：**AES的区块长度固定为128比特，密钥长度则可以是128，192或256比特**；而Rijndael使用的密钥和区块长度均可以是128，192或256比特。加密过程中使用的密钥是由Rijndael密钥生成方案产生



### AES描述

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/crypt_AES_whole_process.jpg)

各轮AES加密循环(除最后一轮)均包含4个步骤:

1. SubBytes: state中每个元素均用S盒进行代换，该步在加密过程中提供**非线性**。 In the `SubBytes` step, each byte $${\displaystyle a_{i,j}}$$ in the *state* array is replaced with a `SubByte` $${\displaystyle S(a_{i,j})}$$ using an 8-bit substitution box. This operation provides the non-linearity in the cipher. The S-box used is derived from the multiplicative inverse over GF(2^8^), known to have good non-linearity properties.
2. ShiftRows: 第一行不变，第二行左移1 byte(一格)，第三行左移2 bytes，第四行左移3 bytes
3. MixColumns: 列混合(每一列都要进行)
4. AddRoundKey: 扩展密钥只参与了这一步。



1. SubBytes: 使用S Box对每一个字节都进行一个独立的代换(非线性变换)。State为4x4个Byte，即分组大小为128bits

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/crypt_AES_SubBytes.png)

2. ShiftRows:

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/crypt_AES_ShiftRows.png)

3. MixColumns: 

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/crypt_AES_MixColumns.png)

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/crypt_AES_AddRoundKey.png)



## Encryption Mode





### ECB 电码本

分组密码的直接使用，对给定的明文分组序列$x_1x_2...$，每个$x_i$都用同一个密钥来加密，产生密文分组序列$y_1y_2...$.



### CBC

每一个密文分组$y_i$在用密钥K加密之前，都要先跟下一个明文分组$x_{i+1}$相异或。从一个初始向量$IV$开始，定义$y_0 = IV$(注意$IV$与明文分组有同样的长度)，用下列公式构造$y_1,y_2...$
$$
y_i = e_{K}(y_{i-1}\oplus x_i)
$$

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/crypt_CBC_mode.png)

### OFB

产生一个密钥流，然后将其与明文相异或（即像流密码一样工作）。OFB模式实际上就是一个同步流密码：密钥流由反复加密一个初始向量IV而产生。定义$z_0 = IV$，然后用下列公式计算密钥流$z_1z_2....$和密文分组序$y_1,y_2...$:
$$
z_i = e_{K}(z_{i-1})\\
y_i = x_{i}\oplus z_i
$$

### CFB

也产生一个密钥流，用于一个同步流密码。由$y_0 = IV$(一个**初始向量**)开始，然后通过加密以前的密文分组来产生密钥流元素$z_i$:
$$
z_i = e_{K}(y_{i-1})\\
y_i = x_{i}\oplus z_{i}
$$
CFB模式中，加密和解密都是用加密函数$e_{K}$

### 计数模式

类似于OFB模式，唯一差别是如何构造密钥流。



### CCM模式

基本上是计数模式(用于加密)和CBC模式(用于认证)的组合使用

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

如果$$h_K(x)=y$$，则对(x, y)$$\in \mathbf{X} \times  \mathbf{Y}$$称为在密钥K下是有效的。令$$\mathbf{F^{X,Y}}$$为所有从X到Y的函数集合。假定|X|=N, |Y|=M, 则显然$$\mathbf{F^{X,Y}} = M^N$$. 任何Hash函数族$$\mathbf{F} \subseteq \mathbf{F^{X,Y}}$$被称为一个**(N, M) - Hash族**。

两种Hash函数: 单一固定的Hash函数，以及带密钥的Hash函数族

一个带密钥的Hash函数通常用来作为消息认证码，即MAC

- 不带密钥的Hash函数，消息摘要必须被安全地存放，不能被篡改。
- 带密钥的Hash函数，可以在**不安全信道同时传送数据和认证标签**。

## Hash函数的安全性

对以下三个问题都是难解的，那么一个Hash函数被认为是安全的

- 原像Preimage: **Preimage Arrack**
  对于Hash函数h: $$\mathbf{X} \rightarrow \mathbf{Y}, \text{and }y \in \mathbf{Y} $$
  找出$$x \in \mathbf{X}$$使得$$h(x) = y$$

不能有效解决原像问题的Hash函数通常称为**单向**的或者**原像稳固**的。

- 第二原像: 次原像攻击， Birthday Attack
  对于Hash函数h: $$\mathbf{X} \rightarrow \mathbf{Y}, \text{and }x \in \mathbf{X} $$
  找出$$x^{'} \in \mathbf{X}$$使得$$h(x^{'}) = h(x)$$

不能有效解决第二原像问题的Hash函数通常称为**第二原像稳固**的。

- 碰撞: **collision**
  对于Hash函数h: $$\mathbf{X} \rightarrow \mathbf{Y}$$
  找出$$x, x^{'} \in \mathbf{X}, s.t. x \neq x^{'} \text{ and }h(x) = h(x^{'})$$

碰撞问题是问是否能找到两组不同的明文，他们的hash code相同。不能有效解决碰撞问题的Hash函数通常称为**碰撞稳固**的。

一个理想的Hash函数的概念：如果Hash函数h设计得好，对给定的x，求出函数h在点x的值应该是得到h(x)的唯一有效方法，即使其他的值h(x1),h(x2)…已经计算出来。



### 随机谕示模型及其算法



企图通过计算在Q个点(x)的h值来解决原像问题

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





![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/crypt_SHA1_process.png)



## Message Authentication Code

> MAC 消息认证码

消息认证码也就是满足某些安全性质的**带密钥**的Hash函数。







---

# RSA密码体制和整数因子分解





## RSA  cryptosystem

设n=pq, 其中p, q是素数。明文空间和密文空间P=C=Z~n~, 定义密钥空间为:
$$
\mathbf{K} = \{(n, p, q, e, d):ed \equiv 1\mod{\phi(n)}) \}
$$
对于给定的密钥K = (n, p, q, e, d), 加密过程和解密过程分别为:(模指数运算)
$$
e_K(m) = m^{e} \mod{n};\  d_K(c) = c^{d} \mod{n};(m, c \in \mathbf{Z}_n)
$$
公钥public key: n, e; 密钥private key: p, q, d.

> related number theory knowledge:
> $$
> ed\equiv 1\mod{\phi(n)} \Rightarrow ed \equiv 1\mod{(p-1)(q-1)}\\
> \therefore m^{ed} \equiv m^{k\phi(n)+1} \equiv m^{1} \equiv m \mod{n}
> $$
>
>完全破解RSA的重点在于知道$$\phi(n)$$, 可以通过(p-1)(q-1)求得，故可以对n进行大整数分解。



### Key Generation

The keys for the RSA algorithm are generated the following way:

1. Choose two distinct prime numbers *p* and *q*
    - For security purposes, the integers *p* and *q* should be chosen at random, and should be similar in magnitude but differ in length by a few digits to make factoring harder.Prime integers can be efficiently found using a **primality test**.

2. Compute **n = pq**
   - n is used as the modulus for both the public and private keys. Its length, usually expressed in bits, is the **key length**.

3. Compute *λ*(*n*) = lcm(*λ*(*p*), *λ*(*q*)) = lcm(*p* − 1, *q* − 1), where *λ* is Carmichael's totient function. This value is kept private. (lcm for Lowest Common Multiple)

4. Choose an integer **e** such that 1 < *e* < *λ*(*n*) and gcd(*e*, *λ*(*n*)) = 1; i.e., *e* and *λ*(*n*) are **coprime**(互质).

5. Determine **d** as d ≡ e^−1^ (mod *λ*(*n*)); i.e., *d* is the **modular multiplicative inverse** (模乘逆) of *e* modulo *λ*(*n*).



---

## Primality Test

> Primality [prai'mæləti]; 素性检验



### Miller-Rabin Primality Test

> 强伪素数检测 strong pseudo-prime test
>
> 对于合数问题的偏是的Monte Carlo算法

- 多项式时间算法

引理：-1和1是 mod p的平凡平方根，当p是奇素数时，不存在1 mod p的非平凡平方根。下面有英语解释及证明。

Certainly 1 and −1 always yield 1 when squared modulo *p*; call these trivial square(平凡平方根) roots of 1.
$$
1^2 \equiv 1 \mod{p}, (-1)^2\equiv 1 \mod{p}
$$
To show this, suppose that *x* is a square root of 1 modulo *p*. Then:
$$
x^2 \equiv 1 \mod{p} \Rightarrow (x-1)(x+1) \equiv 0 \mod{p} 
$$
In other words, prime *p* divides the product (*x* − 1)(*x* + 1). By Euclid's lemma it divides one of the factors *x* − 1 or *x* + 1, implying that *x* is congruent(同余) to either 1 or −1 modulo *p*.

有待补充，摘自Miller–Rabin primality test wiki，https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test

```python
# True: is prime (maybe a composite)
# False: is composite, then must be a composite
def Miller_Rabin(n:int):
    if(n <= 0):
        return False
    m = n-1
    k = 0
    while(m % 2 == 0): # m = n-1
        k += 1
        m = m >> 1
	# now we heave: n-1 == 2^k * m ########## prepare end, now start main process
    a = random.randint(1, n-1)# randomly choose a interger in [1, m-1]
    b = pow(a,m,n) # b = a^m mod n # ini value of b
    if(b == 1):
        return True # n maybe is prime, no enough witness show that n is composite
    for i in range(k): # i iterate for k times
        if(b == n-1):
            return True # n maybe is prime, no enough witness show that n is composite
        else:
            b = pow(b,2,n)
    return False # n must be a composite
```

证明Miller-Rabin 算法对于合数问题是一个偏是的Monte Carlo算法：反证法

假定对于某个素数n回答的是n为合数。则必有$$a^m \not\equiv 1 \mod{n}$$. 下面考虑算法中检测的b的值的序列，由于算法中每一步都进行b的平方操作。故b的序列为$$a^{m}, a^{2m}, ..., a^{2^{k-1}m}$$. 由于算法回答的是n为合数，则有
$$
a^{2^{i}m}\not\equiv -1 \mod{n}; \tag 1
$$
因为n为素数(由假设)，n-1=2^k^m，由Fermat费马定理：
$$
a^{n-1}\equiv 1 \mod{n} \Rightarrow a^{2^{k}m}\equiv 1 \mod{n} \tag 2
$$
所以$$a^{2^{k-1}m}$$为mod n的1的平方根，而由于n为素数，故mod 1的1的平方根仅有-1 mod n, 1 mod n. 而又因为式1，有:
$$
a^{2^{k-1}m} \equiv 1 \mod{n}
$$
重复此过程可以得到$$a^{m} \equiv 1 \mod{n}$$, 而在算法一开始判断的时候，会将此种情况判断为n是素数，推出矛盾。



---

## Factoring Algorithms

- In number theory, **integer factorization** (整数分解) is the decomposition of a composite number into a product of smaller integers. If these integers are further restricted to prime numbers, the process is called **prime factorization**. (质因数分解)



### Pollard p-1 Algorithm

- 缺陷: 要求n有一个素因子p使得p-1的所有素因子都较小。

$$
\begin{align}
& \text{Pollard } p-1 \text{ Factoring Algorithm}(n, B):\\
& a := 2\\
& \text{for } i:=2 \text{ to }B \text{ do}:\\
& \qquad a := a^{j} \mod{n}\\
& d := \gcd{(a-1, n)}\\
& \text{if } (1<d<n):\\
& \qquad \text{return }d\\
& \text{else return }False\\
\end{align}
$$

d is a non-trivial factor of n

proof: 假定p是n的一个素因子，对每一个素数幂q | (p-1), 有q <= B, 则有: (a在for结束时不可等于1)
$$
(p-1)|B!\\
\text{when for ends: }a \equiv 2^{B!}\mod{n}\\
\because p|n \Rightarrow a \equiv 2^{B!} \mod{p}\\
\text{Fermat theorem }\Rightarrow 2^{p-1} \equiv 1 \mod{p}\\
(p-1) | B! \Rightarrow a \equiv 1 \mod{p}\\
\therefore p|(a-1) \because p|n \therefore p|d=\gcd{(a-1,n)}
$$

> 为了抵抗p-1方法的分解，一般在构造RSA参数的时候会选择两个大素数p1,q1，使得p = 2×p1 + 1, q = 2 × q1 + 1也为素数(此时p-1只有2为小素因子，p1也很大)。



### Pollard rho Algorithm

- **Pollard's rho algorithm** is an algorithm for integer factorization. It was invented by John Pollard in 1975. It uses only a small amount of space, and its expected running time is proportional to the square root of the size of the smallest prime factor of the **composite number** being factorized.
- 对于通过计算x2-x1 和 n 的最大公因子得到n的一个非平凡因子

设p为n的最小素因子，则有: 
$$
\exists x, x' \in \mathbf{Z_n}, (x \neq x') \and (x \equiv x' \mod{p}) \Rightarrow p \le \gcd{(x-x', n)} \le n\\
$$
注意gcd求出的数不一定为p，并且无需知道p即可对n进行分解

下面是rho算法，其中x1需要让f(x1)不至于一开始就循环，通常可以取1。算法计算出n的一个非平凡解。This(gcd(x-x', n)) may be n itself, since the two sequences might repeat at the same time. In this (uncommon) case the algorithm fails, and can be repeated with a different parameter.
$$
\begin{align}
& \text{Pollard } \rho \text{ Factoring Algorithm}(n, x_1):\notag\\
& \text{external }f; \text{which is integer polynomial}\notag\\
& x := x_1\notag\\
& x' := f(x) \mod{n}\notag\\
& p := \gcd{(x-x', n)}\notag\\
& \text{while } (p==1) \text{ do }://\text{in the ith iteration:} x=x_i, x'=x_{2i}\notag\\
& \qquad x := f(x) \mod{n}\notag\\
& \qquad x' := f(f(x')) \mod{n}\notag\\
& \qquad p := \gcd{(x-x', n)}\notag\\
& \text{if }(p=n):\notag\\
& \qquad \text{return } Failure\notag\\
& \text{else return } p//\text{a non-trivial factor of n}\notag\\
\end{align}
$$



### Dixon's random squares method

> Dixon's factorization method, Dixon's random squares method, Dixon's algorithm

- 核心思想: 对于分解n的一个因子的问题，核心步骤为找到一个碰撞并求gcd. 特点是有一个因子基 factor base, 碰撞的值为因子基中的因子的乘积。

$$
x^2 \equiv y^2 \mod{n} \and x\not\equiv \pm y \mod{n} \\
\Rightarrow n |(x-y)(x+y) \and n \nmid (x+y) \and n \nmid (x-y)\\
\Rightarrow \gcd{(x-y, n)} \text{ is a non-trivival factor of }n.
$$





### Number Field Sieve

> NFS 数域筛法

数域筛法的渐进运行时间比二次筛法和椭圆曲线算法的渐进运行时间都少。
$$
L_n[1/3, \lambda]\\
O(e^{(1.92+O(1))(\ln n)^{1/3} (\ln \ln n)^{2/3}})
$$



---


# 公钥密码学和离散对数

公钥密码体制无法提供无条件安全性，因为敌手观察到密文c时，可以利用公钥加密规则ek加密每一条可能的明文m，直到某个m使得ek(m)=c，这样就找到了密文c的原文，实现了解密。故仅研究公钥体制的计算安全性。



#### Discrete Logarithm Problem (DLP)

> 离散对数问题可以理解为，在群中，求解对数问题。
>
> 即在群G中求 $$\log_{\alpha}\beta$$ 的值x，使得 $$\alpha^{x} = \beta$$ 成立

- Discrete Logarithm Problem 离散对数问题



###### Discrete Logarithm

Definition of discrete logarithm: 离散对数的定义

Let *G* be any group. Denote its group operation by multiplication and its identity element by 1. Let *b* be any element of *G*. For any positive integer *k*, the expression b^k^ denotes the product of *b* with itself *k* times: b^k^ = b·b·b…b·b. (k times)

Similarly, let b^-k^ denote the product of b^−1^ with itself *k* times. For *k* = 0, the *k*th power is the identity: b^0^ = 1.

Let *a* also be an element of *G*. An integer *k* that solves the equation b^k^ = *a* is termed a **discrete logarithm** (or simply **logarithm**) of *a* to the base *b*. One writes *k* = log~b~ a.

$$
\text{Compute }x = \log_{\alpha}\beta\text{; so that }
$$



## ElGamal cryptosystem

> p185

- In cryptography, the **ElGamal encryption system** is an asymmetric(非对称) key encryption algorithm for public-key cryptography which is based on the Diffie–Hellman key exchange.



Key generation

The key generator works as follows:

- Alice generates an efficient description of a cyclic group G of order p with generator g. See below for a discussion on the required properties of this group.
- Alice chooses an x randomly from {1, …,q-1}.
- Alice computes  h = g^x^.
- Alice publishes h, along with the description of G,q,g, as her **public key**. Alice retains x as her **private key**, which must be kept secret.

Encryption

The encryption algorithm works as follows: to encrypt a message m to Alice under her public key (G,q,g,h),

- Bob chooses a random y from {1, …,q-1}, then calculates c~1~ = g^y^.
- Bob calculates the shared secret s =h^y^ = g^xy^.
- Bob maps his message m onto an element  m' of G.
- Bob calculates c~2~ = m's.
- Bob sends the ciphertext (c~1~, c~2~)=(g^y^,m'h^y^=(g^y^,m'g^xy^) to Alice.

Note that one can easily find h^y^ if one knows m'. Therefore, a new y is generated for every message to improve security. For this reason, y is also called an **ephemeral key**.

Decryption

The decryption algorithm works as follows: to decrypt a ciphertext (c~1~,c~2~) with her private key x,

- Alice calculates the shared secret s = c~1~^x}^
- and then computes m' = c~2~s^-1^ which she then converts back into the plaintext message m, where s^-1^ is the inverse of s in the group G. (E.g. modular multiplicative inverse if G is a subgroup of a multiplicative group of integers modulo *n*).





### Diffie–Hellman key exchange

> 迪菲-赫尔曼密钥交换 Diffie–Hellman key exchange，缩写为D-H  是一种安全协议
>
> 迪菲－赫尔曼密钥协商 , 迪菲－赫尔曼密钥创建, 指数密钥交换, 迪菲－赫尔曼协议

- 让双方在完全没有对方任何预先信息的条件下通过不安全信道创建起一个密钥。这个密钥可以在后续的通讯中作为对称密钥来加密通讯内容
- 虽然迪菲－赫尔曼密钥交换本身是一个匿名（无认证）的密钥交换协议，它却是很多认证协议的基础，并且被用来提供传输层安全协议的短暂模式中的**前向安全性**
- 安全性: 基于素域(模素数p剩余类域)上离散对数求解的困难性。

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/crypt_DH_key_exchange.png)



#### Description

Alice作为发起方，Bob作为应答方，以下为DH密钥交换的过程：

1. Alice: choose, compute and send:
   1. choose: p: prime number;
   2. choose: g: residue class group mod p, not 0. 模p剩余类群中的非零元素
   3. choose: **a**: secret number, keep by Alice only.
   4. compute:  $$A = g^{a} \mod{p}$$.
   5. send g, p, A to Bob.
2. Bob: receive, choose, compute, send and compute shared secret:
   1. receive: g, p, A
   2. choose: **b**: secret number, keep by Bob only.
   3. compute:  $$ B = g^{b} \mod{p} $$
   4. send: B
   5. compute shared secret: $$ K = A^{b} \mod{p}$$
3. Alice: receive and compute shared secret
   1. receive: B
   2. compute shared secret: $$K = B^{a} \mod{p}$$ , ephemeral(短暂的) key

其中a, b, $$g^{ab} \equiv g^{ba} \mod{p}$$  都为秘密的， 其余的所有值: p, g, $$g^a \mod{p}, g^b \mod{p}$$都可以在公共信道上传输

> Tips: $$g^{ab} = g^{ba} \mod{p}$$  , this is ephemeral(短暂的) key, which are used in the Discrete Logarithm based public cryptosystems, are to ensure the security of the systems. ephemeral key通常是短暂使用，多变的，每一个session都使用一个新的ephemeral key. 相反static key则是长期使用不更改的。







#### 前向安全性

> 前向安全, 前向保密, Forward Secrecy, FS, 完美前向安全, Perfect Forward Secrecy, PFS

- 密码学中通讯协议的安全属性，指的是**长期使用的主密钥泄漏**不会导致过去的**会话密钥**泄漏
- 前向安全能够保护过去进行的通讯不受密码或密钥在未来暴露的威胁
- 如果系统具有前向安全性，就可以保证在主密钥泄露时历史通讯的安全，即使系统遭到主动攻击也是如此





## Algorithms for DLP





### Shanks Algorithm

- 一个非平凡的时间-存储折中算法





### Pollard rho DLP Algorithm

> 之前已经介绍过因子分解的Pollard rho Algorithm

- 与之前因子分解的Pollard rho算法一样，该算法求解离散对数的核心步骤之一也是寻找有限域中的碰撞。

算法input: 群G, 元素g的阶n, 需要求对数的值y。output: $$x = log_{g}y$$
$$
\begin{align}
& \text{Pollard } \rho \text{ DLP Algorithm}(G, n, g, y):\notag\\
& \text{function }f(x, a, b): //<a>\times\mathbf{Z_n}\times\mathbf{Z_n} \rightarrow <a>\times\mathbf{Z_n}\times\mathbf{Z_n}\notag\\
& \qquad \text{if }x\in S_1: f \leftarrow(\ bx,\ a,\ (b+1)\mod{n})\notag\\
& \qquad \text{elif }x\in S_2: f \leftarrow(x^{2},2a\mod{n}, 2b\mod{n})\notag\\
& \qquad \text{else }: f \leftarrow(ax,(a+1)\mod{n}, b)\notag\\

& \text{main: }\notag\\
& \text{define a partition: } G = S_1 \cup S_2 \cup S_3  \notag\\
& (x, a, b) = f(1,0,0)  \notag\\
& (x', a', b') = f(x, a, b) \notag\\
& \text{while}(x \neq x') \text{ do}: \notag\\
& \qquad (x, a, b) = f(x, a, b) \notag\\
& \qquad (x', a', b') = f(x', a', b') \notag\\
& \qquad (x', a', b') = f(x', a', b') \notag\\
& \text{if }(\gcd{(b'-b, n) \neq 1}): \notag\\
& \qquad \text{return } Failure  \notag\\
& \text{else return }((a-a')(b'-b)^{-1})\mod{n} \ //x = \log_{g}y, g^x = y\mod{n} \notag\\
\end{align}
$$

> 注意该算法在n为实际元素的阶的倍数的时候也能运行，只是在while循环出来后，需要直接求解同余式来求得x。例如直接令n=p-1





### Pohlig-Hellman Algorithm





### Index Calculus Method

> 指数演算法





# Python Matlab



```matlab
# 分解大整数的code #matlab
factor(sym('1318495191421054802278821514428263373126245158329273220186647806717202576007787869842301836780734718730787282445644314945034421950063629516552490933'))
ans =[ 481006989528686211893, 602384082763980697559, 1037605481820435550019, 1206102098588167138789, 1206102098588167138789, 1524982628045073955591, 1976916723258661210051]
```

