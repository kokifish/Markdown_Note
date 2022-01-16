



# MASS



## Windows 删除文件夹或者文件报错，说要来自自己账户的权限

- Open `command prompt` as administrator
- Execute `rd /S /Q "P:\Ath\To\Directory"`

---

# Software

- Python: Django
- revo uninstaller：卸载软件
- ddu， display driver uninstaller

# JSON简介

-   JSON(JavaScript Object Notation, JS 对象标记) 是一种轻量级的数据交换格式。它基于ECMAScript (w3c制定的js规范)的一个子集，采用完全独立于编程语言的文本格式来存储和表示数据
-   简洁和清晰的层次结构，是理想的数据交换语言。易于人阅读和编写，同时也易于机器解析和生成，有效地提升网络传输效率



**在 JS 语言中，一切都是对象**。因此，任何支持的类型都可以通过 JSON 来表示，例如字符串、数字、对象、数组等。但是对象和数组是比较特殊且常用的两种类型



### 语法

-   JSON 键值对是用来保存 JS 对象的一种方式，和 JS 对象的写法也大同小异，键/值对组合中的键名写在前面并用双引号 "" 包裹，使用冒号 : 分隔，然后紧接着值：

```json
{"firstName": "John"}
```

```json
{//JSON 表示数组的方式
  
"people":[

{
"firstName": "Brett",
"lastName":"McLaughlin"    
},
{       
"firstName":"Jason",
"lastName":"Hunter"
}
  
]
  
}
```





---

# Matlab

> 美国MathWorks公司开发的第四代高层次的编程语言和交互式环境数值计算，可视化和编程

- MATLAB可以进行数值计算，可视化和应用程序的开发，这是一个高层次的语言。
- MATLAB提供了一个互动的环境，探索，设计和解决问题的迭代。
- MATLAB提供了广阔的线性代数，统计，傅立叶分析，筛选，优化，数值积分，解常微分方程的数学函数库。
- MATLAB提供了内置的数据可视化工具，用于创建自定义绘制的图形。
- MATLAB的编程接口给开发工具，提高代码质量和可维护性和性能的最大化。
- MATLAB提供了自定义的图形界面构建应用程序的工具。
- MATLAB提供了基于MATLAB算法集成了C，Java，NET和Microsoft Excel等与外部应用程序和语言功能。
- MATLAB 是一种解释型的环境。也就是说，只要你给MATLAB一个命令，它就会马上开始执行。



## 基本语法

当点击“执行”按钮，或者按“Ctrl+ E”，MATLAB执行并返回结果

```matlab
3 ^ 2	       % 3 raised to the power of 2

sin(pi /2)	  % sine of angle 90o

7/0		      % Divide by zero
% Output:
ans = Inf
warning: division by zero
x = [1 2 3] #1*3行向量 与[1,2,3]等效
x = [1;2;3] #3*1列向量
x = 1:3 # 1*3行向量 [1,2,3] 使用:并指定起始值和最终值
x = 20:2:26 #x = 20    22    24    26 #指定了步长
x = linspace(0,1,5)#0 0.25 0.50 0.75 1.0#linspace(first,last,number_of_elements)
save datafile data # save varible data to datafile.mat
load datafile #load varible from datafile.mat
x = A(end-1,end-2) # 关键字 end，作为行或列索引来引用最后一个元素
```

- Inf for ∞， i (and j) for √-1，Nan 代表“不是一个数字”

| Operator | FFunction                        |
| -------- | -------------------------------- |
| *        | 标量和矩阵乘法运算符             |
| .\*      | **数组**乘法运算符               |
| ^        | 标量和矩阵求幂运算符             |
| .^       | **数组**求幂运算符               |
| \        | 矩阵左除                         |
| /        | 矩阵右除                         |
| .\       | 阵列左除                         |
| ./       | 阵列右除                         |
| .        | 点乘运算，常与其他运算符联合使用 |



## 常用工具箱

