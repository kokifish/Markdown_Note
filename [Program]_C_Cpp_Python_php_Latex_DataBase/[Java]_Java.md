[TOC]

# Java

- 简单：不使用指针、操作符重载、多继承、自动强制类型转换。提供自动分配和回收内存空间
- 面向对象：类、接口、继承。类仅支持单继承，但支持接口之间的多继承。全面支持动态绑定，而C++仅支持虚函数使用动态绑定
- 分布式：网络应用编程接口java net。Java 的 RMI（远程方法激活）
- 健壮：强类型机制，异常处理，垃圾的自动收集
- 安全：ava 对通过网络下载的类具有一个安全防范机制（类 ClassLoader）。安全管理机制（类 SecurityManager）
- 体系结构中立：在 Java 平台上被编译为体系结构中立的字节码格式（.class 的文件），然后可在实现这个 Java 平台的任何系统中运行
- 可移植性：源于体系结构中立性。严格规定各个基本数据类型的长度。java编译器用java实现？？java运行环境用ANSI C实现
- 解释型：java平台中的java解释器对这些字节码解释执行，执行过程中需要的类在链接阶段载入运行环境
- 高性能：随JIT编译器技术发展越来越接近C++
- 多线程：Java 支持多线程同时执行，提供多线程同步机制（synchronized）
- 动态：java需要的类能够动态地载入运行环境，也可通过网络载入所需要的类。java中类有一个运行时刻的表示，能进行运行时刻的类型检查







- java开发工具包JDK: https://www.oracle.com/java/technologies/downloads/



```java
String var = "hex";
boolean result = var instanceof String; // var 是 String 类型，返回 true
```







## Class and Object

- 声明：名称、对象类型等
- 实例化：`new`关键词创建对象
- 初始化：创建对象时调用其中一个构造方法初始化对象

```java
public class Puppy { // 一个源文件只能有一个public类，且与文件名相同 Puppy.java
    int puppyAge;

    public Puppy(String name) {
        // 这个构造器仅有一个参数：name
        System.out.println("小狗的名字是 : " + name);
    }

    public void setAge(int age) {
        puppyAge = age;
    }

    public int getAge() {
        System.out.println("小狗的年龄为 : " + puppyAge);
        return puppyAge;
    }

    public static void main(String[] args) {
        Puppy myPuppy = new Puppy("tommy");//创建对象
        myPuppy.setAge(2); // 通过方法来设定age
        myPuppy.getAge(); // 调用另一个方法获取age
        System.out.println("变量值 : " + myPuppy.puppyAge); // 访问成员变量
    }
}
```

- 源文件(.java)只能有一个public class，且与文件名相同。可以有多个非public class
- 如果类定义在某个包中，package语句应该在源文件首行
- import 语句在package语句后(若有)，class定义前





```java
import java.io.*; //  载入 java_installation/java/io 路径下的所有类
```





## Basic Data Type

Java 的两大数据类型:

- 内置数据类型
- 引用数据类型：类似于C++的指针，指向对象的变量时引用变量

| Type    | Byte | Default  |                                                              |
| ------- | ---- | -------- | ------------------------------------------------------------ |
| byte    | 1    | 0        | signed, [-128, 127]                                          |
| short   | 2    | 0        | signed, [-32768(-2^15^), 32767(2^15^ - 1)]                   |
| int     | 4    | 0        | signed, [-2,147,483,648(-2^31^)2,147,483,647(2^31^ - 1)]     |
| long    | 8    | 0L       | signed, [-9,223,372,036,854,775,808(-2^63^), 9,223,372,036,854,775,807(2^63 -1)] |
| float   | 4    | 0.0f     | 单精度IEEE 754标准的浮点数                                   |
| double  | 8    | 0.0d     | 双精度IEEE 754 标准的浮点数                                  |
| boolean |      | false    | true/false                                                   |
| char    | 2    | `\u0000` | 16bit Unicode Char, `\u0000 ~ \uffff`                        |
局部变量不会给默认值，需要手动初始化

