------

# PyTorch

> Python的深度学习框架

以前是Lua语言下的模块Torch，2016被移植到Python上，可以和Tensor flow一拼高下



```python
import torch
import numpy as np

np_data = np.arange(6).reshape((2, 3))
torch_data = torch.from_numpy(np_data)# np array to torch tensor
tensor2array = torch_data.numpy()# torch tensor to np array
print(
    '\nnumpy array:', np_data, # [[0 1 2], [3 4 5]]
    '\ntorch tensor:', torch_data,#0  1  2 \n 3  4  5[torch.LongTensor of size 2x3]
    '\ntensor to array:', tensor2array,# [[0 1 2], [3 4 5]]
)
```



## Installation

```python
# 改变链接中的cu101可以改变CUDA版本
# 相应更改 torch==1.4.0 torchvision==0.5.0 可以实现下载某个版本的CUDA对应的不同版本的 torch torchvision
pip install torch==1.4.0 torchvision==0.5.0  -f https://download.pytorch.org/whl/cu101/torch_stable.html
```

> 2021.03.17 使用官方推荐的安装指令：`pip install torch==1.8.0+cu111 torchvision==0.9.0+cu111 torchaudio===0.8.0 -f https://download.pytorch.org/whl/torch_stable.html`  会报错，说pytorch某网站连接超时，这种情况就可以用上面的方法安装了。

### Test

- 测试pytorch / CUDA是否安装成功

```python
import torch    # 如正常则静默
a = torch.Tensor([1.])    # 如正常则静默
a.cuda()    # 如正常则返回"tensor([ 1.], device='cuda:0')"
from torch.backends import cudnn # 如正常则静默
cudnn.is_acceptable(a.cuda())    # 如正常则返回 "True"
```





## Tensor

> Pytorch 0.4后，Variable和Tensor基本没有差别了
>
> https://blog.csdn.net/xholes/article/details/81667211

```python
import torch
import torch.nn as nn
import torch.utils.data as Data

torch.from_numpy(y_train).long()#numpy array => tensor => long tensor
```







## Activation Function

```python
import torch #relu sigmoid tanh可以直接在这使用
import torch.nn.functional as F     # 激励函数都在这
from torch.autograd import Variable
import matplotlib.pyplot as plt

# 做一些假数据来观看图像 # Fake data
x = torch.linspace(-5, 5, 200)  # x data (tensor), shape=(100, 1)
x = Variable(x)
x_np = x.data.numpy()   # 换成 numpy array, 出图时用

# 几种常用的 激励函数
y_relu = torch.relu(x).data.numpy() #relu直接在torch中
y_sigmoid = torch.sigmoid(x).data.numpy()
y_tanh = torch.tanh(x).data.numpy()
y_softplus = F.softplus(x).data.numpy()
# y_softmax = F.softmax(x)  softmax 比较特殊, 不能直接显示, 不过他是关于概率的, 用于分类

### 可视化
plt.figure(1, figsize=(8, 6))
plt.subplot(221)
plt.plot(x_np, y_relu, c='red', label='relu')
plt.ylim((-1, 5))
plt.legend(loc='best')

plt.subplot(222)
plt.plot(x_np, y_sigmoid, c='red', label='sigmoid')
plt.ylim((-0.2, 1.2))
plt.legend(loc='best')

plt.subplot(223)
plt.plot(x_np, y_tanh, c='red', label='tanh')
plt.ylim((-1.2, 1.2))
plt.legend(loc='best')

plt.subplot(224)
plt.plot(x_np, y_softplus, c='red', label='softplus')
plt.ylim((-0.2, 6))
plt.legend(loc='best')

plt.show()
```



## Optimizer

```python
import torch
import torch.utils.data as Data
import torch.nn.functional as F
import matplotlib.pyplot as plt

# torch.manual_seed(1)    # reproducible

LR = 0.01
BATCH_SIZE = 32
EPOCH = 12

# fake dataset
x = torch.unsqueeze(torch.linspace(-1, 1, 1000), dim=1)
y = x.pow(2) + 0.1*torch.normal(torch.zeros(*x.size()))

# plot dataset
plt.scatter(x.numpy(), y.numpy())
plt.show()

# put dateset into torch dataset
torch_dataset = Data.TensorDataset(x, y)
loader = Data.DataLoader(dataset=torch_dataset, batch_size=BATCH_SIZE, shuffle=True, num_workers=2,)


# default network
class Net(torch.nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.hidden = torch.nn.Linear(1, 20)   # hidden layer
        self.predict = torch.nn.Linear(20, 1)   # output layer

    def forward(self, x):
        x = F.relu(self.hidden(x))      # activation function for hidden layer
        x = self.predict(x)             # linear output
        return x

if __name__ == '__main__':
    # different nets
    net_SGD         = Net()
    net_Momentum    = Net()
    net_RMSprop     = Net()
    net_Adam        = Net()
    nets = [net_SGD, net_Momentum, net_RMSprop, net_Adam] #记录不同网络(同一模板)

    # different optimizers #生成不同的优化器
    opt_SGD = torch.optim.SGD(net_SGD.parameters(), lr=LR)
    opt_Momentum = torch.optim.SGD(net_Momentum.parameters(), lr=LR, momentum=0.8)
    opt_RMSprop = torch.optim.RMSprop(net_RMSprop.parameters(), lr=LR, alpha=0.9)
    opt_Adam = torch.optim.Adam(net_Adam.parameters(), lr=LR, betas=(0.9, 0.99))
    optimizers = [opt_SGD, opt_Momentum, opt_RMSprop, opt_Adam]

    loss_func = torch.nn.MSELoss() #均方差误差函数
    losses_his = [[], [], [], []] # record loss

    # training
    for epoch in range(EPOCH):
        print('Epoch: ', epoch)
        for step, (b_x, b_y) in enumerate(loader): # for each training step
            for net, opt, l_his in zip(nets, optimizers, losses_his):
                output = net(b_x)              # get output for every net
                loss = loss_func(output, b_y)  # compute loss for every net
                opt.zero_grad()                # clear gradients for next train
                loss.backward() # backpropagation, compute gradients
                opt.step() # apply gradients
                l_his.append(loss.data.numpy()) # loss recoder

    labels = ['SGD', 'Momentum', 'RMSprop', 'Adam']
    for i, l_his in enumerate(losses_his):
        plt.plot(l_his, label=labels[i])
    plt.legend(loc='best')
    plt.xlabel('Steps')
    plt.ylabel('Loss')
    plt.ylim((0, 0.2))
    plt.show()
```





