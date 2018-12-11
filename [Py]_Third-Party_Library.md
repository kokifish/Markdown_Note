[TOC]





------

# numpy

> Python的扩充程序库，支持高阶大量的维度数组与矩阵运算



> ### 特色
>
> 在NumPy上只要能被表示为针对数组或矩阵运算的算法，其运行效率几乎都可以与编译过的等效C语言代码一样快
>
> NumPy提供了与MATLAB相似的功能与操作方式，因为两者皆为解释型语言，并且都可以让用户在针对数组或矩阵运算时提供较标量运算更快的性能

```python
import numpy as np # 一般将numpy简写为np
```



- astype 转换类型
- 



#### ndarray

> **ndarray** stand for ***n*-dimensional array** 多维数组 

- 表示多维度、同质并且固定大小的数组对象

```python
#本例中备注所写的输出会去掉换行
import numpy as np # 一般将numpy简写为np

np_arr = np.array([ [1,2,3],
                    [4,5,6] ], dtype = np.int64) # 一般以list的形式创建, dtype可缺省
print(np_arr)
#[[1 2 3]
# [4 5 6]]
print(np_arr.ndim) # 维度: 2
print(np_arr.shape) # 形状 (2, 3)
print(np_arr.size) # 总共有的元素 6
print(np_arr.dtype) # 存储的元素类型 int64

reversed_arr = arr[::-1]#将一个array逆序

a = np.zeros( (3, 4) ) #生成一个3行4列的全0的矩阵
a = np.ones( (3, 4) ) #生成一个3行4列的全1的矩阵
a = np.empty( (3, 4) ) #生成一个3行4列的空的矩阵
a = np.arange(10, 20, 2) #生成一个[10,20), 步长为2的矩阵 # [10, 12, 14, 16, 18]
a = np.arange(12).reshape( (3, 4) ) #[0,12)为矩阵元素，矩阵形状变成 3*4, 若reshape元素不足会报错
#生成线段  [1, 10], 用6个数字，分为5段
a = np.linspace(1, 10, 6) # [ 1.   2.8  4.6  6.4  8.2 10. ]
a = np.linspace(1, 10, 6).reshape( (2, 3) )#[[ 1.   2.8  4.6]   [ 6.4  8.2 10. ]]
print(a)


a = np.array( [[10, 20, 30], [40, 50, 60] ]) # [[10 20 30]   [40 50 60]]
b = np.arange(6).reshape( (2, 3) ) # [[0 1 2]   [3 4 5]]
print(a, '\n', b)
c = a-b #c: [[10 19 28]   [37 46 55]]
print(b**2) #矩阵的幂，各个元素为原来的2次幂 [[ 0  1  4]   [ 9 16 25]]
print(b)#       [[0 1 2]                 [3 4 5]]
print(b<3) #[[ True  True  True]   [False False False]] #同理可使用 b==3 b>=3
c = a*b #元素逐个相乘，不是矩阵乘法的定义 # [[  0  20  60]   [120 200 300]]
#c = np.dot(a, b) # a.dot(b)  #报错，不符合矩阵乘法的定义
b = b.reshape( (3, 2) ) # [[0 1]   [2 3]   [4 5]]
c = np.dot(a, b) # 等价于c = a.dot(b) #[[160 220]  [340 490]]
print(c)

a = np.random.random((2,3)) #2*3的随机数矩阵, 元素范围[0,1]
print( 10 * np.random.rand(2, 3) ) #2*3的随机数矩阵, 元素范围[0,10]
print(a) 
print( np.sum(a) ) #矩阵元素之和
print( np.min(a) ) #最小矩阵元素
print( np.max(a) ) #最大矩阵元素

print( np.sum(a, axis=1) ) #在每一行求和(横向) #输出为1*2的矩阵
print( np.min(a, axis=0) ) #在每一列求最小值(竖向) #输出为1*3的矩阵

A = np.arange(1, 4, 0.5).reshape(2, 3) #[[1.  1.5  2. ]   [2.5  3.  3.5]]
print(np.argmin(A)) #矩阵最小值的索引 #0
print(np.argmax(A)) #矩阵最大值的索引 #5

print(np.mean(A)) #等价print(A.mean()) #print(np.average(A)) #矩阵的元素平均值 #2.25
print(np.mean(A, axis=0)) #每一列(竖向)的平均值 #输出1*3矩阵 #[1.75 2.25 2.75]

print(np.median(A)) #矩阵的元素中位数 #2.25

print(np.cumsum(A)) #元素累加,输出1*6的矩阵 #[ 1.  2.5 4.5 7. 10. 13.5] #最后的元素是所有元素之和
print(np.diff(A)) #元素累差,输出2*2的矩阵,每行用后一个元素减前一个元素 #[[0.5 0.5] [0.5 0.5]]
print(np.nonzero(A)) #输出两个最大1*6矩阵，第一个表示行数，第二个表示列数#(array([0, 0, 0, 1, 1, 1], dtype=int32), array([0, 1, 2, 0, 1, 2], dtype=int32)) #如果有元素非0，则矩阵元素会少于原矩阵元素，0元素的坐标(row, col)不出现

A = np.arange(6, 0, -1).reshape(2, 3) #[[6 5 4]   [3 2 1]]
print(np.sort(A)) #对矩阵逐行行排序(每一行从小到大) #[[4 5 6]   [1 2 3]]
print(np.transpose(A)) #转置 #等价 print(A.T) #[[6 3]  [5 2]  [4 1]]
print(np.clip(A, 2, 5)) #截断 #小于2的变成2,大于5的变成5 #[[5 5 4]   [3 2 2]]

A = np.array([[1, 1, 1], [1, -1, 1], [1, -1, -1]]) #作为系数矩阵
b = np.array([6, 2, -4])
#若声明 from numpy.linalg import solve #则只需写solve(A, b)
print( np.linalg.solve(A, b) ) # 解矩阵方程式 Ax = b #[1. 2. 3.] 
```

> 下次接着看: bilibili 7 2.5 numpy索引
>
> https://www.bilibili.com/video/av16378934/?p=7



##### tolist

- `ndarray.tolist()`

- Parameters: none; Returns: list

```python
a = np.array([[1, 2], [3, 4]])#<class 'numpy.ndarray'>
a = a.tolist() #<class 'list'> [[1, 2], [3, 4]]
```



```python
a = np.array([[1, 2], [3, 4]])
print(type(a), a)
print('a.tolist():',type(a.tolist()), a.tolist(), type(a.tolist()[0]))
a = np.array(a.tolist())
print(type(a), a)
#Output: 
<class 'numpy.ndarray'> [[1 2]
 [3 4]]
a.tolist(): <class 'list'> [[1, 2], [3, 4]] <class 'list'>
<class 'numpy.ndarray'> [[1 2]
 [3 4]]
```

> The array may be recreated, `a = np.array(a.tolist())`. a前后不变





##### flatten 

> numpy.ndarray.flatten 

- ndarray.flatten(order='C')

- 返回值：一个折叠成 一维 的数组 。Return a copy of the array collapsed into one dimension.

- 参数：order : {‘C’, ‘F’, ‘A’, ‘K’}, optional

  > ‘C’ means to flatten in row-major (C-style) order. ‘F’ means to flatten in column-major (Fortran- style) order. ‘A’ means to flatten in column-major order if a is Fortran *contiguous* in memory, row-major order otherwise. ‘K’ means to flatten a in the order the elements occur in memory. The default is ‘C’.

