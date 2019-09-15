



[TOC]



---

# HTTP

> 应用层协议

- HTTP functions as a request–response protocol in the client–server computing model. CS模式下，请求-应答协议

-  The client submits an HTTP request message to the server. The server, which provides *resources* such as HTML files and other content, or performs other functions on behalf of the client, returns a response message to the client. 应答服务器(源服务器 origin server)存储HTML文件等资源，向客户端返回响应报文

- A web browser is an example of a **user agent (UA)**. Other types of user agent include the indexing software used by search providers (web crawlers), voice browsers, mobile apps, and other software that accesses, consumes, or displays web content. 网页浏览器是**用户代理程序**的一种

- High-traffic websites often benefit from web cache servers that deliver content on behalf of upstream servers to improve response time. web缓存服务器代表上游服务器交付内容，以提高响应时间。Web browsers cache previously accessed web resources and reuse them, when possible, to reduce network traffic. web浏览器缓存以前访问过的web资源，并在可能的时候重用他们，以减少网络流量。HTTP proxy servers at private network boundaries can facilitate communication for clients without a globally routable address, by relaying messages with external servers. 通过与外部服务器中继消息，私有网络边界上的HTTP代理服务器可以在没有全局可路由地址的情况下促进客户机之间的通信

- 在用户代理和源服务器中间可能存在多个“中间层”，比如代理服务器、网关或者隧道(tunnel)

- 假定底层使用可靠的传输层协议，通常使用TCP。 However, HTTP can be adapted to use unreliable protocols such as the User Datagram Protocol (UDP), for example in HTTPU and Simple Service Discovery Protocol (SSDP).

  

HTTP resources are identified and located on the network by **Uniform Resource Locators** (**URL**s)(统一资源定位器), using the **Uniform Resource Identifiers** (**URI**'s)(统一资源标识符) schemes http and https. For example, including all optional components:

```http
            userinfo          host        port
        ┌───────┴───────┐ ┌────┴────────┐ ┌┴┐
 http://john.doe:password@www.example.com:123/forum/questions/?tag=networking&order=newest#top
 └─┬─┘ └───────────┬────────────────────────┘└─┬─────────────┘└────────┬──────────────────┘└┬─┘
 scheme         authority                      path                  query             fragment
```

URIs are encoded as hyperlinks in HTML documents, so as to form interlinked hypertext documents. URL在HTML文档中被编码为超链接，从而形成相互链接的超文本文档。





## History

HTTP/1.1是原始HTTP (HTTP/1.0)的修订版。在HTTP/1.0中，对每个资源请求都建立到同一服务器的单独连接。HTTP/1.1可以在页面交付后多次重用连接来下载图像、脚本、样式表等。因此，HTTP/1.1通信的延迟更小，因为TCP连接的建立带来了相当大的开销。

| Year |                HTTP Version                 | Description                                   |
| :--: | :-----------------------------------------: | --------------------------------------------- |
| 1991 |                     0.9                     | 已过时，只接受GET，不指定版本号，不支持请求头 |
| 1996 |                     1.0                     |                                               |
| 1997 |                     1.1                     | keep-alive-mechanism, 管线化                  |
| 2015 | [2.0](https://en.wikipedia.org/wiki/HTTP/2) |                                               |
| 2018 | [3.0](https://en.wikipedia.org/wiki/HTTP/3) |                                               |



## Session

- An HTTP session is a sequence of network request-response transactions. 网络请求-响应事务
- An HTTP client initiates a request by establishing a Transmission Control Protocol (TCP) connection to a particular port on a server (typically port 80, occasionally port 8080). HTTP客户端通过建立到服务器上特定端口(80, 8080, 8008)的TCP连接来发起请求
- An HTTP server listening on that port waits for a client's request message. HTTP服务器监听对应端口以等待客户端请求报文
- HTTP服务端接收请求后，服务端返回状态行(e.g. HTTP/1.1 200 OK)以及对应消息。消息主体通常是请求的资源



### Persistent Connections

> 持久连接

- In HTTP/0.9 and 1.0, the connection is closed after a single request/response pair. 在HTTP 0.9, 1.0 每次请求-响应对结束后，连接关闭
- In HTTP/1.1 a keep-alive-mechanism was introduced, where a connection could be reused for more than one request. HTTP 1.1 提出保活机制(持久连接)，连接可被重用，进行多次请求
- 持久连接明显减少了请求延迟。第一次请求后，客户端不需要重新协商TCP三次握手连接(TCP 3-Way-Handshake connection)。
- 另一积极副作用：由于TCP慢启动机制(TCP's slow-start-mechanism)，连接通常会随着时间变快。

HTTP 1.1 比1.0还进行了带宽优化：

- HTTP/1.1 introduced chunked transfer encoding(分块传输编码) to allow content on persistent connections to be streamed rather than buffered. 允许持久连接中的内容可以进行流处理而非缓冲
- HTTP pipelining further reduces lag time, allowing clients to send multiple requests before waiting for each response. Another addition to the protocol was byte serving, where a server transmits just the portion of a resource explicitly requested by a client.



### Chunked Transfer Encoding

> 分块传输编码 Chunked transfer encoding 是超文本传输协议 HTTP 中的一种数据传输机制

- 允许HTTP由网页服务器发送给客户端应用（ 通常是网页浏览器）的数据可以分成多个部分。分块传输编码只在HTTP协议1.1版本（HTTP/1.1）中提供
- 如果一个HTTP消息（请求消息或应答消息）的`Transfer-Encoding`消息头的值为`chunked`，那么，消息体由数量未定的块组成，并以最后一个大小为0的块为结束



### 状态码