[TOC]











---



# 关系模型

关系数据库由**表 table**的集合构成，每个表有唯一的名字

- 关系 relation: 指代表，元组的集合
- 元组 tuple: 指代行
- 属性 attribute: 指代列
- 关系模式 relation schema: 对应于程序设计语言中类型定义的概念
- 关系实例 relation instance: 一个关系的特定实例，也就是所包含的一组特定的行

关系是元组集合，所以元组在关系中出现的顺序是无关紧要的

- 域 domain: 关系的每一个属性，都存在一个允许取值的集合，称为该属性的域
- 域的原子性 atomic: 如果域中元素被看作是不可再分的单元，则域是原子的。若instructor(教师)关系中有一个属性存放教师号码，则号码域不是原子的，因为存放的是一组电话号码
- 空值 null: 表示值不存在或未知，是一个特殊的值





- 数据库模式 Database Schema: 数据库的逻辑设计
- 数据库实例 Database Instance: 给定时刻数据库中数据的一个快照

## 码 键 key

码是整个关系的一种性质，而不是单个元组的性质，关系中任意两个不同的元组都不能在码属性上具有相同的值

- 超码 **super key**: 可以在一个关系中唯一地标识一个元组的一个或多个属性的集合
- 候选码 **candidate key**: 最小超码，candidate key是任意子集都不能成为super key的super key
- 主码 **primary key:** 代表被数据库设计者选中的、主要用来在一个关系中区分不同元组的候选码



- 外码 **foreign key**: 一个关系a的属性中包括另一个关系b的**主码**，这个属性就叫a参照b的外码foreign key，关系a称为外码的参照关系 referencing relation，b叫做外码的被参照关系 referenced relation
- 参照完整性约束 referential integrity constraint: 在参照关系中任意元组在特定属性上的取值必须等于被参照关系中某个元组在特定属性上的取值



- 模式图 schema diagram: 将数据库模式的主码和外码依赖展现出来的一种图



- 查询语言 query language: 用户用来从数据库中请求获取信息的语言，可分为过程化的和非过程化的，实际使用的查询语言既包含过程化方式的成分，也包含非过程化的成分
- 过程化语言 procedural language: 用户指导系统对数据库执行一系列操作以计算出所需结果
- 非过程化语言 nonprocedural language: 用户只需描述所需信息，而不用给出获取该信息的具体过程

从单个关系中选出满足一些特定谓词的特殊元组，结果就是一个新关系，是初始关系的一个子集







# SQL

> **Structured Query Language 结构化查询语言**

ANSI（American National Standards Institute 美国国家标准化组织）标准的计算机语言。

RDBMS 指关系型数据库管理系统，全称 Relational Database Management System。

RDBMS 是 SQL 的基础，同样也是所有现代数据库系统的基础，比如 MS SQL Server、IBM DB2、Oracle、MySQL 以及 Microsoft Access。

RDBMS 中的数据存储在被称为表的数据库对象中。

表是相关的数据项的集合，它由列和行组成。

SQL语言有以下几个部分: 

- 数据定义语言 Data-Definition Language (DDL): SQL DDL提供定义关系模式、删除关系、修改关系模式的命令
- 数据操控语言Data-Manipulation Language (DML): 包括查询语言，以及往数据库中插入元组、从数据库中删除元组和修改数据库中元组的命令
- 完整性 integrity: SQL DDL包括定义完整性约束的命令，保存在数据库中的数据必须满足所定义的完整性约束。
- 视图定义 view definition: SQL DDL包括定义视图的命令
- 事务控制 transaction control: SQL包括定义事务的开始和结束的命令 
- 嵌入式SQL和动态SQL embedded SQL and dynamic SQL: 定义SQL语句如何嵌入到通用编程语言，如C、C++、Java
- 授权 authorization: SQL DDL包括定义对关系和视图的访问权限的命令



一些最重要的SQL命令：

