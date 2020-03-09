[TOC]

有关LaTex的所有笔记



---

# Introduction

LaTeX， 是一种基于TEX的排版系统，由美国电脑学家莱斯利·兰伯特在20世纪80年代初期开发，利用这种格式，即使用户没有排版和程序设计的知识也可以充分发挥由TEX所提供的强大功能，能在几天，甚至几小时内生成很多具有书籍质量的印刷品。对于生成复杂表格和数学公式，这一点表现得尤为突出。因此它非常适用于生成高印刷质量的科技和数学类文档。这个系统同样适用于生成从简单的信件到完整书籍的所有其他种类的文档。

LaTeX 基于 TeX，主要目的是为了方便排版。在学术界的论文，尤其是数学、计算机等学科论文都是由 LaTeX 编写, 因为用它写数学公式非常漂亮。

文学编程是 TeX 的作者高德纳提出的编程方式，主张程序员在编写代码的过程中详细地记录自己的思维方式和内在逻辑

### Installation

> VS code + LaTex Workshop 配置方法 https://zhuanlan.zhihu.com/p/38178015





### Ref

http://liuchengxu.org/blog-cn/posts/quick-latex/ 从零开始 LaTeX 快速入门

# File Systemation

可以在.tex源文件中写入样式内容，也可以将内容与样式分离，在.cls .sty 中统一进行样式规定。cls for class



| suffix | features                                                     |
| ------ | ------------------------------------------------------------ |
| .dtx   | **D**ocumented La**T**e**X** sources，宏包重要部分           |
| .ins   | installation，控制 TeX 从 .dtx 文件里释放宏包文件            |
| .cfg   | config， 配置文件，可由上面两个文件生成                      |
| .sty   | style files，使用`\usepackage{...}`命令进行加载              |
| .cls   | classes files，类文件，使用`\documentclass{...}`命令进行加载 |
| .aux   | auxiliary， 辅助文件，不影响正常使用                         |
| .bst   | BibTeX style file，用来控制参考文献样式                      |

>  class 与 style 似乎十分相像，它们在功能上的确很相似，但是也有区别 https://tug.org/pracjourn/2005-3/asknelly/nelly-sty-&-cls.pdf







# Macro Package

> 宏包

`\usepackage{foo}` 即可使用宏包 foo 中定义的内容

宏包：一些写好的内容打包出来以便使用。与 C 语言的 `include` 一致，将文件加载进来进行使用。可以自己编写想要的样式到宏包中。





#### 查看宏包手册

打开 cmd， 输入 `texdoc Macro_Package `， 比如 `texdoc caption`，就会打开 caption 宏包手册。诚然可以网上查找解决办法，但是如果有空的话必然是查看官方手册更靠谱更全面



# Mathematical Formula







# Packages



## tikz

```latex
\begin{figure}[htbp]
    \centering
    \begin{tikzpicture}
        \tikzstyle{output}=[circle, thick, minimum size=0.8cm, draw=purple!90, fill=purple!20]
        \tikzstyle{input}=[circle, thick, minimum size=0.8cm, draw=blue!90, fill=blue!20]
        %绘制节点
        \node[input] (n1) at (0, 2){};
        \node[input] (n2) at (0, 0){};
        \node[output] (out_node) at (2.5, 1){$\sum$};
        %节点之间的路径
        \path[->] 
        (n1) edge[thick] (out_node)
        (n2) edge[thick] (out_node)
        ;
        % 字母
        \path (-1.8,2) node(text_x1)[right]{$x_1$};
        \path (-1.8,0) node(text_x2)[right]{$x_2$};

        \path (1.25,1.95) node(text_w1)[below]{$w_1$};
        \path (1.25,0.5) node(text_w2)[below]{$w_2$};
        
        \path (2.5,0) node(text_b)[below]{$b$}; %字母b
        \path (4,1) node(text_y)[left]{$y$}; %字母y
        %文字
        \path (0,2.7) node(text_input)[above]{输入节点};
        \path (2.5,1.7) node(text_output)[above]{输出节点};
        \path (1.25,0.1) node(text_weight)[below]{权重};
        \path (3.5,0) node(text_weight)[below]{偏置量};
        %字母到节点的连线
        \draw[->,line width=1pt] (text_x1)->(n1);
        \draw[->,line width=1pt] (text_x2)->(n2);
        \draw[->,line width=1pt] (text_b)->(out_node);
        \draw[->,line width=1pt] (out_node)->(text_y);
        
    \end{tikzpicture}
    
    \caption{感知器模型}
    \label{fig:single_layer_perceptron}
\end{figure}
```