只能适用于numpy对象，即array或者mat 

```python
#用于array
>>> alist = [[1,2,3],[5,6,7],[8,9,10]]
>>> ar1 = np.array(alist)  #二维数组 m * n 形式
>>> ar1
array([[ 1,  2,  3],
       [ 5,  6,  7],
       [ 8,  9, 10]])
>>> ar1.flatten()
array([ 1,  2,  3,  5,  6,  7,  8,  9, 10])  #一维数组 1 * n 形式
```

```python
>>> ma = np.mat(alist)  #二维矩阵 m * n 形式
>>> ma
matrix([[ 1,  2,  3],
        [ 5,  6,  7],
        [ 8,  9, 10]])
>>> ma1 = ma.flatten()  #二维数组，1 * n 形式
>>> ma1
matrix([[ 1,  2,  3,  5,  6,  7,  8,  9, 10]])

>>> ma2 = ma.flatten().A #二维数组
>>> ma2
array([[ 1,  2,  3,  5,  6,  7,  8,  9, 10]])

>>> ma3 = ma.flatten().A[0] #一维数组
>>> ma3
array([ 1,  2,  3,  5,  6,  7,  8,  9, 10])
```

> matrix.A  中的 A ：array 
>
> 表示将矩阵 matrix转换为二维数组
>
> matrix.A[0] :取二维数组中第一行元素

a array([[6, 7, 1, 6],        [1, 0, 2, 3],        [7, 8, 2, 1]]) 

#### arange

> numpy.arange([*start*, ]*stop*, [*step*, ]*dtype=None*) 

```python
>>> np.arange(3)
array([0, 1, 2])
>>> np.arange(3.0)
array([ 0.,  1.,  2.])
>>> np.arange(3,7)
array([3, 4, 5, 6])
>>> np.arange(3,7,2)
array([3, 5])
```



### random



##### choice

> `numpy.random.choice`(*a*, *size=None*, *replace=True*, *p=None*) 

Generates a random sample from a given 1-D array 

Parameters: 

- **a** 选择的范围 : 1-D array-like or int; If an ndarray, a random sample is generated from its elements. If an int, the random sample is generated as if *a* were np.arange(a)
- **size** 返回的大小: int or tuple of ints, optional; Output shape. If the given shape is, e.g., `(m, n, k)`, then `m * n * k` samples are drawn. Default is None, in which case a single value is returned.
- **replace** 是否可以重复选择: boolean, optional; Whether the sample is with or without replacement
- **p** 选择几率的概率分布(default = 均匀分布): 1-D array-like, optional; The probabilities associated with each entry in a. If not given the sample assumes a uniform distribution over all entries in a.

Returns:

- **samples** : single item or ndarray; The generated random samples

```python
np.random.choice(5, 3)# [0,5)生成3个随机整数，返回1*3的array #array([0, 3, 4])

np.random.choice(5, 3, replace=False, p=[0.1, 0, 0.3, 0.6, 0])#array([2, 3, 0])

# 下例是错误的！ replace含义
np.random.choice(5, 10, replace=False) # ValueError: Cannot take a larger sample than population when 'replace=False'

np.random.choice(np.arange(100), size=100, replace=True, p=fitness / fitness.sum())#其中fitness是list; len(fitness)=100
```



##### append concatenate



```python

```



```python
>>> a = np.array([[1, 2], [3, 4]])
>>> b = np.array([[5, 6]])
>>> np.concatenate((a, b), axis=0)
array([[1, 2],
       [3, 4],
       [5, 6]])
>>> np.concatenate((a, b.T), axis=1)
array([[1, 2, 5],
       [3, 4, 6]])
```



### common function



###### flatnonzero

- Return indices that are non-zero in the flattened version of a

```python

>>> x = np.arange(-2, 3)
>>> x
array([-2, -1,  0,  1,  2])
>>> np.flatnonzero(x)
array([0, 1, 3, 4])#去除0后，所有元素加上array的最小值绝对值
```







---

# pandas

> 

快速便捷地处理结构化数据的大量数据结构和函数。

Pandas 基于两种数据类型，series 和 dataframe 

dataframe 是一个二维的、表格型的数据结构。Pandas 的 dataframe 可以储存许多不同类型的数据，并且每个轴都有标签。可以把它当作一个 series 的字典 

###### Series

> <class 'pandas.core.series.Series'>

类似一维数组的对象，由一组数据(各种NumPy数据类型)以及相关的tag(index)组成。本质上是一个NumPy数组。存取元素：下标index / 标签tag

Series = index + values; //index: 从NumPy数组继承的Index对象，保存标签信息; values: 保存值的NumPy数组 

没有指定索引时，自动创建一个0到N-1(N为数据的长度)的int索引

```python
s = pd.Series(data, index=index)
s.values #获取值的数组表示形式
obj.index #获取索引对象
s_2 = pd.Series([4,7,-5,3], index=['d','b','a','c'])
s_2['a'] #通过tag获取值# -5
s_2[['c','a','d']] # c 3   a -5   d 6

s4 = pd.Series(np.array([1,9,2,3,5,8])) #通过np.array创建
s4.index = ['a','b','c','d','e','f']#设置index
s4['a'] # 1

#通过dict创建Series
d_data = {'hh': 300,'sherry':520,'Annms':521}
s = pd.Series(d_data)#创建后dict的key-value对应Series的tag-value(有序排列)

```

`data` can be many different things: 

- a Python dict
- an ndarray
- a scalar value (like 5)

The passed **index** is a list of axis labels. Thus, this separates into a few cases depending on what **data is**: 

```python
# From ndarray:
s = pd.Series(np.random.randn(5), index=['a', 'b', 'c', 'd', 'e'])

# From dict:
d = {'a' : 0., 'b' : 1., 'c' : 2.}
pd.Series(d, index=['b', 'c', 'd', 'a'])
# Output:
b    1.0
c    2.0
d    NaN
a    0.0
dtype: float64

# From scalar value:
# From scalar value If data is a scalar value, an index must be provided. The value will be repeated to match the length of index
pd.Series(5., index=['a', 'b', 'c', 'd', 'e'])
# Output:
a    5.0
b    5.0
c    5.0
d    5.0
e    5.0
dtype: float64
```

```python
s = pd.Series(np.random.randn(5), index=['a', 'b', 'c', 'd', 'e'])
# Output: s
a    0.4691
b   -0.2829
c   -1.5091
d   -1.1356
e    1.2121
dtype: float64

###### Series is ndarray-like
s[0] # Output: # 0.46911229990718628

s[:3] # 访问index小于3的元素，即index = 0, 1, 2; 对应label = a, b, c
# Output:
a    0.4691
b   -0.2829
c   -1.5091
dtype: float64
    
s[s > s.median()] # 访问大于s的均值的元素
# Output:
a    0.4691
e    1.2121
dtype: float64
    
s[[4, 3, 1]] #按给定的list的顺序访问元素
# Output:
e    1.2121
d   -1.1356
b   -0.2829
dtype: float64
    
np.exp(s) #e的对应幂的值
# Output:
a    1.5986
b    0.7536
c    0.2211
d    0.3212
e    3.3606
dtype: float64
    
###### Series is dict-like
s['a']# Output: # 0.46911229990718628
s['e'] = 12.
# Output: s
a     0.4691
b    -0.2829
c    -1.5091
d    -1.1356
e    12.0000
dtype: float64
    
'e' in s #in关键字，判断一个key是否在Series中 # True
```