Matlab Main Toolbox——matlab主工具箱
Control System Toolbox——控制系统工具箱
Communication Toolbox——通讯工具箱	
Financial Toolbox——财政金融工具箱
System Identification Toolbox——系统辨识工具箱	
Fuzzy Logic Toolbox——模糊逻辑工具箱
Higher-Order Spectral Analysis Toolbox——高阶谱分析工具箱	
Image Processing Toolbox——图象处理工具箱
computer vision system toolbox——计算机视觉工具箱	
LMI Control Toolbox——线性矩阵不等式工具箱
Model predictive Control Toolbox——模型预测控制工具箱
μ-Analysis and Synthesis Toolbox——μ分析工具箱
Neural Network Toolbox——神经网络工具箱
Optimization Toolbox——优化工具箱
Partial Differential Toolbox——偏微分方程工具箱
Robust Control Toolbox——鲁棒控制工具箱
Signal Processing Toolbox——信号处理工具箱
Spline Toolbox——样条工具箱
Statistics Toolbox——统计工具箱	
Symbolic Math Toolbox——符号数学工具箱
Simulink Toolbox——动态仿真工具箱
Wavelet Toolbox——小波工具箱
DSP system toolbox——DSP处理工具箱





## Cases

$$
g_1(t) = \cos{(6\pi t)}\\
g_2(t) = \cos{(14\pi t)}\\
g_3(t) = \cos{(26\pi t)}
$$



```matlab
% 16337087 黄海宇 DSP作业 M2.6
x = linspace(0,1,300);

figure(1)
g1 = cos(6*pi*x);% 第一个函数
plot(x,g1);
hold on
g2 = cos(14*pi*x);% 第二个函数
plot(x,g2,'-.'); 
hold on
g3 = cos(26*pi*x);% 第三个函数
plot(x,g3,'--');
hold on
x = linspace(0,1,11);%抽样点
g1 = cos(6*pi*x);
title('M2-6'),xlabel('Time (s)');%标题 X坐标
scatter(x, g1,50, 'hexagram', 'k')%"filled"

figure(2)
stem(x,g1);
title('M2-6 Sampled Version'),xlabel('Time (s)');
```





---

# Chrome



1. //HSTS安全设置策略 chrome://net-internals/#hsts
2. "delete domain security policies",输入访问有问题的网站域名，然后点击删除（delete）
3. 找到"Query HSTS/PKP domain"，输入刚才删除的域名，查询结果返回“Not Found”,代表已经删除成功



证书错误显示是VMware的证书

设置服务中的 VMAuthdService “VMware Authorization Service” 为禁用（可能需要禁用一些依赖的服务）





---

# Lua

> 脚本语言 大小写敏感

轻量小巧的脚本语言，用标准C语言编写并以源代码形式开放， 其设计目的是为了嵌入应用程序中，从而为应用程序提供灵活的扩展和定制功能。

- **轻量级**: 它用标准C语言编写并以源代码形式开放，编译后仅仅一百余K，可以很方便的嵌入别的程序里
- **可扩展**: Lua提供了非常易于使用的扩展接口和机制：由宿主语言(通常是C或C++)提供这些功能，Lua可以使用它们，就像是本来就内置的功能一样
- 支持面向过程(procedure-oriented)编程和函数式编程(functional programming)；
- 自动内存管理；只提供了一种通用类型的表（table），用它可以实现数组，哈希表，集合，对象；
- 语言内置模式匹配；闭包(closure)；函数也可以看做一个值；提供多线程（协同进程，并非操作系统所支持的线程）支持；
- 通过闭包和table可以很方便地支持面向对象编程所需要的一些关键机制，比如数据抽象，虚函数，继承和重载等

```python
# Linux lua 5.3.0
curl -R -O http://www.lua.org/ftp/lua-5.3.0.tar.gz
tar zxf lua-5.3.0.tar.gz
cd lua-5.3.0
make linux test
make install
```

交互式编程: ```lua -i```或者直接```lua```

脚本式编程：编写```.lua```文件，用```lua name.lua```运行

