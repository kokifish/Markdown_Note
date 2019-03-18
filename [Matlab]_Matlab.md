[TOC]





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





# Cases

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







