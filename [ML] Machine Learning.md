[TOC]







---

# Introduction



机器学习的主要方法:

1. 监督学习 supervised learning: 有数据和标签
2. 非监督学习 unsupervised learning: 只有数据，没有标签
3. 半监督学习 : 结合监督学习和非监督学习
4. 强化学习 reinforcement learning: 从经验中总结强化提升
5. 遗传算法 genetic algorithm: 





##### ROC & AUC

> ROC曲线：**接收者操作特征曲线**  **receiver operating characteristic curve** 
>
> AUC: **Area Under Curve** **ROC曲线下的面积**

ROC分析的是二元分类模型，即输出结果只有两种类别的模型。

ROC空间将伪阳性率（FPR）定义为 *X* 轴，真阳性率（TPR）定义为 *Y* 轴。一系列的(fp rate, tp rate)或者写成(FPR, TPR)，为二维笛卡尔坐标系中的坐标点

将**同一模型每个阈值** 的 (FPR, TPR) 座标都画在ROC空间里，就成为**特定模型的ROC曲线** 

- **当阈值设定为最高时，必得出ROC座标系左下角的点 (0, 0)**，没有样本被预测为阳性
- **当阈值设定为最低时，必得出ROC座标系右上角的点 (1, 1)** ，没有样本被预测为阴性
-  **随着阈值调低，ROC点** 往右上（或右／或上）移动，或不动；但**绝不会往左下(或左／或下)移动**







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