```lua
#!/usr/local/bin/lua

print("Hello World！")
print("www.runoob.com")
```

> 第一行指定lua解释器，然后可以使用```./name.lua```运行

注释：

```lua
--单行注释
--[[
多行注释
--]]
```



### Identifier&Variable

Lua 标示符用于定义一个变量，函数或其他用户定义的项。标示符以一个字母 A 到 Z 或 a 到 z 或下划线 _ 开头后加上0个或多个字母，下划线，数字（0到9）。最好不要使用下划线加大写字母的标示符，因为Lua的保留字也是这样的

在默认情况下，变量总是认为是全局的

全局变量不需要声明，给一个变量赋值后即创建了这个全局变量，访问一个没有初始化的全局变量也不会出错，只不过得到的结果是：nil

```lua
print(b)-- nil
b=10
print(b)-- 10
b = nil --等同于删除b
print(b)-- nil
```

| TYPE     | DESCRIPTION                                                  |
| -------- | ------------------------------------------------------------ |
| nil      | 只有值nil属于该类，表示一个无效值(在条件表达式中相当于false). (有删除的作用) |
| boolean  | 包含false和true; Lua 把 false 和 nil 看作是"假"，其他的都为"真" |
| number   | 表示双精度类型的**实浮点数**                                 |
| string   | 字符串由一对双引号或单引号来表示                             |
| function | 由 C 或 Lua 编写的函数                                       |
| userdata | 表示任意存储在变量中的**C数据结构**                          |
| thread   | 表示执行的独立线路，用于执行协同程序                         |
| table    | Lua中的table是一个"关联数组"(associative arrays)，数组的索引可以是数字、字符串或表类型。在 Lua 里，table 的创建是通过"构造表达式"来完成，最简单构造表达式是{}，用来创建一个空表 |

```lua
type(X)=="nil" -- true;  nil作比较时应该加上双引号""
```

- Lua 默认只有一种 number 类型 -- double（双精度）类型（默认类型可以修改 luaconf.h 里的定义）

```lua
-- 以下均为number类型
print(type(2))
print(type(2.2))
print(type(0.2))
print(type(2e+1))
print(type(0.2e-1))
print(type(7.8263692594256e-06))
```

```lua
string1 = "this is string1"
string2 = 'this is string2'
html = [[
<html>
<head></head>
<body>
    <a href="http://www.runoob.com/">菜鸟教程</a>
</body>
</html>
]]
print(html)--结果在下面
```

```html
<!-- 上面代码的结果-->
<html>
<head></head>
<body>
    <a href="http://www.runoob.com/">菜鸟教程</a>
</body>
</html>
```

在对一个数字字符串上进行算术操作时，Lua 会尝试将这个数字**字符串**转成一个**数字**

字符串连接使用的是 .. 

```lua
print(157 .. 428) -- 157428 #字符串的连接
```

使用 # 来计算字符串的长度，放在字符串前面

```lua
s = "abc"
print(#s) -- 3
print(#"ab") -- 2
```





---

# Hadoop

- A **mapper** takes a single key and value as input, and returns zero or more (key, value) pairs. The pairs from all map outputs of a single step are grouped by key. 接受单个键和值作为输入，并返回零个或多个(键、值)对。来自单个步骤的所有映射输出的对按键分组。
- A **combiner** takes a key and a subset of the values for that key as input and returns zero or more (key, value) pairs. Combiners are optimizations that run immediately after each mapper and can be used to decrease total data transfer. Combiners should be idempotent (produce the same output if run multiple times in the job pipeline). 接受一个键和该键值的子集作为输入，并返回零个或多个(键、值)对。
- A **reducer** takes a key and the complete set of values for that key in the current step, and returns zero or more arbitrary (key, value) pairs as output. 在当前步骤中接受一个键和该键的完整值集，并返回零对或更多任意(键、值)对作为输出。

After the reducer has run, if there are more steps, the individual results are arbitrarily assigned to mappers for further processing. If there are no more steps, the results are sorted and made available for reading. 在reducer运行之后，如果有更多步骤，则将各个结果任意分配给映射器以供进一步处理。如果没有其他步骤，则对结果进行排序并使其可供阅读。