- **SELECT** - 从数据库中提取数据
- **UPDATE** - 更新数据库中的数据
- **DELETE** - 从数据库中删除数据
- **INSERT INTO** - 向数据库中插入新数据
- **CREATE DATABASE** - 创建新数据库
- **ALTER DATABASE** - 修改数据库
- **CREATE TABLE** - 创建新表
- **ALTER TABLE** - 变更（改变）数据库表
- **DROP TABLE** - 删除表
- **CREATE INDEX** - 创建索引（搜索键）
- **DROP INDEX** - 删除索引



## SQL数据定义

- char(n): 固定长度的字符串，用户指定n，也可以用全称character
- varchar(n): 可变长度的字符串，用户指定最大长度n，等价于全称character varying
- int: 整数类型(与机器相关的有限子集)，等价于全称integer
- smallint: 小整数类型(与机器相关的int类型的子集)
- numeric:
- real, double precision:
- float(n):

基本模式定义:

```sql
create table department
	(dept_name varchar(20),
     building varchar(15),
     budget numeric(12,2),
     primary key(dept_name) --指定主键
    ); --create table 命令后面用分号结束(很多SQL实现中分号是可选的)
```

```sql
primary key(A1, A2,..., An) --: 表明属性A1, A2,..., An构成关系的主码primary key，主码必须非空且唯一，主码声明是可选的。
foreign key(A1, A2,..., An) references a_table --:声明关系中的任意元组在属性(A1, A2,..., An)上的取值必须出现在a_table的主码属性上的取值中。 //e.g. foreign key(dept_name) references department: 该关系的dept_name的取值必须出现在department的主码中
not null: -- 约束该属性上不允许空值

-- e.g. 
create table instructor
	(ID varchar(5),
     name varchar(20) not null,--指定非空
     dept_name varchar(20),
     salary numeric(8,2),
     primary key(ID), -- 指定主码
     foreign key(dept_name) references department);--指定外码
```







## SQL查询的基本结构





```sql
select A1, A2, ..., An
from r1, r2, ...,rm
where P;--省略where时，相当于P为true
```



SQL查询语句基本结构由三个子句构成: 1. select; 2. from; 3. where

- select子句中，*表示所有的属性

```sql
--从instructor关系中选择attribute name
select name
from instructor; -- 命令后面用分号结束

select *  --选择所有列
from instructor;

--select默认保留重复元组,all可以显示指明不去除重复，下例效果与上等同
select all name
from instructor;

--在结果中删除重复:
select distinct name
from instructor;

--select子句可带有+ - * /运算符的算术表达式，运算对象(二元运算符右侧)可以是常数或元组的属性
select ID, salary *1.1 --输出每位老师工资增长10%后的工资
from instrector;

--where只选择在from子句的结果中满足特定谓词的元组 --逻辑连词: and, or, not
select name
from instructor
where dept_name = 'Comp.Sci.' and salary > 7000;--从计算机系的教师中选择工资高于7000的老师的名字
```



多关系查询:

```sql
select name, instructor.dept_name, building
from instructor, department --两个关系做笛卡儿积，元组数为两个关系的元组数的乘积
where instructor.dept_name = department.dept_name
```

###### 自然连接

只考虑那些在两个关系模式中都出现的属性上取值相同的元组对。自然连接的结果是关系

```sql
---实现自然连接:假设关系instructor和teaches只有attribute ID相同
select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID;--对所有讲授课程的教师，找出他们的姓名以及所讲述的所有课程标识
--更简洁的版本:
select name, course_id
from instructor natural join teaches; --natural join为关键字
--用自然连接将多个关系结合在一起:
select A1, A2, ..., An
from r1 natural join r2 natural join ... natural join rm
where P;
```



- 



## 附加的基本运算



### 更名运算

```sql
old_name as new_name
```



```sql
select name as instructor_name, course_id
from instructor, teaches
where instructor.ID = teaches.ID;
```

- 找出满足下面条件的所有教师的姓名，他们的工资比Biology系的最低工资高

```sql
select distinct T.name
from instructor as T, instructor as S
where T.salary > S.salary and S.dept_name = 'Biology'
```

- 上例中，S和T可以被认为是instructor关系的两个拷贝，更准确的说是被声明为instructor关系的别名。
- 重命名关系的标识符: 在SQL中被称作相关名称(correlation name), 表别名(table alias), 相关变量(correlation variable), 元组变量(tuple variable)