## Build NN

```python
torch.optim #包含很多optimizer #e.g. SGD, Adom
```





# Digest Of Pytorch Package Reference

> 摘要
>
> https://pytorch.org/docs/stable/index.html



## torch.nn



### Conv2d

> `torch.nn.Conv2d`(*in_channels*, *out_channels*, *kernel_size*, *stride=1*, *padding=0*, *dilation=1*, *groups=1*, *bias=True*)

- Applies a 2D convolution over an input signal composed of several input planes.

parameters:

- in_channels 输入通道数: 例如输入的是rgb图像(对于第一层卷积层)，则通道数应为3
- out_channels 输出通道数: 输出的通道数
- kernel_size 核大小: 
- stride 步幅: step/movement
- padding 填充: 对输入图像边缘的补零
- dilation 扩大: controls the spacing between the kernel points. 卷积核元素之间的间距
- groups:
- bias 偏置(bool, optional): If `True`, adds a learnable bias to the output. Default: `True`

The parameters `kernel_size`, `stride`, `padding`, `dilation` can either be:

- a single `int` – in which case the same value is used for the height and width dimension. 单个int表示宽高均为传入的int
- a `tuple` of two ints – in which case, the first int is used for the height dimension, and the second int for the width dimension. 传入tuple分别表示高、宽

> ### Note
>
> Depending of the size of your kernel, several (of the last) columns of the input might be lost, because it is a valid **cross-correlation**, and not a full cross-correlation. It is up to the user to add proper padding. 根据核大小，可能会丢失输入的(最后)几列。应该由用户来添加适当的padding。



# Cases



## Classifier

```python
import torch
import torch.nn.functional as F
import matplotlib.pyplot as plt

# torch.manual_seed(1)    # reproducible

# make fake data #制造实验数据###############################
n_data = torch.ones(100, 2)# type:Tensor; torch.Size([100, 2]); 全为1
x0 = torch.normal(2*n_data, 1) # class0 x data (tensor), shape=(100, 2)#正态分布化
y0 = torch.zeros(100)          # class0 y data (tensor), shape=(100, 1)
x1 = torch.normal(-2*n_data, 1) # class1 x data (tensor), shape=(100, 2)#正态分布化
y1 = torch.ones(100)            # class1 y data (tensor), shape=(100, 1)
x = torch.cat((x0, x1), 0).type(torch.FloatTensor)  # FloatTensor = 32-bit floating
y = torch.cat((y0, y1), ).type(torch.LongTensor)    # LongTensor = 64-bit integer
print(type(x), x.shape) # <class 'torch.Tensor'>, torch.Size([200, 2])
print(type(y), y.shape) # <class 'torch.Tensor'>, torch.Size([200])
print(type(y[0]), type(x[0]), type(x[0][0]), type(x[0][0].data), x[0][0], x[0][0].data)
#(all Tensor)  Tensor, Tensor, Tensor, Tensor, tensor(3.2958), tensor(3.2958)
# The code below is deprecated in Pytorch 0.4. Now, autograd directly supports tensors
# x, y = Variable(x), Variable(y) # No needed for pytorch 1.0

# plt.scatter(x.data.numpy()[:, 0], x.data.numpy()[:, 1], c=y.data.numpy(), s=100, lw=0, cmap='RdYlGn')
# #s:scalar or array_like, shape (n, ) #linewidths : scalar or array_like.The linewidth of the marker edges.
# #cmap : Colormap。A Colormap instance or registered colormap name.cmap is only used if c is an array of floats.
# plt.show()


class Net(torch.nn.Module):
    def __init__(self, n_feature, n_hidden, n_output):
        super(Net, self).__init__()
        self.hidden = torch.nn.Linear(n_feature, n_hidden)   # hidden layer
        self.out = torch.nn.Linear(n_hidden, n_output)   # output layer

    def forward(self, x):
        x = F.relu(self.hidden(x)) # activation function for hidden layer
        x = self.out(x)
        return x

net = Net(n_feature=2, n_hidden=10, n_output=2)     # define the network
print(net)  # net architecture #输出网络结构

optimizer = torch.optim.SGD(net.parameters(), lr=0.01)
loss_func = torch.nn.CrossEntropyLoss()  # the target label is NOT an one-hotted
# 在回归时使用的是MSELoss 均方差 #多分类问题常用交叉熵，计算的是概率
# 例如输出的是[0.1, 0.2, 0.7]表示预测是第一类的概率是0.1，第二类是0.2,第三类是0.7
plt.ion() # something about plotting # interactive model on

for t in range(100):
    out = net(x) # input x and predict based on x #使用网络进行预测
    print(out[0], type(out), out.shape, type(out[0]), out[0].shape, F.softmax(out[0]))#调用softmax转化为概率
    #tensor([ 1.1094, -0.5418], grad_fn=<SelectBackward>) Tensor,Size([200, 2]); Tensor,Size([2])
    loss = loss_func(out, y) # must be (1. nn output, 2. target), the target label is NOT one-hotted

    optimizer.zero_grad() # clear gradients for next train#清除梯度
    loss.backward() # backpropagation, compute gradients #BP过程，计算梯度
    optimizer.step() # apply gradients #将梯度施加到神经网络上

    if(t % 2 == 0):
        # plot and show learning process
        plt.cla()#Clear the current axes.
        prediction = torch.max(out, 1)[1]
        pred_y = prediction.data.numpy()#tensor.data后才可以转换为numpy的array
        target_y = y.data.numpy()
        plt.scatter(x.data.numpy()[:, 0], x.data.numpy()[:, 1], c=pred_y, s=100, lw=0, cmap='RdYlGn')
        accuracy = float((pred_y == target_y).astype(int).sum()) / float(target_y.size)
        plt.text(1.5, -4, 'Accuracy=%.2f' % accuracy, fontdict={'size': 20, 'color':  'red'})
        plt.pause(0.1)

plt.ioff()
plt.show()
```