```java
import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class WordCount {

  public static class TokenizerMapper
       extends Mapper<Object, Text, Text, IntWritable>{

    private final static IntWritable one = new IntWritable(1);
    private Text word = new Text();
	// 根据读入的文本(string) value，若文本为a b a, 输出 a 1 b 1 a 1
    public void map(Object key, Text value, Context context
                    ) throws IOException, InterruptedException {
      StringTokenizer itr = new StringTokenizer(value.toString());
      while (itr.hasMoreTokens()) {
        word.set(itr.nextToken());
        context.write(word, one);
      }
    }
  }

  public static class IntSumReducer
       extends Reducer<Text,IntWritable,Text,IntWritable> {
    private IntWritable result = new IntWritable();

    public void reduce(Text key, Iterable<IntWritable> values,
                       Context context
                       ) throws IOException, InterruptedException {
      int sum = 0;
      for (IntWritable val : values) {
        sum += val.get();
      }
      result.set(sum);
      context.write(key, result);
    }
  }

  public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
    Job job = Job.getInstance(conf, "word count");
    job.setJarByClass(WordCount.class);
    job.setMapperClass(TokenizerMapper.class);
    job.setCombinerClass(IntSumReducer.class);
    job.setReducerClass(IntSumReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(IntWritable.class);
    FileInputFormat.addInputPath(job, new Path(args[0]));
    FileOutputFormat.setOutputPath(job, new Path(args[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}
```









## mrjob

- Write multi-step MapReduce jobs in pure Python
- Test on your local machine
- Run on a Hadoop cluster
- Run in the cloud using Amazon Elastic MapReduce (EMR)
- Run in the cloud using Google Cloud Dataproc (Dataproc)
- Easily run Spark jobs on EMR or your own Hadoop cluster

How to Install: `pip install mrjob`

> <https://pythonhosted.org/mrjob/guides/quickstart.html>

```python
# mr_word_count.py 计算一个文本的字母数 词数 行数
from mrjob.job import MRJob

class MRWordFrequencyCount(MRJob): # inherits from MRJob
    # map: 
    def mapper(self, _, line):
        yield "chars", len(line)
        yield "words", len(line.split())
        yield "lines", 1
    # recude:
    def reducer(self, key, values):
        yield key, sum(values)

if __name__ == '__main__':
    MRWordFrequencyCount.run()
# python mr_word_count.py my_file.txt
# Sample Output:
"chars" 3654
"lines" 123
"words" 417
# python3 mr_word_count.py -r hadoop hdfs:///temp/a.txt -o hdfs:///out3
```

- This class contains methods that define the steps of your job.
- A “step” consists of a mapper, a combiner, and a reducer. All of those are optional, though you must have at least one. So you could have a step that’s just a mapper, or just a combiner and a reducer. step可以只有一个
- When you only have one step, all you have to do is write methods called mapper(), combiner(), and reducer().







- By default, mrjob will run your job in a single Python process. This provides the friendliest debugging experience, but it’s not exactly distributed computing.
- You change the way the job is run with the -r/--runner option. You can use -r inline (the default), -r local, -r hadoop, or -r emr.
- To run your job in multiple subprocesses with a few Hadoop features simulated, use -r local.
- To run it on your Hadoop cluster, use -r hadoop.
- If you have Dataproc configured (see Dataproc Quickstart), you can run it there with -r dataproc.
- Your input files can come from HDFS if you’re using Hadoop, or GCS if you’re using Dataproc:

```python
$ python my_job.py -r dataproc gcs://my-inputs/input.txt
$ python my_job.py -r hadoop hdfs://my_home/input.txt
```







### Writing jobs

> <https://pythonhosted.org/mrjob/guides/writing-mrjobs.html>







#### Multi-step jobs

To define multiple steps, **override** `steps()` to return a list of MRSteps:

