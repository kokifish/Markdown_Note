[TOC]



- revision control: 版本控制
- repository: 版本库，仓库







# License



![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/choose-a-free-software-license.png)



## GNU General Public License

GNU General Public License （GPL）的可能是开源项目最常用的许可证。GPL赋予和保证了开源项目开发者广泛的权利。基本上，它允许用户合法复制，分发和修改软件。 这意味着你可以：

- 复制软件：复制软件到自己的服务器，客户端的服务器，你自己的电脑，几乎任何你想要的地方，而且没有数量限制。
- 发布软件：发布你想要的软件，例如，在你的网站提供下载链接，刻成光盘，打印出来等等。
- 收取费用：如果你想在向别人提供软件时收费，如设置在别人的网站上或者其他用途时。GPL允许你这么做，但是你必须给客户提供一个GPL副本，告诉他们可以在其他地方得到免费版本。当然最好在此之前，告诉客户，你为什么收费。
- 可以任意修改：如果你想添加或删除功能，没问题。如果想在其他项目中使用部分代码，也是可以的，但是唯一的限制是此项目也必须按GPL发布。

> 商业软件不能使用GPL协议的代码





# Git

- Git跟踪的是修改，而非文件。(修改：增/删/改行，创建/删文件)

## Introduction

CVS, SVN为集中式版本控制系统，Git是分布式版本控制系统。

- 集中式：版本库存放在中央服务器，干活时从中央服务器获取最新版本，更改后推送给中央服务器。必须联网才能工作，文件大时会很麻烦。
- 分布式：每个人的电脑上都是一个完整的版本库，A修改了文件w，只需把修改推送给其他参与者，不需要服务器端软件，就可以運作版本控制。安全性高很多。BitKeeper, Mercurial, Bazaar



- CVS：最早的开源、免费集中式版本控制系统。由于CVS自身设计的问题，会造成提交文件不完整，版本库莫名其妙损坏的情况
- SVN：开源、免费，目前用得最多的集中式版本库控制系统。修正了CVS的一些稳定性问题
- VSS：集中式版本控制系统，集成在Visual Studio



## How to Use



### install

```python
#linux下
$ git
The program 'git' is currently not installed. You can install it by typing:
sudo apt-get install git
```

- 有很多Linux会提示Git未安装并告知如何安装Git

```python
sudo apt-get install git #Debian, Ubuntu
sudo apt-get install git-core #老一点的Debian, Ubuntu # 以前有个软件叫GIT (GNU Interactive Tools) 后来由于Git名气改成gnuit
```

其他的Linux版本：

1. Git官网下载源码，解压
2. 依次输入：`./config`，`make`，`sudo make install`



```python
$ git config --global user.name "Your Name"
$ git config --global user.email "email@example.com"
```

- 设置自己的名字与Email地址
- --global参数：表示该机器上所有的Git仓库都使用这个配置，也可以对某个仓库指定不同的用户名和Email地址



### Create & Initialization

- 版本库，仓库，可以理解成一个目录，该目录下所有文件都可以被Git管理起来，每个文件的修改、删除，Git都能跟踪，以便任何时刻都可以追踪历史，或者在将来某个时刻可以“还原”

```python
$ mkdir learngit   #创建新文件夹
$ cd learngit   #更改当前路径
$ pwd   #显示当前目录路径
/Users/test/learngit
git init   #把当前目录变成Git可以管理的仓库 #会被告知创建了空的仓库
Initialized empty Git repository in /Users/test/learngit/.git/
```

- `.git`目录默认隐藏，用`ls -ah`可看见
- 可以选择一个已有文件的目录来创建Git仓库



- 只能跟踪文本文件的改动(e.g. TXT, webpage, code). 二进制文件虽然可以管理，但无法跟踪改动(e.g. doc, jpg)

> ###### WARNING (for Windows)
>
> Windows自带的**记事本**在每个文件开头添加了0xefbbbf, 建议使用Notepad++将默认编码设置为UTF-8 without BOM

### add & commit

- add命令将修改从工作区添加至暂存区stage
- commit将暂存区的所有修改提交到当前分支
- 每次修改，如果不用`git add`到stage，那就不会加入到`commit`中