> **自动类型转换**`byte,short,char—> int —> long—> float —> double `
>
> 不能对`boolean`类型进行类型转换
>
> 不能把对象类型转换成不相关类的对象
>
> 在把容量大的类型转换为容量小的类型时必须使用强制类型转换，可能导致溢出/精度损失
>
> 浮点数到整数的转换是**舍弃小数**，不是四舍五入
>
> 整数的默认类型是 int
>
> 小数默认是 double 类型浮点型，在定义 float 类型时必须在数字后面跟上 F 或者 f

```java
// 输出某种类型的SIZE(bit) 最小 最大值 
// 输出时使用：Byte, Short, Integer, Long, Float, Double, Character
System.out.println("Int类型: " + Integer.SIZE + "," + Integer.MIN_VALUE + "," + Integer.MAX_VALUE);
System.out.println("Character: " + Character.SIZE + "," + (int)Character.MIN_VALUE + "," + (int)Character.MAX_VALUE); // 强制转换为int，否则输出Unicode
```

> 还有一种基本类型Void(`java.lang.Void`)，但无法直接操作

引用类型：

- 对象、数组...
- 默认值为null







### Constants

常量运行时不可修改，使用`final`关键词修饰常量

```java
final double PI = 3.1415927;
String s = "Hello World"; //字符串常量是包含在两个引号之间的字符序列
final String final_s = "Hello World"; // final_s是个常量
// 字符串常量和字符常量都可以包含任何Unicode字符
char a = '\u0001';
String a = "\u0001";
```

```java
int decimal = 100; // 10进制
int octal = 0144; // 8进制
int hexa =  0x64; // 16进制
```

### Escape Character

| Char     | Description              |
| :------- | :----------------------- |
| `\n`     | 换行 (0x0a)              |
| `\r`     | 回车 (0x0d)              |
| `\f`     | 换页符(0x0c)             |
| `\b`     | 退格 (0x08)              |
| `\0`     | 空字符 (0x0)             |
| `\s`     | 空格 (0x20)              |
| `\t`     | 制表符                   |
| `\"`     | 双引号                   |
| `\'`     | 单引号                   |
| `\\`     | 反斜杠                   |
| `\ddd`   | 八进制字符 (ddd)         |
| `\uxxxx` | 16进制Unicode字符 (xxxx) |



## Array and `class Arrays`



```java
double[] myList; // 推荐方法
double notRecommend[]; // 不推荐
```

```java
int size = 10;
double[] myList = new double[size];
myList[9] = 16;
double[] List2 = {1.1, 2.2, 3.3};

for (double element: List2) { // For-Each 循环 (加强型循环)
	System.out.println(element);
}
```

For-Each Loop: JDK 1.5 引进 For-Each 循环 (加强型循环)，能不使用下标遍历数组

```java
// 数组：函数参数，函数返回值
public static int[] reverse(int[] list) {
  int[] result = new int[list.length];
 
  for (int i = 0, j = result.length - 1; i < list.length; i++, j--) {
    result[j] = list[i];
  }
  return result;
}
```



多维数组：

```java
int[][] a = new int[2][3]; // 一次性确定两个维度上的长度

String[][] s = new String[2][]; // 先确定最高维
s[0] = new String[2];
s[1] = new String[3];
s[0][0] = new String("Good");
```



`java.util.Arrays` 类能方便地操作数组，它提供的所有方法都是静态的



## Variable Type

- 局部变量：类的方法、构造方法、语句块中的变量。栈上分配，没有默认值，执行完后销毁
- 实例变量：独立于方法之外的变量，没有 static 修饰。
- 类变量：独立于方法之外的变量，用 static 修饰



### Instance Var and Class Var

实例变量：

- 对象实例化后确定值，生命周期与对象的寿命周期相同
- 具有默认值
- 可以通过变量名访问，但在静态方法以及其他类中应使用完全限定名：`OjjectRef.VarName`
- 至少被一个方法、构造方法或者语句块引用
- 实例变量可以生命在使用前或使用后
- 访问修饰符可以修饰实例变量，对类中方法、构造方法、语句块可见



类变量：又称静态变量，在类中以`static`关键字声明，必须在方法之外

