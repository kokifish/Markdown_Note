[TOC]

---



# 数字取证

> Digital Forensics  数字图像取证 Digital Image Forensics

Digital Forensics (sometimes known as digital forensic science) is a branch of forensic science encompassing the recovery and investigation of material found in digital devices, often in relation to computer crime.

数字取证是取证科学的一个分支，包含对从数字设备中获取的材料的恢复和调查，通常这些材料与计算机犯罪有关。

The technical aspect of an investigation is divided into several sub-branches:

1. computer forensics
2. network forensics
3. database forensics
4. mobile device forensics

The digital forensic process encompasses:

1. seizure: 捕获
2. forensics imaging(acquisition): 获得
3. analysis of digital media: 数字媒体的分析
4. the production of a report: 制作报告

into collected evidence for the benefit of courts or an employer.

数字图像取证技术(Digital Image Forensics)：通过对图像统计特性的分析来判断数字图像内容的真实性、完整性和原始性，也是怕地暖数字图像从被数码相机拍摄之后，有没有讲过篡改的技术。它是计算机取证的一个分支，是对源于数字图像资源的数字证据进行确定、收集、识别、分析及出示法庭的过程。不同于先前的计算机取证，数字图像取证主要是针对于数字图像内容的完整性和原始性，而不是对计算机文件或磁盘格式的取证。



## Papers

### Sensor Pattern Noise Estimation Based on Improved Locally Adaptive DCT Filtering and Weighted Averaging for Source Camera Identification and Verification

> 传感器模式噪声 Sensor Pattern Noise SPN

照相机输出可以表示如下：
$$
I = I^{0} + I^{0}K + \Theta
$$
其中$I^{0}$表示图像的原始输入，$I^{0}K$表示PRNU term，$\Theta​$表示random noise factor.

SPN在原始图像上的影响遵循multiplicative rule. 乘性法则（即两个变量无关，概率分布不受对方影响）

noise residue 噪声残留的提取过程：
$$
r = I - F(I); F: filter
$$
噪声残留中包含PRNU，F(I)表示对图片进行滤波。

