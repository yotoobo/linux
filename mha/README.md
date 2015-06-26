## Mysql-master-ha
  [mha<木弟^子>](https://code.google.com/p/mysql-master-ha/)目前在MySQL高可用方面是一个相对成熟的解决方案，是一套优秀的作为MySQL高可用性环境下故障切换和主从提升的高可用软件。在MySQL故障切换过程中，MHA能做到在0~30秒之内自动完成数据库的故障切换操作，并且在进行故障切换的过程中，MHA能在最大程度上保证数据的一致性，以达到真正意义上的高可用. 

  该软件由两部分组成：MHA Manager（管理节点）和MHA Node（数据节点）。  
  ![MHA-components](https://github.com/yotoobo/linux/blob/master/mha/MHA-components.png)  
  MHA Manager可以单独部署在一台独立的机器上管理多个master-slave集群，也可以部署在一台slave节点上。MHA Node运行在每台MySQL服务器上，MHA Manager会定时探测集群中的master节点，当master出现故障时，它可以自动将最新数据的slave提升为新的master，然后将所有其他的slave重新指向新的master。整个故障转移过程对应用程序完全透明。

  在MHA自动故障切换过程中，MHA试图从宕机的主服务器上保存二进制日志，最大程度的保证数据的不丢失，但这并不总是可行的。例如，如果主服务器硬件故障或无法通过ssh访问，MHA没法保存二进制日志，只进行故障转移而丢失了最新的数据。使用MySQL 5.5的半同步复制，可以大大降低数据丢失的风险。MHA可以与半同步复制结合起来。如果只有一个slave已经收到了最新的二进制日志，MHA可以将最新的二进制日志应用于其他所有的slave服务器上，因此可以保证所有节点的数据一致性。

  目前MHA主要支持一主多从的架构，要搭建MHA,要求一个复制集群中必须最少有三台数据库服务器，一主二从，即一台充当master，一台充当备用master，另外一台充当从库，因为至少需要三台服务器，出于机器成本的考虑，淘宝也在该基础上进行了改造，目前淘宝TMHA已经支持一主一从.  

## 工作原理
![mha管理多组主从](https://github.com/yotoobo/config/blob/master/mha/mha.png)  

## Getting Started
* replication environments  
  初始化[主从环境](https://github.com/yotoobo/config/blob/master/mysql/README.md)
* 拓扑关系  
```
| Hosts      | IP            | 角色                            |
| ---------- | ------------- | ------------------------------- |
| master     | 192.168.1.121 | Master and MHA-Node             |
| slave1     | 192.168.1.122 | Slave  and MHA-Node             |
| slave2     | 192.168.1.123 | Slave  and MHA-Node MHA-Manager |
```  
* Install MHA-Node on all hosts  
In Centos or Redhat,do install from package 
```
# yum install perl-DBD-MySQL
# rpm -ivh mha4mysql-node-X.Y.noarch.rpm
```  
In Debian or ubuntu,do install from deb  
```
$ sudo apt-get install libdbd-mysql-perl
$ sudo dpkg -i mha4mysql-node_X.Y_all.deb  
```  
Or install from source  
```
$ tar zxf mha4mysql-node-X.Y.tar.gz  
$ cd mha4mysql-node-X.Y  
$ perl Makefile.PL  
$ make  
$ sudo make install
```  
_Note:相应软件包已放在当前目录下,可下载使用_  

* Install MHA-Manager on host4  
In Centos or Redhat,do install from package  
官方源缺失部分软件包,请安装对应的[epel源](http://fedoraproject.org/wiki/EPEL)
```
# rpm -ivh http://mirrors.yun-idc.com/epel/6/x86_64/epel-release-6-8.noarch.rpm
# yum install perl-DBD-MySQL perl-Config-Tiny perl-Log-Dispatch perl-Parallel-ForkManager perl-Time-HiRes
# rpm -ivh mha4mysql-manager-X.Y-0.noarch.rpm
```  
In Debian or ubuntu,do install from deb  
```
$ sudo apt-get install libdbd-mysql-perl libconfig-tiny-perl liblog-dispatch-perl libparallel-forkmanager-perl
$ dpkg -i mha4mysql-manager_X.Y_all.deb
```  
Or install from source  
```
$ tar -zxf mha4mysql-manager-X.Y.tar.gz
$ cd tar -zxf mha4mysql-manager-X.Y
$ perl Makefile.PL
$ make
$ sudo make install
```
_Note:相应软件包已放在当前目录下,可下载使用._  

* SSH 免密码登录  

* MHA Configure  
示例配置文件在源码包内
```
cat /etc/mha/app1.conf
[server default]
manager_workdir=/var/log/masterha/app1
manager_log=/var/log/masterha/app1/manager.log

master_binlog_dir=/home/user/mysql/data
master_ip_failover_script=/usr/local/bin/master_ip_failover
master_ip_online_change_script=/usr/local/bin/master_ip_online_change
user=admin
password=123456
ping_interval=1
remote_workdir=/tmp
repl_password=password
repl_user=repUser
report_script=/usr/local/bin/send_report
secondary_check_script=/usr/bin/masterha_secondary_check -s slave1 -s master --user=root --master_host=master --master_ip=192.168.1.121 --master_port=3306
ssh_user=root

[server1]
hostname=master
port=3306

[server2]
hostname=slave1
port=3306
candidate_master=1


[server3]
hostname=slave2
port=3306
```  
```
cat master_ip_failover
#!/usr/bin/env perl

#  Copyright (C) 2011 DeNA Co.,Ltd.
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#  Foundation, Inc.,
#  51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

## Note: This is a sample script and is not complete. Modify the script based on your environment.

use strict;
use warnings FATAL => 'all';

use Getopt::Long;
use MHA::DBHelper;

my (
  $command,        $ssh_user,         $orig_master_host,
  $orig_master_ip, $orig_master_port, $new_master_host,
  $new_master_ip,  $new_master_port,  $new_master_user,
  $new_master_password
);

my $vip = '10.49.1.180';
my $key = '2';
my $ssh_start_vip = '/sbin/ifconfig eth1:$key $vip';
my $ssh_stop_vip = '/sbin/ifconfig eth1:$key down';
$ssh_user = 'root';

GetOptions(
  'command=s'             => \$command,
  'ssh_user=s'            => \$ssh_user,
  'orig_master_host=s'    => \$orig_master_host,
  'orig_master_ip=s'      => \$orig_master_ip,
  'orig_master_port=i'    => \$orig_master_port,
  'new_master_host=s'     => \$new_master_host,
  'new_master_ip=s'       => \$new_master_ip,
  'new_master_port=i'     => \$new_master_port,
  'new_master_user=s'     => \$new_master_user,
  'new_master_password=s' => \$new_master_password,
);

exit &main();

sub main {
  if ( $command eq "stop" || $command eq "stopssh" ) {

    # $orig_master_host, $orig_master_ip, $orig_master_port are passed.
    # If you manage master ip address at global catalog database,
    # invalidate orig_master_ip here.
    my $exit_code = 1;
    eval {

      # updating global catalog, etc
      print "Disabling the VIP on old master: $orig_master_host \n";
      &stop_vip();
      $exit_code = 0;
    };
    if ($@) {
      warn "Got Error: $@\n";
      exit $exit_code;
    }
    exit $exit_code;
  }
  elsif ( $command eq "start" ) {

    # all arguments are passed.
    # If you manage master ip address at global catalog database,
    # activate new_master_ip here.
    # You can also grant write access (create user, set read_only=0, etc) here.
    my $exit_code = 10;
    eval {
      print "Enabling the VIP - $vip on the new master - $new_master_host \n";
      &start_vip();
      $exit_code = 0;
    };
    if ($@) {
      warn $@;

      # If you want to continue failover, exit 10.
      exit $exit_code;
    }
    exit $exit_code;
  }
  elsif ( $command eq "status" ) {

    # do nothing
    print "Checking the Status of the script.. OK \n";
    `ssh $ssh_user\@cluster1 \" $ssh_start_vip \"`;
    exit 0;
  }
  else {
    &usage();
    exit 1;
  }
}

sub start_vip() {
    `ssh $ssh_user\@$new_master_host \" $ssh_start_vip \"`;
}

sub stop_vip() {
    `ssh $ssh_user\@$orig_master_host \" $ssh_stop_vip \"`;
}

sub usage {
  print
"Usage: master_ip_failover --command=start|stop|stopssh|status --orig_master_host=host --orig_master_ip=ip --orig_master_port=port --new_master_host=host --new_master_ip=ip --new_master_port=port\n";
}

```  

* 执行检测  
在slave2上  
1. masterha_check_ssh --conf=/etc/mha/app1.cnf  
2. masterha_check_repl --conf=/etc/mha/app1.cnf  
3. masterha_check_status --conf=/etc/mha/app1.cnf 

* 参考文档  
  1. [MHA](https://code.google.com/p/mysql-master-ha/)  
  2. [Mysql高可用之MHA](http://www.cnblogs.com/gomysql/p/3675429.html)  
  3. [Mysql大杀器之MHA](http://huoding.com/2011/12/18/139)


