



---

# TensorFlow

- 开源软件库，最初由谷歌大脑团队开发，用于Google的研究和生产，于2015年11月9日在Apache 2.0开源许可证下发布
- TensorFlow 1.0.0: released on February 11, 2017. 想要成为一门新的语言，而不仅是python package
- TensorFlow 2.0: officially available in Sep 2019. 简化使用，移除`tf.app`,`tf.flags`, `tf.logging`, `tf.session`, `tf.graph`等，本分地当个python package?
- 提供稳定的Python, C API, 对很多其他语言(c++, Go, Java, JavaScript, Swift)提供不具向后兼容保证的API，以及第三方包(Haskell, Julia, Matlab, Scale, Rust...)
- WARNING! 需要注意版本问题，貌似tf 1.x之间都很可能互不兼容，2.x和1.x之间的更无法兼容



# Installation



## Windows

> 部分参考：
>
> https://blog.csdn.net/Kelly_Young/article/details/100009833

- Install TensorFlow in Win10(test in 2021.3.3)

1. Install CUDA 11.1: run `nvidia-smi` for test. Output snippet: `NVIDIA-SMI 456.71  Driver Version: 456.71  CUDA Version: 11.1`

2. `pip install tensorflow-gpu `: Output: `Successfully installed protobuf-3.15.3 tensorflow-gpu-2.4.1`

3. ```bash
   SET PATH=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.0\bin;%PATH%
   SET PATH=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.0\extras\CUPTI\lib64;%PATH%
   SET PATH=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.0\include;%PATH%
   SET PATH=C:\tools\cuda\bin;%PATH%
   ```

4. `cudnn`: Download `cudnn-11.2-windows-x64-v8.1.1.33.zip` from Nvidia official website. Then unzip.

5. Copy `cudnn` folders `bin, include, lib` to `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.0`



## Linux

> https://blog.csdn.net/daydaydreamer/article/details/107172364    pk分享的链接