![](https://raw.githubusercontent.com/pureteap/pictures/main/Code_pic/lifecycle.png)

```python
$ git add readme.txt   #add file to repository
$ git add .   #添加当前目录下所有文件至 repository #没有任何输出
$ git commit -m "wrote a readme file"  #把文件提交到 repository
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
        modified:   README.md

no changes added to commit
```

- git add xxx.txt: 将文件添加至仓库中。表示需要跟踪该文件，Git不自动将文件纳入跟踪范围
- git add <path>: 参数为路径时，递归地跟踪该目录下的所有文件( . 为当前路径的根目录)
- git commit -m "test": 将文件提交到仓库中，-m “commit message”，一次提交很多文件，不需要指定提交哪些文件，提交的文件由add指定。



### status & diff

```python
$ git status  #查看仓库当前状态 #可以知道文件是否改过
$ git diff readme.md  #查看文件difference #格式: Unix通用diff格式
```



```python
$ git status #以下为可能出现的状态信息

### clean: 自上次commit后没有更改
On branch main #当前所在分支
nothing to commit, working tree clean #当前没有需要提交的修改,工作目录是干净的 #说明所有已跟踪文件在上次提交后都未被更改过，且当前目录下没有出现任何处于未跟踪状态的新文件
### untracked: 未跟踪
On branch main
Untracked files: #以下将列出未跟踪的文件
  (use "git add <file>..." to include in what will be committed)

    README #这个是未跟踪的文件

nothing added to commit but untracked files present (use "git add" to track)

### Changes to be committed: 暂存状态
On branch main
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    new file:   README #已暂存状态
```





```cmd
git diff ~/path/to/file1 ~/path/to/file2 # 比较两个本地文件之间的区别
```



#### diff输出内容解析

```cmd
# 改动前test.txt
aaa
bbb
# 改动后test.txt
aaa
bbbb
ccc
```

> 上面的是文件的内容，下面的是有关该文件的diff的输出

```cmd
$ git diff test.txt # 比较工作目录和暂存区域快照之间的差异
diff --git a/test.txt b/test.txt # Output: 比较的是a版(变动前)和b版(变动后)的区别
index d39cda9..ca48dab 100644 # 两个版本的git哈希值 # 最后六个数字是对象的模式 100代表普通文件，644表示权限 # index区d39cda9与工作目录区域的ca48dab对象进行比较
--- a/test.txt # --- 表示变动前版本
+++ b/test.txt # +++ 表示变动后版本
@@ -1,2 +1,3 @@ # 源文件1~2行与目标文件的1~3行有差异
 aaa
-bbb # - 减少的部分 # 红色
\ No newline at end of file # 文件最后一行没有换行
+bbbb # + 增加的部分 # 绿色
+ccc # + 增加的部分 # 绿色
\ No newline at end of file
```



### Revision Control

> 版本控制;

- commit id: SHA1计算得出的提交id，作为版本号
- `HEAD`表示当前版本，上一个版本是`HEAD^`，上100个版本为`HEAD~100`
- `HEAD`是指向main的指针，main指向提交(commit)，回退版本相当于指针指向旧版本的main，然后更新工作区文件



![wiki git](https://raw.githubusercontent.com/pureteap/pictures/main/Code_pic/760px-Git_operations.svg.png)

撤销修改的几种场景：

1. 只改乱了工作区某个文件的内容，直接丢弃工作区的修改时：`git checkout -- file`
2. 改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改：①`git reset HEAD <file>`，回到场景1。②`git checkout -- file`
3. 提交修改到版本库，但没有推送到远程库，想要撤销本次提交：`git reset --hard HEAD^`



#### Repository

> repository: 版本库; 

- 工作区的隐藏目录`.git`为版本库repository，不算工作区
- stage (): 暂存区

工作区中的文件 → git add → 将修改放到stage → git commit → 一次性把暂存区所有修改提交到分支中

> 注意！commit只会提交被放在stage的修改，如果在add后，进行第二次修改再提交，第二次修改不会被提交



#### log & reflog

```python
$ git log #命令显示从最近到最远的提交日志
$ git log --pretty=oneline #单行显示log

```

- 

```python
$ git log #
commit 02ae2815bbb01694d60630d6bbda3abf46b01df9 (HEAD -> main, origin/main, origin/HEAD)#当前版本号
Author: pureteap <pureteap@gmail.com>
Date:   Sun Aug 26 02:04:09 2018 +0800

    readme refresh

commit 5ed70f6671e475916695f893c5807729ffe9a90c #commit id #上一个版本号
Author: pureteap <pureteap@gmail.com> #commit author
Date:   Sat Aug 25 23:31:54 2018 +0800 #commit time

    readme add #commit message

commit ... # omited
```

- `git reflog`可以查看命令历史，从新到旧

```python
$ git reflog #查看历史操作
02ae281 (HEAD -> main, origin/main, origin/HEAD) HEAD@{0}: reset: moving to 02ae2
5ed70f6 HEAD@{1}: reset: moving to HEAD^
02ae281 (HEAD -> main, origin/main, origin/HEAD) HEAD@{2}: reset: moving to HEAD
02ae281 (HEAD -> main, origin/main, origin/HEAD) HEAD@{3}: commit: readme refresh
5ed70f6 HEAD@{4}: commit: readme add
fe2b859 HEAD@{5}: commit: pictures ini
c7b48fb HEAD@{6}: commit: ini
f31bd10 HEAD@{7}: clone: from git@github.com:pureteap/CN.git

```



#### reset

`git reset`命令

1. 回退版本
2. 把stage的修改回退到工作区

- `git reset --hard HEAD^` reset到上一个版本
- `git reset HEAD readme.md` 把stage中的修改撤销掉(unstage)，重新放回工作区。(而后可以用 git checkout -- file 撤销文件的修改)

```python
$ git log # 查看log
commit 02ae2815bbb01694d60630d6bbda3abf46b01df9 (HEAD -> main, origin/main, origin/HEAD)#当前版本号
Author: pureteap <pureteap@gmail.com>
Date:   Sun Aug 26 02:04:09 2018 +0800

    readme refresh

commit 5ed70f6671e475916695f893c5807729ffe9a90c #commit id #上一个版本号
Author: pureteap <pureteap@gmail.com> #commit author
Date:   Sat Aug 25 23:31:54 2018 +0800 #commit time

    readme add #commit message

commit ... # omited

$ git reset --hard HEAD #相当于reset到当前版本，所以版本号不变
HEAD is now at 02ae281 readme refresh

$ git reset --hard HEAD^ #回退到上一个版本
HEAD is now at 5ed70f6 readme add

$ git log # 查看log
commit 5ed70f6671e475916695f893c5807729ffe9a90c (HEAD -> main)#此时最新版已变成上一个版本，原本的最新版02ae281已经没有显示了
Author: pureteap <pureteap@gmail.com>
Date:   Sat Aug 25 23:31:54 2018 +0800

    readme add

commit ... # omited

$ git reset --hard 02ae2 #回退到02ae2版，即原本的最新版 readme refresh #版本号没必要写全，Git会自动去找。版本号过少时Git可能找到多个版本从而无法确定具体版本
HEAD is now at 02ae281 readme refresh #已回到原本的最新版 readme refresh
```

> 若误reset，可以寻找之前的版本号，git reset --hard [版本号前几位]，如果关掉了console，可以用git reflog从历史操作中查找历史版本号



#### checkout & rm

- `git checkout -- <file>...`撤销工作区的修改至上次add/commit，用版本库里的版本替换工作区的版本

`git checkout -- readme.txt`：把`readme.txt`在工作区的修改全部撤销，这里有两种情况：

1. `readme.txt`自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；
2. `readme.txt`已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态

总之，就是让这个文件回到最近一次`git commit`或`git add`时的状态。`git checkout -- file`命令中的`--`很重要，没有`--`，就变成了“切换到另一个分支”的命令



- `git rm`删除版本库中的一个文件，并且`git commit`后，文件就从版本库中删除



### remote repository

> remote repository: 远程仓库

GitHub提供Git仓库托管服务，本地Git仓库与GitHub之间的传输通过SSH加密

1. 创建SSH Key
2. GitHub: New SSH Key:`id_rsa.pub`文件的内容(公钥)

```python
$ ssh-keygen -t rsa -C "youremail@example.com" #创建SSH Key
# then copy id_rsa.pub file content, like:
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2LFS0Myajvaqj00aRt6+E1HPrPhGO14nwEf/wrZFG/bOa6f3gH2mv32uvyipy4zM8rsEDt37qs5mMVrmk0lB1b7yHYI+G6UkuCVugcmVb2EELWWazfN1CwLFD8kl0z1qtvHosKVVWjavsKvZoOHRW6aOm4bdvv+wnI6SwRrFpvIld4pmF/cNs8jl6FNrYHg4GsSnLmphw88HObZKn7FSB9KqoUkWhWjw3SsJxyTnVFVkegtmK71NfxFZ9cCGQc4Ng3aYobxxrAGGb63FasSenobFrkdHXwD5CT9W1wfILhrgWJDA6h/0LfKDtVqmb+4rWomnbKr1cui3ArcmO3ySzPBPBLcEkmpiaFYrwy8SpoGmE+jSwgtaksArAlsGczVqLDRsfwa/2ZEtgogAnGoyd8RZE5/sPhH+bkqlwkgI5gW6pM/61/4J7+RUBq/BruVrXlkDQ6yaeqy7XP4u5ZHjqJDNh8zctx16CyL+P8PFcSB3ru88OosoRo6tn2yemtmE=
```

> 若需要在多台电脑上访问远程库，需要将每台电脑的公钥都添加到GitHub



远程库的名字是`origin`，是Git默认的叫法，也可以改成别的，但是`origin`这个名字一看就知道是远程库

```python
$ git remote add origin git@github.com:pureteap/repo-name.git # 第一次添加时使用 #把本地仓库与远程仓库关联，关联错了没有关系，因为SSH Key公钥不在账户列表中时，无法推送
```



#### push

- `git push`： 把本地库的内容推送到远程，实际上是把当前分支`main`推送到远程。

```python
$ git push -u origin main #-u #第一次推送main分支的所有内容时使用
```

由于远程库是空的，我们第一次推送`main`分支时，加上了`-u`参数，Git不但会把本地的`main`分支内容推送到远程新的`main`分支，还会把本地的`main`分支和远程的`main`分支关联起来，在以后的推送或者拉取时就可以简化命令

```python
$ git push origin main # 把本地main分支的最新修改推送至GitHub
```



> ### SSH警告
>
> 第一次使用Git的`clone`或者`push`命令连接GitHub时，会得到一个警告：
>
> ```
> The authenticity of host 'github.com (xx.xx.xx.xx)' can't be established.
> RSA key fingerprint is xx.xx.xx.xx.xx.
> Are you sure you want to continue connecting (yes/no)?
> ```
>
> 因为SSH连接在第一次验证GitHub服务器的Key时，需要确认GitHub的Key的指纹信息是否真的来自GitHub的服务器，输入`yes`回车即可。若担心有人冒充可对照GitHub's SSH key fingerprints

#### clone

- 克隆仓库，需要知道仓库地址，然后使用`git clone`

```python
$ git clone git@github.com:user_name/repo_name.git
```

> Git支持多种协议，默认的`git://`使用ssh，但也可以使用`https`等其他协议。
>
> 使用`https`除了速度慢以外，还有个最大的麻烦是每次推送都必须输入口令，但是在某些只开放http端口的公司内部就无法使用`ssh`协议而只能用`https`



### branching and merging

- main: 主分支
- `HEAD`:指向main，main指向提交commit

https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/001375840038939c291467cc7c747b1810aab2fb8863508000 廖雪峰，创建与合并分支





### .sh update

- shell文件一句话更新并push

```bash
# update.sh
git add .;
git commit -m ".sh update";
git push origin main;
```

- 在git中打开
- `sh ./update.sh` or `sh update.sh`

---

## CMD Quick Find

```python
$ git init   #初始化Git repository #创建.git文件夹 #解决: fatal: Not a git repository (or any of the parent directories): .git
$ git add file.txt  #添加文件到仓库
$ git add .  #将当前目录的所有文件添加至仓库中
$ git commit -m "test commit node"  #将文件提交到仓库，-m后问提交说明
$ git push origin main #push files to online repository #推送至远程main分支

$ git clone git@github.com:hex-16/pictures.git #将远程仓库clone到本地
$ git status  #查看仓库当前状态
$ git remote -v #列出所有远程仓库
$ git checkout -- file #撤销工作区文件的修改至上次add/commit
$ git reset HEAD <file> #把stage中的修改撤销掉(unstage)

$ git config --global core.autocrlf false # global 不自动转换crlf #默认为true
$ git pull origin main # 将远程仓库同步到本地
$ gitk # 图像化界面
```





```cmd
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/pureteap/Ali.git
git push -u origin main
```











# OneDrive

1. Use the **Windows key + X** keyboard shortcut to open the Power User menu, and select **Command Prompt (Admin)**.
2. ```%localappdata%\Microsoft\OneDrive\onedrive.exe /reset```     //reset OneDrive
3. Make sure the OneDrive icon is no longer visible in the taskbar's notification area (bottom right corner) to verify the command worked.
4. According to Microsoft, the icon should re-appear after two minutes. If it doesn't re-appear, open Start, do a search for **OneDrive** and hit **Enter** to restart the desktop sync app.