###### DataFrame

> pandas.DataFrame 横行为index，竖列为columns

面向列 column-oriented 的二维表结构(表格型)，含有行标，列标。

每个轴都有标签，可以当作一个Series的字典。

```python
class pandas.DataFrame(data=None, index=None, columns=None, dtype=None, copy=False)
```



**data** : numpy ndarray (structured or homogeneous), dict, or DataFrame

> Dict can contain Series, arrays, constants, or list-like objects
>
> Changed in version 0.23.0: If data is a dict, argument order is maintained for Python 3.6 and later.

**index** : Index or array-like

> Index to use for resulting frame. Will default to Range Index if no indexing information part of input data and no index provided

**columns** : Index or array-like

> Column labels to use for resulting frame. Will default to RangeIndex (0, 1, 2, …, n) if no column labels are provided

**dtype** : dtype, default None. 强制存储的数据类型

**copy** : boolean, default False

> Copy data from inputs. Only affects DataFrame / 2d ndarray input

```python
df = pd.DataFrame({'AAA' : [4,5,6,7], 'BBB' : [10,20,30,40],'CCC' : [100,50,-30,-50]});
df['ddd'] = None #添加空列
```



```python
#打开CSV文件，header: 列tag, None指定无列tag，header=0指定第一行为列tag；sep：指定分隔符，默认为','
df = pd.read_csv('test.csv',header=0,sep=',') #返回DataFrame类型
df.size #总大小 = row x col = 60
len(df) #行数长度，不含列名
df.index #索引 = RangeIndex(start=0, stop=10, step=1)
df.columns #列索引(tag) #Index(['intersection_id', 'tollgate_id', 'vehicle_id', 'starting_time', 'travel_seq', 'travel_time'], dtype='object')
df.values #查看df存的值 #array([['B', 3, 1065642, '7/19/2016 0:14', '105#2016-07-  .........2.87', 214.87]], dtype=object)
df.T #df的转置
df.shape #形状 #(10, 6)
df.dtypes #数据类型
df.loc[:,['travel_seq']] #从中抽出一列形成新DataFrame（原来的DataFrame的子集）
df['travel_seq'] #选中其中一列，type = Series
df.describe() #部分数据统计: count(sum), mean, 标准差, min, 25% ...
df[df.rain_octsep < 3] #保留满足条件的record
df[(df.tollgate_id > 0) & (df.tollgate_id < 3)] #保留满足条件的record#不可用keyword 'and'
df[df.starting_time.str.startswith('105#2016-07-19')]


t = df.loc[:,['travel_seq']] #由一行行Series组成的DataFrame
type(t) #<class 'pandas.core.frame.DataFrame'>
type(t.iloc[0]) #<class 'pandas.core.series.Series'>
t.iloc[2].dtype #dtype('O')
t.iloc[2].name #2
t.iloc[2].travel_seq #'105#2016-07-19 00:37:15#5.26;100#2016-07-19 00:37:20#2.85;111#2016-07-19 00:37:23#5.94;103#2016-07-19 00:37:29#1.13;116#2016-07-19 00:37:30#10.07;101#2016-07-19 00:37:40#5.27;121#2016-07-19 00:37:46#25.51;106#2016-07-19 00:38:11#3.42;113#2016-07-19 00:38:15#19.76'

ttt = t['travel_seq'].str.split(';',expand=False) #依';'分隔，不自动分列
ttt[0] #['105#2016-07-19 00:14:24#9.56', '100#2016-07-19 00:14:34#6.75', '111#2016-07-19 00:14:41#13.00', '103#2016-07-19 00:14:54#7.47', '122#2016-07-19 00:15:02#32.85']
type(ttt) #<class 'pandas.core.series.Series'>
type(ttt[0]) #<class 'list'>
```

> 以上示例的CSV 文件内容 #内容大小 10 x 6
>
> ```c
> intersection_id,tollgate_id,vehicle_id,starting_time,travel_seq,travel_time
> B,3,1065642,7/19/2016 0:14,105#2016-07-19 00:14:24#9.56;100#2016-07-19 00:14:34#6.75;111#2016-07-19 00:14:41#13.00;103#2016-07-19 00:14:54#7.47;122#2016-07-19 00:15:02#32.85,70.85
> B,3,1047198,7/19/2016 0:35,105#2016-07-19 00:35:56#11.58;100#2016-07-19 00:36:08#7.44;111#2016-07-19 00:36:15#16.23;103#2016-07-19 00:36:32#5.95;122#2016-07-19 00:36:40#104.79,148.79
> B,1,1086390,7/19/2016 0:37,105#2016-07-19 00:37:15#5.26;100#2016-07-19 00:37:20#2.85;111#2016-07-19 00:37:23#5.94;103#2016-07-19 00:37:29#1.13;116#2016-07-19 00:37:30#10.07;101#2016-07-19 00:37:40#5.27;121#2016-07-19 00:37:46#25.51;106#2016-07-19 00:38:11#3.42;113#2016-07-19 00:38:15#19.76,79.76
> A,2,1071181,7/19/2016 0:37,110#2016-07-19 00:37:59#13.74;123#2016-07-19 00:38:13#4.70;107#2016-07-19 00:38:17#6.63;108#2016-07-19 00:38:24#4.95;120#2016-07-19 00:38:29#0.74;117#2016-07-19 00:38:30#27.05,58.05
> B,1,1065807,7/19/2016 0:56,105#2016-07-19 00:56:21#16.08;100#2016-07-19 00:56:37#12.34;111#2016-07-19 00:56:49#25.75;103#2016-07-19 00:57:15#4.89;116#2016-07-19 00:57:21#38.30;101#2016-07-19 00:57:59#17.87;121#2016-07-19 00:58:17#15.00;106#2016-07-19 00:58:32#0.62;113#2016-07-19 00:58:33#5.98,137.98
> C,3,1072812,7/19/2016 0:56,115#2016-07-19 00:56:31#10.97;102#2016-07-19 00:56:42#13.42;109#2016-07-19 00:56:56#8.35;104#2016-07-19 00:57:04#18.12;112#2016-07-19 00:57:22#18.58;111#2016-07-19 00:57:41#12.92;103#2016-07-19 00:57:53#2.30;122#2016-07-19 00:57:58#26.54,113.54
> B,1,1014648,7/19/2016 1:26,105#2016-07-19 01:26:03#16.85;100#2016-07-19 01:26:20#9.35;111#2016-07-19 01:26:30#19.52;103#2016-07-19 01:26:49#18.43;116#2016-07-19 01:27:12#37.11;101#2016-07-19 01:27:49#14.89;121#2016-07-19 01:28:04#21.81;106#2016-07-19 01:28:26#3.20;113#2016-07-19 01:28:29#30.70,176.7
> A,2,1063919,7/19/2016 1:36,110#2016-07-19 01:36:04#10.39;123#2016-07-19 01:36:15#10.09;107#2016-07-19 01:36:25#8.37;108#2016-07-19 01:36:33#14.65;120#2016-07-19 01:36:48#1.30;117#2016-07-19 01:36:49#29.47,74.47
> A,3,1064408,7/19/2016 1:36,110#2016-07-19 01:36:20#8.58;123#2016-07-19 01:36:28#5.28;107#2016-07-19 01:36:33#3.32;108#2016-07-19 01:36:37#3.97;119#2016-07-19 01:36:41#0.87;114#2016-07-19 01:36:42#16.29;118#2016-07-19 01:36:58#23.12;122#2016-07-19 01:37:21#33.57,94.57
> C,1,1056529,7/19/2016 1:36,115#2016-07-19 01:36:28#9.50;102#2016-07-19 01:36:37#11.62;109#2016-07-19 01:36:49#11.98;104#2016-07-19 01:37:01#26.00;112#2016-07-19 01:37:27#17.66;111#2016-07-19 01:37:44#10.74;103#2016-07-19 01:37:55#10.77;116#2016-07-19 01:38:06#16.33;101#2016-07-19 01:38:23#6.78;121#2016-07-19 01:38:30#9.25;106#2016-07-19 01:38:39#1.15;113#2016-07-19 01:38:40#82.87,214.87
> ```
>
> 

