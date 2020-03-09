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





---

# 事务管理

> transaction 事务 一个程序执行单位

- 数据库事务（简称 事务）是数据库管理系统执行过程重的一个逻辑单位，由一个有限的数据库操作序列构成。

一个数据库事务通常包含了一个序列的对数据库的读/写操作。它的存在包含有以下两个目的：

1. 为数据库操作序列提供了一个从失败中恢复到正常状态的方法，同时提供了数据库即使在异常状态下仍能保持一致性的方法。
2. 当多个应用程序在并发访问数据库时，可以在这些应用程序之间提供一个隔离方法，以防止彼此的操作互相干扰。

当事务被提交给了DBMS（数据库管理系统），则DBMS（数据库管理系统）需要确保该事务中的所有操作都成功完成且其结果被永久保存在数据库中，如果事务中有的操作没有成功完成，则事务中的所有操作都需要被回滚，回到事务执行前的状态;同时，该事务对数据库或者其他事务的执行无影响，所有的事务都好像在独立的运行。

但在现实情况下，失败的风险很高。在一个数据库事务的执行过程中，有可能会遇上事务操作失败、数据库系统/操作系统失败，甚至是存储介质失败等情况。这便需要DBMS对一个执行失败的事务执行恢复操作，将其数据库状态恢复到一致状态（数据的一致性得到保证的状态）。为了实现将数据库状态恢复到一致状态的功能，DBMS通常需要维护事务日志以追踪事务中所有影响数据库数据的操作

并非任意的对数据库的操作序列都是数据库事务。

#### 存储结构

- 易失性存储器 volatile storage: 保存的信息通常在系统崩溃后不会幸存，访问速度非常快，因为内存访问速度本身就快，且可以直接访问易失性存储器中的任何数据项。e.g. 主存储器，高速缓冲存储器
- 非易失性存储器 nonvolatile storage: 在系统崩溃后会幸存。e.g. 在线存储的二级存储设备(如硬盘 闪存)，用于存档存储的三级存储设备(光介质 CD-Rom 磁带)。非易失性存储比易失性存储器速度慢，特别对于随机访问。容易受到故障的影响，导致信息丢失。
- **稳定性存储器 stable storage**: 信息**永远不会丢失**。可以通过技术近似使得数据丢失的可能性微乎其微。





## ACID

数据库事务拥有以下四个特性，习惯上被称之为ACID特性(ACID property)：

- 原子性（Atomicity）：事务作为一个整体被执行，包含在其中的对数据库的操作要么全部被执行，要么都不执行。保证原子性时数据库系统本身的责任，这项工作由称作**恢复系统(recovery system)**的一个数据库组件处理。(恢复系统也负责持久性)
- 一致性（Consistency）：隔离执行事务时保持数据库的一致性。事务应确保数据库的状态从一个一致状态转变为另一个一致状态。一致状态的含义是数据库中的数据应满足完整性约束。一致性约束依赖于程序，是编写事务的程序员的职责。
- 隔离性（Isolation）：多个事务并发执行时，一个事务的执行不应影响其他事务的执行。事务互相之间感觉不到有其他事务在并发执行。由**并发控制系统(concurrency-control system)**的部件负责。
- 持久性（Durability 耐久性）：已被提交的事务对数据库的修改应该永久保存在数据库中。持久性也由恢复系统来负责。

> 不一致状态 inconsistent state：数据库系统的状态不再反应数据库本应描述的现实世界的真实状态。



## 原子性和持久性

- 中止 aborted: 事务没有被成功执行完成
- 已回滚 rolled back: 中止事务造成的变更被撤销
- 已提交 committed: 成功完成执行的事务
- 补偿事务 compensating transaction: 撤销已提交事务所造成的影响的唯一方法。e.g. 给账户增加了20的补偿事务是给账户减少20。补偿事务的责任留给用户。



事务必须处于以下状态之一：

- **活动的 active**: 初始状态，事务执行时处于这个状态。可转移到部分提交、失败。
- **部分提交的 partially committed**: 最后一条语句执行后。可转移到失败、提交的。
- **失败的 failed**: 发现正常的执行不能继续后。只可转移到**终止aborted**状态。
- **中止的 aborted**: 事务回滚并且数据库已恢复到事务开始执行前的状态后。已结束。
- **提交的 committed**: 成功完成以后。已结束。

已结束的 terminated: 如果事务时提交的或中止的。

进入**中止状态aborted**后，系统只有两种选择:

1. **重启 restart**: 仅当引起事务中止的是**硬件错误**或**不是由事务的内部逻辑所产生的软件错误**时。重启的事务被看成是一个新事务。
2. **杀死 kill**: 通常是由于事务的**内部逻辑**造成的错误，只有重写应用程序才能改正，或者由于输入错误，或所需数据在数据库中没有找到。

可见的外部写 observable external write: 比如写到用户屏幕，发送电子邮件。由于写的结果可能在数据库系统以外的地方看到，故一旦写了，就无法抹去。大多数系统仅在事务进入提交状态后，才允许进行可见的外部写。



## 事务隔离性与可串行化

数据库系统必须控制事务之间的交互，以防止它们破坏数据库的一致性。系统通过**并发控制机制 concurrency-control scheme**的一系列机制来保证这一点。

事务和事务是冲突的conflict: 当事务I和事务J是不同事务在相同的数据项上的操作，并且其中至少有一个是write指令时，称I和J是冲突的。

如果调度S可以经过一系列非冲突指令交换转换成S’，称S与S’是冲突等价 conflict equivalent 的.

**冲突可串行化 conflict serializable**: 若一个调度S与一个*串行调度***冲突等价**





可恢复调度：调度必须是可恢复的，以确保若事务a受到事务b的影响，则当b中止时，a也要终止。

无级联调度：调度最好是无级联的，不会由于一个事务的中止引起其他事务的级联中止。无级联性是通过只允许事务读取已提交数据来保证的。



## 事务隔离性级别

SQL标准规定的隔离性级别如下：

- 可串行化 serializable: (较强) 通常保证可串行化调度
- 可重复度 repeatable read: 只允许读取已提交数据，并且在一个事务两次读取一个数据项期间，其他事务不可更新该数据
- 已提交读 read committed: 只允许读取已提交数据，但不要求可重复度。e.g. 十五两次读取一个数据时，该值允许被其他事务修改
- 未提交读 read committed: 允许读取未提交数据，这是SQL允许的最低一致性级别。



---

# 并发控制



- 共享型锁 shared-mode lock (S): 可读不可写
- 排他型锁 exclusive-mode lock (X): 可读可写



并发控制器授权加锁的条件：当事务T申请在数据项Q上加M型锁时

1. 不存在数据项Q上持有与M型锁冲突的锁的其他事务
2. 不存在等待对Q加锁且先于T申请加锁的事务。(避免了饥饿 starved)

两阶段封锁协议 two-phase locking protocol:

1. 增长阶段 growing phase: 事务可以获得锁，但不能释放锁。获得最后加锁的位置，增长阶段结束点，成为事务的封锁点 lock point
2. 缩减阶段 shrinking phase: 事务可以释放锁，但不能获得新锁。

依据封锁点对事务进行排序，这个顺序就是事务的一个可串行化顺序。

无法避免死锁。级联回滚可能发生。

严格两阶段封锁协议 strict two-phase locking protocol:

在两阶段封锁协议的基础上，还需满足：事务持有的所有排他锁必须在事务提交后才可以释放。

强两阶段封锁协议 rigorous two-phase locking protocol:

事务提交之前不得释放任何锁。

锁转换 lock conversion:

- 升级 upgrade: 从共享到排他。只能在增长阶段
- 降级 downgrade: 从排他到共享。只能在缩减阶段

具有锁转换的两阶段封锁协议只产生冲突可串行化的调度，且事务可以根据其封锁点做串行化。如果排他锁知道事务结束才释放，准则调度是无级联的。





从死锁中恢复

解除死锁的最通常的做法是回滚一个或多个事务。需采取的动作有三个：

1. 选择牺牲者:
2. 回滚:
3. 饿死:



---

# 恢复系统





## 故障分类

每种故障需要不同的方法来处理，本章只考虑如下故障

- 事务故障 transaction failure
  - 逻辑错误 logical error
  - 系统错误 system error
- 系统崩溃 fail-stop assumption
- 磁盘故障 disk failure



## 稳定存储器的实现

> 事务管理那一章的存储结构小节有介绍三种存储器。分别为易失性存储器，非易失性存储器，稳定存储器。





## 恢复与原子性



### 数据库修改

事务修改了数据库：一个事务执行了对磁盘缓冲区或磁盘自身的更新。而事务在主存中自己私有的部分进行的更新不算数据库修改。

- 延迟修改 deferred-modification: 事务直到提交时都没有修改数据库
- 立即修改 immediate-modification: 数据库修改在事务仍然活跃时发生。



- **undo**: 使用一个日志记录，将该日志记录中指明的数据项设置为**旧值**
- **redo**: 使用一个日志记录，将该日志记录中指明的数据项设置为**新值**