- 同一个类的所有对象共享同一份类变量
- 静态变量可以通过：`ClassName.VarName` 访问，也可以像实例变量一样`Obj.VarName`



```java
public class Fish {
    public String name;  // public instance var: 对子类可见
    private String wife; // private instance var: 仅在该类可见
    private static long fish_conut;
    public static final String BELONGTO = "animals"; // 类常量

    public Fish(String name) {
        fish_conut += 1;
        this.name = name; // 与C++一致，重名时用this访问实例变量（但不是用->），否则可以省略this.
    }

    public void setWife(String name) { // 被声明为 public 的类、方法、构造方法和接口能够被任何其他类访问
        if(this.name == "hex-16"){
            String valid_wife = "sherry";
            if (name == valid_wife) {
                wife = name;
            } else {
                wife = null;
            }
        }
        else{
            wife = name;
        }
    }

    public String getWife() { // 外被类只能通过public方法访问声明为private的方法、变量、构造方法
        String valid_wife = "sherry";
        return wife;
    }
    public long getFishConut() { // 外被类只能通过public方法访问声明为private的方法、变量、构造方法
        return fish_conut;
    }

    public static void main(String[] args) { // main()方法必须为public，否则，Java 解释器将不能运行该类
        Fish fish_a = new Fish("hex-16");
        System.out.println("name:" + fish_a.name);
        System.out.println("wife:" + fish_a.getWife());
        fish_a.setWife("sherry");
        System.out.println("wife:" + fish_a.getWife() + "," + fish_a.wife); // main在class中，可直接访问private instance var
        System.out.println("public static final:" + Fish.BELONGTO + "," + fish_a.BELONGTO + "," + BELONGTO);
        System.out.println("fish count:" + fish_a.fish_conut);
    }
}
```

```java

public class FishTest {
    public static void main(String[] args) {
        Fish fish_a = new Fish("hex-16");
        System.out.println("name:" + fish_a.name);
        System.out.println("wife:" + fish_a.getWife());
        fish_a.setWife("sherry");
        System.out.println("wife:" + fish_a.getWife()); // main在class中，可直接访问private instance var
        System.out.println("public static final:" + Fish.BELONGTO + "," + fish_a.BELONGTO);
        System.out.println("private static long:" + fish_a.getFishConut()); // 只能通过getter方法获取 private的
    }
}

```





## Modifiers:public, private, final...

主要分两类修饰符：

- 访问修饰符
- 非访问修饰符



