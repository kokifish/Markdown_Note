



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

  

##### URI

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



## HTTP Session

- An HTTP session is a sequence of network request-response transactions. 网络请求-响应事务
- An HTTP client initiates a request by establishing a Transmission Control Protocol (TCP) connection to a particular port on a server (typically port 80, occasionally port 8080). HTTP客户端通过建立到服务器上特定端口(80, 8080, 8008)的TCP连接来发起请求
- An HTTP server listening on that port waits for a client's request message. HTTP服务器监听对应端口以等待客户端请求报文
- HTTP服务端接收请求后，服务端返回状态行(e.g. HTTP/1.1 200 OK)以及对应消息。消息主体通常是请求的资源
- HTTP是无状态协议，无状态协议不需要HTTP服务器在多个请求间保存用户的信息或者状态
- 一些web应用使用HTTP cookie或web表单中的隐藏变量实现状态或服务器端会话



### Persistent Connections

> 持久连接

- In HTTP/0.9 and 1.0, the connection is closed after a single request/response pair. 在HTTP 0.9, 1.0 每次请求-响应对结束后，连接关闭
- In HTTP/1.1 a **keep-alive-mechanism** was introduced, where a connection could be reused for more than one request. HTTP 1.1 提出**保活机制**(持久连接)，连接可被重用，进行多次请求
- 持久连接明显减少了请求延迟。第一次请求后，客户端不需要重新协商TCP三次握手连接(TCP 3-Way-Handshake connection)。
- 另一积极副作用：由于TCP慢启动机制(TCP's slow-start-mechanism)，连接通常会随着时间变快。

HTTP 1.1 比1.0还进行了带宽优化：

- HTTP/1.1 introduced **chunked transfer encoding**(分块传输编码) to allow content on persistent connections to be streamed rather than buffered. 允许持久连接中的内容可以进行流处理而非缓冲
- HTTP pipelining further reduces lag time, allowing clients to send multiple requests before waiting for each response. Another addition to the protocol was byte serving, where a server transmits just the portion of a resource explicitly requested by a client.







#### Chunked Transfer Encoding

> **分块传输编码** Chunked transfer encoding 是超文本传输协议 HTTP 中的一种数据传输机制

- 允许HTTP由网页服务器发送给客户端应用（ 通常是网页浏览器）的数据可以分成多个部分。分块传输编码只在HTTP协议1.1版本（HTTP/1.1）中提供
- 如果一个HTTP消息（请求消息或应答消息）的`Transfer-Encoding`消息头的值为`chunked`，那么，消息体由数量未定的块组成，并以最后一个大小为0的块为结束





## HTTP Authentication

- challenge-response mechanism质询-响应机制



## Message Format



### Request Message

> 客户端请求消息

请求报文包含四个部分：

1. 请求行 request line(e.g. `GET /images/logo.png HTTP/1.1`, 从服务器请求`/images/logo.png`)
2. 请求头域 request header fields (e.g., Accept-Language: en).在HTTP/1.1, 除了`Host`外所有请求头域都是可选的。In the HTTP/1.1 protocol, all header fields except Host are optional.
3. 空行 an empty line. 仅包含`<CR><LF>`，无其他空白
4. 可选的报文体 an optional message body; (即请求数据)

请求行与别的头部域必须以回车换行结束The request line and other header fields must each end with `<CR><LF> `(that is, a **carriage return** character followed by a **line feed** character).

#### Request Methods

- HTTP定义方法(有时称为谓词，但在规范中没有提到谓词verb，OPTIONS或HEAD也没有提到谓词)来指示要在标识的资源上执行的所需操作

HTTP1.0 定义了三种请求方法：GET, POST, HEAD

HTTP1.1 新增了六种请求方法：OPTIONS, PUT, PATCH, DELETE, TRACE, CONNECT



| Method  | Description                                                  |
| ------- | ------------------------------------------------------------ |
| GET     | **请求指定的页面信息**，并返回实体主体                       |
| HEAD    | 类似于 GET 请求，只不过**返回的响应中没有具体的内容**，用于获取报头 |
| POST    | **向指定资源提交数据进行处理请求**（例如提交表单或者上传文件）。数据被包含在请求体中。POST 请求可能会导致**新的资源的建立和/或已有资源的修改** |
| PUT     | 从客户端向服务器传送的数据**取代指定的文档的内容**           |
| DELETE  | 请求服务器**删除指定的页面**                                 |
| CONNECT | HTTP/1.1 协议中预留给能够将连接改为**管道**方式的**代理服务器** |
| OPTIONS | 允许客户端查看服务器的性能                                   |
| TRACE   | 回显服务器收到的请求，主要用于**测试或诊断**                 |
| PATCH   | 是对 PUT 方法的补充，用来对已知资源进行**局部更新**          |

##### Safe Methods



### Response Message

> 服务器响应消息



HTTP响应也由四个部分组成：

1. 状态行
2. 消息报头
3. 空行
4. 响应正文



| 应答头           | 说明                                                         |
| :--------------- | :----------------------------------------------------------- |
| Allow            | 服务器支持哪些请求方法（GET、POST等）                        |
| Content-Encoding | 文档的编码（Encode）方法。只有在解码之后才可以得到Content-Type头指定的内容类型。利用gzip压缩文档能够显著地减少HTML文档的下载时间。Java的GZIPOutputStream可以很方便地进行gzip压缩，但只有Unix上的Netscape和Windows上的IE 4、IE 5才支持它。因此，Servlet应该通过查看Accept-Encoding头（即request.getHeader("Accept-Encoding")）检查浏览器是否支持gzip，为支持gzip的浏览器返回经gzip压缩的HTML页面，为其他浏览器返回普通页面 |
| Content-Length   | 表示内容长度。只有当浏览器使用持久HTTP连接时才需要这个数据。如果你想要利用持久连接的优势，可以把输出文档写入 ByteArrayOutputStream，完成后查看其大小，然后把该值放入Content-Length头，最后通过byteArrayStream.writeTo(response.getOutputStream()发送内容 |
| Content-Type     | 表示后面的文档属于什么MIME类型。Servlet默认为text/plain，但通常需要显式地指定为text/html。由于经常要设置Content-Type，因此HttpServletResponse提供了一个专用的方法setContentType |
| Date             | 当前的GMT时间。你可以用setDateHeader来设置这个头以避免转换时间格式的麻烦 |
| Expires          | 应该在什么时候认为文档已经过期，从而不再缓存它？             |
| Last-Modified    | 文档的最后改动时间。客户可以通过If-Modified-Since请求头提供一个日期，该请求将被视为一个条件GET，只有改动时间迟于指定时间的文档才会返回，否则返回一个304（Not Modified）状态。Last-Modified也可用setDateHeader方法来设置 |
| Location         | 表示客户应当到哪里去提取文档。Location通常不是直接设置的，而是通过HttpServletResponse的sendRedirect方法，该方法同时设置状态代码为302 |
| Refresh          | 表示浏览器应该在多少时间之后刷新文档，以秒计。除了刷新当前文档之外，你还可以通过setHeader("Refresh", "5; URL=http://host/path")让浏览器读取指定的页面。 注意这种功能通常是通过设置HTML页面HEAD区的＜META HTTP-EQUIV="Refresh" CONTENT="5;URL=http://host/path"＞实现，这是因为，自动刷新或重定向对于那些不能使用CGI或Servlet的HTML编写者十分重要。但是，对于Servlet来说，直接设置Refresh头更加方便。  注意Refresh的意义是"N秒之后刷新本页面或访问指定页面"，而不是"每隔N秒刷新本页面或访问指定页面"。因此，连续刷新要求每次都发送一个Refresh头，而发送204状态代码则可以阻止浏览器继续刷新，不管是使用Refresh头还是＜META HTTP-EQUIV="Refresh" ...＞。  注意Refresh头不属于HTTP 1.1正式规范的一部分，而是一个扩展，但Netscape和IE都支持它 |
| Server           | 服务器名字。Servlet一般不设置这个值，而是由Web服务器自己设置 |
| Set-Cookie       | 设置和页面关联的Cookie。Servlet不应使用response.setHeader("Set-Cookie", ...)，而是应使用HttpServletResponse提供的专用方法addCookie。参见下文有关Cookie设置的讨论 |
| WWW-Authenticate | 客户应该在Authorization头中提供什么类型的授权信息？在包含401（Unauthorized）状态行的应答中这个头是必需的。例如，response.setHeader("WWW-Authenticate", "BASIC realm=＼"executives＼"")。 注意Servlet一般不进行这方面的处理，而是让Web服务器的专门机制来控制受密码保护页面的访问（例如.htaccess） |





## HTTP Tunnel

> HTTP隧道





