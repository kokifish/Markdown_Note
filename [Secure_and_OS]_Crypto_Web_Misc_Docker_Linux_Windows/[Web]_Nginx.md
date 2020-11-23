[TOC]

---



# Nginx

---

高性能的HTTP和反向代理web服务器，同时也提供了IMAP/POP3/SMTP服务

- 反向代理，主要用于服务器集群分布式部署的情况下，反向代理隐藏了服务器的信息
- 正向代理最大的特点: 客户端非常明确要访问的服务器地址；服务器只清楚请求来自哪个代理服务器，而不清楚来自哪个具体的客户端；正向代理模式屏蔽或者隐藏了真实客户端信息





# CMD Quick Find

```python
netstat -anput | grep nginx # 检测Nginx是否在运行
nginx -c /path/to/nginx.conf # 利用配置文件启动nginx
service nginx restart # 重启服务
nginx -s stop # 快速停止或关闭
nginx -s quit # 正常停止或关闭
nginx -s reload # 配置文件修改重装载命令
nginx -t # 配置文件测试
```

