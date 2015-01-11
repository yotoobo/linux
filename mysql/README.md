* 配置复制
  1. 在每台机器上创建复制账号  
  2. 配置主库和备库  
  3. 通知备库连接到主库并开始复制数据  
  _示例代码_  
```
创建复制账号
mysql> grant replication slave,replication client on *.* to repUser@'192.168.1.%' identified by 'password';

配置主库                               配置从库
log-bin = mysql-bin                   log-bin = mysql-bin  
binlog_format = row                   binlog_format = row
server-id = 1  #唯一值                 server-id = 2  #唯一值
                                      relay-log = mysql-relay-bin
                                      log-slave-updates = 1  

启动复制
mysql> change master to master_host='192.168.1.121',
     > master_user='repUser',
     > master_passwork='password',
     > master_log_file='mysql-bin.000001',
     > master_log_pos=245;
mysql> start slave;
```