##### read_csv

> 如果数据集中有中文最好在read_csv里面加上 `encoding = 'gbk'`，以避免乱码问题 

- **filepath_or_buffer** : str, pathlib.Path, py._path.local.LocalPath or any object with a read() method (such as a file handle or StringIO). The string could be a URL. Valid URL schemes include http, ftp, s3, and file. For file URLs, a host is expected. For instance, a local file could be  file://localhost/path/to/table.csv
- sep : str, default ‘,’ . Delimiter to use. If sep is None, the C engine cannot automatically detect the separator, but the Python parsing engine can, meaning the latter will be used and automatically detect the separator by Python’s builtin sniffer tool, csv.Sniffer. In addition, separators longer than 1 character and different from '\s+' will be interpreted as regular expressions and will also force the use of the Python parsing engine. Note that regex delimiters are prone to ignoring quoted data. Regex example: '\r\t'
- header : int or list of ints, default ‘infer’. Row number(s) to use as the column names, and the start of the data. Default behavior is to infer the column names: if no names are passed the behavior is identical to header=0 and column names are inferred from the first line of the file, if column names are passed explicitly then the behavior is identical to header=None. Explicitly pass header=0 to be able to replace existing names. The header can be a list of integers that specify row locations for a multi-index on the columns e.g. [0,1,3]. Intervening rows that are not specified will be skipped (e.g. 2 in this example is skipped). Note that this parameter ignores commented lines and empty lines if skip_blank_lines=True, so header=0 denotes the first line of data rather than the first line of the file.
- encoding : str, default None. Encoding to use for UTF when reading/writing (ex. ‘utf-8’). List of Python standard encodings

```python
#
df = pd.read_csv('trajectories(table 5)_training.csv',header=0,sep=',')
>>> df.size #总大小 = row x col
655464
>>> df.shape #形状 (row, col)
(109244, 6)

>>> df.dtypes #列 → type
intersection_id     object
tollgate_id          int64
vehicle_id           int64
starting_time       object
travel_seq          object
travel_time        float64
dtype: object
>>> df.index#索引（即行）
RangeIndex(start=0, stop=109244, step=1)

>>> df.columns #列
Index(['intersection_id', 'tollgate_id', 'vehicle_id', 'starting_time',
       'travel_seq', 'travel_time'],
      dtype='object')

>>> df.values #中间...省去大部分
array([['B', 3, 1065642, '2016-07-19 00:14:24',
        '105#2016-07-19 00:14:24#9.56;100#2016-07-19 00:14:34#6.75;111#2016-07-19 00:14:41#13.00;103#2016-07-19 00:14:54#7.47;122#2016-07-19 00:15:02#32.85',
        70.85],
       ['B', 3, 1047198, '2016-07-19 00:35:56',
        '105#2016-07-19 00:35:56#11.58;100#2016-07-19 00:36:08#7.44;111#2016-07-19 00:36:15#16.23;103#2016-07-19 00:36:32#5.95;122#2016-07-19 00:36:40#104.79',
        148.79000000000005],
       ['B', 1, 1086390, '2016-07-19 00:37:15',
        '105#2016-07-19 00:37:15#5.26;100#2016-07-19 00:37:20#2.85;111#2016-07-19 00:37:23#5.94;103#2016-07-19 00:37:29#1.13;116#2016-07-19 00:37:30#10.07;101#2016-07-19 00:37:40#5.27;121#2016-07-19 00:37:46#25.51;106#2016-07-19 00:38:11#3.42;113#2016-07-19 00:38:15#19.76',
        79.76],
       ...,
       ['A', 3, 1003251, '2016-10-17 23:52:18',
        '110#2016-10-17 23:52:18#7.59;123#2016-10-17 23:52:26#4.11;107#2016-10-17 23:52:30#2.37;108#2016-10-17 23:52:32#2.78;119#2016-10-17 23:52:35#0.63;114#2016-10-17 23:52:36#15.16;118#2016-10-17 23:52:51#18.23;122#2016-10-17 23:53:09#20.94',
        71.94],
       ['A', 3, 1041002, '2016-10-17 23:53:57',
        '110#2016-10-17 23:53:57#10.56;123#2016-10-17 23:54:07#4.02;107#2016-10-17 23:54:11#2.28;108#2016-10-17 23:54:14#4.17;119#2016-10-17 23:54:18#1.44;114#2016-10-17 23:54:19#62.86;118#2016-10-17 23:55:22#22.62;122#2016-10-17 23:55:45#24.51',
        132.51],
       ['A', 3, 1017582, '2016-10-17 23:54:35',
        '110#2016-10-17 23:54:35#9.10;123#2016-10-17 23:54:44#5.36;107#2016-10-17 23:54:50#3.09;108#2016-10-17 23:54:53#3.64;119#2016-10-17 23:54:56#0.82;114#2016-10-17 23:54:57#18.00;118#2016-10-17 23:55:15#18.73;122#2016-10-17 23:55:34#78.38',
        137.38]], dtype=object)
>>> df.describe() #部分数据统计，count(sum), mean, 标准差
         tollgate_id    vehicle_id    travel_time
count  109244.000000  1.092440e+05  109244.000000
mean        2.274496  1.040367e+06     106.447486
std         0.700266  2.717108e+04      71.761686
min         1.000000  1.000004e+06       9.260000
25%         2.000000  1.014494e+06      60.230000
50%         2.000000  1.039902e+06      93.575000
75%         3.000000  1.063742e+06     134.010000
max         3.000000  1.088979e+06    6711.110000
>>> df.T #转置
                                                            0                             ...                                                                     109243
intersection_id                                                  B                        ...                                                                          A
tollgate_id                                                      3                        ...                                                                          3
vehicle_id                                                 1065642                        ...                                                                    1017582
starting_time                                  2016-07-19 00:14:24                        ...                                                        2016-10-17 23:54:35
travel_seq       105#2016-07-19 00:14:24#9.56;100#2016-07-19 00...                        ...                          110#2016-10-17 23:54:35#9.10;123#2016-10-17 23...
travel_time                                                  70.85                        ...                                                                     137.38

[6 rows x 109244 columns]
>>> df.loc[:,['travel_seq']]#选择其中的一列生成数据子集
>>> df.loc[:,['A','B']]#选择其中的两列生成数据子集
len(df)
```



##### loc iloc ix at

iloc 只能使用数字型。返回给定行的 series，行中的每一列都是返回 series 的一个元素 

loc 返回引用的列，使用的是基于字符串的引用，而不是基于数字的

ix 是基于标签的查询方法，同时也支持数字型索引作为备选。但ix有轻微的不可预测性



```python
#访问该Series下，该index的对象#相当于二维数组取元素
df.at[index, Series_name]#注意顺序: [index, Series_name]
```