```python
from mrjob.job import MRJob
from mrjob.step import MRStep
import re

WORD_RE = re.compile(r"[\w']+")

class MRMostUsedWord(MRJob):
    # 由于是RawValueProtocol，所以key永远为None，value永远为一行的文本
    def mapper_get_words(self, _, line):
        for word in WORD_RE.findall(line):
            yield (word.lower(), 1) # yield each word in the line

    def combiner_count_words(self, word, counts):
        yield (word, sum(counts)) # sum the words we've seen so far

    def reducer_count_words(self, word, counts):
        # send all (num_occurrences, word) pairs to the same reducer.
        # num_occurrences is so we can easily use Python's max() function.
        yield None, (sum(counts), word)

    # discard the key; it is just None
    def reducer_find_max_word(self, _, word_count_pairs):
        # each item of word_count_pairs is (count, word),
        # so yielding one results in key=counts, value=word
        yield max(word_count_pairs)

    def steps(self): # override
        return [
            MRStep(mapper=self.mapper_get_words,
                   combiner=self.combiner_count_words,
                   reducer=self.reducer_count_words),
            MRStep(reducer=self.reducer_find_max_word)
        ]

if __name__ == '__main__':
    MRMostUsedWord.run()
```



#### protocol

mrjob assumes that all data is newline-delimited bytes. It automatically serializes and deserializes these bytes using protocols. Each job has an input protocol, an output protocol, and an internal protocol.

A protocol has a read() method and a write() method. The read() method converts bytes to pairs of Python objects representing the keys and values. The write() method converts a pair of Python objects back to bytes.

```python
# 默认的protocol
class MyMRJob(mrjob.job.MRJob):
    # these are the defaults
    INPUT_PROTOCOL = mrjob.protocol.RawValueProtocol
    INTERNAL_PROTOCOL = mrjob.protocol.JSONProtocol
    OUTPUT_PROTOCOL = mrjob.protocol.JSONProtocol
```





> 如果对protocol头疼，可以简单的判定如下：
>
> RawValueProtocol：当想要从原始txt中读取
>
> JSONProtocol：当想要读写键值对，且键值以JSON方式编码。

Since the input protocol is `RawValueProtocol`, the key will always be `None` and the value will be the text of the line.



### Runners



#### Running on your own Hadoop cluster

- Set up a hadoop cluster (see http://hadoop.apache.org/common/docs/current/)

- Run your job with -r hadoop:

  `python your_mr_job_sub_class.py -r hadoop < input > output`

> Note You don’t need to install mrjob or any other libraries on the nodes of your Hadoop cluster, but they do at least need a version of Python that’s compatible with your job. Hadoop cluster上仅需有兼容可用的Python即可





```python
# input: hdfs:///temp//README.txt output: hdfs:///out4
python3 mrjob_demo.py -r hadoop hdfs:///temp//README.txt hdfs:///out
```





# Install Python from Source

```python
tar xzf Python-3.7.3.tgz # 解压源码压缩包
cd Python-3.7.3/
./configure --with-ssl
make
make test
sudo make install

# ~/.bashrc
export PYTHONPATH=$PYTHONPATH:/usr/lib/python3.6/site-packages

```



```python
Python build finished successfully!
The necessary bits to build these optional modules were not found:
_dbm                  _gdbm                 _lzma
_sqlite3              _tkinter              readline
To find the necessary bits, look in setup.py in detect_modules() for the module's name.

# solution:
sudo yum install gdbm-devel tk-devel xz-devel sqlite-devel readline-devel bzip2-devel ncurses-devel zlib-devel
```





```python
# /etc/bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export JAVA_HOME=/usr
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib

export HADOOP_HOME=/home/annms/hadoop
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin:${JAVA_HOME}/bin:$PATH

```



```c
将hadoop添加进sudoers中
usermod -aG wheel hadoop 
```





# Links

```python
https://www.youtube.com/watch?v=n6d4KHSKqGk&t=107s   # 第八分钟有介绍github action实现profile更新最近动态
https://pufler.dev/git-badges/
```

