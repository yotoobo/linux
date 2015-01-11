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
* 半同步复制  
mysql5.5之前的复制是异步复制,主库在执行完一些事务后，是不会管备库的进度的。如果备库不幸落后，而更不幸的是主库此时又出现Crash（例如宕机），这时备库中的数据就是不完整的。简而言之，在主库发生故障的时候，我们无法使用备库来继续提供数据一致的服务了.  
而开启[半同步复制](http://dev.mysql.com/doc/refman/5.5/en/replication-semisync.html)后,MySQL每一个事务需等待备库接收日志后才返回给客户端。如果做的是小事务，两台主机的延迟又较小，则Semi-sync可以实现在性能很小损失的情况下的零数据丢失。
  1. 搭建主从环境
  2. 开启semi-sync插件
```
on the Master
mysql> INSTALL PLUGIN rpl_semi_sync_master SONAME ‘semisync_master.so';
mysql> SET GLOBAL rpl_semi_sync_master_enabled = 1;
mysql> SET GLOBAL rpl_semi_sync_master_timeout = 1000;  # 1 second
on the Slave
mysql> INSTALL PLUGIN rpl_semi_sync_slave SONAME ‘semisync_slave.so';
mysql> SET GLOBAL rpl_semi_sync_slave_enabled = 1;
mysql> START SLAVE;
```
_NOTE: SLAVE端需要先开启半同步参数，然后启动从库复制，否则，Rpl_semi_sync_slave_status的状态始终为：OFF。_  

* 参考文档
  1. [半同步原理介绍](http://www.orczhou.com/index.php/2011/07/why-and-how-mysql-5-5-semi-sync-replication/)
  2. [半同步复制介绍](http://www.mysqlsystems.com/2012/08/understand-mysql-semi-sync-replication.html)