## AutoEncoder

```python
# -*- coding: utf-8 -*-
# 将MNIST数据集读入后，训练自编码机，并且用自编码机编码后的数据训练分类器，对预测集数据做预测
import os
import time
import struct
import numpy as np
import matplotlib.pyplot as plt
import torch
import torch.nn as nn
import torch.utils.data as Data
from torch.autograd import Variable
from sklearn.neighbors import KNeighborsClassifier

# 超参数 Hyper parameter
EPOCH = 10 #对数据整体训练的次数
BATCH_SIZE = 128 #批训练的大小
LEARNING_RATE = 0.002

path = './mnist'

def load_mnist(path, kind='train'):
    # Load MNIST data from `path`
    labels_path = os.path.join(path, '%s-labels-idx1-ubyte' % kind)
    images_path = os.path.join(path, '%s-images-idx3-ubyte' % kind)
    with open(labels_path, 'rb') as lbpath:
        magic, n = struct.unpack('>II', lbpath.read(8))
        labels = np.fromfile(lbpath, dtype=np.uint8)

    with open(images_path, 'rb') as imgpath:
        magic, num, rows, cols = struct.unpack('>IIII', imgpath.read(16))
        images = np.fromfile(imgpath, dtype=np.uint8).reshape(len(labels), 784)

    return images, labels  # images: n x m: n:样本数量; m: 784=28*28

# 自编码机
class AutoEncoder(nn.Module):  # 继承自torch.nn.Module
    #定义所有的层属性
    def __init__(self):  # 该行和下一行是官方步骤
        super(AutoEncoder, self).__init__()  # 继承AutoEncoder到self: Module

        # 压缩 encoder
        self.encoder = nn.Sequential( #Sequential: 一层一层的神经层搭建,快速搭建
            nn.Linear(28*28, 196), #para1: 输入的神经元数量; para2: 输出的神经元的数量
            nn.ReLU(), #激励层
            nn.Linear(196, 64),
            nn.ReLU(),
            nn.Linear(64, 16),
            nn.ReLU(),
            nn.Linear(16, 8),
        )
        # 解压 decoder
        self.decoder = nn.Sequential(
            nn.Linear(8, 16),
            nn.ReLU(),
            nn.Linear(16, 64),
            nn.ReLU(),
            nn.Linear(64, 196),
            nn.ReLU(),
            nn.Linear(196, 28*28),
            nn.Sigmoid(),# 该激励函数使得输出值在[0,1]
        )

    # 前向传递的过程 #一层层搭建层与层的关系链接
    def forward(self, x):  # x:输入信息,data
        encoded = self.encoder(x)
        decoded = self.decoder(encoded)
        return encoded, decoded


if __name__ == '__main__':
    X_train, y_train = load_mnist(path)

    ### 动态显示过程，显示数据集中第一个出现的0,1,2,...,9
    fig, ax = plt.subplots( nrows=2, ncols=10, sharex=True, sharey=True, figsize=(6, 2))
    idx_l = [np.where(y_train==i)[0][0] for i in range(10)] # 0,1,2,...,9第一次出现的坐标
    # print(idx_l, len(idx_l))
    ax = ax.flatten()
    for i in range(10):
        img = X_train[idx_l[i]].reshape(28, 28)
        ax[i].imshow(img, cmap='Greys', interpolation='nearest')
        ax[10+i].imshow(img, cmap='Greys', interpolation='nearest')
    ax[0].set_xticks([]);ax[0].set_yticks([])
    plt.tight_layout()
    plt.ion()#打开互动模式，就是边显示边修改
    plt.draw(); plt.pause(0.05)
    #####################

    X_train = X_train.astype(np.float32) /255 # to float, to [0,1]
    X_train, y_train = torch.from_numpy(X_train), torch.from_numpy(y_train)# to tensor
    print('X_train:', type(X_train), X_train.shape, 'y_train:', type(y_train))

    autoencoder = AutoEncoder() # 创建自编码机
    gpuFLAG = torch.cuda.is_available() # True: use cuda; False: cuda NOT used.
    # gpuFLAG = False
    if(gpuFLAG):
        autoencoder = autoencoder.cuda()
        X_train = X_train.cuda()
        y_train = y_train.cuda()
    print('AutoEncoder structure:', autoencoder)
    # 优化器优化神经网络的参数 #1st para: 需要优化的参数; lr: learning rate, 学习速率
    optimizer = torch.optim.Adam(autoencoder.parameters(), lr=LEARNING_RATE)
    # 误差计算函数，Loss Function #MSELoss：Mean Square Error 均方差
    loss_func = nn.MSELoss()

    train_data = Data.TensorDataset(X_train, y_train)
    # print('train_data:', type(train_data))
    train_loader = Data.DataLoader(dataset=train_data, batch_size=BATCH_SIZE, shuffle=True)#创建DataLoader

    t = time.process_time()

    # epoch: 对数据整体训练的次数
    for epoch in range(EPOCH):
        for step, (x, batch_label) in enumerate(train_loader):
            batch_x = x.view(-1, 28*28)#转换数据的维度
            batch_y = x.view(-1, 28*28)
            encoded, decoded = autoencoder(batch_x)  # 往autoencoder中放入输入信息

            loss = loss_func(decoded, batch_y)  # 损失函数计算，均方误差
            optimizer.zero_grad()  # 将所有参数的梯度都清空0 #否则保存的梯度会是上一次的梯度
            loss.backward() # 反向传递，计算出梯度
            optimizer.step() # 以给定的学习速率，反向传递计算出来的梯度，优化参数
            if(step % BATCH_SIZE == 0):
                if(gpuFLAG):
                    loss = loss.cpu()
                print('[Training] epoch:',epoch,', loss:', loss.data.numpy())

                for i in range(10): # 动态更新显示的0~9, 显示解码后的显示效果
                    _, decoded_data = autoencoder(X_train[idx_l[i]])
                    if(gpuFLAG):
                        decoded_data = decoded_data.cpu()
                    ax[10+i].clear()
                    ax[10+i].imshow(np.reshape(decoded_data.data.numpy(), [28,28]), cmap='Greys')
                    ax[10+i].set_xticks([]); ax[10+i].set_yticks([])
                plt.draw();plt.pause(0.1)
    print('[Train End] AutoEncoder train success! Train Time Used:', time.process_time()-t)
    for i in range(10):
        _, decoded_data = autoencoder(X_train[idx_l[i]])
        if(gpuFLAG):
            decoded_data = decoded_data.cpu()
        ax[10+i].clear()
        ax[10+i].imshow(np.reshape(decoded_data.data.numpy(), [28,28]), cmap='Greys')
        ax[10+i].set_xticks([]); ax[10+i].set_yticks([])
    plt.draw();plt.pause(0.1)
    plt.ioff()
    plt.show()

    # 分类过程 # 训练 training
    encodedX, _ = autoencoder(X_train)#对训练集进行编码
    if(gpuFLAG):
        encodedX = encodedX.cpu()
        y_train = y_train.cpu()
    x_train = encodedX.data.numpy() # to numpy array
    y_train = y_train.data.numpy()
    knn = KNeighborsClassifier() #创建训练器
    knn.fit(x_train, y_train) #训练分类器

    # 测试过程
    X_test, y_test = load_mnist(path,'t10k') # load: 测试集与测试标签
    X_test = torch.from_numpy(X_test.astype(np.float32) /255)
    if(gpuFLAG):
        X_test = X_test.cuda()
    encodedX, _ = autoencoder(X_test)#对测试集进行编码
    if(gpuFLAG):
        encodedX = encodedX.cpu()
    X_test = encodedX.data.numpy()
    #用测试集数据进行预测 #(测试集输入, 测试集输出)进行评分，输出准确度
    print('Prediction Accuracy:' ,knn.score(X_test, y_test))
```



