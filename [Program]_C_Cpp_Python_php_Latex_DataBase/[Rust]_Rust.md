

# Rust





# Build

```bash
cd ./greeting 
cargo build 
cargo run 
```

# Comment 注释

```rust
/// Adds one to the number given.
///
/// # Examples
///
/// ```
/// let x = add(1, 2);
///
/// ```

fn add(a: i32, b: i32) -> i32 {
    return a + b;
}
   
fn main() {
    println!("{}",add(2,3)); // 在add函数处可以看到优雅的注释，貌似是markdown语法的
}
```

> Cargo 具有 cargo doc 功能，开发者可以通过这个命令将工程中的说明注释转换成 HTML 格式的说明文档



# Variable

- Rust 是**强类型语言**，但具有**自动判断变量类型**的能力
- 如果要声明变量，需要使用`let`关键字

```rust
/*
教程摘抄自 runnoob.com Rust教程 后续会进行丰富
*/
let a = 123; // 此时a被确定为整型数字，且不是可变变量。是不可变变量
let a: u64 = 123; // 声明了 a 为无符号 64 位整型变量；否则a将自动被判断为有符号 32 位整型变量
// a = "abc"; // Forbidden: 不能把字符串类型的值赋给a
// a = 4.56; // Forbidden: 自动转换数字精度有损失，Rust 不允许精度有损失的自动数据类型转换
// a = 456; // Forbidden: a 不是个可变变量
let a = 456; // valid: 不可变变量的值可以重影Shadowing。但在重影以前不能私自被改变
```

- Rust 为了高并发安全而做的设计：在语言层面尽量少的让变量的值可以改变
- 使变量变得"可变"（mutable）只需一个 mut 关键字

```rust
let mut a = 123; // mutable variable
a = 456;
```

```rust
const a: i32 = 123; // 如果a是常量； i32: 有符号 32 位整型变量
let a = 456; // invalid: 常量不可以像不可变变量一样重影
```



## 重影 Shadowing

- 指变量的名称可以被重新使用的机制

```rust
fn main() {
    let x = 5; 
    let x = x + 1; // Shadowing
    let x = x * 2; // Shadowing
    println!("The value of x is: {}", x); // The value of x is: 12
}
```

- 重影与可变变量的赋值不是一个概念，重影是指用同一个名字重新代表另一个变量实体，其类型、可变属性和值都可以变化。但可变变量赋值仅能发生值的变化。

```rust
let mut s = "123"; // 可变变量的类型不可以变化
// s = s.len(); // error: 不能给字符串变量赋整型值。此处尝试对可变变量的类型进行变化了
```



# Data Type

整数型Interger

| Bit Len | signed | unsigned |
| ------- | ------ | -------- |
| 8-bit   | i8     | u8       |
| 16-bit  | i16    | u16      |
| 32-bit  | i32    | u32      |
| 64-bit  | i64    | u64      |
| 128-bit | i128   | u128     |
| arch    | isize  | usize    |

> isize 和 usize 两种整数类型是用来衡量数据大小的，它们的位长度取决于所运行的目标平台，如果是 32 位架构的处理器将使用 32 位位长度整型

表述方法:

| 进制                 | example      |
| :------------------- | :----------- |
| 十进制               | 98\_222      |
| 十六进制             | 0xff         |
| 八进制               | 0o77         |
| 二进制               | 0b1111\_0000 |
| 字节(只能表示 u8 型) | b'A'         |

> 整数中间的下划线可以更容易判断数字的值大概是多少

浮点数

```rust
fn main() {
    let x = 2.0; // f64 默认为 64 位浮点数。因为现代计算机处理器对两种浮点数计算的速度几乎相同，但 64 位浮点数精度更高
    let y: f32 = 3.0; // f32
}
```

> Rust 不支持 **++** 和 **--**，因为这两个运算符出现在变量的前后会影响代码可读性，减弱了开发者对变量改变的意识能力

- 布尔型用 bool 表示，值只能为 true 或 false
- 字符型用 char 表示
- Rust的 char 类型大小为 4 个字节，代表 Unicode标量值，这意味着它可以支持中文，日文和韩文字符等非英文字符甚至表情符号和零宽度空格在 Rust 中都是有效的 char 值。



## 元组 tup

- 元组用一对 **( )** 包括的一组数据，可以包含不同种类的数据

```rust
let tup: (i32, f64, u8) = (500, 6.4, 1);
// tup.0 等于 500
// tup.1 等于 6.4
// tup.2 等于 1
let (x, y, z) = tup;
// y 等于 6.4
```

## 数组

```rust
let a = [1, 2, 3, 4, 5]; // a 是一个长度为 5 的整型数组，不可变
a[0] = 123; // error: 数组 a 不可变

