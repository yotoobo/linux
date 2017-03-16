# Network File System  

* 环境
Centos 6.6 x86_64  

* 安装软件包  
```yum install nfs-utils-* rpcbind```  

* NFS结构  
  主要配置文件：/etc/exports  
  配置挂载属主：/etc/idmapd.conf
  >在配置挂载属主时，要保证所有机器的uid，gid一致。
  分享资源的信息：/var/lib/nfs/*tab  
  维护指令：/usr/sbin/exportfs  
  维护指令：/usr/sbin/showmount  
  
* 配置exports  
示例1  
允许/tmp目录开放给所有人，可读可写  
```/tmp *(rw)```  

* iptables 设置  
关闭防火墙或开放端口  

* 挂载  
在client端  
```mount -t nfs server.ip:/tmp /new_dir```