## Convolutional Neural Network

> CNN 卷积神经网络







## DQN

- 共三个文件，其中`atari_wrappers.py`来自openai官网，对atari游戏环境进行配置；`DQN_Net_Buffer.py`定义网络模型，经验池；`DQN.py`为训练主过程

```python
# DQN.py
# 使用DQN 玩atari的pong游戏
# 含Agent定义 DQN训练过程
from atari_wrappers import make_atari, wrap_deepmind
import torch.nn.functional as F
import torch
import gym
import random
import os
import sys
import math
import glob
import numpy as np
import matplotlib.pyplot as plt
import time
from DQN_Net_Buffer import DQN, Memory_Buffer

saveStdOut = None
file_log = None

class DQNAgent:
    def __init__(self, in_channels=1, action_space=[], USE_CUDA=False, memory_size=10001,
                epsilon=1, lr=1e-4):
        self.epsilon = epsilon  # 选择随机策略的概率
        self.action_space = action_space  # action的空间
        self.memory_buffer = Memory_Buffer(memory_size) # 经验池
        # 初始化Agent的网络结构
        self.DQN = DQN(in_channels=in_channels, num_actions=action_space.n)
        self.DQN_target = DQN(in_channels=in_channels, num_actions=action_space.n)
        self.DQN_target.load_state_dict(self.DQN.state_dict()) # same
        self.USE_CUDA = USE_CUDA # 是否使用CUDA
        if self.USE_CUDA:
            self.DQN = self.DQN.cuda()
            self.DQN_target = self.DQN_target.cuda()
        self.optimizer = torch.optim.RMSprop(self.DQN.parameters(),
                                             lr=lr, eps=0.001, alpha=0.95)

    def observe(self, lazyframe):
        # 将环境给出的observation(np.array)转换为torch tensor # from Lazy frame to tensor
        state = torch.from_numpy(lazyframe._force().transpose(2, 0, 1)[None] / 255).float()
        if self.USE_CUDA:
            state = state.cuda()
        return state

    def value(self, state):
        # 给出state即atari game中的一帧图像 对应的每个action的价值Q value
        q_values = self.DQN(state)
        return q_values

    def act(self, state, epsilon=None):
        # 通过epsilon-greedy policy选出action
        # epsilon 的概率采用随机action 1-epsilon的概率选择具有最大 Q(s,a) 的 action
        if epsilon is None:
            epsilon = self.epsilon
        # q_values.shape = (1, 6)
        q_values = self.value(state).cpu().detach().numpy()
        if random.random() < epsilon:  # 命中epsilon概率 采用随机策略
            aciton = random.randrange(self.action_space.n)
        else:  # 命中 1-epsilon 选择最大的q_value所对应的action
            aciton = q_values.argmax(1)[0]
        return aciton

    def compute_td_loss(self, states, actions, rewards, next_states, is_done, gamma=0.99):
        # 计算 temporal difference loss # 时间差分法(无模型的方法)
        # TDLoss = R_t + \gamma * Q(s_{s+1}, a_{t+1}) - Q(s_s, a_t)
        actions = torch.tensor(actions).long()  # shape: [batch_size]
        rewards = torch.tensor(rewards, dtype=torch.float)  # same
        is_done = torch.tensor(is_done).bool()  # shape: [batch_size]
        if self.USE_CUDA:
            actions = actions.cuda()
            rewards = rewards.cuda()
            is_done = is_done.cuda()
        # 计算当前所有状态states的q value预测值
        predicted_qvalues = self.DQN(states)
        # 选择actions对应的q values
        predicted_qvalues_for_actions = predicted_qvalues[range(states.shape[0]), actions]

        # 预测的下一 states 对应的所有actions 的 q values
        predicted_next_qvalues = self.DQN_target(next_states)
        # 用预测的下一状态对应的q values最大值作为下一状态的q values
        next_state_values = predicted_next_qvalues.max(-1)[0]
        # 计算目标q values
        target_qvalues_for_actions = rewards + gamma * next_state_values
        target_qvalues_for_actions = torch.where(is_done, rewards, target_qvalues_for_actions)

        # 计算 均方差误差
        loss = F.smooth_l1_loss(predicted_qvalues_for_actions, target_qvalues_for_actions.detach())
        return loss

    def sample_from_buffer(self, batch_size):
        # 从buffer中采样过往的经验
        states, actions, rewards, next_states, dones = [], [], [], [], []
        for _ in range(batch_size):
            idx = random.randint(0, self.memory_buffer.size() - 1)
            data = self.memory_buffer.buffer[idx]
            frame, action, reward, next_frame, done = data
            states.append(self.observe(frame))
            actions.append(action)
            rewards.append(reward)
            next_states.append(self.observe(next_frame))
            dones.append(done)
        return torch.cat(states), actions, rewards, torch.cat(next_states), dones

    def learn_from_experience(self, batch_size):
        # 根据已有经验学习
        if self.memory_buffer.size() > batch_size:
            states, actions, rewards, next_states, dones = self.sample_from_buffer(batch_size)
            td_loss = self.compute_td_loss(states, actions, rewards, next_states, dones)
            self.optimizer.zero_grad()
            td_loss.backward()  # bp backward
            for param in self.DQN.parameters():
                param.grad.data.clamp_(-1, 1)
            self.optimizer.step()
            return td_loss  # !
        else:
            if self.USE_CUDA:
                torch.FloatTensor([0]).cuda()
            else:
                return torch.FloatTensor([0])


def epsilon_by_frame(idx, epsilon_max, epsilon_min, eps_decay):
    # e-greedy decay # epsilon 衰变 返回对应idx下的 epsilon value
    return epsilon_min + (epsilon_max - epsilon_min) * math.exp(-1.0 * idx / eps_decay)

def moving_average(a, n=3):
    ret = np.cumsum(a, dtype=float)
    ret[n:] = ret[n:] - ret[:-n]
    return ret[n - 1:] / n

def draw_training(frame_idx, rewards, path):
    # 绘制每个 episode 的 total reward 变化曲线
    plt.title("total frame %s. mean reward(last 100 games): %s" %
              (frame_idx + 1, np.mean(rewards[-100:])))
    plt.plot(moving_average(rewards, 20))
    plt.savefig("./" + path + "/reward.jpg")
    # plt.show()

def draw_epsilon(frames, epsilon_max, epsilon_min, eps_decay, path):
    # 绘制 epsilon 的变化曲线
    plt.title("epsilon curve(max=%s,min=%s,eps_decay=%s,frames=%s)"
        % (epsilon_max, epsilon_min, eps_decay, frames))
    plt.plot([epsilon_by_frame(i, epsilon_max, epsilon_min, eps_decay) for i in range(frames)])
    plt.savefig("./" + path + "/epsilon curve.jpg")

def log_to_file(path, time_id):
    # 将程序输出到log文件中
    global saveStdOut
    global file_log
    saveStdOut = sys.stdout

    path = os.path.join(os.path.abspath("."), path)  # 绝对路径 + 相对路径
    folder = os.path.exists(path)  # 判断是否存在
    if not folder:  # 判断是否存在文件夹如果不存在则创建为文件夹
        os.makedirs(path)  # makedirs 创建文件时如果路径不存在会创建这个路径
        print("[DEBUG] new folder ", path, " created")
    else:
        print("[DEBUG] folder ", path, " exits")

    # 绝对路径 + time id为文件名
    file_log = open((os.path.join(path, str(time_id) + str(".log"))), "w")
    sys.stdout = file_log

def cancel_log():
    # 取消输出到文件
    sys.stdout = saveStdOut
    file_log.close()

if __name__ == "__main__":  # run: python DQN.py
    USE_CUDA = torch.cuda.is_available()
    env = make_atari("PongNoFrameskip-v4")
    env = wrap_deepmind(env, scale=False, frame_stack=True)
    # === 超参数 START ==================================
    batch_size = 32  # default = 32
    learning_rate = 0.0002  # 学习率 # default = 0.0005
    frames = 1000000  # 游戏给出的总帧数 用作停止条件 # default = 1000000 10^6
    epsilon_max = 1  # 最大epsilon epsilon为采用随机选择action策略的概率 # default = 1
    epsilon_min = 0.01  # 最小epsilon # default = 0.01
    eps_decay = 50000  # epsilon衰减系数 # default = 50000
    gamma = 0.99  # 遗忘系数 # default = 0.99
    interval_update_DQNtar = 1000  # 更新DQN_target的间隔 # default = 1000
    interval_print = 1000  # debug输出间隔 frame数 # default = 1000
    learn_start = 10000  # 到多少frame后开始学习 # default = 10000
    # === 超参数 END ==================================

    start_time = time.time()
    print("start:", time.asctime(time.localtime(start_time)), " id=",
            int(start_time), " CUDA:", USE_CUDA)
    # 保存 log pictures video 文件的目录
    path = ("pong_" + str(float(learning_rate)) + "_batchSize_" + str(batch_size) + 
            "_epsDecay_" + str(eps_decay) + "_frames_" + str(frames))
    log_to_file(path, int(start_time))  # === 开始写log # 该调用会创建文件夹
    draw_epsilon(frames, epsilon_max, epsilon_min, eps_decay, '')
    
    print("start:", time.asctime(time.localtime(start_time)), " CUDA:", USE_CUDA)
    print("batch_size= ", batch_size, " learning_rate= ", learning_rate, " frames= ",
        frames, " epsilon_max=", epsilon_max, " epsilon_min=", epsilon_min, " eps_decay=",
        eps_decay, " gamma=", gamma)

    action_space = env.action_space  # action 空间 用于记录数量
    state_channel = env.observation_space.shape[2]  # 状态 state 数量
    # state_channel=4  action_space=Discrete(6) env.observation_space.shape=(84, 84, 4)
    # env.action_space.n = 6 action状态数
    # 创建DQN Agent
    agent = DQNAgent(in_channels=state_channel, action_space=action_space, USE_CUDA=USE_CUDA, lr=learning_rate)
    frame = env.reset()

    episode_reward = 0  # 记录当前 episode 的 reward
    all_rewards = []  # 记录所有 episode 的 reward
    losses = []
    episode_count = 0  # 记录当前 episode 数

    for i in range(frames):
        # 计算当前epsilon的值
        epsilon = epsilon_by_frame(i, epsilon_max, epsilon_min, eps_decay)
        cur_state = agent.observe(frame)  # 从atari游戏的帧观测出当前状态
        action = agent.act(cur_state, epsilon)  # 对当前状态依据e-greedy计算应采取的action
        next_frame, reward, done, _ = env.step(action)  # 采用了该action后的...
        # reward: 1表示赢了，-1表示输了 在出现第21次|reward|=1时，done=True表示21局打完
        episode_reward += reward  # 将该动作产生的reward累加起来
        # 记录经验至buffer中
        agent.memory_buffer.push(frame, action, reward, next_frame, done)
        frame = next_frame  # 更新frame
        loss = 0
        if agent.memory_buffer.size() >= learn_start:  # 如果已经开始学习
            loss = agent.learn_from_experience(batch_size)  # 从经验中学习
            losses.append(loss)

        if i % interval_print == 0 and i > 0:
            if len(all_rewards) >= 10:
                recent_reward_mean = np.mean(all_rewards[-10:])
            else:
                recent_reward_mean = -21
            print("frames: %5d, reward: %5f, loss: %4f, epsilon: %5f, episode: %4d"
                % (i, recent_reward_mean, loss, epsilon, episode_count))

        if i % interval_update_DQNtar == 0:  # 将 DQN_target 更新为当前 DQN
            agent.DQN_target.load_state_dict(agent.DQN.state_dict())

        if done:  # 游戏每完成一次(指打完21局) 则episode+1 将episode_reward置0
            frame = env.reset()  # 重新开始游戏
            all_rewards.append(episode_reward)  # 该21局的最终reward [-21, 21]
            episode_reward = 0
            episode_count += 1

    torch.save(agent.DQN.state_dict(), "./" + path + "/DQN_dict.pth.tar")
    torch.save(agent.DQN.state_dict(), "DQN_dict.pth.tar")
    # 绘制reword曲线
    draw_training(i, all_rewards, path)

    print("[End] Total time: ", (time.time() - start_time) / 3600, "hours")
    cancel_log()  # === 结束log记录
    print("[End] Total time: ", (time.time() - start_time) / 3600, "hours")
    # 录制视频 # force=True 表示如果有之前的视频 则覆盖保存
    env = gym.wrappers.Monitor(env, "./" + path, force=True)
    frame = env.reset()
    for i in range(10000):
        cur_state = agent.observe(frame)
        action = agent.act(cur_state, epsilon=0)
        next_frame, reward, done, _ = env.step(action)
        frame = next_frame
        if done:
            break
```



