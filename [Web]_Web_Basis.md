[TOC]







---

# HTML



> HTML速查列表：https://www.runoob.com/html/html-quicklist.html

## 标签

网页中每一个内容在浏览器中的显示，都要存放到各种标签中



- 标签由英文尖括号<和>括起来，如\<html\>就是一个标签
- html中的标签一般都是成对出现的，分开始标签和结束标签。结束标签比开始标签多了一个/
- 标签与标签之间是可以嵌套的，但先后顺序必须保持一致
- HTML标签不区分大小写，\<h1\>和\<H1\>是一样的，但建议小写，因为大部分程序员都以小写为准

标签的用途：语义化：明白每个标签的用途。网页上的文章的标题就可以用标题标签，网页上的各个栏目的栏目名称也可以使用标题标签。文章中内容的段落就得放在段落标签中，在文章中有想强调的文本，就可以使用 em 标签表示强调等等



在HTML 4, 原来支持定义HTML元素样式的标签和属性已被弃用。这些标签将不支持新版本的HTML标签。

不建议使用的标签有: <font>, <center>, <strike>

不建议使用的属性: color 和 bgcolor.

```html
<!--注释文字 -->
```



### \<html\> \</html\> 根标签 \<head\> \<title\>

- 所有的网页标签都在<html></html>中



- 文档的头部描述了文档的各种属性和信息，包括文档的标题等。绝大多数文档头部包含的数据都不会真正作为内容显示给读者
- 标签用于定义文档的头部，它是所有头部元素的容器。头部元素有<title>、<script>、 <style>、<link>、 <meta>等标签

- 在`<title>`和`</title>`标签之间的文字内容是网页的标题信息，它会出现在浏览器的标题栏中。网页的title标签用于告诉用户和搜索引擎这个网页的主要内容是什么，搜索引擎可以通过网页标题，迅速的判断出网页的主题。每个网页的内容都是不同的，每个网页都应该有一个独一无二的title






### \<body\>

- 在网页上要展示出来的页面内容一定要放在body标签中
- <body>和</body>标签之间的内容是网页的主要内容，如<h1>、<p>、<a>、<img>等网页内容标签，在这里的标签中的内容会在浏览器中显示出来

### \<hx\>\</hx> 标题

- 标题标签一共有6个，h1、h2、h3、h4、h5、h6分别为一级标题、二级标题、三级标题、四级标题、五级标题、六级标题。并且依据重要性递减。<h1>是最高的等级
- 标题标签的样式都会加粗，h1标签字号最大，h2标签字号相对h1要小，以此类推h6标签的字号最小

### \<p\> \</p\> 段落

- <p>段落文本</p>
- 一段文字一个<p>标签，如在一篇新闻文章中有3段文字，就要把这3个段落分别放到3个<p>标签中
- <p>标签的默认样式，段前段后都会有空白，如果不喜欢这个空白，可以用css样式来删除或改变它。




### \<strong\> 和 \<em\> 

- `<em>需要强调的文本</em>`		<strong>需要强调的文本</strong> 
- `<em>` 表示强调`<strong>` 表示更强烈的强调	并且在浏览器中`<em>` 默认用斜体表示，`<strong>` 用粗体表示

### \<span\>

没有语义，它的作用就是为了设置单独的样式用的
```html
span{
	color:blue;
}
<span>XXX</span>
```

### \<q\>引用文本\</q\>

- 对简短文本的引用
- 要引用的文本不用加双引号，浏览器会对q标签自动添加双引号
- 用<q>标签的真正关键点不是它的默认样式双引号（如果这样我们不如自己在键盘上输入双引号就行了），而是它的语义：引用别人的话

### \<blockquote\> 长文本引用

- <blockquote>引用文本</blockquote>



### \<br /\> 折行标签 空格 分隔横线

- xhtml 1.0 版本的写法 
- 在需要加回车换行的地方加入`<br />`，`<br />`标签作用相当于word文档中的回车
  - xhtml1.0写法：`<br />`html4.01写法：`<br>`	
    在 html 中是忽略回车和空格的

- 一个`&nbsp`对一个空格
```html
&nbsp;
```

分隔横线