### 字符串运算





### 排列元组的显示次序



### where子句谓词

- between: 比较运算符，说明一个值是小于或等于某个值，同时大于或等于另一个值

- 例如下例：工资在90000和100000之间的教师的名字

```sql
select name
from instructor
where salary between 90000 and 100000;
--上下两个写法等效
select name
from instructor
where salary >= 90000 and salary <= 100000;
```

- not between: 不在某一范围的

- (v1, v2, ..., vn)表示一个分量值为v1, v2, ...,vn的n维元组，可在元组上用**比较运算符**，按照字典序进行比较运算。//e.g. (a1, a2) <= (b1, b2)在a1 <= b1且a2 <= b2时为真。

- 查找Biology系讲授了课程的所有老师的姓名和他们所教授的课程id

```sql
select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID and dept_name = 'Biology'
```





## 集合运算

- 在关系上的一些运算对应于集合论中的一些运算:

$$
\text{union}: \cup; 并集 \\
\text{intersect}: \cap; 交集 \\
\text{except}: - ; 差集\\
$$



### union 并

- 找出在2009秋季开课，或在2010春季开课，或两个学期都开课的所有课程id

```mysql
(select course_id
from section
where semester = 'Fall' and year = 2009)
union
(select course_id
from section
where semester = 'Spring' and year = 2010);
#上例会自动去除重复，两个学期都开课的course_id只会出现一次
(select course_id
from section
where semester = 'Fall' and year = 2009)
union all    #这样写就不会去除重复了
(select course_id
from section
where semester = 'Spring' and year = 2010);
```

- union会自动去除重复，union all 则会保留重复

### intersect 交





### except 差

- 对应于集合运算的差

找出所有没有选修在2009年春季之前开设的任何课程的学生的ID和姓名

```mysql
select id, name
from student
except
select id, name
from student natural join takes
where year<2009
```

> Since the except operator eliminates duplicates, there is no need
> to use a select distinct clause, although doing so would not affect
> correctness of the query.



## 空值NULL

- NULL空值是一种特殊的值，表示值未知或不存在，既不等于False也不等于True
- SQL将涉及NULL的任何比较运算的结果视为**unknown**，创建了true, false以外的第三个逻辑值

```sql
and: true and unknown = unknown;  false and unknown = false; unknown and unknown = unknown ;
or: true or unknown = true;  false or unknown = unknown ; unknown or unknown = unknown ;
not: not unknown = unknown;
```



- is null: 值为空时为真，否则为假
- is not null: 值为非空时为真，否则为假



## 聚集函数

- 聚集函数是以值的一个集合(集或多重集)为输入，返回单个值的函数,SQL提供五个固有聚集函数：

1. avg: 平均值(输入必须是数字集)
2. min: 最小值
3. max: 最大值
4. sum: 总和(输入必须是数字集)
5. count: 计数

> 除特殊说明外可以作用在非数字数据类型的集合上，例如字符串





- 计算一个关系中元组的个数:

```sql
select count(*)
from course;
```

- SQL不允许在count(\*)时使用distinct



找出每个系教师的最高工资值，可以假设每个系至少有一位教师

```mysql
select dept, max(salary)
from instructor
group by dept
```

### 分组聚集 group by

- group by给出的一个或多个属性事用来构造分组的，group by子句中所有属性上取值相同的元组将被分在一个组中



### having

- having子句中的谓词在形成分组后才起作用，

选择教师平均工资超过42000的系

```mysql
select dept_name, avg(salary) as avg_salary
from instructor group by dept_name
having avg(salary) > 42000;
#output:
dept_name  avg_salary
Physics     91000
Finance     85000
```





## 嵌套子查询





### with子句

with子句提供定义**临时关系**的方法，这个定义只对包含with子句的查询有效

找出具有最大预算值得系: with子句定义了临时关系max_budget，此关系在随后的查询中马上被使用。

```mysql
with max_budget(value) as
    (select max(budget)
    from department)
select budget
from department, max_budget
where department.budget = max_budget.value
```





