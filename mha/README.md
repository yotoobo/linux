## Mysql-master-ha
  [mha<木弟子>](https://code.google.com/p/mysql-master-ha/)目前在MySQL高可用方面是一个相对成熟的解决方案，是一套优秀的作为MySQL高可用性环境下故障切换和主从提升的高可用软件。在MySQL故障切换过程中，MHA能做到在0~30秒之内自动完成数据库的故障切换操作，并且在进行故障切换的过程中，MHA能在最大程度上保证数据的一致性，以达到真正意义上的高可用. 

  该软件由两部分组成：MHA Manager（管理节点）和MHA Node（数据节点）。MHA Manager可以单独部署在一台独立的机器上管理多个master-slave集群，也可以部署在一台slave节点上。MHA Node运行在每台MySQL服务器上，MHA Manager会定时探测集群中的master节点，当master出现故障时，它可以自动将最新数据的slave提升为新的master，然后将所有其他的slave重新指向新的master。整个故障转移过程对应用程序完全透明。

  在MHA自动故障切换过程中，MHA试图从宕机的主服务器上保存二进制日志，最大程度的保证数据的不丢失，但这并不总是可行的。例如，如果主服务器硬件故障或无法通过ssh访问，MHA没法保存二进制日志，只进行故障转移而丢失了最新的数据。使用MySQL 5.5的半同步复制，可以大大降低数据丢失的风险。MHA可以与半同步复制结合起来。如果只有一个slave已经收到了最新的二进制日志，MHA可以将最新的二进制日志应用于其他所有的slave服务器上，因此可以保证所有节点的数据一致性。

  目前MHA主要支持一主多从的架构，要搭建MHA,要求一个复制集群中必须最少有三台数据库服务器，一主二从，即一台充当master，一台充当备用master，另外一台充当从库，因为至少需要三台服务器，出于机器成本的考虑，淘宝也在该基础上进行了改造，目前淘宝TMHA已经支持一主一从.  

## 工作原理
![mha管理多组主从](https://github.com/yotoobo/config/blob/master/mha/mha.png)  

## Getting Started
* replication environments  
  初始化[主从环境](https://github.com/yotoobo/config/blob/master/mysql/README.md)
* 拓扑关系  
```
| Hosts      | IP            | 角色                 |
| ---------- |:-------------:| -------------------:|
| host1      | 192.168.1.121 | Master and MHA-Node |
| host2      | 192.168.1.122 | Slave  and MHA-Node |
| host3      | 192.168.1.123 | Slave  and MHA-Node |
| host4      | 192.168.1.120 | MHA-Manager         |  
```  
* Install MHA-Node on host1 - host4
```
```
* Install MHA-Manager on host4 
