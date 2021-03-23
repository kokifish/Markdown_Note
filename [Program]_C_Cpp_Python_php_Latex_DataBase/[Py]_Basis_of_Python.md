[TOC]



Python是一种解释型、面向对象、动态数据类型的高级程序设计语言

像Perl语言一样, Python 源代码同样遵循 GPL(GNU General Public License)协议

Python的3.0版本，常被称为Python 3000，或简称Py3k。相对于Python的早期版本，这是一个较大的升级。为了不带入过多的累赘，Python 3.0在设计的时候没有考虑向下兼容

Python就为我们提供了非常完善的基础代码库，覆盖了网络、文件、GUI、数据库、文本等大量内容，被形象地称作"内置电池"batteries included





```python
	df.at[start_date.hour, road] = \ #换行
		np.append(df.at[start_date.hour, road], [travel_time])
```



---

# Basics of Python

-   Python交互式模式下，可以直接输入代码，然后执行，并立刻得到结果。主要是为了调试Python代码用的
-   命令行模式下，可以直接运行`.py`文件

```python
#!/usr/bin/env python3 #.py文件的第一行加特殊的注释,在Mac\Linux上直接运行
print('hello, world')

$ chmod a+x hello.py#通过命令给hello.py以执行权限
```

-   以`#`开头的语句是注释,其他每一行都是一个语句
-   没有规定缩进是几个空格还是Tab。约定俗成应该使用4个空格的缩进
-   当语句以冒号`:`结尾时，缩进的语句视为代码块
-   Python程序是大小写敏感的

---

# Data Type & Name & Related Method

>   数据类型与标识符

-   只有name和object概念，如a = 3, a为标识name，3为对象object。过程可以理解为: 
    1.  创建name: a
    2.  创建object: 3
    3.  将name a关联到3这个object
-   所有name创建时必须关联到一个object, name可以在创建以后指向任何一个object(可以跨类型)
-   name本身没有类别，关联的object有类别 //用type(name)查看name关联的object的类型


```python
x = 1 # name x 关联到 object 1
print(id(x))
x = x + 1 # x+1 后创建了一个新的objct 2, 然后name x 重新关联到 object 2
print(id(x))
print(type(x))
print( isinstance((x), int ) )

# Possible output:
1648288528
1648288544
<class 'int'>
True
```

>   isinstance() 函数来判断一个对象是否是一个已知的类型
>
>   sinstance() 与 type() 区别：
>
>   -   type() 不会认为子类是一种父类类型，不考虑继承关系。
>   -   isinstance() 会认为子类是一种父类类型，考虑继承关系。
>
>   isinstance (a, (str,int,list))    # a是元组中的一个返回 True

Python3 中有六个标准的数据类型：

-   Number 数字
-   String 字符串
-   List 列表
-   Tuple 元组
-   Sets 集合
-   Dictionary 字典

**可迭代对象**: list, dict, tuple

- mutable 可更改: list, dict 是可修改的对象。可迭代对象的一个属性(除了tuple)
- immutable 不可更改: strings, tuples, numbers



-   **不可变数据 (4个):** Number 数字、String 字符串、Tuple 元组、Sets 集合
-   **可变数据 (2个):** List 列表、Dictionary 字典




>   数据模型 python3文档
>
>   http://docspy3zh.readthedocs.io/en/latest/reference/datamodel.html 

| Type        | mutable     | Description                              | Syntax example                         |
| ----------- | ----------- | ---------------------------------------- | -------------------------------------- |
| `bool`      | immutable   | Boolean value                            | True False                             |
| `bytearray` | **mutable** | Sequence of bytes                        | bytearray(b'Demo') bytearray([65, 97]) |
| `bytes`     | immutable   | Sequence of bytes                        | b'ASCII' bytes([65, 97])               |
| `complex`   | immutable   | Complex number with real and imaginary parts | 3+2.7j                                 |
| `dict`      | **mutable** | Associative array (or dictionary) of key and value pairs; can contain mixed types (keys and values), keys must be a hashable type | {'key1': 1.0, 3: False}                |
| `ellipsis`  |             | An ellipsis placeholder to be used as an index in NumPy arrays | ...                                    |
| `float`     | immutable   | Floating point number, system-defined precision | 3.1415927                              |
| `frozenset` | immutable   | Unordered set, contains no duplicates; can contain mixed types, if hashable | frozenset([4.0, 'string', True])       |
| `int`       | immutable   | Integer of unlimited magnitude           | 42                                     |
| `list`      | **mutable** | List, can contain mixed types            | [4.0, 'string', True]                  |
| `set`       | **mutable** | Unordered set, contains no duplicates; can contain mixed types, if hashable | {4.0, 'string', True}                  |
| `str`       | immutable   | A character string: sequence of Unicode codepoints | 'aaa'  "bbb"                           |
| `tuple`     | immutable   | Can contain mixed types                  | (4.0, 'string', True)                  |

mutable: 容器类对象通常是可变对象

1.  dict
2.  set
3.  list
4.  bytearray



## Number

>   Python3 支持 **int、float、bool、complex复数**

整型int:

-   Python的整数没有大小限制
-   整数运算永远是精确的(含除法 ' / ')



### float



浮点型:

-   Python的浮点数也没有大小限制，但是超出一定范围就直接表示为`inf`（无限大）
-   1.23x109就是`1.23e9`，或者`12.3e8`，0.000012可以写成`1.2e-5`
-   整数和浮点数在计算机内部存储的方式是不同的，而浮点数运算则会有四舍五入的误差








## str & encode

-   字符串是以单引号`'`或双引号`"`括起来的任意文本 # e.g. `'abc'`，`"xyz"`
-   如果`'`本身也是一个字符，可以用`""`括起来，也可以用转义字符' \ '转义 ' 和 "  # e.g.  `"I'm OK"`包含的字符是`I`，`'`，`m`，空格，`O`，`K`这6个字符
-   str是不可变对象

>   https://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000/001431664106267f12e9bef7ee14cf6a8776a479bdec9b9000

-   Python中，通常用全部大写的变量名表示常量

```python
PI = 3.14159265359
```

-   事实上`PI`仍然是一个变量，Python根本没有任何机制保证`PI`不会被改变



-   Python允许用`r''`表示`''`内部的字符串默认不转义

```python
>>> print('\\\t\\')
\       \
>>> print(r'\\\t\\')
\\\t\\
```

-   Python允许用`'''...'''`的格式表示多行内容
-   在交互式命令行内输入，在输入多行内容时，提示符由`>>>`变为`...`，提示你可以接着上一行输入，`...`是提示符，不是代码的一部分