## 数据库的修改



### 插入

插入时，若没有指定插入的tuple的attribute顺序，values内的顺序应与relation schema中的attribute顺序一致，若指定，则按照顺序一一对应，没有赋值的attribute(没有要求not null的前提下)会被赋值为null

```mysql
#插入的tuple属性值应和关系模式中的属性排列顺序一致
insert into course
	values('CS-437', 'Database Systems', 'Comp.Sci.', 4);
#在insert中指定插入的tuple的属性顺序
insert into course(title, course_id, credits, dept_name)
	values('Database Systems', 'CS-437', 4, 'Comp.Sci.');
```







### 删除

```mysql
delete from r
where P;
```

删除关系下的所有元组，关系本山还存在，只是没有一个元组了:

```mysql
delete from instructor;
```

删除所有工资在13000到15000之间的教师:

```mysql
delete from instructor
where salary between 13000 and 15000
```





### 更新

- 不改变整个元组的情况下改变其部分attribute的值，待更新的元组可以用query语句找到

```mysql
#所有教师的工资增长5%
update instructor
set salary = salary * 1.05
#所有工资低于70000的教师工资增长5%
update instructor
set salary = salary * 1.05
where salary < 70000
```

- update语句中的where子句可以包含select语句的where子句中的任何合法结构，包括嵌套的select
- 和insert、delete类似，update语句中嵌套的select可以引用待更新的关系(例如上例中的instructor)。SQL首先检查关系中的所有元组，看他们是否应该被更新，然后才执行

```mysql
#对工资低于平均数的教师涨5%的工资
update instructor
set salary = salary * 1.05
where salary < (select avg(salary)
               	from instructor)
```





## 连接表达式

能够指定显式的**连接谓词 join predicate**，能够在结果中包含被自然连接排除在外的元组



### 连接条件 on

```mysql
#如果一个来自student的tuple和一个来自takes的tuple在ID上取值相同，那么他们是匹配的，但是在下例的查询中，会出现两个ID，一次是student的，一次是takes的，与student natural join takes的差别就在于，ID出现两次，为student.ID, takes.ID
select *
from student join takes on student.ID = takes.ID;
#下例与上例效果相同，即等价
select *
from student, takes,
where student.ID = takes.ID;
#只显示一次ID的查询版本,忽略了ID的第二次出现
select student.ID as ID, name, dept_name, tot_cred, course_id, sec_id, semester, yesr, grade
from student join takes on student.ID = takes.ID;

```



### 外连接 outer join

如果有学生没有选择任何一门课程，即该学生在takes中从未出现，则下面的写法会丢失一些学生的信息。

```mysql
#自然连接会丢失一些tuple
select *
from student natural join takes;
```



- **左外连接 left outer join**: 只保留出现在左外连接运算之前(左边)的关系中的元组
- **右外连接 right outer join**: 只保留出现在右外连接运算之后(右边)的关系中的元组
- **全连接 full outer join**: 保留出现在两个关系中的元组。是左外连接与右外连接的组合。

不保留未匹配元组的连接运算被称作**内连接inner join**运算，**关键词inner是可选的**，常规的连接称作内连接，当join子句中没有使用outer前缀，**默认的连接类型是inner join**

左外连接运算的操作：先**计算出内连接结果**，然后对在内连接左侧关系中任意一个与右侧关系中任何元组都不匹配的元组t，向连接结果中加入一个元组r，r的构造如下：

- 元组r从**左侧关系**得到的属性**被赋为t中的值**
- r的其他属性被赋为**空置null**

```mysql
#左外连接的例子，所有student里的元组都不会被忽略，没选课的，takes中的属性为null
select *
from student natural left outer join takes;
#下例使用了on的，与上例相同，只是ID出现过两次
select *
from student left outer join takes on student.ID = takes.ID
#下例与上两例等效，只是结果中属性列出的顺序不同
select *
from takes natural right outer join student;
#找出所有一门课程也没有选修的学生ID
select ID
from student natural left outer join takes
where course_id is null
#会排除没有选课记录的学生的写法：
select *
from student left outer join takes on true #在where之前，包括了没有选课的学生
where student.ID = takes.ID#where使得没有选课的学生被排除掉(takes中不会出现没选课学生的ID)
```