```python
# DQN_Net_Buffer.py
# 使用DQN 玩atari的pong游戏 # 附属文件 需要被DQN.py (main文件) 调用
# 定义DQN网络结构 经验缓存 Memory_Buffer
import torch.autograd as autograd
import torch.nn.functional as F
import torch.nn as nn
import torch.optim as optim
import numpy as np
import random

class DQN(nn.Module):
    # 实现论文中的DQN: Human-level control through deep reinforcement learning
    def __init__(self, in_channels=4, num_actions=5):
        # in_channels: 输入通道数 即最近的frame的数量
        # num_actions: action-value的数量 与游戏里的action一一对应
        super(DQN, self).__init__()
        self.conv1 = nn.Conv2d(in_channels, 32, kernel_size=8, stride=4)
        self.conv2 = nn.Conv2d(32, 64, kernel_size=4, stride=2)
        self.conv3 = nn.Conv2d(64, 64, kernel_size=3, stride=1)
        self.fc4 = nn.Linear(7 * 7 * 64, 512)
        self.fc5 = nn.Linear(512, num_actions)

    def forward(self, x):
        x = F.relu(self.conv1(x))
        x = F.relu(self.conv2(x))
        x = F.relu(self.conv3(x))
        x = F.relu(self.fc4(x.reshape(x.size(0), -1)))
        return self.fc5(x)  # <class 'torch.Tensor'>, maybe: torch.Size([1, 6])

class Memory_Buffer(object):
    # 经验池 # 经验缓存
    def __init__(self, memory_size=1000):
        self.buffer = []
        self.memory_size = memory_size
        self.next_idx = 0

    def push(self, state, action, reward, next_state, done):
        # 存储经验样本
        data = (state, action, reward, next_state, done)
        if len(self.buffer) <= self.memory_size:  # buffer not full
            self.buffer.append(data)
        else:  # buffer is full
            self.buffer[self.next_idx] = data
        self.next_idx = (self.next_idx + 1) % self.memory_size

    def sample(self, batch_size): # 获取经验样本
        states, actions, rewards, next_states, dones = [], [], [], [], []
        for _ in range(batch_size):
            idx = random.randint(0, self.size() - 1)
            data = self.buffer[idx]
            state, action, reward, next_state, done = data
            states.append(state)
            actions.append(action)
            rewards.append(reward)
            next_states.append(next_state)
            dones.append(done)
        return np.concatenate(states), actions, rewards, np.concatenate(next_states), dones

    def size(self):
        return len(self.buffer)
```