| Access Modifiers  | 当前类 | 同一包内 | 子孙类(同一包) | 子孙类(不同包)                                               | 其他包 |
| :---------------- | :----- | :------- | :------------- | :----------------------------------------------------------- | :----- |
| `public`(default) | Y      | Y        | Y              | Y                                                            | Y      |
| `protected`       | Y      | Y        | Y              | Y/N（[说明](https://www.runoob.com/java/java-modifier-types.html#protected-desc)） | N      |
| `default`         | Y      | Y        | Y              | N                                                            | N      |
| `private`         | Y      | N        | N              | N                                                            | N      |



## Loop and Condition

> 循环与条件语句，条件语句与C++（几乎？）一致，省略，switch case也貌似一致

```java
for(int x = 10; x < 20; x = x+1) {
	// some sentances
}
while(...); {
    // ...
}
do{
    // ...
} while(...);
```

- java 5引入：

```java
public class Test {
   public static void main(String[] args){
      int [] numbers = {10, 20, 30, 40, 50};
 
      for(int x : numbers ){
         System.out.print( x );
         System.out.print(",");
      }
      System.out.print("\n");
      String [] names ={"James", "Larry", "Tom", "Lacy"};
      for( String name : names ) {
         System.out.print( name );
         System.out.print(",");
      }
   }
}
```

- **break**: 用于跳出循环或switch的最里层
- **continue**: 跳转到下一次循环迭代



## Class: Number & Math

Java 为每一个内置数据类型提供了对应的包装类

| 包装类    | 基本数据类型 |
| :-------- | :----------- |
| Boolean   | boolean      |
| Byte      | byte         |
| Short     | short        |
| Integer   | int          |
| Long      | long         |
| Character | char         |
| Float     | float        |
| Double    | double       |

- 装箱：当内置数据类型被当作对象使用的时候，编译器会把内置类型装箱为包装类
- 拆箱：进行如加减运算时，需要对包装类拆箱为基本数据类型再进行计算




|Function	| Description |
| :-------- | :----------- |
|xxxValue()|将 Number 对象转换为xxx数据类型的值并返回|
|compareTo()|将number对象与参数比较|
|equals()|判断number对象是否与参数相等|
|valueOf()|返回一个 Number 对象指定的**内置数据类型**|
|toString()|以字符串形式返回值|
|parseInt()|将字符串解析为int类型|
|abs()|返回参数的绝对值|
|ceil()|返回大于等于( >= )给定参数的的最小整数，类型为双精度浮点型|
|floor()|返回小于等于（<=）给定参数的最大整数|
|rint()|返回与参数最接近的整数。返回类型为double|
|round()|四舍五入`Math.floor(x+0.5)`，`Math.round(11.5)` =12，`Math.round(-11.5)` = -11|
|min()|两个参数中的最小值|
|max()|两个参数中的最大值|
|exp()|自然数底数e的参数次方|
|log()|参数的自然数底数的对数值|
|pow()|第一个参数的第二个参数次方|
|sqrt()|算术平方根|
|sin()|正弦值|
|cos()|余弦值|
|tan()|正切值|
|asin()|反正弦值|
|acos()|反余弦值|
|atan()|反正切值|
|atan2()|将笛卡尔坐标转换为极坐标，并返回极坐标的角度值|
|toDegrees()|将参数转化为角度|
|toRadians()|将角度转换为弧度|
|random()|返回一个随机数|



## Class: Character, String, StringBuffer





当对字符串进行修改的时候，需要使用 StringBuffer 和 StringBuilder 类







## Method





### Varargs: Variable Arguments

> 可变参数，variable number of arguments，Variable arguments. JDK1.5开始

在方法声明中，在指定参数类型后加一个省略号(...) 

只能指定一个可变参数，必须是方法的最后一个参数

```java
public class VarargsDemo {
    public static void main(String args[]) {
        // 调用可变参数的方法
        f(34, 3, 3, 2, 56.5);
        f(new double[]{1, 2, 3});
    }
 
    public static void f( double... numbers) {
        if (numbers.length == 0) {
            System.out.println("No argument passed");
            return;
        }
    }
}
```



### `finalize()`

- 在对象被垃圾收集器析构（回收）前调用，用来清除回收对象









## Exception

所有的异常类是从 `java.lang.Exception` 类继承的子类

Exception 类是 Throwable 类的子类。除了Exception类外，Throwable还有一个子类Error 

Error 用来指示运行时环境发生的错误: 如JVM内存溢出，程序不会从错误中恢复

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/java_exception_hierarchy.png)

```java
import java.io.*;// file name: ExcepTest.java

public class Test {
    public static void main(String args[]) {
        try {
            int a[] = new int[2];
            System.out.println("Access element three :" + a[3]);
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Exception thrown:" + e);
        } catch (ArithmeticException e2) {
            // 这也是个内置异常类 表示运算异常，如除以零错误
        } finally {
            // ...
        }
    }
}
```

finally 代码块出现在 catch 代码块最后。无论是否发生异常，`finally` 代码块中的代码总会被执行



# Java: OOP

Java 面向对象 **Object-oriented programming**

## Inheritance

继承：用`extends`or `implements`实现继承，所有类继承于`java.lang.Object`，如果类声明不含`extends`or `implements`则继承`Object`

`super`: 用于访问当前对象的父类成员。指向父类的引用

`this`: 指向自己的引用

`final`: 可以把类定义为不能继承的，即最终类。修饰方法时，该方法不能被子类重写

```java
final class ClassName {...} // final 类
(public/private/default/protected) final void function(){...} // final 方法
```

> 被声明为 final 类的方法自动地声明为 final，但是实例变量并不是 final

### extends and implements

extends: `extends`后是父类，只能有一个（仅支持单继承）