- on和where在外连接中的表现是不同的。on条件只是外连接声明的一部分，但where子句却不是。



以上例子都在逻辑模型层操作，即我们假定了给定的集合中的关系都是实际存储在数据库中的。

## 视图

SQL允许通过查询来定义“虚关系”，它在概念上包含查询结果。虚关系并不预先计算并存储，而是在使用虚关系的时候才通过执行查询被计算出来。任何像这种不是逻辑模型的一部分，但作为虚关系对用户可见的关系称为**视图 view**。

视图通常的实现：定义一个视图时，数据库系统存储视图的定义本身，而不存储定义该视图的查询表达式的执行结果。一旦视图关系出现在查询中，它就被已存储的查询表达式代替。因此无论何时执行这个查询，视图关系都被重新计算。



### 视图定义 使用 与嵌套

定义视图：必须给视图一个名称(比如下例的v)，\<query expression\>可以是任何合法的查询表达式

```mysql
create view v as <query_expression>
create view view_name as <query_expression>
```

列出Physics系在2009年秋季学期所开设的所有课程段，以及每个课程段在哪栋建筑的哪个房间授课的信息

```mysql
create view physics_fall_2009 as 
  select course.course_id, sec_id, building, room_number
  from course, section
  where course.course_id = section.course_id
    and course.dept_name = 'Physics'
    and section.semester = 'Fall'
    and section.yesr = '2009';
```

一旦定义了视图，就可以使用视图名指代该视图生成的虚关系。

利用视图physics_fall_2009查询所有2009年秋季学期在Watson大楼开设的Physics课程

```mysql
select course_id
from physics_fall_2009
where building = 'Watson';
```

显示指定视图的属性名：

```mysql
#因为sum(salary)没有名称，其属性名是在视图定义中显式指定的
create view departments_total_salary(dept_name, total_salary) as
  select dept_name, sum(salary)
  from instructor
  group by dept_name;
```





## 事务

> transaction

事务：由查询和(或)更新语句的序列组成。SQL标准规定当一条SQL语句被执行，就隐式地开始了一个事务



## 完整性约束

完整性约束保证授权用户对数据库所做的修改不会破坏数据的一致性。完整性约束防止的是对数据的意外破坏。







## 授权

对数据的授权包括：

- 授权读取数据
- 授权插入新数据
- 授权更新数据
- 授权删除数据

### 权限的授予与收回

grant语句用来**授予权限**

```mysql
grant <权限列表>
on <关系名或视图名>
to <用户/角色列表>
```



---

# 形式化关系查询语言

- 关系代数
- 元组关系演算
- 域关系演算





## 关系代数

关系代数是一种**过程化**查询语言。

即使SQL的查询语言也松散的基于了关系代数，尽管SQL中的操作数(表 table)不完全是关系，很多有用的关于关系代数的理论在SQL对应者中不成立

关系代数的基本运算:Codd的代数的六个原始运算:

1. 选择 select: σ 小写sigma，将谓词写作σ的下标，
2. 投影 project: ∏ 大写pi，列举希望在结果中出现的属性作为∏的下标
3. 并 union: ∪
4. 集合差 set-difference: -
5. 笛卡儿积 Cartesian-product: ×
6. 更名 rename: ρ 小写rho

已经依据这六个原始运算定义了很多其他运算。其中最重要的是**交集**、**除法**和**自然连接**

> 关系代数中的select对应于SQL中使用的where

### 基本运算

找到物理系中工资额大于90000的教师:选择运算
$$
\sigma_{dept\_name = "Physics" \land salary>90000}(instructor)
$$
找出物理系所有教师的名字: 投影运算+选择运算
$$
\Pi_{name}(\sigma_{dept\_name = "Physics"}(instructor))
$$
找出开设在2009年秋季学期或者2010年春季学期或者这二者皆开的所有课程的集合: 并运算
$$
\Pi_{course\_id}(\sigma_{semester="Fall"\land year=2009}(section))\cup \Pi_{course\_id}(\sigma_{semester="Spring"\land year=2010}(section))
$$