```python
# 附属文件 需要被DQN.py (main文件) 调用
import numpy as np
from collections import deque
import gym
from gym import spaces
import cv2
cv2.ocl.setUseOpenCL(False)


class NoopResetEnv(gym.Wrapper):
    def __init__(self, env, noop_max=30):
        """Sample initial states by taking random number of no-ops on reset.
        No-op is assumed to be action 0.
        """
        gym.Wrapper.__init__(self, env)
        self.noop_max = noop_max
        self.override_num_noops = None
        self.noop_action = 0
        assert env.unwrapped.get_action_meanings()[0] == 'NOOP'

    def reset(self, **kwargs):
        """ Do no-op action for a number of steps in [1, noop_max]."""
        self.env.reset(**kwargs)
        if self.override_num_noops is not None:
            noops = self.override_num_noops
        else:
            noops = self.unwrapped.np_random.randint(1, self.noop_max + 1)  # pylint: disable=E1101
        assert noops > 0
        obs = None
        for _ in range(noops):
            obs, _, done, _ = self.env.step(self.noop_action)
            if done:
                obs = self.env.reset(**kwargs)
        return obs

    def step(self, ac):
        return self.env.step(ac)

class FireResetEnv(gym.Wrapper):
    def __init__(self, env):
        """Take action on reset for environments that are fixed until firing."""
        gym.Wrapper.__init__(self, env)
        assert env.unwrapped.get_action_meanings()[1] == 'FIRE'
        assert len(env.unwrapped.get_action_meanings()) >= 3

    def reset(self, **kwargs):
        self.env.reset(**kwargs)
        obs, _, done, _ = self.env.step(1)
        if done:
            self.env.reset(**kwargs)
        obs, _, done, _ = self.env.step(2)
        if done:
            self.env.reset(**kwargs)
        return obs

    def step(self, ac):
        return self.env.step(ac)

class EpisodicLifeEnv(gym.Wrapper):
    def __init__(self, env):
        """Make end-of-life == end-of-episode, but only reset on true game over.
        Done by DeepMind for the DQN and co. since it helps value estimation.
        """
        gym.Wrapper.__init__(self, env)
        self.lives = 0
        self.was_real_done = True

    def step(self, action):
        obs, reward, done, info = self.env.step(action)
        self.was_real_done = done
        # check current lives, make loss of life terminal,
        # then update lives to handle bonus lives
        lives = self.env.unwrapped.ale.lives()
        if lives < self.lives and lives > 0:
            # for Qbert sometimes we stay in lives == 0 condition for a few frames
            # so it's important to keep lives > 0, so that we only reset once
            # the environment advertises done.
            done = True
        self.lives = lives
        return obs, reward, done, info

    def reset(self, **kwargs):
        """Reset only when lives are exhausted.
        This way all states are still reachable even though lives are episodic,
        and the learner need not know about any of this behind-the-scenes.
        """
        if self.was_real_done:
            obs = self.env.reset(**kwargs)
        else:
            # no-op step to advance from terminal/lost life state
            obs, _, _, _ = self.env.step(0)
        self.lives = self.env.unwrapped.ale.lives()
        return obs

class LossLifePunishEnv(gym.Wrapper):
    def __init__(self, env, train="True", fire_reset=False):
        """Make end-of-life have a -1 reward when training. 
        When evaluation, end-of-life have 0 reward, but perform no-op step to advance from terminal/lost life state
        if fire_reset = True, performs fire action to reset when life is loss
        """
        if train:
            self.loss_life_punishment = -1
        else:
            self.loss_life_punishment = 0

        gym.Wrapper.__init__(self, env)
        self.lives = 0
        self.fire_reset = fire_reset

    def step(self, action):
        obs, reward, done, info = self.env.step(action)
        # check current lives, make loss of life terminal,
        # then update lives to handle bonus lives
        lives = self.env.unwrapped.ale.lives()
        if lives < self.lives and lives > 0:
            # set reward to -1 when life is loss
            reward += self.loss_life_punishment
            # no-op step to advance from terminal/lost life state
            obs, _, _, _ = self.env.step(0)
            if self.fire_reset:
                obs, _, done, _ = self.env.step(1)
        self.lives = lives
        return obs, reward, done, info

    def reset(self, **kwargs):
        return self.env.reset(**kwargs)

class MaxAndSkipEnv(gym.Wrapper):
    def __init__(self, env, skip=4):
        """Return only every `skip`-th frame"""
        gym.Wrapper.__init__(self, env)
        # most recent raw observations (for max pooling across time steps)
        self._obs_buffer = np.zeros((2,)+env.observation_space.shape, dtype=np.uint8)
        self._skip = skip

    def step(self, action):
        """Repeat action, sum reward, and max over last observations."""
        total_reward = 0.0
        done = None
        for i in range(self._skip):
            obs, reward, done, info = self.env.step(action)
            if i == self._skip - 2:
                self._obs_buffer[0] = obs
            if i == self._skip - 1:
                self._obs_buffer[1] = obs
            total_reward += reward
            if done:
                break
        # Note that the observation on the done=True frame
        # doesn't matter
        max_frame = self._obs_buffer.max(axis=0)

        return max_frame, total_reward, done, info

    def reset(self, **kwargs):
        return self.env.reset(**kwargs)

class ClipRewardEnv(gym.RewardWrapper):
    def __init__(self, env):
        gym.RewardWrapper.__init__(self, env)

    def reward(self, reward):
        """Bin reward to {+1, 0, -1} by its sign."""
        return np.sign(reward)

class WarpFrame(gym.ObservationWrapper):
    def __init__(self, env, width=84, height=84, grayscale=True, dict_space_key=None):
        """
        Warp frames to 84x84 as done in the Nature paper and later work.
        If the environment uses dictionary observations, `dict_space_key` can be specified which indicates which
        observation should be warped.
        """
        super().__init__(env)
        self._width = width
        self._height = height
        self._grayscale = grayscale
        self._key = dict_space_key
        if self._grayscale:
            num_colors = 1
        else:
            num_colors = 3
        new_space = gym.spaces.Box(low=0, high=255,
            shape=(self._height, self._width, num_colors), dtype=np.uint8)
        if self._key is None:
            original_space = self.observation_space
            self.observation_space = new_space
        else:
            original_space = self.observation_space.spaces[self._key]
            self.observation_space.spaces[self._key] = new_space
        assert original_space.dtype == np.uint8 and len(original_space.shape) == 3

    def observation(self, obs):
        if self._key is None:
            frame = obs
        else:
            frame = obs[self._key]
        if self._grayscale:
            frame = cv2.cvtColor(frame, cv2.COLOR_RGB2GRAY)
        frame = cv2.resize(frame, (self._width, self._height), interpolation=cv2.INTER_AREA)
        if self._grayscale:
            frame = np.expand_dims(frame, -1)
        if self._key is None:
            obs = frame
        else:
            obs = obs.copy()
            obs[self._key] = frame
        return obs

class FrameStack(gym.Wrapper):
    def __init__(self, env, k):
        """Stack k last frames.
        Returns lazy array, which is much more memory efficient.
        See Also
        --------
        baselines.common.atari_wrappers.LazyFrames
        """
        gym.Wrapper.__init__(self, env)
        self.k = k
        self.frames = deque([], maxlen=k)
        shp = env.observation_space.shape
        self.observation_space = spaces.Box(low=0, high=255, shape=(
            shp[:-1] + (shp[-1] * k,)), dtype=env.observation_space.dtype)
        
    def reset(self):
        ob = self.env.reset()
        for _ in range(self.k):
            self.frames.append(ob)
        return self._get_ob()

    def step(self, action):
        ob, reward, done, info = self.env.step(action)
        self.frames.append(ob)
        return self._get_ob(), reward, done, info

    def _get_ob(self):
        assert len(self.frames) == self.k
        return LazyFrames(list(self.frames))

class ScaledFloatFrame(gym.ObservationWrapper):
    def __init__(self, env):
        gym.ObservationWrapper.__init__(self, env)
        self.observation_space = gym.spaces.Box(
            low=0, high=1, shape=env.observation_space.shape, dtype=np.float32)

    def observation(self, observation):
        # careful! This undoes the memory optimization, use
        # with smaller replay buffers only.
        return np.array(observation).astype(np.float32) / 255.0

class LazyFrames(object):
    def __init__(self, frames):
        """This object ensures that common frames between the observations are only stored once.
        It exists purely to optimize memory usage which can be huge for DQN's 1M frames replay
        buffers.
        This object should only be converted to numpy array before being passed to the model.
        You'd not believe how complex the previous solution was."""
        self._frames = frames
        self._out = None

    def _force(self):
        if self._out is None:
            self._out = np.concatenate(self._frames, axis=-1)
            self._frames = None
        return self._out

    def __array__(self, dtype=None):
        out = self._force()
        if dtype is not None:
            out = out.astype(dtype)
        return out

    def __len__(self):
        return len(self._force())

    def __getitem__(self, i):
        return self._force()[i]

    def count(self):
        frames = self._force()
        return frames.shape[frames.ndim - 1]

    def frame(self, i):
        return self._force()[..., i]

def make_atari(env_id, max_episode_steps=None):
    env = gym.make(env_id)
    assert 'NoFrameskip' in env.spec.id
    env = NoopResetEnv(env, noop_max=30)
    env = MaxAndSkipEnv(env, skip=4)
    return env

def wrap_deepmind(env, episode_life=False, clip_rewards=False, frame_stack=False, scale=False):
    # Configure environment for DeepMind-style Atari.
    if episode_life:
        env = EpisodicLifeEnv(env)
    if 'FIRE' in env.unwrapped.get_action_meanings():
        env = FireResetEnv(env)
    env = WarpFrame(env)
    if scale:
        env = ScaledFloatFrame(env)
    if clip_rewards:
        env = ClipRewardEnv(env)
    if frame_stack:
        env = FrameStack(env, 4)
    return env
```