- html4.01版本 `<hr>`
- xhtml1.0版本` <hr />`
- <hr />标签和<br />标签一样也是一个空标签，所以只有一个开始标签，没有结束标签


### img图片

- \<img src="1.jpg">

```html
<img src="url" alt="some_text">
<img src="boat.gif" alt="Big Boat">
<img src="pulpit.jpg" alt="Pulpit rock" width="304" height="228">
```

指定图像的高度和宽度是一个很好的习惯。如果图像指定了高度宽度，页面加载时就会保留指定的尺寸。如果没有指定图片的大小，加载页面时有可能会破坏HTML页面的整体布局

| 标签   | 描述                       |
| :----- | :------------------------- |
| <img>  | 定义图像                   |
| <map>  | 定义图像地图               |
| <area> | 定义图像地图中的可点击区域 |

### 表格与列表

```html
<table border="1">
    <tr>
        <td>row 1, cell 1</td>
        <td>row 1, cell 2</td>
    </tr>
    <tr>
        <td>row 2, cell 1</td>
        <td>row 2, cell 2</td>
    </tr>
</table>
```

无序列表使用 `<ul>` 标签

```html
<ul>
<li>Coffee</li>
<li>Milk</li>
</ul>
```

有序列表`<ol>`

```html
<ol>
<li>Coffee</li>
<li>Milk</li>
</ol>
```

自定义列表不仅仅是一列项目，而是项目及其注释的组合。

自定义列表以 `<dl>` 标签开始。每个自定义列表项以 `<dt>` 开始。每个自定义列表项的定义以 `<dd>` 开始

```html
<dl>
<dt>Coffee</dt>
<dd>- black hot drink</dd>
<dt>Milk</dt>
<dd>- white cold drink</dd>
</dl>
```

### 区块, 内联, `<div>`

HTML 可以通过 `<div>` 和`<span>`将元素组合起来

区块元素：

- 大多数 HTML 元素被定义为**块级元素**或**内联元素**。
- 块级元素在浏览器显示时，通常会以新行来开始（和结束）。
- 实例: `<h1>, <p>, <ul>, <table>`

内联元素：

- 内联元素在显示时通常不会以新行开始。
- 实例: `<b>, <td>, <a>, <img>`



- ` <div>` 元素是块级元素，它可用于组合其他 HTML 元素的容器。
- `<div>` 元素没有特定的含义。除此之外，由于它属于块级元素，浏览器会在其前后显示折行。
- 如果与 CSS 一同使用，`<div>` 元素可用于对大的内容块设置样式属性。
- `<div> `元素的另一个常见的用途是文档布局。它取代了使用表格定义布局的老式方法。使用 `<table>` 元素进行文档布局不是表格的正确用法。`<table>` 元素的作用是显示表格化的数据



- `<span>` 元素是内联元素，可用作文本的容器
- `<span> `元素也没有特定的含义
- 当与 CSS 一同使用时，`<span>` 元素可用于为部分文本设置样式属性

### 脚本`<script>`

```html
<!DOCTYPE html>
<html>
<head> 
<meta charset="utf-8"> 
<title>菜鸟教程(runoob.com)</title> 
</head> 
<body>

<script>
document.write("Hello World!")
</script> <!--向浏览器输出"Hello World!"-->
<noscript>抱歉，你的浏览器不支持 JavaScript!</noscript>
    <!--应对不支持脚本或禁用脚本的浏览器-->

<p>不支持 JavaScript 的浏览器会使用 &lt;noscript&gt; 元素中定义的内容（文本）来替代。</p>
 
</body>
</html>
```

- `<script>` 标签用于定义客户端脚本，比如 JavaScript。
- `<script>` 元素既可包含脚本语句，也可通过 `src` 属性指向外部脚本文件。
- JavaScript 最常用于图片操作、表单验证以及内容动态更新
- `<noscript>` 标签提供无法使用脚本时的替代内容，比方在浏览器禁用脚本时，或浏览器不支持客户端脚本时。
- `<noscript>`元素可包含普通 HTML 页面的 body 元素中能够找到的所有元素。
- 只有在浏览器不支持脚本或者禁用脚本时，才会显示`<noscript>` 元素中的内容