- **并运算**: 使r ∪ s有意义，需要满足：(r, s可以是数据库关系或者作为关系代数表达式结果的临时关系)
1. r和s必须使同元的，即属性数目必须相同
2. 对所有的i, r的第i个属性的域必须和s的第i个属性的域相同

- **集合差** set-difference: r-s的结果即一个包含在所有在r中而不在s中的元组的关系

找出所有开设在2009年秋季学期但是在2010年春季学期不开的课程: 集合差运算
$$
\Pi_{course\_id}(\sigma_{semester="Fall"\land year=2009}(section)) - \Pi_{course\_id}(\sigma_{semester="Spring"\land year=2010}(section))
$$

- **笛卡儿积** Cartesian-product: 将任意两个关系的信息组合在一起， r × s

r = instructor × teaches 的关系模式: 
$$
(instructor.ID, name, dept\_name, salary,\\
teaches.ID, course_id, sec_id, semester, year)
$$
物理系的所有教师，以及他们教授的所有课程:
$$
\sigma_{instructor.ID = teaches.ID} (\sigma_{dept\_name = "Physics"}(instructor × teaches))\\
\sigma_{instructor.ID = teaches.ID} ((\sigma_{dept\_name = "Physics"}(instructor)) × teaches)
$$

> 以上两者等价

- 更名运算 rename: 假设代数表达式E是n元的:

$$
\rho_{x(A_1, A_2, ..., A_n)}(E)
$$

返回表达式E的结果，并赋给它名字x，同时将各属性更名为A~1~, A~2~, …, A~n~

查找大学里的最高工资:
$$
\Pi_{salary}(instructor) - \Pi_{instructor.salary}(\sigma_{instructor.salary < d.salary}(instructor)×\rho_d(instructor))
$$


### 关系代数的形式化定义

关系代数中基本的表达式是如下二者之一:

- 数据库中的一个关系
- 一个常数关系

常数关系可以用在 { } 内列出它的元组来表示, e.g. {(1, Physics), (76543, Finance)}

关系代数中一般的表达式是由更小的子表达式构成的，设E~1~和E~2~是关系代数表达式，则以下这些都是关系代数表达式:

- E~1~ ∪ E~2~
- E~1~ - E~2~
- E~1~ × E~2~
- σ~P~ (E~1~), 其中P是E~1~的属性上的谓词
- ∏~S~ (E~1~), 其中S是E~1~中某些属性的列表
- ρ~x~ (E~1~), 其中x是E~1~结果的新名字



### 连接和类似连接的运算

附加的关系代数运算

- 集合交运算 intersection: ∩
- 自然连接 natural join: ⋈
- 赋值 assignment: ←
- 外连接 outer-join:  ⟕ 左外连接，⟖ 右外连接，⟗ 全外连接





### 除法 ÷ Division Operation

除法是写为*R* ÷ *S*的二元关系。其结果由*R*中元组到唯一于*R*的属性名字（就是说只在*R*表头中而不在*S*表头中的属性）的限制构成，并且它们与*S*中的元组的所有组合都存在于*R*中。


$$
R ÷ S = \{ t[a1,...,an] : t\in R \wedge \forall s \in S( (t[a1,...,an] \cup s)  \in R)\}
$$

```python
#Student	Task # complete
Fred	Database1
Fred	Database2
Fred	Compiler1
Eugene	Database1
Eugene	Compiler1
Sara	Database1
Sara	Database2
#Task  #DBproject
Database1
Database2

#Student #complete ÷ DBproject #除法
Fred
Sara
#找出完成了DB所有项目的student
```



### 扩展的关系代数运算 Extended Relational-Algebra

- 广义投影 generalized-projection
- 聚集 aggregation: G



---

# 数据库设计和E-R模型

> Entity-Relationship Model 实体-联系模型
>
> 前面讲的SQL是关系模型 Relation Model





---

# 查询处理

> query processing: 查询处理，指从数据库中提取数据时涉及的一系列活动



