* Varnish版本为3.0.6
* 工作流程
![工作流程](https://www.varnish-software.com/static/book/_images/request.png)
* 安装  
```
Varnish 4.0:
    rpm --nosignature -i https://repo.varnish-cache.org/redhat/varnish-4.0.el6.rpm
    yum install varnish
Varnish 3.0:
If you are on RHEL 5 or a compatible distribution, use:
    rpm --nosignature -i https://repo.varnish-cache.org/redhat/varnish-3.0.el5.rpm
    yum install varnish

For RHEL 6 and compatible distributions, use:
    rpm --nosignature -i https://repo.varnish-cache.org/redhat/varnish-3.0.el6.rpm
    yum install varnish
```  

* /etc/sysconfig/varnish
```
NFILES=131072  #最大文件数
MEMLOCK=82000  #允许多大共享内存保存日志
NPROCS="unlimited"  #打开的最大线程数，不限制
RELOAD_VCL=1  #设为1，reload配置文件时不需要restart
VARNISH_VCL_CONF=/etc/varnish/default.vcl #指定VCL文件
VARNISH_LISTEN_PORT=80  #侦听端口
VARNISH_ADMIN_LISTEN_ADDRESS=127.0.0.1  #管理接口的侦听地址
VARNISH_ADMIN_LISTEN_PORT=6082  #管理接口的侦听端口
VARNISH_SECRET_FILE=/etc/varnish/secret  #密钥文件
VARNISH_MIN_THREADS=50  #最小工作线程数
VARNISH_MAX_THREADS=1000  #最大工作线程数
VARNISH_THREAD_TIMEOUT=120  #工作线程的超时时间
VARNISH_STORAGE_FILE=/var/lib/varnish/varnish_storage.bin  #指定缓存文件
VARNISH_STORAGE_SIZE=1G  #设置缓存大小，单位有k / M / G / T suffix
VARNISH_STORAGE="malloc,16M"  #使用malloc，即内存缓存，大小16M
VARNISH_TTL=120  #联系后端的超时时间
```  

* VCL Basics
设置允许清理缓存的主机或网段
```
acl purgers {
"127.0.0.1";
"192.168.0.0/24";
}
```  
设置后端主机  
```
backend default {
  .host = "192.168.1.1";
  .port = "80";
  .probe = {  #健康监测
    .url = "/";  #请求的url
    .expected_response = 200;  #期望后端主机响应的状态码，默认为200；
    .interval = 3s;  #请求的间隔时间
    .window = 3;  #设定在判定后端主机健康状态时基于最近多少次的探测进行
    .threshold = 2;  #在.window中指定的次数中，至少有多少次是成功的才判定后端主机正健康运行
  }
}
 
backend backup {
  .host = "192.168.1.2";
  .port = "80";
  .probe = { 
    .url = "/";
    .expected_response = 200;
    .interval = 3s; 
    .window = 3;
    .threshold = 2;
  }
}
 
director server client {  #定义主机池
{
  .backend = default;
  .weight = 5;  #权重越高，分配的请求越多
}
{
  .backend = backup;
  .weight = 5;
}
}
```  