```html
<!DOCTYPE html>
<html>
<head> 
<meta charset="utf-8"> 
<title>菜鸟教程(runoob.com)</title> 
</head>
<body>

<h1>我的第一个 JavaScript </h1>

<p id="demo">
JavaScript 可以触发事件，就像按钮点击。</p>

<script>
function myFunction()
{
	document.getElementById("demo").innerHTML="Hello JavaScript!";
}
</script>

<button type="button" onclick="myFunction()">点我</button>
<!--这个按钮点击之后，显示的内容会从 “JavaScript 可以触发事件，就像按钮点击。”变成“Hello JavaScript!”-->
</body>
</html>
```

```html
<!DOCTYPE html>
<html>
<head> 
<meta charset="utf-8"> 
<title>菜鸟教程(runoob.com)</title> 
</head>
<body>
	
<h1>我的第一段 JavaScript</h1>
<p id="demo">
JavaScript 能改变 HTML 元素的样式。
</p>
<script>
function myFunction()
{
	x=document.getElementById("demo") // 找到元素
	x.style.color="#ff0000";          // 改变样式
}
</script>
<button type="button" onclick="myFunction()">点击这里</button>
	
</body>
</html>
```



### 字符实体

- HTML 中的预留字符必须被替换为字符实体
- 一些在键盘上找不到的字符也可以使用字符实体来替换
-  使用实体名而不是数字的好处是，名称易于记忆。不过坏处是，浏览器也许并不支持所有实体名称（对实体数字的支持却很好）

> 如需显示小于号，我们必须这样写：`&lt;` 或 `&#60;` 或 `&#060;`
>
> HTML 中的常用字符实体是不间断空格(`&nbsp;`)。
>
> 浏览器总是会截短 HTML 页面中的空格。如果您在文本中写 10 个空格，在显示该页面之前，浏览器会删除它们中的 9 个。如需在页面中增加空格的数量，您需要使用 `&nbsp;` 字符实体。

- 实体名称对大小写敏感！



### URL

- 一个网页地址实例: http://www.xxx.com/html/html-tutorial.html 语法规则:
- **scheme://host.domain:port/path/filename**

- scheme - 定义因特网服务的类型。最常见的类型是 http
- host - 定义域主机（http 的默认主机是 www）
- domain - 定义因特网域名，比如 runoob.com
- :port - 定义主机上的端口号（http 的默认端口号是 80）
- path - 定义服务器上的路径（如果省略，则文档必须位于网站的根目录中）。
- filename - 定义文档/资源的名称



- URL 只能使用 [ASCII 字符集](https://www.runoob.com/tags/html-ascii.html). 通过因特网进行发送。
- 由于 URL 常常会包含 ASCII 集合之外的字符，URL 必须转换为有效的 ASCII 格式。
- URL 编码使用 "%" 其后跟随两位的十六进制数来替换非 ASCII 字符。
- URL 不能包含空格。URL 编码通常使用 + 来替换空格。

> URL编码参考手册：https://www.runoob.com/tags/html-urlencode.html

---

# CSS

W3C标准是由万维网联盟制定的一系列标准，包括：

1. 结构化标准语言（HTML和XML）
2. 表现标准语言（CSS）
3. 行为标准语言（DOM和ECMAScript）
4. W3C倡导结构，样式，行为分离。



CSS 是在 HTML 4 开始使用的,是为了更好的渲染HTML元素而引入的.

CSS 可以通过以下方式添加到HTML中:

- 内联样式- 在HTML元素中使用"style" **属性**
- 内部样式表 -在HTML文档头部 <head> 区域使用<style> **元素** 来包含CSS
- 外部引用 - 使用外部 CSS **文件** (最佳方式)



## 定位机制 



### 标准文档流Normal flow

【特点】		从上到下，从左到右，输出文档内容	由块级元素和行级元素组成
【块级元素】	从左到右撑满页面，独占一行，触碰到页面边缘时，自动换行	//div ul li dl dt p
【行级元素】	能在同一行内显示，不会改变HTML文档结构	//span strong img input//大部分表单标签都是行级标签
【盒子模型】	网页布局的基石	块级元素和行级元素都是盒子模型

### 盒子模型

【边框】		border	
【外边距】	margin	
【内边距】	padding	
【内容】		content	



### 浮动Floats





**绝对定位** Absolute positioning