```python
#三引号允许字符串跨多行，字符串中可以包含换行符，制表符及其他特殊符号 "..."在交互式模式下是自动添加的
>>> print('''line1
... line2
... line3''')
line1
line2
line3
#与上等价,在.py文件中
print('''line1
line2
line3''')
```

```python
print(r'''hello,\n
world''')
# output:
hello,\n
world
```



-   最新的Python 3版本中，字符串是以Unicode编码的，故Python的字符串支持多语言
-   对于单个字符的编码，Python提供了`ord()`函数获取字符的整数表示，`chr()`函数把编码转换为对应的字符

```python
>>> ord('A')
65
>>> ord('中')
20013
>>> chr(66)
'B'
>>> chr(25991)
'文'
```

由于Python的字符串类型是str，在内存中以Unicode表示，一个字符对应若干个字节。如果要在网络上传输，或者保存到磁盘上，就需要把str变为以字节为单位的bytes

```python
x = b'ABC' # Python对bytes类型的数据用带b前缀的单引号或双引号表示
```

要注意区分`'ABC'`和`b'ABC'`，前者是`str`，后者虽然内容显示得和前者一样，但`bytes`的每个字符都只占用一个字节

以Unicode表示的`str`通过`encode()`方法可以编码为指定的`bytes`

```python
>>> 'ABC'.encode('ascii')
b'ABC'
>>> '中文'.encode('utf-8') # 一般不使用gb2312
b'\xe4\xb8\xad\xe6\x96\x87'
>>> '中文'.encode('ascii')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
UnicodeEncodeError: 'ascii' codec can't encode characters in position 0-1: ordinal not in range(128)
```

纯英文的`str`可以用`ASCII`编码为`bytes`，内容是一样的，含有中文的`str`可以用`UTF-8`编码为`bytes`。含有中文的`str`无法用`ASCII`编码，因为中文编码的范围超过了`ASCII`编码的范围，Python会报错

在`bytes`中，无法显示为ASCII字符的字节，用`\x##`显示

如果我们从网络或磁盘上读取了字节流，那么读到的数据就是`bytes`。要把`bytes`变为`str`，就需要用`decode()`方法

```python
>>> b'ABC'.decode('ascii')
'ABC'
>>> b'\xe4\xb8\xad\xe6\x96\x87'.decode('utf-8')
'中文'
```

如果`bytes`中包含无法解码的字节，`decode()`方法会报错

如果`bytes`中只有一小部分无效的字节，可以传入`errors='ignore'`忽略错误的字节

```python
>>> b'\xe4\xb8\xad\xff'.decode('utf-8', errors='ignore')
'中'
```

要计算`str`包含多少个字符，可以用`len()`函数：

```python
>>> len('ABC')
3
>>> len('中文')
2

```

`len()`函数计算的是`str`的字符数，如果换成`bytes`，`len()`函数就计算字节数：

```python
>>> len(b'ABC')
3
>>> len(b'\xe4\xb8\xad\xe6\x96\x87')
6
>>> len('中文'.encode('utf-8'))
6
```

由于Python源代码也是一个文本文件，所以，当你的源代码中包含中文的时候，在保存源代码时，就需要务必指定保存为UTF-8编码。当Python解释器读取源代码时，为了让它按UTF-8编码读取，我们通常在文件开头写上这两行：

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
```

1.  第一行注释是为了告诉Linux/OS X系统，这是一个Python可执行程序，Windows系统会忽略这个注释
2.  第二行注释是为了告诉Python解释器，按照UTF-8编码读取源代码，否则，你在源代码中写的中文输出可能会有乱码

申明了UTF-8编码并不意味着你的`.py`文件就是UTF-8编码的，必须并且要确保文本编辑器正在使用UTF-8 without BOM编码



| 占位符  | 替换内容   |
| ---- | ------ |
| %d   | 整数     |
| %f   | 浮点数    |
| %s   | 字符串    |
| %x   | 十六进制整数 |

```python
print('%2d-%02d' % (3, 1))
print('%.2f' % 3.1415926)
```



-   format()

使用字符串的`format()`方法，用传入的参数依次替换字符串内的占位符`{0} {1}`...

```python
>>> 'Hello, {0}, 成绩提升了 {1:.1f}%'.format('小明', 17.125)
'Hello, 小明, 成绩提升了 17.1%'
```



## 容器类对象

-   容器类对象通常是可变的mutable
-   容器实际存储的是对象的reference
-   可变是指reference可变，即存储的reference指向新的object

```python
l = ['sherry', 'App', 'pix', 'py'] #创建list标识l
a = l[0] #返回l的0位置的reference所关联的object的值
print(a, id(a))
print(l[0], id(l[0]))
l[0] = 1 #l[0]关联到了新的object 1
print(l[0], id(l[0]))

#possible output:
sherry 96054656
sherry 96054656
1 1648288528
```

1.  列表
2.  元组
3.  字典
4.  集合



### list 列表

-   list是一种有序的集合，可以随时添加和删除其中的元素





>   https://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000/0014316724772904521142196b74a3f8abf93d8e97c6ee6000

```python
import numpy as np
import math

l1 = [ ['Apple', 'Google', 'Microsoft'], ['Java', 'Python', 'Ruby', 'PHP']， ['Adam', 'Bart', 'Lisa'] ] #多维list


print(l1[0][1]) # Google
print(l1[2][-1]) # Lisa #-1取倒数第一个元素
len(l1) # 3
len(l1[1]) # 4

l2 = list(range(-5, 6, 1)) #创建整数列表[-5, 6)的list: -5 -4 -3 -2 -1 0 1 2 3 4 5
print(l2.)


l3 = list() #创建空list

### list推导
l4 = [1/(1+x**2) for x in range(-5,6)]#默认step为1

b = [1,2,3] #list
b = np.array(b)#实际上可要可不要，l5生成的list是一样的
l5 = [math.log(x)for x in b]

prcs_ist_x = [float(5 * sp.cos((2*x-1)/(2*11) * sp.pi)) for x in range(11, 0, -1)]
prcs_ist_y = [1/(1+x**2) for x in prcs_ist_x]


