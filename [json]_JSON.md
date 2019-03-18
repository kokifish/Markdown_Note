[TOC]



# JSON简介

-   JSON(JavaScript Object Notation, JS 对象标记) 是一种轻量级的数据交换格式。它基于ECMAScript (w3c制定的js规范)的一个子集，采用完全独立于编程语言的文本格式来存储和表示数据
-   简洁和清晰的层次结构，是理想的数据交换语言。易于人阅读和编写，同时也易于机器解析和生成，有效地提升网络传输效率



**在 JS 语言中，一切都是对象**。因此，任何支持的类型都可以通过 JSON 来表示，例如字符串、数字、对象、数组等。但是对象和数组是比较特殊且常用的两种类型



### 语法

-   JSON 键值对是用来保存 JS 对象的一种方式，和 JS 对象的写法也大同小异，键/值对组合中的键名写在前面并用双引号 "" 包裹，使用冒号 : 分隔，然后紧接着值：

```json
{"firstName": "John"}
```

```json
{//JSON 表示数组的方式
  
"people":[

{
"firstName": "Brett",
"lastName":"McLaughlin"    
},
{       
"firstName":"Jason",
"lastName":"Hunter"
}
  
]
  
}
```

