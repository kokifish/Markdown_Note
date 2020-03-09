[TOC]



---

# MySQL



## Installation

- 

>  https://dev.mysql.com/doc/refman/5.7/en/linux-installation-rpm.html 

```cmd
# Install: Mysql 5.7
# Configure Yum Repository
cd /etc/pki/rpm-gpg
sudo wget https://repo.mysql.com/RPM-GPG-KEY-mysql
vim /etc/yum.repos.d/mysql-community.repo

# file content (/etc/yum.repos.d/mysql-community.repo)
[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/fc/$releasever/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

# save file and close
dnf install mysql-community-server
dnf install mysql-community-devel

# Enable the MySQL service to start on system boot
systemctl enable mysqld.service
# start mysql service
systemctl start mysqld.service
```

| Package Name                     | Summary                                                      |
| -------------------------------- | ------------------------------------------------------------ |
| `mysql-community-server`         | Database server and related tools                            |
| `mysql-community-client`         | MySQL client applications and tools                          |
| `mysql-community-common`         | Common files for server and client libraries                 |
| `mysql-community-devel`          | Development header files and libraries for MySQL database client applications |
| `mysql-community-libs`           | Shared libraries for MySQL database client applications      |
| `mysql-community-libs-compat`    | Shared compatibility libraries for previous MySQL installations |
| `mysql-community-embedded`       | MySQL embedded library                                       |
| `mysql-community-embedded-devel` | Development header files and libraries for MySQL as an embeddable library |
| `mysql-community-test`           | Test suite for the MySQL server                              |



## CMD: DB



### Login



```mysql
# Mysql5.7 login
# 首次安装成功后，获取root的临时密码
grep "temporary password" /var/log/mysqld.log
mysql -u root -p
# 输入之前查询出来的临时密码
# 登陆成功之后
alter user 'test'@'localhost' identified by 'Ab123,.AAA';
# 修改的密码要足够复杂 否则报错
uninstall plugin validate_password;
# 现在可以修改为简单密码了
alter user 'test'@'localhost' identified by '123456';

exit; # 退出数据库
```





### Create, Show, Delete

```mysql
create database db1; # 创建数据库db1
show databases; # 显示所有数据库 注意最后有s
use db1; # 切换到数据库db1 # use 通告MySQL把db1作为默认（当前）数据库使用，用于后续语句
# 该数据库保持为默认数据库，直到语段的结尾，或者直到发布一个不同的USE语句
# Output: Database changed
show tables; # 显示当前数据库中所有的表

drop database db2; # 删除数据库(必须存在 否则报错)
drop database if exists db2;
Query OK, 0 rows affected, 1 warning (0.00 sec) #[Output] 产生一个warning说明此数据库不存在 没有warning说明数据库存在现已被删除
```



### Auxiliary


```mysql
select version(); # 显示MYSQL版本
select now(); # 显示当前时间
```





## CMD: Table



### Delete


```mysql
DELETE FROM tb1; # 删除表所有数据
TRUNCATE TABLE table1; # 删除表所有数据
```







```mysql
select * from TB1; # 显示表TB1的所有元组(行)
```