time_zones = [rec['tz'] for rec in records if 'tz' in rec]
```

##### list method

| 方法        | 功能        |
| --------- | --------- |
| len(list) | 列表元素个数    |
| max(list) | 返回列表元素最大值 |
| min(list) | 返回列表元素最小值 |
| list(seq) | 将元组转换为列表  |




| 方法                                         | 功能                                                         |
| -------------------------------------------- | ------------------------------------------------------------ |
| list.append(obj)                             | 在列表**末尾添加**新的对象                                   |
| list.count(obj)                              | 统计某个元素在列表中出现的次数                               |
| list.extend(seq)                             | 在列表末尾一次性追加另一个序列中的多个值(用新列表扩展原来的列表) |
| list.index(obj)                              | 从列表中找出某个值**第一个**匹配项的索引位置                 |
| list.insert(index, obj)                      | 将obj插入列表                                                |
| list.pop( [index = -1 ] )                    | 移除列表中的一个元素(默认最后一个 即index = -1), 并返回该元素的值 |
| list.remove(obj)                             | 删除列表中第一个与obj匹配的项                                |
| list.reverse()                               | 反向列表中元素                                               |
| list.sort(cmp=None, key=None, reverse=False) | 对原列表进行排序                                             |
| list.clear()                                 | 清空列表                                                     |
| list.copy()                                  | 复制列表                                                     |

> list去重 http://peiqiang.net/2015/01/13/python-remove-duplicates-in-list.html

```python
list(set(seq))# Not order preserving #不保持顺序 #list去重
[1,2,3,2].index(2) # => 1
[i for i,x in enumerate([1,2,3,2]) if x==2] # => [1, 3]
```





### tuple 元组

-   tuple元组，有序列表，tuple一旦初始化就**不能修改**



只有1个元素的tuple定义时必须加一个逗号`,`，来消除歧义

```python
t = (1) # t为整数 #t: 1

t = (1,) # t为tuple #t: (1,) 
#在显示只有1个元素的tuple时，也会加一个逗号, 以免误解成数学计算意义上的括号
```





### dict (map)字典

-   dict for dictionary
-   使用 **key-value** 存储(键值对)，内部实现使用hash，所以查找时间不随key的增加而增加，具有极快的查找速度，复杂度O(1)
-   dict的key必须是不可变对象//e.g. list不可作key

```python
d = {} #定义空dict
d = dict() #定义空dict
d = {'Sherry': 95, 'Dennis': 75, '1024': 85} # dict初始化
d['sb'] = 67 # dict通过key增加元素
d['sb'] = 100 # dict通过key覆盖value

'Thomas' in d # 通过key判断是否存在 # 返回 False 

d.get('no_body') # get方法判断key是否存在 # 返回None
#返回None时，Python的交互环境不显示结果(一行输出都没有)
d.get('no_body', -1) # get方法指定不存在时返回的值 #返回-1

d.pop('1024') # 删除key对应的键值对

d_2 = {1:9, 3:5, 2:6}
items = sorted(d_2.items(), key=lambda d: d[0])#排序，dict.iterms 返回tuple组成的list
```

1.  查找和插入的速度极快，不会随着key的增加而变慢
2.  需要占用大量的内存，内存浪费多//空间换时间

```python
# 元素遍历 #使用到了dict推导式，list推导式
data_list=[2, 1, 3.2, 6, 99]
key_list=['s', 'h', 'e', 'r', 'y']
d={key_list[i]:data_list[i] for i in range(5)}
print(d)
for k in d:
    print(k) #Output: dict的key
for da in d.items():
    print(da) #Output: dict的(key, value)
for k, da in d.items():
    print(k, da) #Output: dict的 key, value
print([k for k in d]) #Output: list: key in dict
print([da for da in d.items()]) #Output: list: (key, value) in dict
print([da for k, da in d.items()]) #Output: list: value in dict
```





### set & frozenset

>   可变集合与不可变集合
>
>   https://www.cnblogs.com/panwenbin-logs/p/5519617.html
>
>   关系测试和消除重复元素. 集合对象还支持union(联合), intersection(交集), difference(差集)和sysmmetric difference(对称差集)等数学运算.支持 x in set, len(set),和 for x in set

-   key的集合，不存value //由于key不可重复，故set中没有重复的元素
-   无序，无重复元素，可变的集合 //可变→无法hash，不存在hash值 //不记录元素位置\插入点不支持 indexing
-   不可以放入可变对象 //如果放入可变对象，则无法判断两个对象是否相等也无法判断是否有重复元素
-   创建一个set，需要提供一个list作为输入集合

```python
s = set([1, 1, 2, 3]) #提供一个list来创建set # 重复的元素会被忽略 # {1, 2, 3}
s.add(4) # add() 添加元素4 # {1, 2, 3, 4}
s.add(4) # 可以重复添加但无效果 # {1, 2, 3, 4}
s.remove(4) # remove() 删除元素4 # {1, 2, 3}

s1 = set([1, 2, 3])
s2 = set([2, 3, 4])
s1 & s2 # 集合运算: 交集
s1 | s2 # 集合运算: 并集

```





#### frozenset

-   不可变集合 frozenset 冻结的集合
-   不可变，存在哈希值，可以作为字典的key，可以作为其它集合的元素
-   缺点: 一旦创建便不能更改，没有`add(), remove()`





## Data Type Conversion

-   

```python
### int(x)
birth = int('birth: 1997') # convert string to int
int(12.99) # 转换为整数 12 # 取整

### hex(x)
s = hex(255) # '0xff' # 把一个整数转换成十六进制表示的字符串

### float(x)
float('12.34') # 转换为浮点数12.34

### complex(x)
complex(x)

### bool(x)
bool(1) # True
bool('') # False

### str(x)
str(1.23) # '1.23'
str(100) # '100'


```



## Starred Expression 星号表达式

> https://www.python.org/dev/peps/pep-3132/
>
> https://www.python.org/dev/peps/pep-0448/

星号表达式 `*args` 用于将传入的可迭代参数序列解析出来，并存入`args`中

1. 参数传递

```python
def f(a, b, c, d):
     print(a, b, c, d, sep = '&')
func(1,2,3,4)
func(*[1, 2, 3, 4])#会将列表[1,2,3,4]中的数字取出来，分别赋给参数a,b,c,d

np.random.randn(*m.shape)#用numpy创建一个大小与m相同的随机矩阵
```

2. unpack可迭代的变量

```python
a, *b, c = range(5)
#a=0; c=4; b=[1, 2, 3];
record = ('ACME', 50, 123.45, (12, 18, 2012))
name, *_1, (*_2, year) = record
#name='ACME'; _1=[50,123.45]; _2=[12,18]; year=2012
for a, *b in [(1, 2, 3), (4, 5, 6, 7)]:
	print(b)
#[2, 3]
#[5, 6, 7]


```
- **\* 表达式不可单独使用！**

```python
#错误用法
*a = range(5)
a = *range(5)
print(*range(5))

#正确用法
*a, = range(5) #[0, 1, 2, 3, 4]
a = *range(5), #(0, 1, 2, 3, 4)
*a,b = range(5)
print(*range(5),)
```



## Comprehension 推导式





### list Comprehension

```python
multiples = [i for i in range(30) if i % 3 is 0]
# multiples: [0, 3, 6, 9, 12, 15, 18, 21, 24, 27]
squared = [x**2 for x in range(10)]

