

[TOC]



会阻塞的函数:

-   accept
-   recv
-   send













---

# socket

-   套接字socket是使用传输层服务的一种编程接口
-   传输层为进程之间数据传送提供服务
-   运输层主要协议: TCP UDP
-   TCP 传输控制协议 Transmission Control Protocol : 可靠，有连接，通过重传机制在不可靠的网络中实现可靠传输。全双工。无比特错，不丢失，无错序，无重复的数据传输。
-   UDP 用户数据报协议 User Datagram Protocol: 不可靠，无连接，全双工//视频等要求延迟低的，丢包影响不大的





### 概述

-   套接字，socket是在应用层和传输层之间的一个抽象层
-   socket的英文原义是“孔”或“插座”。作为BSD UNIX的进程通信机制，取后一种意思。通常也称作"套接字"，用于描述IP地址和端口，是一个通信链的句柄，可以用来实现不同虚拟机或不同计算机之间的通信
-   socket是面向客户/服务器模型而设计的，针对客户和服务器程序提供不同的Socket系统调用
-   常用类型：流式Socket和数据包式Socket




#### TCP Socket


![](http://op4fcrj8y.bkt.clouddn.com/18-3-15/65967706.jpg)

Server:

1.  Initialize Winsock.//初始化
2.  Create a socket.//创建socket
3.  Bind the socket.//绑定
4.  **Listen** on the socket for a client.//监听
5.  **Accept** a connection from a client.//接受来自client的连接
6.  Receive and send data.//接收和发送data//C/S对称
7.  Disconnect.//断开//C/S对称

Client:

1.  Initialize Winsock.
2.  Create a socket.//创建socket
3.  **Connect** to the server.//请求连接
4.  Send and receive data.//接收和发送data//C/S对称
5.  Disconnect.//断开//C/S对称

服务器监听，客户端请求，连接确认   //三步握手法则

![](http://op4fcrj8y.bkt.clouddn.com/18-3-16/38852083.jpg)

-   进程接收segment的次数和进程开辟的缓冲区有关，传送包的时候当成字节流传输，发的segment不一定按照原来的分包方式传送到接收进程





#### UDP Socket

-   无需建立连接
-   

![](http://op4fcrj8y.bkt.clouddn.com/18-3-16/65605021.jpg)

-   接收进程每次接收一个完整的数据段Datagram
-   UDP协议采用数据报方式传送，每次接收都接收一个数据段
-   接收时存放位置不够，数据段将被截断



#### 端口号 port number

-   IP地址确定数据发往哪个host，**端口号确定数据传给host中哪个进程**
-   端口号是一个**16bits整数**，取值0-65535，分为知名端口号(0\~1023)、注册端口号(1024\~49151)和动态端口号(49152\~65535)，分别用于知名的应用层协议、公司业务和临时连接
-   知名端口号(0\~1023)大部分被比较知名的协议占用
-   注册端口号(1024\~49151)企业的某些软件注册使用，也可以自用，但可能冲突
-   动态端口号(49152\~65535)任何人都可使用
-   建立TCP连接时，客户的端口号默认就是由系统选择一个未用的端口号
-   ipconfig可以用来查看本机所有的IP地址，netstat可以用来查看所有被占用的端口号




知名端口号(部分)：

1.  21-ftp 协议
2.  23-telnet协议
3.  25-SMTP协议
4.  80-HTTP协议
5.  110-POP3协议








### Berkeley sockets

-   **伯克利套接字**nternet Berkeley sockets ，又称为**BSD 套接字**(BSD sockets)是一种应用程序接口（API），用于网际套接字（ socket）与[Unix域套接字](https://zh.wikipedia.org/wiki/Unix%E5%9F%9F%E5%A5%97%E6%8E%A5%E5%AD%97)，包括了一个用C写成的应用程序开发库，主要用于实现进程间通讯，在计算机网络通讯方面被广泛使用

-   Berkeley套接字应用程序接口形成了事实上的网络套接字的标准精髓。 大多数其他的编程语言使用与这套用C语言写成的应用程序接口类似的接口

-   这套应用程序接口也被用于Unix域套接字(Unix domain sockets)，可以在单机上为进程间通讯(IPC Inter-Process Communication)的接口

-   **Berkeley套接字接口**，一个应用程序接口（API），使用一个Internet套接字的概念，使主机间或者一台计算机上的进程间可以通讯。 它可以在很多不同的输入/输出设备和驱动之上运行，尽管这有赖于操作系统的具体实现。 接口实现用于TCP/IP协议，因此它是维持Internet的基本技术之一。 它是由加利福尼亚的伯克利大学开发，最初用于Unix系统。 如今，所有的现代操作系统都有一些源于Berkeley套接字接口的实现，它已成为连接Internet的标准接口。

    套接字接口的接入有三个不同的级别，最基础的也是最有效的就是raw socket级别接入。 很少的应用程序需要在外向通讯控制的这个级别接入，所以raw socket级别是只为了用于开发计算机Internet相关技术的。 最近几年，大多数的操作系统已经实现了对它的全方位支持，包括Windows XP





### winsock

-   **Windows Sockets API (WSA)**, 简记为**Winsock**, 是Windows的TCP/IP网络编程接口(API)
-   兼容于Berkeley socketsAPI在函数名字。实际上Winsock的实现库(winsock.dll)使用的是长名字。这些函数从UNIX BSD(Berkeley Software Distributed)的套接字版本4.3扩展来的




>   版本1.0和1.1: winsock.h wsock32.lib wsock32.dll
>
>   版本2.0: winsock2.h ws2_32.lib ws2_32.dll



>   [Winsock Reference](https://msdn.microsoft.com/en-us/library/windows/desktop/ms741416(v=vs.85).aspx)
>
>   [Winsock Functions](https://msdn.microsoft.com/en-us/library/windows/desktop/ms741394(v=vs.85).aspx)





###### 编程时简称

-   msock master socket
-   ssock slave socket
-   sin sockaddr_in
-   fsin from sockaddr_in//来源的sockaddr_in





###### sockaddr_in & sockaddr

```cpp
//winsock2.h
//The in_addr structure is used with IPv4 addresses.
typedef struct in_addr {//4Bytes
	union {
		struct {
			u_char s_b1, s_b2, s_b3, s_b4;
		} S_un_b;//An IPv4 address formatted as four u_chars.
		struct {
			u_short s_w1, s_w2;
		} S_un_w;//An IPv4 address formatted as two u_shorts.
		u_long S_addr;//An IPv4 address formatted as a u_long.
	} S_un;
} IN_ADDR, *PIN_ADDR, FAR *LPIN_ADDR;


//bind() 第二个参数的类型为sockaddr，但一般使用sockaddr_in再强制转换为sockaddr
struct sockaddr_in {//sin: short for sockaddr_in
	short sin_family;//地址族 Address Family//地址类型
	unsigned short sin_port;//16bits IP端口号0-65535
	struct in_addr sin_addr;//32bits IP地址 上方提到的，用于存储ip地址
	char sin_zero[8];//不使用，一般用0填充
};

struct sockaddr{//一般不使用//16Bytes
    sa_family_t  sin_family;   //地址族（Address Family），也就是地址类型
    char         sa_data[14];  //IP地址和端口号
};
```

>   sockaddr 和 sockaddr_in 的长度相同，都是16字节，只是将IP地址和端口号合并到一起，用一个成员 sa_data 表示。要想给 sa_data 赋值，必须同时指明IP地址和端口号，例如”127.0.0.1:80“，遗憾的是，没有相关函数将这个字符串转换成需要的形式，也就很难给 sockaddr 类型的变量赋值，所以使用 sockaddr_in 来代替。这两个结构体的长度相同，强制转换类型时不会丢失字节，也没有多余的字节



###### getaddrinfo() & addrinfo

```c++
#include <ws2tcpip.h>//Linux:#include<netdb.h>
int getaddrinfo( 
  const char *hostname, 
  const char *service, 
  const struct addrinfo *hints, 
  struct addrinfo **result );
//1.hostname:一个主机名或者地址串(IPv4的点分十进制串或者IPv6的16进制串)
//service：服务名可以是十进制的端口号，也可以是已定义的服务名称，如ftp、http等
//hints：可以是一个空指针，也可以是一个指向某个addrinfo结构体的指针，调用者在这个结构中填入关于期望返回的信息类型的暗示。举例来说：指定的服务既可支持TCP也可支持UDP，所以调用者可以把hints结构中的ai_socktype成员设置成SOCK_DGRAM使得返回的仅仅是适用于数据报套接口的信息
//result：本函数通过result指针参数返回一个指向addrinfo结构体链表的指针
addrinfo
typedef struct addrinfo {
  int             ai_flags;
  //Flags that indicate options used in the getaddrinfo function
  int             ai_family;//The address family//IPv4/6/unspecified
  int             ai_socktype;//SOCK_STREAM(流)常用
  int             ai_protocol;//协议类型IPPROTO_TCP表示使用TCP协议
  size_t          ai_addrlen;//the buffer pointed to by the ai_addr member
  char            *ai_canonname;//The canonical name for the host.主机规范名
  struct sockaddr  *ai_addr;
  //The ai_addr member in each returned addrinfo structure points to a filled-in socket address structure. The length, in bytes, of each returned addrinfo structure is specified in the ai_addrlen member
  struct addrinfo  *ai_next;
} ADDRINFOA, *PADDRINFOA;
```

>   [getaddrinfo](https://baike.baidu.com/item/getaddrinfo/9021771?noadapt=1)             [addrinfo](https://msdn.microsoft.com/en-us/library/windows/desktop/ms737530(v=vs.85).aspx)





---

#### TCP基本流程

```c++
//TCP Socket Server 
WSAStartup
socket
bind
listen//让一个套接字处于监听连接请求的状态
accept//接受套接字上的一个连接请求
send ...//发送数据到已连接套接字
closesocket
WSACleanup



//TCP Socket Clint
WSAStartup
socket
connect
recv
closesocket
WSACleanup
```

>   可能阻塞: accept recv send



| Function    |                          |      |
| ----------- | ------------------------ | ---- |
| socket      | 建立一个绑定到特定服务提供者的套接字       | ALL  |
| bind        | 把一个本地地址(IP地址和端口号)与套接字关联  | ALL  |
| listen      | 让一个套接字处于监听连接请求的状态        | T-S  |
| accept      | 接受套接字上的一个连接请求(blocked)   | T-S  |
| connect     | 建立连接到指定套接字               | T-C  |
| recv        | 从连接或绑定的套接字上接收数据(blocked) | T-SC |
| send        | 发送数据到已连接套接字(blocked)     | T-SC |
| shutdown    | 停止在套接字上的发送数据             | ALL  |
| closesocket | 关闭一个套接字                  | ALL  |

>   T-TCPU-UDPS-serverC-ClientALL-TCPSCandUDPSC











###### socket()

```cpp
//函数功能：创建套接字描述符；
//返回值：若成功则返回套接字非负描述符，若出错返回-1；
#include <winsock2.h>

int socket(int family, int type, int protocol);
/*//af: address family
说明：socket类似与open对普通文件操作一样，都是返回描述符，后续的操作基于该描述符
family 表示套接字的通信域，不同的取值决定了socket的地址类型，一般取值如下：
（1）AF_INET         IPv4因特网域
（2）AF_INET6        IPv6因特网域
（3）AF_UNIX         Unix域
（4）AF_ROUTE        路由套接字
（5）AF_KEY          密钥套接字
（6）AF_UNSPEC       未指定

type确定socket的类型，常用类型如下：
（1）SOCK_STREAM     有序、可靠、双向的面向连接字节流套接字
（2）SOCK_DGRAM      长度固定的、无连接的不可靠数据报套接字
（3）SOCK_RAW        原始套接字
（4）SOCK_SEQPACKET  长度固定、有序、可靠的面向连接的有序分组套接字

protocol指定协议，常用取值如下：
（1）0               选择type类型对应的默认协议
（2）IPPROTO_TCP     TCP传输协议
（3）IPPROTO_UDP     UDP传输协议
（4）IPPROTO_SCTP    SCTP传输协议
（5）IPPROTO_TIPC    TIPC传输协议 */
```



###### bind()

-   将套接字与特定的IP地址和端口绑定起来，流经该IP地址和端口的数据才能交给套接字处理

```cpp
int bind(
  _In_ SOCKET                s,//已建立未捆绑的socket编号(描述符)
  _In_ const struct sockaddr *name,//指向sockaddr的指针
  _In_ int                   namelen//表示上一个参数的长度
);//成功返回0，失败返回-1
```



###### connect()



```cpp
int connect(
  _In_ SOCKET                s,
  //A descriptor identifying an unconnected socket.
  _In_ const struct sockaddr *name,
  //A pointer to the sockaddr structure to which the connection should be established
  _In_ int                   namelen
  //The length, in bytes, of the sockaddr structure pointed to by the name parameter.
);
//If no error occurs, connect returns zero. Otherwise, it returns SOCKET_ERROR, and a specific error code can be retrieved by calling WSAGetLastError
```





###### listen()

-   第二个参数是等待连接队列的最大长度，默认是5。就是最大同时能处理5个并发连接请求

```cpp
int listen(
  _In_ SOCKET s,//A descriptor identifying a bound, unconnected socket.
  _In_ int    backlog//
);//If no error occurs, listen returns zero.
```





###### accept()

-   accept会根据listen设定的个数，如果同时请求的个数多于设定的值，则只处理前面的几个请求，后面的不会响应

```c
SOCKET accept(
  _In_    SOCKET          s,
  _Out_   struct sockaddr *addr,
  _Inout_ int             *addrlen
);//If no error occurs, accept returns a value of type SOCKET that is a descriptor for the new socket. This returned value is a handle for the socket on which the actual connection is made
```







###### send()

```cpp
int send(
	_In_       SOCKET s,//A descriptor identifying a connected socket
	_In_ const char   *buf,
	_In_       int    len,//The length, in bytes, of the data in buffer pointed to by the buf parameter
	_In_       int    flags
);
//send的返回值>0时，表示实际发送了多少字节。注意：只是copy到系统缓存里，系统决定什么时候会发送这些数据
//send的返回值==0时，这个在send空串时会发生，是正常的
//send的返回值<0时，需要检查errno，当errno == EINTR || errno == EWOULDBLOCK || errno == EAGAIN时，连接正常，可以稍后再试。其他的就是连接异常了
```





###### recv()



```cpp
int recv(
	_In_  SOCKET s,
	_Out_ char   *buf,//指向缓冲区
	_In_  int    len,//缓冲区大小(字节数)
	_In_  int    flags//一般设置为0
);
//return:(>0)接收到的字节数,(=0)连接断开(正常关闭),(<0)连接出错
//返回SOCKET_ERROR可调用WSAGetLastError取得错误代码
```





#### UDP基本流程

-   在服务器程序中，TCP协议通信中，需要调用listen()监听，accept()准备接受连接，而UDP中，则没有这两个函数，它只需要等待接受数据
-   而在客户端，TCP需要用到connect函数，UDP不需要
-   如果用到connect()，虽然后面的发送和接受函数可以不用写源目的地址，但其协议仍然是无连接的



![](http://op4fcrj8y.bkt.clouddn.com/18-3-19/95454375.jpg)







###### sendto()

-   If no error occurs, **sendto** returns the total number of bytes sent, which can be less than the number indicated by *len*. Otherwise, a value of SOCKET_ERROR is returned, and a specific error code can be retrieved by calling WSAGetLastError()

```cpp
int sendto(
  _In_       SOCKET                s,
  _In_ const char                  *buf,//需要发送的字符串基址
  _In_       int                   len,//需要发送的字符串长度
  _In_       int                   flags,
  _In_       const struct sockaddr *to,
  _In_       int                   tolen//The size, in bytes, of the address pointed to by the to parameter.
);//无错误则返回发送的字节数(小于等于第三个参数len，一般等于)，有错误则返回SOCKET_ERROR
```



###### recvfrom()

-   

```cpp
int recvfrom(
  _In_        SOCKET          s,
  _Out_       char            *buf,
  _In_        int             len,//buf可容纳的最大长度
  _In_        int             flags,
  _Out_       struct sockaddr *from,
  _Inout_opt_ int             *fromlen//fromlen [in, out, optional] An optional pointer to the size, in bytes, of the buffer pointed to by the from parameter.
);
```







#### 其余相关函数



###### setsockopt()



-   可以利用setsockopt()设置成异步模式解决阻塞问题//也可以调用select函数或epool或ioctl解决阻塞问题





###### inet_ntoa()

-   IP地址转换函数
-   网络字节序IP转化点分十进制IP
-   返回点分十进制的字符串在静态内存中的指针



```cpp
char *inet_ntoa (struct in_addr);

#include <WINSOCK2.h>
#pragma comment(lib,"WS2_32.LIB")

char* cstr = inet_ntoa(fsin.sin_addr);
```