##### demo

```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

left = pd.DataFrame({'a':['foo', 'bar'], 'l':[1.1, 2.2], 'c':[1, 2]})
right = pd.DataFrame({'a':['hhh', 'foo', 'bar'], 'r':[3.3, 4.4, 5.5], 'c':[1, 2, 3]})

print(left, 'this is left')
print(right, 'this is right', right.index)
print(pd.merge(left, right, on=['a'], how='outer'))
print(pd.merge(left, right, on=['a'], how='inner'))
print(pd.merge(left, right, on=['a', 'c'], how='outer'))

print(pd.merge(left, right, left_on=['c'], right_index=True))

print(left.groupby('a'))
for index,row in right.iterrows():
    print('index = ',index)
    print(row)

```







---

# sympy



-   Subs is the slowest but simplest option. It runs at SymPy speeds. The `.subs(...).evalf()` method can substitute a numeric value for a symbolic one and then evaluate the result within SymPy

```python
from sympy.abc import x
f = x**3-2*x-6
print f.diff() #result is :3*x**2-2
print f.diff().evalf(subs={x:6}) #result is : 106.0000000000

```

```python
#经典demo (writing)
import sympy as sp

x = sp.Symbol("x")
f_1 = sin(x)/x
f_1.evalf(subs={x: 1.57}) #函数求值 0.636942473204990

f_2 = 1/(1+x**2)
sp.integrate(f, (x,-1, 1)) #pi/2 求定积分
sp.integrate(f, (x,-float("inf"),float("inf")) #求无穷限广义积分 3.14159265358979 #返回类型 <class 'sympy.core.mul.Mul'>
```

---

# sklearn

> scikit-learning

可以做监督学习，非监督学习

分类学习classifier，线性回归

选择机器学习方法的流程:

![]()



```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier

iris = datasets.load_iris()#加载一个特定的dataset
iris_X = iris.data
iris_y = iris.target

print(iris_X[:4, :])
print('iris_y:',iris_y)

#将train和test分开，测试集占0.3#会同时打乱顺序
x_train, x_test, y_train, y_test = train_test_split(iris_X, iris_y, test_size=0.3)#调用train_test_split分成训练测试集

print('y_train:', y_train)#训练的target
print('y_test:', y_test)#测试用的target
knn = KNeighborsClassifier()#创建kd树分类器
knn.fit(x_train, y_train)#训练
print(knn.predict(x_test))#用测试集数据进行预测
print(y_test)#查看真实的值，即target
```



```python
from sklearn import datasets
from sklearn.linear_model import LinearRegression

loaded_data = datasets.load_boston()#加载boston这个dataset
data_X = loaded_data.data
data_y = loaded_data.target

model = LinearRegression()#线性回归模型
model.fit(data_X, data_y)#fit: 训练模型，适应模型

print(model.predict(data_X[:4, :]))#用前四个样本进行预测，输出预测结果
print('model.coef_:',model.coef_)#线性回归模型的系数
print('model.intercept_:',model.intercept_)#线性回归模型的常数项
print(model.get_params())#model定义的参数
print(model.score(data_X, data_y)) #对model进行打分，获取精确度，方式：R^2 coefficient of determination(自行wiki)
```



#### SVC SVR

> SVC: Support Vectors Classification; SVR: Support Vectors Regression

```python
from sklearn import preprocessing
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.datasets.samples_generator import make_classification
from sklearn.svm import SVC
import matplotlib.pyplot as plt

a = np.array([[10, 2.7, 3.6],[-100, 5, -2],[120, 20, 40]], dtype=np.float64)
print(a)
print(preprocessing.scale(a))#利用scale，将array-like的数据normalize，使得数据更适合ML处理
#生成data：n_samples：样例数；n_informative：相关属性；n_redundant: 冗余属性；random_state：随机状态，指定后，虽然每次都是随机生成，但每次随机生成的数据相同（相当于指定random seed）
x, y = make_classification(n_samples=300,n_features=2,n_redundant=0, n_informative=2,random_state=22,n_clusters_per_class=1,scale=100)

plt.scatter(x[:, 0],x[:, 1],c=y)#x[:, 0]作为作图的x，x[:, 1]作为作图的y；c=y：y作为颜色
plt.show()

x = preprocessing.scale(x)  # normalization step, 使用默认的scale
#x = preprocessing.minmax_scale(x,feature_range=(-1, 1))#normalize 到[-1,1]

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=.3)#7:3分开训练-测试集
clf = SVC()#创建一个Support Vectors Classification
clf.fit(x_train, y_train)#用train 输入-输出对进行学习
print(clf.predict(x_test))#用测试集输入进行预测
print(clf.score(x_test, y_test))#(测试集输入, 测试集输出)进行评分，输出准确度
```





---

# CSV

CSV (Comma Separated Values)，即逗号分隔值（也称字符分隔值，因为分隔符可以不是逗号），是一种常用的文本格式，用以存储表格数据，包括数字或者字符



##### reader

```python
reader(csvfile, dialect='excel', **fmtparams)
csvfile，必须是支持迭代(Iterator)的对象，可以是文件(file)对象或者列表(list)对象，如果是文件对象，打开时需要加"b"标志参数。
dialect，编码风格，默认为excel的风格，也就是用逗号（,）分隔，dialect方式也支持自定义，通过调用register_dialect方法来注册。
fmtparam，格式化参数，用来覆盖之前dialect对象指定的编码风格
```

```python
import csv
with open('test.csv','rb') as myFile:
    lines=csv.reader(myFile)
    for line in lines:
        print line
```





# matplotlib



## pyplot

- Provides a MATLAB-like plotting framework.

> https://matplotlib.org/api/pyplot_api.html
>
> https://matplotlib.org/api/_as_gen/matplotlib.pyplot.html 函数references

```python
matplotlib.rcParams[‘figure.figsize’]#图片像素 
matplotlib.rcParams[‘savefig.dpi’]#分辨率 
plt.savefig(‘plot123_2.png’, dpi=200)#指定分辨率
```







###### plot()

- 画线

> plot [n.] 情节 图 阴谋 [vt.] 密谋 绘图 划分 标绘  [vi.] 密谋 策划 绘制
>
> https://matplotlib.org/api/_as_gen/matplotlib.pyplot.plot.html

```python
import matplotlib.pyplot as plt
import numpy as np

np.random.seed(0)

x, y = np.random.randn(2, 100)
fig = plt.figure()
ax1 = fig.add_subplot(211)
ax1.xcorr(x, y, usevlines=True, maxlags=50, normed=True, lw=2)
ax1.grid(True)
ax1.axhline(0, color='black', lw=2)

ax2 = fig.add_subplot(212, sharex=ax1)
ax2.acorr(x, usevlines=True, normed=True, maxlags=50, lw=2)
ax2.grid(True)
ax2.axhline(0, color='black', lw=2)

plt.show()

```





###### imshow

```python
matplotlib.pyplot.imshow(X, cmap=None, norm=None, aspect=None, interpolation=None, alpha=None, vmin=None, vmax=None, origin=None, extent=None, shape=None, filternorm=1, filterrad=4.0, imlim=None, resample=None, url=None, hold=None, data=None, **kwargs)[source]
```