# 二层推导式
>>> alist = [[1,2,3],[5,6,7],[8,9,10]]
>>> [y for x in alist for y in x]
[1, 2, 3, 5, 6, 7, 8, 9, 10]
```



### dict & set Comprehension

dict推导式：

```python
#快速对换dict key—value to value-key
mca={"a":1, "b":2, "c":3, "d":4}
dicts={v:k for k,v in mca.items()}

bc = {n:b/b_sum for n, b in bc.items()}
bc.update({n: b/b_sum for n,b in bc.items()})#与上条等效
```





set推导式：跟list推导式类似。 唯一的区别在于使用大括号`{}` 

```python
squared = {x**2 for x in [1, 1, 2]} #set推导式
# squared: {1, 4}
s = {i+1 for i in range(9)} # 1~9的set
```





## The **Scope** of a Name Binding







## shallow and deep copy

> 浅拷贝 深拷贝

```python
def f(a):
    a.append(2)
    print('in f():id:', id(a), 'a:', a)
    print(' id(a[0]):', id(a[0]), 'a[0]:', a[0])
    return a

def main():
    a=[1]
    print('ori id(a):', id(a), 'a:', a)
    print(' id(a[0]):', 'a[0]:', a[0])
    re_a=f(a)
    print('now id(a):', id(a), 'a:', a)
    print(' id(a[0]):', id(a[0]), 'a[0]:', a[0])
    print('id(re_a): ', id(re_a), 're_a:', re_a)

main()
#Output:
ori id(a): 2376741096840 a: [1]
 id(a[0]): 140728639411232 a[0]: 1
in f():id: 2376741096840 a: [1, 2]
 id(a[0]): 140728639411232 a[0]: 1
now id(a): 2376741096840 a: [1, 2]
 id(a[0]): 140728639411232 a[0]: 1
id(re_a):  2376741096840 re_a: [1, 2]
```





---

# Operational Character

>   操作符

```python
#!/usr/bin/env python
# -*-coding:utf-8 -*-
x = 1
y = 1
print(id(x))
if(x is y):
    print("x is y == true")
else:
    print("x is y == false")
```







| 运算符优先级                   | 描述                                |
| ------------------------ | --------------------------------- |
| **                       | 指数 (最高优先级)                        |
| ~ + -                    | 按位取反, 一元加号和减号 (最后两个的方法名为 +@ 和 -@) |
| * / % //                 | 乘，除，取模，取整除                        |
| + -                      | 加法减法                              |
| >> <<                    | 右移，左移运算符                          |
| &                        | 位 'AND'                           |
| ^ \|                     | 位运算符                              |
| <= < > >=                | 比较运算符(小于，大于，小于等于，大于等于)            |
| == !=                    | 等于运算符(等于，不等于)                     |
| = %= /= //= -= += *= **= | 赋值运算符                             |
| is is not                | 身份运算符                             |
| in not in                | 成员运算符                             |
| and or not               | 逻辑运算符                             |







| Operator |      | example                    |
| -------- | ---- | -------------------------- |
| +        | 加    |                            |
| -        | 减    |                            |
| *        | 乘    |                            |
| /        | 精确除  | 21 / 10 = 2.1              |
| %        | 取模   |                            |
| **       | 幂    | 2\*\*4 = 16,   3\*\*4 = 81 |
| //       | 取整除  | 9.0//2.0 = 4.0,  9//2 = 4  |
|          |      |                            |







### Division & Mod

-   Python中，有两种除法: 精确除   /    和   取整除   //
-   求模: % 取模，保证出来的数大于等于0

```python
>>> 10 / 3
3.3333333333333335
>>> 9 / 3 # 即使是两个整数恰好整除，结果也是浮点数
3.0
>>> 10 // 3 #整数的地板除//永远是整数
3
>>> 10 % 3 #取余
1
>>> -1 % 3 #取余
2
```



### is & is not

>   身份运算符

-   is: 判断两个标识符是不是引用同一个Object, 引用同一个Object为True, 否则Flase // x is y, 类似id(x) == id(y)
-   is not: 判断两个标识符是不是引用自不同Object// x is not y, 类似id(x) != id(y)


>   与 '\=\=', '!\=' 的区别: is, is not 是地址比较，\=\=, !\= 是值比较

```python
x = 1
y = 1
print(id(x))
if(x is y):
    print("x is y == true") # x, y都引用(指向)同一个Object: 1 
else:
    print("x is y == false")
    
#Output:
x is y == true
```




### in & not in

>   成员运算符

| operator | Logic                                                 |                               |
| -------- | ----------------------------------------------------- | ----------------------------- |
| in       | 如果在指定的序列中找到值返回 True，否则返回 False     | 如果 x 在 y 序列中返回 True   |
| not in   | 如果在指定的序列中没有找到值返回 True，否则返回 False | 如果 x 不在 y 序列中返回 True |




```python
>>> 3 not in [2, 3, 4]
False
>>> 3 not in [4, 5, 6]
True
```





### 三目运算符

```python
exp1 if contion else exp2
max_num = a if a>b else b

a if a>b else c if c>d else d # 与下面一句等效
a if a>b else ( c if c>d else d )
```



---

# Conditions & Loops

>   条件判断与循环



### if elif else

-   `elif`是`else if`的缩写
-   python不支持switch

```python
#demo:
age = 3
if age >= 18:
    print('adult')
elif age >= 6:
    print('teenager')
else:
    print('kid')
#基本结构:    
if <条件判断1>:
    <执行1>
elif <条件判断2>:
    <执行2>
else:
    <执行3>
```





### for



-   `for x in ...`循环就是把每个元素代入变量`x`，然后执行缩进块的语句

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-

for letter in 'Python':     # 第一个实例
   print('当前字母 :', letter)

fruits = ['banana', 'apple',  'mango']
for fruit in fruits:        # 第二个实例
   print('当前字母 :', fruit)

print("Good bye!")
# output:
当前字母 : P
当前字母 : y
当前字母 : t
当前字母 : h
当前字母 : o
当前字母 : n
当前字母 : banana
当前字母 : apple
当前字母 : mango
Good bye!
```



for … else : 

for 中的语句和普通的没有区别，else 中的语句会在循环正常执行完(即 for 不是通过 break 跳出而中断的)的情况下执行，while … else 相同