let b = ["January", "February", "March"]; // b 是一个长度为 3 的字符串数组

let c: [i32; 5] = [1, 2, 3, 4, 5]; // c 是一个长度为 5 的 i32 数组(不可变)

let d = [3; 5]; // 等同于 let d = [3, 3, 3, 3, 3];

let first = a[0]; // 数组访问
let second = a[1]; // 数组访问

let mut a = [1, 2, 3]; // 可变数组
a[0] = 4; // 正确
let mut seed : [u8; 32] = [0; 32]; // seed 是一个长度为 32 的 u8 可变数组, 32 个 0
```



# Function

- `fn <函数名> ( <参数> ) <函数体>`
- Rust不在乎函数定义位置，定义了即可

```rust
fn main() {
    another_function(5, 6);// 虽然在后面定义，但仍可调用
}
// Rust 函数名称的命名风格是小写字母以下划线分割
fn another_function(x: i32, y: i32) { // 参数必须声明参数名称和类型
    println!("x value : {}", x);
    println!("y value : {}", y);
} // 由于没有声明函数返回值的类型，函数将被认为是"纯过程"，不允许产生返回值。return 后面不能有返回值表达式或没有 return
```

Rust 函数体由一系列可以以表达式（Expression）结尾的语句（Statement）组成

- 语句是执行某些操作且没有返回值的步骤

```rust
let a = 6; // 语句 Statement 
// let a = (let b = 2); // error 这个步骤没有返回值
```

表达式有计算步骤且有返回值。以下是表达式（假设出现的标识符已经被定义）：

```rust
a = 7  // 表达式 Expression: 有计算步骤且有返回值
b + 2 // 表达式 Expression
c * (a + b) // 表达式 Expression
```
- 可以在一个用 {} 包括的块里编写一个较为复杂的表达式
```rust
fn main() {
    let x = 5;

    let y = {    // 表达式块 // y的值是整个表达式块所代表的值，即 3+1=4
        let x = 3; // 在块中可以使用函数语句 // 这里不会Shadowing掉外面的x
        x + 1 // 最后一个步骤是表达式，这里不能有分号 否则将变成一条语句
    };
    println!("x value : {}", x); // 5
    println!("y value : {}", y); // 4
}
```

- 函数定义可以嵌套

```rust
fn main() {
    fn five() -> i32 { // 声明函数返回值的类型为i32
        5
    }
    println!("five() 的值为: {}", five());
}
```





# Conditional Statement 条件语句

```rust
fn main() {
    let a = 12;
    let b;
    if a > 0 { // 需要用小括号包括 // 但是也可以用()
        b = 1; // 不存在单语句不用加 {} 的规则 不允许使用一个语句代替一个块
    }  
    else if a < 0 { // Rust 中的条件表达式必须是 bool 类型
        b = -1;
    }  
    else {
        b = 0;
    }
}
```

```rust
fn main() {  // ERROR demo
    let number = 3; 
    if number {   // error，expected `bool`, found integerrustc(E0308)
        println!("Yes");
    }
}
```

- 实现类似三元条件运算表达式：`let number = if a > 0 { 1 } else { -1 };`



# Loop 循环

- while循环

```rust
fn main() {
    let mut number = 1;
    while number != 4 {
        println!("{}", number);
        number += 1;
    }
    println!("EXIT");
}
// 1    2    3    EXIT
```

- Rust暂无for三元语句的循环控制，但可用上例实现方式替代



- for 循环是最常用的循环结构，常用来遍历一个线性数据据结构（比如数组）

```rust
fn main() {
    let a = [10, 20, 30, 40, 50];
    for i in a.iter() { // a.iter() 代表 a 的迭代器 iterator
        println!("value : {}", i);
    }
}
```

```rust
fn main() { // same as the precedent
let a = [10, 20, 30, 40, 50];
    for i in 0..5 { // 通过下标访问 将访问 0 1 2 3 4 
        println!("a[{}] = {}", i, a[i]);
    }
}
```



## loop 无限循环

- Rust 语言有原生的无限循环结构 loop

```rust
fn main() {
    let s = ['R', 'U', 'N', 'O', 'O', 'B'];
    let mut i = 0;
    loop {
        let ch = s[i];
        if ch == 'O' {
            break; // 跳出循环 这里的break不带返回值
        }
        println!("\'{}\'", ch);
        i += 1;
    }
}
```

```rust
fn main() {
    let s = ['R', 'U', 'N', 'O', 'O', 'B'];
    let mut i = 0;
    let location = loop {  // location用于接收loop的返回值
        let ch = s[i];
        if ch == 'O' {
            break i; // 跳出循环并返回i
        }
        i += 1;
    };
    println!(" \'O\' index= {}", location); // 'O' index= 3
}
```



# Ownership 所有权

- https://www.runoob.com/rust/rust-ownership.html



# Slice 切片类型

- 切片（Slice）是对数据值的部分引用

```rust
fn main() { // 字符串切片（String Slice）
    let s = String::from("broadcast");
    let part1 = &s[0..5];
    let part2 = &s[5..9];

    println!("{}={}+{}", s, part1, part2);
} // broadcast=broad+cast
```



# Struct 结构体

Rust 中的结构体（Struct）与元组（Tuple）都可以将若干个类型不一定相同的数据捆绑在一起形成整体，但结构体的每个成员和其本身都有一个名字，这样访问它成员的时候就不用记住下标了。元组常用于非定义的多值传递，而结构体用于规范常用的数据结构。结构体的每个成员叫做"字段"。

```rust
struct Site { // 定义结构体 // struct 语句仅用来定义，不能声明实例
    domain: String, // 每个字段定义之后用 , 分隔
    name: String, // 字段名字为name，类型为String
    nation: String,
    found: u32
} // 结尾不需要 ; 符号
```

```rust
// 结构体实例
let foo = Site {
    domain: String::from("www.foo.com"),
    name: String::from("foo"),
    nation: String::from("China"),
    found: 2013
};
```

```rust
// 如果正在实例化的结构体有字段名称和现存变量名称一样的，可以简化书写
let domain = String::from("www.foo.com");
let name = String::from("foo");
let foo = Site {
    domain,  // 等同于 domain : domain,
    name,    // 等同于 name : name,
    nation: String::from("China"),
    traffic: 2013
};
```
- 有这样一种情况：你想要新建一个结构体的实例，其中大部分属性需要被设置成与现存的一个结构体属性一样，仅需更改其中的一两个字段的值，可以使用结构体更新语法

```rust
let site = Site {
    domain: String::from("www.foo1.com"),
    name: String::from("foo1"),
    ..foo // ..foo 后面不可以有逗号。这种语法不允许一成不变的复制另一个结构体实例，即至少重新设定一个字段的值才能引用其他实例的值
};
```



## 元组结构体

- 元组结构体是一种形式是元组的结构体
- 与元组的区别是它有名字和固定的类型格式。它存在的意义是为了处理那些需要定义类型（经常使用）又不想太复杂的简单数据：

```rust
fn main() {
    struct Color(u8, u8, u8); // 元组结构体
    struct Point(f64, f64);

    let black = Color(0, 0, 0);
    let origin = Point(0.0, 0.0);
	// 元组结构体对象的使用方式和元组一样，通过 . 和下标来进行访问
    println!("black = ({}, {}, {})", black.0, black.1, black.2);
    println!("origin = ({}, {})", origin.0, origin.1);
}