- **X** (image): array_like, shape (n, m) or (n, m, 3) or (n, m, 4)

  Display the image in `X` to current axes. `X` may be an array or a PIL image. If `X` is an array, it can have the following shapes and types:

  - MxN -- values to be mapped (float or int)
  - MxNx3 -- RGB (float or uint8)
  - MxNx4 -- RGBA (float or uint8)

  MxN arrays are mapped to colors based on the `norm`(mapping scalar to scalar) and the `cmap` (mapping the normed scalar to a color).

  Elements of RGB and RGBA arrays represent pixels of an MxN image. All values should be in the range [0 .. 1] for floats or [0 .. 255] for integers. Out-of-range values will be clipped to these bounds.



------

## Apply in math





```python
import numpy as np
import matplotlib.pyplot as plt

x = np.linspace(-30, 30, 10000) #[-30, 30]分10000个点 # x为numpy.ndarray
y = (x**2-5*x+10) # 每个x都计算x**2-5*x+10后保存在y中 # y为numpy.ndarray
z = (2*x-5)#导数方程
z = (-5*x+10)#二次函数的0点切线方程

plt.figure(num = 1, figsize=(8,4)) #1号figure，以下信息直至下个figure出现的都属于这个figure #figure 标号num = 1, figsize设置绘图区大小
plt.grid(False) #是否显示网格

#画线
plt.plot(x, y, color="red", linewidth=2) #画线，color线条颜色, linewidth线条宽度
plt.plot(x, z, color="blue", linewidth=1, linestyle = '--')#linestyle画线方式

plt.title("PyPlot First Example")
plt.xlabel("Time(s)") # x轴label
plt.ylabel("Volt") # y轴label

#更改坐标轴值的初始显示范围，刻度等
plt.xlim(-30, 40) # set x limits #初始显示x的范围，拉到其他地方坐标依然有值显示
plt.ylim(-100, 400) #初始显示y的范围，拉到其他地方坐标依然有值显示

x_ticks = np.linspace(-20, 30, 10) #起始值，终止值，点数
plt.xticks(x_ticks) #设置x轴的ticks，ticks以外的部分坐标无值，如果设置的ticks小于xlim的范围，初始时就有一部分坐标无值
plt.yticks([-2, -1.8, -1, 1.22, 3], [r'$really\ bad$', r'$bad$', r'$normal$', r'$good$', r'$really\ good$'])#用str替代对应值，'$'机器能读取的 #输出数学形式的alpha: '\alpha'

plt.legend() #显示旁注#attention: 不会显示后来再定义的旁注

#另一个figure
plt.figure(num = 5, figsize=(8, 4)) #3号figure

plt.show() #显示图像
```



```python
# https://www.bilibili.com/video/av16378354/?p=6
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(-3, 3, 50)
y1 = 2*x + 1
y2 = x**2

plt.figure()
plt.plot(x, y2)
plt.plot(x, y1, color='red', linewidth=1.0, linestyle='--')# plot the second curve in this figure with certain parameters

plt.xlim((-1, 2))# set x limits
plt.ylim((-2, 3))

new_ticks = np.linspace(-1, 2, 5)# set new ticks
plt.xticks(new_ticks)

plt.yticks([-2, -1.8, -1, 1.22, 3],
           ['$really\ bad$', '$bad$', '$normal$', '$good$', '$really\ good$']) # set tick labels # to use '$ $' for math text and nice looking, e.g. '$\pi$'


ax = plt.gca() # gca = 'get current axis'
ax.spines['right'].set_color('none') #spines:脊柱,这里指轴,函数图像框的四条边
ax.spines['top'].set_color('none') #使上边的框颜色透明

ax.xaxis.set_ticks_position('bottom') #将x坐标轴用bottom的坐标轴代替
# ACCEPTS: [ 'top' | 'bottom' | 'both' | 'default' | 'none' ]

ax.spines['bottom'].set_position(('data', -1))#挪动x坐标轴的位置至纵坐标值data的值为-1处
# the 1st is in 'outward' | 'axes' | 'data' #定位到的比例，传入0.1则定位到10%
# axes: percentage of y axis
# data: depend on y data

ax.yaxis.set_ticks_position('left') #将y坐标轴用left的坐标轴代替
# ACCEPTS: [ 'left' | 'right' | 'both' | 'default' | 'none' ]

ax.spines['left'].set_position(('data',0))
plt.show()
```

> 下次从7 2.5legend图例开始看
>
> https://www.bilibili.com/video/av16378354/?p=7





###### task written by dennis

```python
#author: 黄海宇 student_id = 16337087 信息安全专业 SDCS SYSU
#f(x) = 1/(1+x**2)
#令插值节点为等距节点-5，-4，-3，-2，-1，0，1，2，3，4，5，在这些节点处对f进行三次样条插值
#其中边界条件为第一类边界条件，在两个端点处导数为1，即f´(-5)=f´(5)=1

#CSI for Cubic Spline Interpolating 三次样条插值
import numpy as np
import matplotlib.pyplot as plt
import sympy as sp

prcs_x = list(range(-5, 6, 1))
prcs_y = [1/(1+x**2) for x in prcs_x]
h_list = [prcs_x[i+1] - prcs_x[i] for i in range(0, 10)]#step

A = np.zeros( (11, 11) )
for i in range(0, 11):
    A[i][i] = 2

for i in range(1, 10):
    A[i][i+1] = h_list[i] / (h_list[i-1] + h_list[i])
    A[i][i-1] = h_list[i-1] / (h_list[i-1] + h_list[i])
A[0][1] = 1
A[10][9] = 1

diff_list = [(prcs_y[i+1] - prcs_y[i])/h_list[i] for i in range(0, 10)] #一阶差分f[x_i, x_i+1]

d_list = list()
d_list.append(6/h_list[0] * (diff_list[0] - 1))# d_0
for i in range(1, 10):
    d_list.append(6* (diff_list[i] - diff_list[i-1]) / (h_list[i-1] + h_list[i]))
d_list.append(6/h_list[9] * (1 - diff_list[9]))# d_n = d_10

M = np.linalg.solve(A, d_list)

S_func = list()
for i in range(0, 10):
    S_i = np.poly1d([-1, prcs_x[i+1]])**3 * M[i] / (6*h_list[i])
    S_i += np.poly1d([1, -prcs_x[i]])**3 * M[i+1] / (6*h_list[i])
    S_i += np.poly1d([-1, prcs_x[i+1]]) * (prcs_y[i]/h_list[i] - h_list[i]*M[i]/6)
    S_i += np.poly1d([1, -prcs_x[i]]) * (prcs_y[i+1]/h_list[i] - h_list[i]*M[i+1]/6)
    S_func.append(S_i)

def CSI_func(x:float):
    if(x>=5.0):
        return S_func[-1](x)
    if(x <= -5.0):
        return S_func[0](x)
    return S_func[int(x+5)](x)

#误差计算 算法为区间[-5,5]内101个等距分布点处的误差绝对值的平均值
prcs_x = np.linspace(-5, 5, 101) #插值节点
prcs_y = (1 /(prcs_x**2 +1))
itplt_y = [CSI_func(x) for x in prcs_x]
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
print("分段三次样条插值的误差: ", mean_error)


###matplotlib.pyplot绘图
plt.figure(num = 1, figsize=(10,6))
plt.grid(False)
x_ticks = np.linspace(-10, 10, 21) #起始值，终止值，点数
plt.xticks(x_ticks)
plt.xlim(-5, 5)
plt.ylim(-1, 2)
plt.title("Piecewise Cubic Spline Interpolation")
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
prcs_x = np.linspace(-5, 5, 1000)
prcs_y = (1 /(prcs_x**2 +1))
plt.plot(prcs_x, prcs_y, color="black", linewidth=1)

###matplotlib.pyplot插值函数绘图
itplt_x = np.linspace(-5, 5, 1000)
plt.plot(itplt_x, [CSI_func(x) for x in itplt_x], color="red", linewidth=1.5)

plt.show() #显示图像
```