```python
for num in range(10,20):  # 迭代 10 到 20 之间的数字 [10, 20)
	for i in range(2,num): # 根据因子迭代
		if num%i == 0:      # 确定第一个因子
			j=num/i          # 计算第二个因子
			print('%d 等于 %d * %d' % (num,i,j))
			break            # 跳出当前循环
	else:                  # 循环的 else 部分
		print(num, '是一个质数')
# output:
10 等于 2 * 5
11 是一个质数
12 等于 2 * 6
13 是一个质数
14 等于 2 * 7
15 等于 3 * 5
16 等于 2 * 8
17 是一个质数
18 等于 2 * 9
19 是一个质数
```

-   循环语句可以有 else 子句，它在穷尽列表(以for循环)或条件变为 false (以while循环)导致循环终止时被执行,但循环被break终止时不执行

### while

```python
#!/usr/bin/python #Python 3.6.5 (v3.6.5:f59c0932b4, Mar 28 2018, 16:07:46) [MSC v.1900 32 bit (Intel)] on win32
# -*- coding: UTF-8 -*-
i = 2
while(i < 100):
   j = 2
   while(j <= (i/j)):
      if not(i%j): break
      j = j + 1
   if (j > i/j) : print(i), " 是素数"
   i = i + 1
 
print("Good bye!")

# output:
2 是素数
3 是素数
...
89 是素数
97 是素数
Good bye!
```





### break continue pass

-   **break** : break 语句可以跳出 for 和 while 的循环体。如果你从 for 或 while 循环中终止，任何对应的循环 else 块将不执行
-   **continue** : 告诉Python跳过当前循环块中的剩余语句，然后继续进行下一轮循环
-   **pass** : 空语句，是为了保持程序结构的完整性，不做任何事情，一般用做占位语句

```python
for letter in 'Runoob':
    if letter == 'o':
        pass
        print ('执行 pass 块')
    print ('当前字母 :', letter)

print ("Good bye!")
# Output:
当前字母 : R
当前字母 : u
当前字母 : n
执行 pass 块
当前字母 : o
执行 pass 块
当前字母 : o
当前字母 : b
Good bye!
```



---

# Iterator

>   迭代器

-   Iterator 迭代器是访问集合元素的一种对象
-   Python的`Iterator`对象表示的是一个数据流，Iterator对象可以被`next()`函数调用并不断返回下一个数据，直到没有数据时抛出`StopIteration`错误
-   `Iterator`的计算是惰性的，只有在需要返回下一个数据时它才会计算

```python
>>>list=[1,2,3,4]
>>> it = iter(list)    # 创建迭代器对象
>>> print (next(it))   # 输出迭代器的下一个元素
1
>>> print (next(it))
2
>>>
```

```python
list=[1,2,3,4]
it = iter(list)    # 创建迭代器对象
for x in it:
    print (x, end=" ")
# Output:
1 2 3 4
```



-   凡是可作用于`for`循环的对象都是`Iterable`类型
-   凡是可作用于`next()`函数的对象都是`Iterator`类型，它们表示一个惰性计算的序列；
-   集合数据类型如`list`、`dict`、`str`等是`Iterable`但不是`Iterator`，不过可以通过`iter()`函数获得一个`Iterator`对象。
-   Python的`for`循环本质上就是通过不断调用`next()`函数实现的

```python
for x in [1, 2, 3, 4, 5]:
    pass

# 首先获得Iterator对象:
it = iter([1, 2, 3, 4, 5])
# 循环:
while True:
    try:
        x = next(it)# 获得下一个值
    except StopIteration:
        break# 遇到StopIteration就退出循环
```





---

# Generator / yield

>   生成器

-   一边循环一边计算的机制: generator
-   generator保存的是算法，每次调用`next(g)`，就计算出`g`的下一个元素的值，直到计算到最后一个元素，没有更多的元素时，抛出`StopIteration`错误
-   如果一个函数定义中包含`yield`关键字，那么这个函数就不再是一个普通函数，而是一个generator
-   生成器是一个返回迭代器的函数，只能用于迭代操作

```python
def gen_example():
    print('before any yield')
    yield 'first yield' # yield 1
    print('between yields')
    yield 'second yield' # yield 2
    print('no yield anymore')

gen = gen_example()
print(gen.__next__()) # 第一次调用next
# before any yield
# first yield
print(gen.__next__()) # 第二次调用next
# between yields
# second yield
print(gen.__next__()) # 第三次调用next
# no yield anymore
#Traceback (most recent call last):
#  File "c:.../generator.py", line 13, in <module>
#    print(gen.__next__())
# StopIteration
```



创建generator: 方式一: 把一个列表生成式的[]改成()

```python
>>> L = [x * x for x in range(10)] # list
>>> L
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
>>> g = (x * x for x in range(10)) # generator
>>> g
<generator object <genexpr> at 0x1022ef630>
>>> next(g)
0
>>> next(g)
1
>>> next(g)
4
>>> next(g)
9
>>> next(g)
16
>>> next(g)
25
>>> next(g)
36
>>> next(g)
49
>>> next(g)
64
>>> next(g)
81
>>> next(g)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration
>>> g = (x * x for x in range(10))
>>> for n in g:   #用for来迭代generator，无需担心StopIteration
...     print(n)
... 
0
1
4
9
16
25
36
49
64
81

```



创建generator: 方式二: 函数定义中含`yield`关键字

```python
import sys
 
def fibonacci(n): # 生成器函数 # 斐波那契
    a, b, count = 0, 1, 0
    while count < n:
        yield a # 遇到yield语句返回，再次执行时从上次返回的yield语句处继续执行
        a, b = b, a + b
        count += 1
    return 'done'

f = fibonacci(10) # f 是一个迭代器，由生成器fibonacci()返回生成

while True:#尝试改写成for的版本
    try:
        print (next(f), end=" ")
    except StopIteration: # StopIteration
        sys.exit() # exit退出
#for的版本
for x in f:#此时迭代器已经到了StopIteration，不再有输出
    print (x, end=" ")
# Output:
0 1 1 2 3 5 8 13 21 34
```



#### Conversion of Generator



```python
#assume: ge is <class 'generator'>

#需要多次使用genertator的东西时:
list(ge)#可以理解为：list不断调用迭代器ge的__next__直到抛出错误
for i in ge:
    print('This cannot print')#永远不会输出，因为ge已经被next完了
```





---

# Functions



```python
# 定义一个什么事也不做的空函数
def nop():
    pass
```

定义默认参数要牢记一点：默认参数必须指向不变对象！

```python
def add_end(L=[]):
    L.append('END')
    return L

>>> add_end()
['END']
>>> add_end()
['END', 'END']
>>> add_end()
['END', 'END', 'END']
```