implements: `implements`后可以跟多个接口，变相的使java具有多继承特性，可以同时继承多个接口

```java
public interface A { // 接口
    public void eat();
    public void sleep();
}

public interface B { // 接口
    public void show();
}

public class C implements A,B { // C 这个类就有接口 A, B 的所有接口了
}
```



### Constructor

子类不继承父类构造器（构造方法/构造函数），隐式或显式调用父类构造器。`super(args)`注意参数对应

如果父类构造函数没有参数，子类可以不显式调用父类构造函数，会隐式调用父类无参构造函数





## Overriding

> 父类与子类之间多态性表现

重写(Override): 子类对父类允许访问的方法的实现进行重新编写，返回值、形参不变。不能抛出新异常或比父类异常更宽泛的异常。

- 返回类型与被重写方法的返回类型可以不相同，但是必须是父类返回值的派生类（java5 及更早版本返回类型要一样，java7 及更高版本可以不同）
-  final 方法不能被重写
- static 方法不能被重写，但是能够被再次声明
- Constructor 不能被重写
- 子类和父类在同一个包中：子类可以重写父类所有方法，除了声明为 private 和 final 的方法
- 子类和父类**不在**同一个包：子类只能够重写父类的声明为 public 和 protected 的非 final 方法



## Overloading

> 一个类的多态性表现

重载(Overload): 在同一个类里面，方法或构造方法名字相同，参数不同，返回类型可以不同



## Virtual Function

Java其实没有虚函数的概念，普通函数就相当于C++的虚函数，动态绑定是Java的默认行为，如果不想某个函数有虚函数特性，用`final`变成非虚函数



## Abstract Class & Method

抽象类不能被实例化，不一定包含抽象方法

```java
public abstract class Animal { // 抽象类，不可被实例化
   private String name;
   
   public abstract double eat(); // 抽象方法，具体实现由子类确定，后跟分号，没有花括号
   // ...
}
```

- 包含抽象方法的类必须是抽象类
- 子类须重写父类所有抽象方法，否则声明自身为抽象类
- 构造方法，类方法（用 static 修饰的方法）不能声明为抽象方法





封装(**Encapsulation**): 将抽象接口的实现部分包装、隐藏起来的方法。防止该类的代码和数据被外部类访问



## Interface

接口Interface：一个抽象类型，是抽象方法的集合，通常以`interface`来声明，类通过继承接口的方式继承接口的抽象方法

接口不是类，属于不同概念。类描述对象的属性和方法。接口包含类要实现的方法。

除非实现接口的类是抽象类，否则该类要定义接口中的所有方法。







类不允许多继承，接口允许多继承

```java
public interface Hockey extends Sports, Event
```



## Package

- 把功能相似的类或接口组织在同一个包中方便查找和使用
- 树形目录，同一个包中的Class名不同，不同包中的Class名可以相同，调用两个不同包的同名类时，加上包名以区分
- 包有访问权限，拥有包访问权限的类才能访问某个包中的类

```java
package net.java.util; // package pkg1[．pkg2[．pkg3…]]; // 保存路径：net/java/util/Something.java
public class Something{
   ...
}
```

包声明应该在源文件的第一行，每个源文件只能有一个包声明





### import

import 语句应位于 package 语句之后，所有类的定义之前，可以没有，也可以有多条



```java
import animal.*; // 通配符，引入所有 类似于python
import animal.Cat; // 引入 animal package 里面的 Cat 类
```

类目录的绝对路径叫做 **class path**。设置在系统变量 **CLASSPATH** 中。编译器和 java 虚拟机通过将 package 名字加到 class path 后来构造 .class 文件的路径





# Java: call python

```java
String[] arguments = new String[]{"python", "D:\\path\\DES.py", arg0, arg1};
try {
	Process process = Runtime.getRuntime().exec(arguments);
	BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
	String tmp = null;
	while ((tmp_last_block = in.readLine()) != null) {
		System.out.println("tmp:" + tmp);
    }
	in.close();
	int re = process.waitFor();
} catch (Exception e) {
	e.printStackTrace();
}
```