- 随机过程，最优停时的大作业

$$
u: 当前收益；c: 游戏成本\\
若当前收益小于继续游戏的收益的期望则继续游戏，可以列出\\
u < \sum_{i=1}^{11}\frac{1}{12} (100\times i+u)+\frac{1}{12} \times(0) - c\\
化简后得:\ u < 6600-12\times c
$$



```python

```



---

# networkx



`networkx.generators.random_graphs.barabasi_albert_graph` 根据BA模型生成无标度网络

Parameters:
- **n** (*int*) – Number of nodes
- **m** (*int*) – Number of edges to attach from a new node to existing nodes
- **seed** (*int, optional*) – Seed for random number generator (default=None).


```python
import time
import networkx as nx
import matplotlib.pyplot as plt
BA= nx.random_graphs.barabasi_albert_graph(500,2,time.time()) #生成节点n=20、m=1的BA无标度网络
pos = nx.spring_layout(BA) #定义一个布局，此处采用了spring布局方式
nx.draw(BA,pos,with_labels=False,node_size = 30)  #绘制图形
plt.show()
```





```python
#重要函数list

draw_shell
barabasi_albert_graph
betweenness_centrality#node betweenness centrality#https://networkx.github.io/documentation/latest/reference/algorithms/generated/networkx.algorithms.centrality.betweenness_centrality.html#networkx.algorithms.centrality.betweenness_centrality
connected_double_edge_swap#交换两条线的连接
set_node_attributes#设置节点属性
average_shortest_path_length#计算平均最短路径长度
communicability_betweenness_centrality
```



> draw_networkx:参数列表   https://networkx.github.io/documentation/latest/reference/generated/networkx.drawing.nx_pylab.draw_networkx.html

betweenness_centrality: normalized=False时，无向图的结果会 x 2/( (N-1) x (N-2) )

```python
import networkx as nx
import matplotlib.pyplot as plt


G = nx.Graph([(0,1),(1,2),(1,5),(5,4),(2,4),(2,3),(4,3),(3,6)])
cbc = nx.betweenness_centrality(G,endpoints=False,normalized=False)
print('betweenness_centrality',cbc)
cbc = nx.betweenness_centrality_subset(G,[0,1,4,3],[0,1,4,3],normalized=False)#制定一部分点可以产生包，以此来计算betweenness
print('betweenness_centrality_subset',cbc)
nx.draw(G,with_labels=True)
plt.show()
```



### paper used



```python
import time
import networkx as nx
import matplotlib.pyplot as plt

### main
G=nx.random_graphs.barabasi_albert_graph(500,2,time.time()) #生成节点n=20、m=1的BA无标度网络
print(type(G))
print(G.degree()[2])


def draw_graph(G:nx.Graph):
    nlist=list()
    for d_level in set(sorted([d for n, d in G.degree()])):
        sub_list = [n for n,d in G.degree() if d == d_level]
        nlist.insert(0,sub_list)
    i=1
    print('before:',nlist)
    plt.figure(figsize=(4,4))
    while(i<len(nlist)-4): #忽略最中心一层与最外三层
        if(len(nlist[i])<=1):
            nlist[i+1].extend(nlist[i])
            nlist.pop(i)
        elif(len(nlist[i]) <= 2**(i)
            and len(nlist[i])+len(nlist[i+1]) > len(nlist[i+2]) 
            and (len(nlist[i+1])+len(nlist[i+2])) < 2**(i)):
            nlist[i+2].extend(nlist[i+1])
            nlist.pop(i+1)
        else:
            i+=1
    print('after:',nlist)
    nx.draw_shell(G,nlist=nlist,with_labels=False, node_size=5,font_size=7,width=0.2,edge_color='#272727')
    plt.show()
    return None

#return: node id of degree max(if more than one, random select one)
def find_degree_max(G:nx.Graph):
    dv = nx.degree(G)
    dmax = max([v for k, v in dv])#degree max
    nid = random.choice([i for i,j in dv if j==dmax])#if more than one, random select one
    return nid

#设置capacity；按照degree**ALPHA / total(degree**ALPHA)
def set_ori_capacity_by_degree(G:nx.Graph, ALPHA:float=1.0):
    print(nx.degree(G))
    dv = nx.degree(G)
    d_sum = sum([d**ALPHA for n, d in dv])
    print('d_sum:', d_sum)
    dv = {n:d**ALPHA/d_sum for n, d in dv}
    nx.set_node_attributes(G, dv, 'ori_capacity')
    return None

#设置attribute：betweenness；以host计算介数betweenness，
def set_betweenness_by_host(G:nx.Graph, host_list:list):
    bc = nx.betweenness_centrality_subset(G,host_list,host_list,normalized=False)#return dict
    nx.set_node_attributes(G, bc, 'betweenness')
    # for i in host_list:#起点终点计入load中
    #     G.node[i]['load']+=len(host_list)-1
    return None
```



```python
#20180809 11:58
import time
import networkx as nx
import matplotlib.pyplot as plt
import random

class SFN:
    def __init__(self, G):
        self.G = G
        self.lambda_c = 0
        self.b_sum = 0
        self.M = 0

def draw_graph(G:nx.Graph):
    nlist=list()
    for d_level in set(sorted([d for n, d in G.degree()])):
        sub_list = [n for n,d in G.degree() if d == d_level]
        nlist.insert(0,sub_list)
    i=1
    print('before:',nlist)
    plt.figure(figsize=(4,4))
    while(i<len(nlist)-4): #忽略最中心一层与最外三层
        if(len(nlist[i])<=1):
            nlist[i+1].extend(nlist[i])
            nlist.pop(i)
        elif(len(nlist[i]) <= 2**(i)
            and len(nlist[i])+len(nlist[i+1]) > len(nlist[i+2]) 
            and (len(nlist[i+1])+len(nlist[i+2])) < 2**(i)):
            nlist[i+2].extend(nlist[i+1])
            nlist.pop(i+1)
        else:
            i+=1
    print('after:',nlist)
    nx.draw_shell(G, nlist=nlist, with_labels=False,node_size=5,font_size=7,
        width=0.2,edge_color='#272727')
    plt.show()
    return None

#return: node id of degree max(if more than one, random select one)
def find_degree_max(G:nx.Graph):
    dv = nx.degree(G)
    dmax = max([v for k, v in dv])#degree max
    nid = random.choice([i for i,j in dv if j==dmax])#if more than one, random select one
    return nid

#set: capacity；according degree**ALPHA / total(degree**ALPHA)
def set_ori_capacity_by_degree(G:nx.Graph, ALPHA:float=1.0):
    print(nx.degree(G))
    dv = nx.degree(G)
    d_sum = sum([d**ALPHA for n, d in dv])
    print('d_sum:', d_sum)
    dv = {n:d**ALPHA/d_sum for n, d in dv}
    nx.set_node_attributes(G, dv, 'ori_capacity')
    return None

#set: attribute：betweenness；以host计算介数betweenness
def set_betweenness_by_host(G:nx.Graph, host_list:list):
    bc = nx.betweenness_centrality_subset(G,host_list,host_list,normalized=False)#re: dict
    nx.set_node_attributes(G, bc, 'betweenness')
    # for i in host_list:#起点终点计入load中
    #     G.node[i]['load']+=len(host_list)-1
    return None

#set: use probability #return: sum of betweenness
def set_usep_by_host(G:nx.Graph, host_list:list):
    bc = nx.betweenness_centrality_subset(G,host_list,host_list,normalized=False)
    b_sum = sum([b for b in bc.values()])
    print('b_sum', b_sum)
    bc.update({n: b/b_sum for n,b in bc.items()})
    #bc = {n:b/b_sum for n, b in bc.items()}
    nx.set_node_attributes(G, bc, 'usep')
    return b_sum

#cal: lambda_c
def cal_lambda_c(G:nx.Graph, host_list:list):
    M = len(host_list)
    lambda_c = 9999999999999999999999.9
    for i in G.nodes:
        if(G.node[i]['betweenness']!=0):
            temp = G.node[i]['ori_capacity']*(M-1)/G.node[i]['betweenness']
            lambda_c = temp if temp<lambda_c else lambda_c
    return lambda_c

#cal: initial total load(L0) # need attribute: usep, ori_capacity
def cal_initial_total_load(G:nx.Graph, ALPHA:float):
    cu_min = 9999999999999999999999.9
    for i in G.nodes:
        if(G.node[i]['usep']!=0):
            temp = G.node[i]['ori_capacity']/G.node[i]['usep']
            cu_min = temp if temp<cu_min else cu_min
    L0 = cu_min/(1+ALPHA)
    return L0

#cal: initial total load(L0) # need: lambda_c, b_sum, M, ALPHA(redundancy parameter)
def cal_initial_total_load_fast(G:nx.Graph, lambda_c:float, b_sum:float, M:int, ALPHA:float):
    return lambda_c*b_sum/((M-1)*(1+ALPHA))

#cal: R (Robustness)
def cal_R(G:nx.Graph, host_list:list):
    GC = G.copy()
    degree_max_nid = find_degree_max(GC)
    GC.remove_node(degree_max_nid)
    
    for i in GC.nodes:
        if(GC.node[i]['betweenness']!=0):
            pass
    return None
```