>   上例释疑: add_end在定义的时候，默认参数`L`的值就被计算出来了，即`[]`，因为默认参数`L`也是一个变量，它指向对象`[]`，每次调用该函数，如果改变了`L`的内容，则下次调用时，默认参数的内容就变了，不再是函数定义时的`[]`

```python
# add_end更新版
def add_end(L=None):
    if L is None:
        L = []
    L.append('END')
    return L
```





### parameters

可更改(mutable)与不可更改(immutable)对象

在 python 中，strings, tuples, 和 numbers 是不可更改的对象，而 list,dict 等则是可以修改的对象。

-   **不可变类型：**变量赋值 **a=5** 后再赋值 **a=10**，这里实际是新生成一个 int 值对象 10，再让 a 指向它，而 5 被丢弃，不是改变a的值，相当于新生成了a。
-   **可变类型：**变量赋值 **la=[1,2,3,4]** 后再赋值 **la[2]=5** 则是将 list la 的第三个元素值更改，本身la没有动，只是其内部的一部分值被修改了。

python 函数的参数传递：

-   **不可变类型：**类似 c++ 的值传递，如 整数、字符串、元组。如fun（a），传递的只是a的值，没有影响a对象本身。比如在 fun（a）内部修改 a 的值，只是修改另一个复制的对象，不会影响 a 本身。
-   **可变类型：**类似 c++ 的引用传递，如 list, dict。如 fun（la），则是将 la 真正的传过去，修改后fun外部的la也会受影响







-   函数执行完毕也没有`return`语句时，自动`return None`
-   Python函数返回值可以是tuple
-   返回一个tuple可以省略括号，而多个变量可以同时接收一个tuple，按位置赋给对应的值



### main()

> http://codingpy.com/article/guido-shows-how-to-write-main-function/

```python
#初级用法
import sys
import getopt

def main():
    # parse command line options
    try:
        opts, args = getopt.getopt(sys.argv[1:], "h", ["help"])
    except getopt.error, msg:
        print msg
        print "for help use --help"
        sys.exit(2)
    # process options
    for o, a in opts:
        if o in ("-h", "--help"):
            print __doc__
            sys.exit(0)
    # process arguments
    for arg in args:
        process(arg) # process() is defined elsewhere

if __name__ == "__main__":
    main()
```



---

## Built-in Functions





>   https://docs.python.org/3/library/functions.html#abs





###### isinstance

-   Return true if the *object* argument is an instance of the *classinfo* argument, or of a (direct, indirect or virtual) subclass thereof. If *object* is not an object of the given type, the function always returns false. If *classinfo* is a tuple of type objects (or recursively, other such tuples), return true if *object*is an instance of any of the types. If *classinfo* is not a type or tuple of types and such tuples, a `TypeError` exception is raised.

```python
isinstance(object, classinfo)
```

```python
def my_abs(x):
    if not isinstance(x, (int, float)): # 检查x是否为int或float
        raise TypeError('bad operand type')
    if x >= 0:
        return x
    else:
        return -x
    
>>> my_abs('A')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 3, in my_abs
TypeError: bad operand type
```

###### range max min

```python
range(-5, 6, 1) #创建整数列表[-5, 6)的list: -5 -4 -3 -2 -1 0 1 2 3 4 5
```



###### sum pow 

The two-argument form `pow(x, y)` is equivalent to using the power operator: `x**y`

```python
sum(iterable[, start])
sum([0,1,2])#output:3
sum([0,1,2,3,4], 2)#list计算总和(10)后再 +2, output: 12
```



###### reduce 

- **reduce()** 函数会对参数序列中元素顺序两两操作

```python
reduce(function, iterable[, initializer])#注意第一个是function
def add(x, y) :            # 两数相加
    return x + y

reduce(add, [1,2,3,4,5])#计算列表和：1+2+3+4+5 15
reduce(lambda x, y: x+y, [1,2,3,4,5])#使用 lambda 匿名函数, output: 15

```

###### eval

- eval() 函数用来执行一个字符串表达式，并返回表达式的值

```python
x = 7
eval( '3 * x' )# output: 21
```



###### globals

> globals()  # 参数：无；返回值：全局变量的字典

```python
a='runoob'
print(globals()) # globals 函数返回一个全局变量的字典，包括所有导入的变量
{'__builtins__': <module '__builtin__' (built-in)>, '__name__': '__main__', '__doc__': None, 'a': 'runoob', '__package__': None}
```





###### map update

```python
d.update({key: value/2 for key,value in d.items()})
```





###### enumerate

- 返回 enumerate(枚举) 对象

```python
>>>seasons = ['Spring', 'Summer', 'Fall', 'Winter']
>>> list(enumerate(seasons))
[(0, 'Spring'), (1, 'Summer'), (2, 'Fall'), (3, 'Winter')]
>>> list(enumerate(seasons, start=1))       # 小标从 1 开始
[(1, 'Spring'), (2, 'Summer'), (3, 'Fall'), (4, 'Winter')]
```





###### open

```python
f = open("work/test.txt",'r')  #变量名=open（文件路径和文件名，打开模式） 模式：w:写，r:只写；a:追加写
print(f.read())     #f.read():从文件中读入整个文件内容，结果为字符串
print(f.readline()) #f.readline():从文件中读入一行内容，结果为字符串 
print(f.readlines()) #f.readlines():从文件中读取所有行，以每行元素形成一个列表
f.close()
```

使用open()函数打开的文件对象，必须手动进行关闭，Python 垃圾回收机制无法自动回收打开文件所占用的资源。

因此，推荐以下写法：

```python
with open("work/test.txt",'a') as  f:
    f.write("PaddlePaddle")
    f.write("\nokokok")
```



# 异常处理 try, except, else, finally



```python
try:
<语句>        #运行别的代码
except <名字>：
<语句>        #如果在try部份引发了'name'异常
except <名字>，<数据>:
<语句>        #如果引发了'name'异常，获得附加的数据
else:
<语句>        #如果没有异常发生
```

```python
#!/usr/bin/python
# -*- coding: UTF-8 -*-
try:
    fh = open("testfile", "w")
    fh.write("这是一个测试文件，用于测试异常!!")
except IOError:
    print "Error: 没有找到文件或读取文件失败"
else:
    print "内容写入文件成功"
    fh.close()
```



---

# Module

>   模块. Python内置了很多模块
>

-   一个.py文件就是一个module


```python
import numpy as np
```







---

## Built-in Module



---

### random