```latex
\begin{figure}[!ht] %%%% figure 
    \centering
    \begin{tikzpicture}[scale = 1.3]
        \tikzstyle{output}=[circle, thick, minimum size=0.1cm, draw=purple!85, fill=purple!25]
        \tikzstyle{input}=[circle, thick, minimum size=0.1cm, draw=blue!85, fill=blue!25]
        \tikzstyle{node}=[circle, thick, minimum size=0.1cm, draw=green!85, fill=green!25]
        % 绘制节点
        \foreach \y in {0,1,2,3,4,5}  % 0.05偏置，间隔0.55
            \node[input] (n_in\y) at (-2, \y/2+0.5){};
        \foreach \x in {0, 2, 4}
            \foreach \y in {0,1,2,3,4,5,6,7}
                \node[node] (n\x\y) at (\x, \y/2){};
        \foreach \y in {0,1,2,3}  % 间隔0.6
            \node[output] (n_out\y) at (6, \y/2*1.2+0.85){}; % 输出层节点
        % 连线
        \foreach \a in {0,1,2,3,4,5}
            \foreach \y in {0,1,2,3,4,5,6,7}
                \draw[-,line width=0.7pt, gray!30!black] (n_in\a)->(n0\y);
        \foreach \x in {0, 2}
            \foreach \ya in {0,1,2,3,4,5,6,7}
                \foreach \yb in {0,1,2,3,4,5,6,7}
                \pgfmathtruncatemacro{\xplus}{\x + 2} % 加2
                \draw[-,line width=0.7pt, gray!30!black] (n\x\ya)->(n\xplus\yb);
        \foreach \a in {0,1,2,3,4,5,6,7}
            \foreach \y in {0,1,2,3}
                \draw[-,line width=0.7pt, gray!30!black] (n4\a)->(n_out\y);
        % 文字
        \path (-2,3.2) node(text_input)[above]{输入层};
        \path (6,2.9) node(text_output)[above]{输出层};
        \path (0,3.7) node(text_hidden_1)[above]{隐层1};
        \path (2,3.7) node(text_hidden_2)[above]{隐层2};
        \path (4,3.7) node(text_hidden_3)[above]{隐层3};
    \end{tikzpicture}

    \caption{多层结构的神经网络基本结构}
    \label{fig:multi_layers_NN}
\end{figure}
```

```latex
\begin{figure}[!ht]
    \small
    \centering
    \begin{minipage}[b]{0.3\textwidth}
    \centering
    \begin{tikzpicture}[domain=-0.8:1.8]
        \tikzstyle{true_node}=[circle, thick, minimum size=0.1cm, draw=purple!80, fill=purple!30]
        \tikzstyle{false_node}=[circle, thick, minimum size=0.1cm, draw=blue!80, fill=blue!30]
        %绘制坐标
        \draw[->] (-0.8,0) -- (2.8,0) node[right] {$x_1$};
        \draw[->] (0,-0.8) -- (0,2.8) node[above] {$x_2$};
        %绘制节点
        \node[false_node] (node00) at (0, 0){$0$};
        \node[true_node] (node02) at (0, 2){$1$};
        \node[true_node] (out_node) at (2,0){$1$};
        \node[true_node] (out_node) at (2,2){$1$};
        %分割线
        \draw[color=red, line width=1pt]  plot (\x,{-1 * \x + 1});
        
    \end{tikzpicture}
    \captionof{figure}{模拟布尔函数}
    \label{fig:illustration_bool}
    \end{minipage}
    \begin{minipage}[b]{0.3\textwidth}
    \centering
    \begin{tabular}{|p{0.4cm}<{\centering}|p{0.4cm}<{\centering}|p{0.4cm}<{\centering}|}
        \hline
         $x_1$ & $x_2$ & $y$ \\
        \hline
         0 & 0 & 0  \\
        \hline 
         0 & 1 & 1 \\
        \hline 
         1 & 0 & 1 \\
        \hline 
         1 & 1 & 0 \\
         \hline 
    \end{tabular}
    \captionof{table}{异或函数真值表}
    \label{tb:Xor_true_table}
    \end{minipage}
    \begin{minipage}[b]{0.3\textwidth}
    \begin{tikzpicture}[domain=-0.8:1.8]
        \tikzstyle{true_node}=[circle, thick, minimum size=0.1cm, draw=purple!80, fill=purple!30]
        \tikzstyle{false_node}=[circle, thick, minimum size=0.1cm, draw=blue!80, fill=blue!30]
        %绘制坐标
        \draw[->] (-0.8,0) -- (2.8,0) node[right] {$x_1$};
        \draw[->] (0,-0.8) -- (0,2.8) node[above] {$x_2$};
        %绘制节点
        \node[false_node] (node00) at (0, 0){$0$};
        \node[true_node] (node02) at (0, 2){$1$};
        \node[true_node] (out_node) at (2,0){$1$};
        \node[false_node] (out_node) at (2,2){$0$};
    \end{tikzpicture}
    \captionof{figure}{异或函数}
    \label{fig:illustration_Xor}
    \end{minipage}
\end{figure}
```

### 可能用到的commands

```latex
%%% tikz %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{tikz} %作图用
\usetikzlibrary{decorations.pathmorphing} % noisy shapes
\usetikzlibrary{fit}					% fitting shapes to coordinates
\usetikzlibrary{backgrounds}	% drawing the background after the foreground
\usetikzlibrary{positioning}
\usetikzlibrary{calc}
\tikzset{>=stealth}
```