```python
# G=nx.random_graphs.barabasi_albert_graph(NETWORK_SIZE,2,time.time())#生成BA无标度网络
# host_list=np.random.randint(0,NETWORK_SIZE,size=50)
# print('host_list:', host_list)
# cna.set_ori_capacity_by_degree(G, 1)#set capacity #ALPHA=1时成正比设置
# print('G.node[0] ori_capacity:',type(G.node[0]['ori_capacity']), G.node[0]['ori_capacity'])
# for i in range(10):
#     print(G.node[i]['ori_capacity'])
# cna.set_betweenness_by_host(G, host_list)#set betweeness
# for i in range(20):
#     if i in G.nodes:
#         print(i,' node betweenness:',G.node[i]['betweenness'])
# b_sum = cna.set_usep_by_host(G, host_list)#set use probability #
# for i in range(20):
#     if i in G.nodes:
#         print(i,' node use probability:',G.node[i]['usep'])
# lambda_c = cna.cal_lambda_c(G, host_list)
# print('lambda_c: ', lambda_c)
# ALPHA = 0.5
# L0 = cna.cal_initial_total_load(G, ALPHA)
# print('L0: initial total load=', L0, 'lambda_c*b_sum/((M-1)*(1+ALPHA))=', 
#     lambda_c*b_sum/((50-1)*(1+ALPHA)))
```



### official demo



> ### Parallel Betweenness
>
> 并行化计算Betweenness
>
> https://networkx.github.io/documentation/stable/auto_examples/advanced/plot_parallel_betweenness.html#sphx-glr-auto-examples-advanced-plot-parallel-betweenness-py

```python
from multiprocessing import Pool
import time
import itertools

import matplotlib.pyplot as plt
import networkx as nx


def chunks(l, n):
    """Divide a list of nodes `l` in `n` chunks"""
    l_c = iter(l)
    while 1:
        x = tuple(itertools.islice(l_c, n))
        if not x:
            return
        yield x


def _betmap(G_normalized_weight_sources_tuple):
    """Pool for multiprocess only accepts functions with one argument.
    This function uses a tuple as its only argument. We use a named tuple for
    python 3 compatibility, and then unpack it when we send it to
    `betweenness_centrality_source`
    """
    return nx.betweenness_centrality_source(*G_normalized_weight_sources_tuple)


def betweenness_centrality_parallel(G, processes=None):
    """Parallel betweenness centrality  function"""
    p = Pool(processes=processes)
    node_divisor = len(p._pool) * 4
    node_chunks = list(chunks(G.nodes(), int(G.order() / node_divisor)))
    num_chunks = len(node_chunks)
    bt_sc = p.map(_betmap,
                  zip([G] * num_chunks,
                      [True] * num_chunks,
                      [None] * num_chunks,
                      node_chunks))

    # Reduce the partial solutions
    bt_c = bt_sc[0]
    for bt in bt_sc[1:]:
        for n in bt:
            bt_c[n] += bt[n]
    return bt_c


if __name__ == "__main__":
    G_ba = nx.barabasi_albert_graph(1000, 3)
    G_er = nx.gnp_random_graph(1000, 0.01)
    G_ws = nx.connected_watts_strogatz_graph(1000, 4, 0.1)
    for G in [G_ba, G_er, G_ws]:
        print("")
        print("Computing betweenness centrality for:")
        print(nx.info(G))
        print("\tParallel version")
        start = time.time()
        bt = betweenness_centrality_parallel(G)
        print("\t\tTime: %.4F" % (time.time() - start))
        print("\t\tBetweenness centrality for node 0: %.5f" % (bt[0]))
        print("\tNon-Parallel version")
        start = time.time()
        bt = nx.betweenness_centrality(G)
        print("\t\tTime: %.4F seconds" % (time.time() - start))
        print("\t\tBetweenness centrality for node 0: %.5f" % (bt[0]))
    print("")

    nx.draw(G_ba)
    plt.show()
```



---

# python文件批量运行(真并行)

1. 每个运行的实例都得在一个独立的虚拟环境，否则会出错，包括其调用的包
2. 用一个额外的程序或脚本调用那些独立的虚拟环境。



## Virtualenv & Pythonbrew

> python的虚拟环境及多版本开发利器: https://www.openfoundry.org/tw/tech-column/8516-pythons-virtual-environment-and-multi-version-programming-tools-virtualenv-and-pythonbrew

Pythonbrew 已整合了 Virtualenv

Windows下的安装:

1. 将C:\PythonX.Y\Scripts\下找到easy_install.exe，并将该目录放进Windows环境中的PATH
2. cmd: easy_install virtualenv 安装virtualenv

使用方法：

建立虚拟环境:

1. cd进工作目录
2. virtualenv [指定虚拟环境的名称], 例如使用virtualenv ENV创建一个叫ENV的虚拟环境

启动虚拟环境:

1. cd ENV
2. source bin/activate, windows: \path\to\env\Scripts\activate.bat
3. 此时命令行的最前端出现了虚拟环境名称，e.g. (ENV)
4. [opt.] 如果在虚拟环境中需要安装其他包，可以使用pip与requirements.txt相关的指令

退出虚拟环境:

1. 在已启动虚拟环境的情况下，输入deactivate，而后命令行最前端不再显示虚拟环境的名称