```python
import random
#生成一个0到1的随机float 
random.random()#[0.0, 1.0]

#生成[a, b]的随机float, a>b则[b, a]
random.uniform(10, 20)

#生成[a, b]的随机int,注意必须满足a <= b
random.randint(12, 20)

#指定范围内，按step随机获取一个随机数
random.randrange([start], stop[, step])
random.randrange(10, 100, 2)#相当于从[10, 12, 14, 16, ... 96, 98]中随机生成
random.choice(range(10, 100, 2))#等效

#从指定序列中获取一个随机元素
random.choice(["JGood", "is", "a", "handsome", "boy"])

#将一个列表中的元素打乱
random.shuffle(x[, random])
p = ["Python", "is", "powerful", "simple", "and so on..."]  
random.shuffle(p)

#从指定序列中随机获取指定长度的片断，不一定按序(不会修改原有序列)
random.sample(sequence, k)
random.sample([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5)
```



---

### datetime

> https://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000/001431937554888869fb52b812243dda6103214cd61d0c2000/ 廖雪峰datetime专题

timestamp: 1970年1月1日 00:00:00 UTC+00:00时区的时刻称为epoch time，记为`0`（1970年以前的时间timestamp为负数），当前时间就是相对于epoch time的秒数。Python的timestamp是一个浮点数。如果有小数位，小数位表示毫秒数。某些编程语言（如Java和JavaScript）的timestamp使用整数表示毫秒数，这种情况下只需要把timestamp除以1000就得到Python的浮点表示方法 

```python
from datetime import datetime #datetime是模块，datetime模块还包含一个datetime类

now = datetime.now() # 获取当前datetime #2015-05-18 16:28:07.198690
type(now)#<class 'datetime.datetime'>
dt = datetime(2015, 4, 19, 12, 20) # 指定日期时间创建datetime(年，月，日，时，分)
dt.timestamp() # 把datetime转换为timestamp #1429417200.0
datetime.fromtimestamp(t)#本地时间 #把timestamp转换为datetime #datetime是有时区的转换是在timestamp和本地时间做转换
datetime.utcfromtimestamp(t)# UTC时间
datetime.strptime('2015-6-1 18:19:59', '%Y-%m-%d %H:%M:%S') #字符串todatetime #参数二为指定格式#2015-06-01 18:19:59  #注意转换后的datetime是没有时区信息的
```



> https://docs.python.org/3/library/datetime.html#strftime-strptime-behavior python文档，format的%意义



### timeit

- 可用于计算一段代码的使用时间



### re 正则表达式



#### match & search

re.match只匹配字符串的开始，如果字符串开始不符合正则表达式，则匹配失败，函数返回None；而re.search匹配整个字符串，直到找到一个匹配 

re.match():

```python
re.match(pattern, string, flags=0)
```

re.search():       re.search(pattern, string, flags=0) 

| 参数    | 描述                                                         |
| ------- | ------------------------------------------------------------ |
| pattern | 匹配的正则表达式                                             |
| string  | 要匹配的字符串。                                             |
| flags   | 标志位，用于控制正则表达式的匹配方式，如：是否区分大小写，多行匹配等等。 |

匹配成功re.search方法返回一个re.Match对象，否则返回None。

我们可以使用group(num) 或 groups() 匹配对象函数来获取匹配表达式。

| 匹配对象方法 | 描述                                                         |
| ------------ | ------------------------------------------------------------ |
| group(num=0) | 匹配的整个表达式的字符串，group() 可以一次输入多个组号，在这种情况下它将返回一个包含那些组所对应值的元组。 |
| groups()     | 返回一个包含所有小组字符串的元组，从 1 到 所含的小组号。     |

```python
import re
print(re.search('www', 'www.runoob.com').span()) #Output: (0, 3)
print(re.search('com', 'www.runoob.com').span()) #Output: (11, 14)
print(re.search('www', 'awwwwwwwwwww')) # 
#Output: <re.Match object; span=(1, 4), match='www'>

```



### sys





#### IO重定向

```python
#stdout redirect
import sys
print('Dive in')#print to console
saveout = sys.stdout#save original stdout
fsock = open('out.log', 'w')#open a file, if not exits, create it
sys.stdout = fsock#redirect the stdout to the file fsock
print('This message will be logged instead of displayed') #this will be print to file
sys.stdout = saveout#recover the stdout, 后面的print会输出到console
fsock.close()#close the file
```



```python
#stderr redirect
import sys
fsock = open('error.log', 'w')#open a file
sys.stderr = fsock
raise Exception, 'this error will be logged'
```

> Note: need not to close the file.
>
> 当程序由于异常而崩溃时，Python程序也结束了，Python会替我们清理和关闭文件

### logging

> Python 标准库，用于事件日志系统
>
> refer: https://www.cnblogs.com/yyds/p/6901864.html


- 日志级别：
| log level | 描述                                                         |
| --------- | ------------------------------------------------------------ |
| DEBUG     | 最详细的日志信息，典型应用场景是 问题诊断                    |
| INFO      | 信息详细程度仅次于DEBUG，通常只记录关键节点信息，用于确认一切都是按照我们预期的那样进行工作 |
| WARNING   | 当某些不期望的事情发生时记录的信息（如，磁盘可用空间较低），但是此时应用程序还是正常运行的 |
| ERROR     | 由于一个更严重的问题导致某些功能不能正常运行时记录的信息     |
| CRITICAL  | 当发生严重错误，导致应用程序不能继续运行时记录的信息         |


- 常用函数：
| Function                               | 说明                                 |
| -------------------------------------- | ------------------------------------ |
| logging.debug(msg, *args, **kwargs)    | 创建一条严重级别为DEBUG的日志记录    |
| logging.info(msg, *args, **kwargs)     | 创建一条严重级别为INFO的日志记录     |
| logging.warning(msg, *args, **kwargs)  | 创建一条严重级别为WARNING的日志记录  |
| logging.error(msg, *args, **kwargs)    | 创建一条严重级别为ERROR的日志记录    |
| logging.critical(msg, *args, **kwargs) | 创建一条严重级别为CRITICAL的日志记录 |
| logging.log(level, *args, **kwargs)    | 创建一条严重级别为level的日志记录    |
| logging.basicConfig(**kwargs)          | 对root logger进行一次性配置          |

- logging 模块四大组件
| 组件       | 说明                                                         |
| ---------- | ------------------------------------------------------------ |
| loggers    | 提供应用程序代码直接使用的接口                               |
| handlers   | 用于将日志记录发送到指定的目的位置                           |
| filters    | 提供更细粒度的日志过滤功能，用于决定哪些日志记录将会被输出（其它的日志记录将会被忽略） |
| formatters | 用于控制日志信息的最终输出格式                               |





#### cases

```python
LOG_FORMAT = "%(asctime)s-[%(levelname)s]- %(message)s"
logging.basicConfig(filename='mawi_pcap2df.log', level=logging.DEBUG, format=LOG_FORMAT)
logging.info("[START] mawi_pcap2df.py START {}".format(time.asctime(time.localtime())))
```