```



## 结构体方法 Method

> "结构体方法"不叫"结构体函数"是因为"函数"这个名字留给了在 impl 块中却没有 &self 参数的函数

- 方法（Method）和函数（Function）类似，只不过它是用来操作结构体实例的。
- 结构体方法的第一个参数必须是 &self，不需声明类型，因为 self 不是一种风格而是关键字

```rust
struct Rectangle { // 定义结构体 
    width: u32,
    height: u32,
}

impl Rectangle { // 结构体 impl 块可以写几次，效果相当于它们内容的拼接
    fn area(&self) -> u32 { // 定义结构体 Rectangle 的 method : area
        self.width * self.height
    }

    fn wider(&self, rect: &Rectangle) -> bool { // 计算是否比 rect 宽
        self.width > rect.width
    }
}

fn main() {
    let rect1 = Rectangle { width: 30, height: 50 };
    let rect2 = Rectangle { width: 40, height: 20 };
    println!("rect1's area is {}", rect1.area()); // 在调用结构体方法的时候不需要填写 self ，这是出于对使用方便性的考虑
    println!("{}", rect1.wider(&rect2)); // false
}
```



## 结构体关联函数

- 在 impl 块中却没有 &self 参数
- 不依赖实例，但是使用它需要声明是在哪个 impl 块中的
- `String::from` 就是一个"关联函数"

```rust
#[derive(Debug)]
struct Rectangle { // 定义结构体 
    width: u32,
    height: u32,
}

impl Rectangle {
    // 结构体关联函数
    fn create(width: u32, height: u32) -> Rectangle { // 没有 &self 参数
        Rectangle { width, height }
    }
}

fn main() {
    let rect = Rectangle::create(30, 50);
    println!("{:?}", rect);
}
```



## Unit Struct 单元结构体

结构体可以只作为一种象征而无需任何成员，称这种没有身体的结构体为单元结构体（Unit Struct）

```rust
struct UnitStruct;
```

