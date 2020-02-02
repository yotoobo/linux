# 网络文件系统

网络文件系统(NFS) 是一个简单易用的集中存储，它允许远程主机挂载指定分区。

## 安装 NFS

- 系统: Centos7 以上

- 安装软件包
  
```shell
sudo yum install -y nfs-utils rpcbind
sudo systemctl enable nfs
sudo systemctl enable rpcbind
sudo systemctl start nfs
sudo systemctl start rpcbind
```

- NFS 结构  
  主要配置文件：/etc/exports
  配置挂载属主：/etc/idmapd.conf
  维护指令：/usr/sbin/exportfs
  维护指令：/usr/sbin/showmount

## 配置 NFS 共享目录

共享目录都要通过修改文件 **/etc/exports** 。

例如：

```txt
directory1 machine1(option11,option12)
           machine2(option13,option14)
directory2 machine1(option21,option22)
```

其中，常用的 **optionXX** 有：

- ro：只读
- rw：可读写
- no_root_squash
- no_subtree_check
- sync
- async

例如允许 /tmp 目录开放给所有远程主机，并且可读写:

```txt
/tmp *(rw)
```

## Firewalld

如果网络确保安全，可以直接关闭，不然还是配置防火墙规则:

```shell
firewall-cmd --permanent --add-service=nfs
firewall-cmd --permanent --add-service=mountd
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --reload
```

## 挂载

使用 **mount** 指令进行挂载：

```shell
mkdir /path/to/dir
mount -t nfs <server-ip>:/directory1 /path/to/dir
```

> Note
> 在配置挂载属主时，要保证用户的UID，GID一致。
