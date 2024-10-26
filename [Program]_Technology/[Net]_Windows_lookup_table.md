# Windows Network Commond
```shell
ipconfig /all # 详版ipconfig
route -4 print # 仅查看IPv4路由表 接口等
```



## route add/delete

```shell
route add 118.193.1.1 mask 255.255.255.255 192.168.0.1 metric 1 if 16 -p # 把特定ip访问118.193.1.1固定Gateway=192.168.0.1 interface为Interface List里面列出的设备序号 -p表示静态路由 Persistent Routes

route delete 0.0.0.0 mask 0.0.0.0 192.168.1.1 # 删除默认路由
route delete 118.193.12.34 mask 255.255.255.255 192.168.0.1 # 删除某一路由表项
route add 0.0.0.0 mask 0.0.0.0 192.168.1.1 metric 100 if 13 # 改大metric值 降低权重

```





## 链路聚合

```shell
# on powershell(admin)
Get-NetAdapter
New-NetSwitchTeam -Name "SwitchTeam01" -TeamMembers "Ethernet 2","Ethernet 3" # 创建一个聚合接口
Remove-NetSwitchTeam -Name "SwitchTeam01" # 删除该聚合接口
```

