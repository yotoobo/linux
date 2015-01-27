× 工作流程
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
