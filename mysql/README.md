## 复制
* 概述
mysql的复制是指一台服务器与多台服务器的数据保持同步,即一主多从.它是Mysql水平扩容的最易实现,最成熟的方案(个人这么认为哈!)!

* 它能解决什么问题?
  1. 数据分布(鸡蛋不要放在一个篮子里)
  2. 负载均衡(将读操作分布到多个从库上,优化读密集型的应用)
  3. 高可用性和故障切换

* ![复制如何工作](https://github.com/yotoobo/config/blob/master/mysql/mysql-replication.jpg)
* 配置复制
  1. 在每台机器上创建复制账号  
  2. 配置主库和备库  
  3. 通知备库连接到主库并开始复制数据  
  _示例代码_  
```
创建复制账号
mysql> grant replication slave,replication client on *.* to repUser@'192.168.1.%' identified by 'password';
mysql> flush privileges;

配置主库                               配置从库
log-bin = mysql-bin                   log-bin = mysql-bin  
binlog_format = row                   binlog_format = row
server-id = 1  #唯一值                 server-id = 2  #唯一值
                                      relay-log = mysql-relay-bin
                                      log-slave-updates = 1  

启动复制
mysql> change master to master_host='192.168.1.121',
     > master_user='repUser',
     > master_password='password',
     > master_log_file='mysql-bin.000001',
     > master_log_pos=245;
mysql> start slave;
```