---

## Module Interaction

> 模块之间的相互作用

```python
# file: a.py
import b
```



```python
# file: b.py
class Foo:
    pass
class Boo:
    pass
if __name__ == "b":
    pass

print(__name__)
```

- 运行b时，``__name__``为 "main", 输出 main
- 运行a时，``__name__``为 "b", 会输出 b 



---

# ipython与魔法命令

> http://blog.hszofficial.site/TutorialForPython/%E5%B7%A5%E5%85%B7%E9%93%BE%E7%AF%87/%E4%BA%A4%E4%BA%92%E7%8E%AF%E5%A2%83jupyter/ipython%E4%B8%8E%E9%AD%94%E6%B3%95%E5%91%BD%E4%BB%A4/ipython%E4%B8%8E%E9%AD%94%E6%B3%95%E5%91%BD%E4%BB%A4.html

- 魔法命令都以%或者%%开头,可以理解为ipython里定义的宏或者内置方法,以%开头的成为行命令，%%开头的称为单元命令。行命令只对命令所在的行有效，而单元命令则必须出现在单元的第一行，**对整个单元的代码进行处理**





---

# IO





### 格式化IO

```python
a=1
b=99
print("% 4d" % 5)#填充空格至4位
print("%+5d" % (a))#强制带符号,填充空格至5位
```



---

# Concurrent Execution 并发执行

> 并发执行
>
> Related Python module: os, multiprocessing
>
> note: parfor

- 线程是最小的执行单元，而进程由至少一个线程组成。如何调度进程和线程，完全由操作系统决定，程序自己不能决定什么时候执行，执行多长时间
- **全局解释器锁 global interpreter lock**: 运行在解释器主循环中，在多线程环境下，任何一条线程想要执行代码的时候都必须获取 acquire 到这个锁，运行一定数量字节码，然后释放 release掉，然后再尝试获取。这样 GIL 就保证了**同时只有一条线程在执行**

Unix/Linux操作系统提供了一个`fork()`系统调用，`fork()`返回两次

1. 子进程: return 0
2. 父进程: return child process id

Python的`os`模块封装了常见的系统调用，其中就包括`fork`

```python
import os #fork()

print('Process (%s) start...' % os.getpid())
# Only works on Unix/Linux/Mac:
pid = os.fork()
if pid == 0:#child process
    print('I am child process (%s) and my parent is %s.' % (os.getpid(), os.getppid()))
else:#main process
    print('I (%s) just created a child process (%s).' % (os.getpid(), pid))
```

> Windows无fork调用，无法运行。MacOS基于BSD(Unix的一种)故可运行



## Module multiprocessing

> `multiprocessing`: 跨平台版本的多进程模块
>
> fork在module os中，但Windows无法使用，Module multiprocessing为跨平台版本的多进程模块

- Process(): 创建子进程

```python
from multiprocessing import Process
import os

# 子进程要执行的代码
def run_proc(name):
    print('Run child process %s (%s)...' % (name, os.getpid()))

if __name__=='__main__':
    print('Parent process %s.' % os.getpid())#parent process id
    p = Process(target=run_proc, args=('test',))#创建一个Process p
    print('Child process will start.')
    p.start()#启动child proecess p
    p.join()#等待child process p结束后再继续向下进行，用于进程间同步
    print('Child process end.')
```





## Module threading

> Python Module: threading, `_thread`的高级模块，对`_thread`进行了封装
>
> This module constructs higher-level threading interfaces on top of the lower level [`_thread`](https://docs.python.org/3/library/_thread.html#module-_thread) module

- Python的线程是真正的Posix Thread，而不是模拟出来的线程

```python
import time, threading

def loop():
    print('thread %s is running...' % threading.current_thread().name)
    time.sleep(1)
    print('thread %s ended.' % threading.current_thread().name)

print('thread %s is running...' % threading.current_thread().name)#获取主进程名字: MainThread
t = threading.Thread(target=loop, name='LoopThread')#target: thread function; the name of new thrad t: LoopThread
t.start()
t.join()
print('thread %s ended.' % threading.current_thread().name)#
#Output:
thread MainThread is running...
thread LoopThread is running...
thread LoopThread ended.
thread MainThread ended.
```

- threading.current_thread(): 返回当前进程实例. threading.current_thread().name 当前进程实例的名字





```python
balance = 0
lock = threading.Lock()

def run_thread(n):
    for i in range(100000):
        # 先要获取锁:
        lock.acquire()
        try:
            # 放心地改吧:
            change_it(n)
        finally:
            # 改完了一定要释放锁:
            lock.release()
```

> 用`try...finally`确保锁一定会被释放



---

# pip

-   a package management system used to install and manage software packageswritten in Python

>   https://pypi.org/project/pip/

```python
pip <command> [options]

pip -V #查看pip版本
pip --version #查看pip版本
pip #查看使用帮助
pip list #查看已安装的package and version
pip install numpy #安装numpy package

python -m pip install -U pip #Win: Upgrading pip
python -m pip install --upgrade pip # upgrade pip

pip install -U pip #Linux: Upgrading pip

pip list --outdated #检查哪些packet需要更新
pip install --upgrade numpy #更新numpy
pip uninstall numpy #卸载

pip install matplotlib==2.0.0 #安装指定版本的包
# 使用whl文件安装第三方模块
pip install C:\Users\puretea\Downloads\xgboost-0.72-cp37-cp37m-win_amd64.whl
```

安装pip: //在安装python时可以选择安装pip

1.  官网下载Source (e.g. pip-10.0.1.tar.gz)
2.  python运行: win: python setup.py install  Linux: sudo python setup.py install
3.  测试是否安装成功 pip -version //查看版本


安装pip:

1.  download get-pip.py     /https://pip.pypa.io/en/stable/installing/
2.  python get-pip.py

#### pip批处理 / requirements

```python
pip freeze >requirements.txt #在当前目录下，将当前环境下pip list能列出的几乎所有包列出，除去pip, setuptools等 
pip install -r requirements.txt #根据requirements.txt安装需要的包，注意-r参数
```







---

# Differences between cpp and python



关于变量:

1.  cpp: 变量的概念面向内存，声明变量需要表明空间大小(e.g. 4 bytes)，存储格式(e.g. c的float通常为IEEE 754单精度)，不变名(即变量名)以指向变量。

2.  python: 只有name和object概念，如a = 3, a为name，3为object。过程可以理解为: 
    1.  创建name: a
    2.  创建object: 3
    3.  将name a关联到3这个object

---













---

