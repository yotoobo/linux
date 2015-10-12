## HAProxy 是什么？
  **HAProxy** 是一款自由，快速，可靠的解决方案。它用以提供高可用性、负载均衡和基于tcp和http应用的代理。    

## HAProxy 有什么特点？
  * 支持虚拟主机，工作在4，7层
  * 支持url检测后端服务器
  * 更强大的session保持，cookie的引导
  * 支持多的负载均衡算法

## 应用示例
![示例](https://github.com/yotoobo/config/blob/master/haproxy/haproxy-pmode.png)

## [官方文档](http://cbonte.github.io/haproxy-dconv/configuration-1.5.html)

## 安装
```
wget http://www.haproxy.org/download/1.5/src/haproxy-1.5.14.tar.gz
tar zxf haproxy-1.5.14.tar.gz
cd haproxy-1.5.14
make TARGET=linux26 CPU=native USE_PCRE=1 USE_LIBCRYPT=1 USE_LINUX_SPLICE=1 USE_LINUX_TPROXY=1
make install
```

## haproxy.cfg 示例
```global
	log 127.0.0.1	local0 日志记录到本地
	log 127.0.0.1	local1 notice 
	#log 127.0.0.1	local1 notice
	#log loghost	local0 info
	
	maxconn 10240  #最大连接数
	chroot /usr/share/haproxy
	uid 99
	gid 99
	daemon     #后台运行
	nbproc 1   #启动进程
	#debug
	#quiet

defaults
	log	global
	mode	http
	option	httplog
	option	dontlognull
	log	127.0.0.1 local3
	retries	3          #健康检查的重试次数
	option redispatch  #当服务器组中出现机器不可用，自动将请求重定向到存活机器

	timeout check	1s  
	timeout http-request 10s    #请求超时
	timeout queue	1m          #请求在队列中的超时
	timeout connect	10s         #连接超时
	timeout client	1m          #客户端超时
	timeout server	1m          #服务端超时
	timeout http-keep-alive 30s 

listen stats
	mode  http
        bind  0.0.0.0:8090
	stats enable
	stats refresh 30s  
	stats uri /stats
	stats realm baison-test-Haproxy
	stats auth admin:admin
	stats admin if TRUE
	stats hide-version

frontend allen
	bind *:80
	mode http
	option httpclose
	option forwardfor

	acl url_static path_end -i .html .jpg .gif .png
	acl url_dynamic path_end -i .php .jsp

	default_backend webDynamic
	use_backend webStatic if url_static
        use_backend webDynamic if url_dynamic

backend webDynamic
	balance roundrobin
	server web1 10.0.0.1:80 check rise 2 fall 1 weight 2
	server web2 10.0.0.2:80 check rise 2 fall 1 weight 2

backend webStatic
	balance source
	server lamp 10.0.0.3:80 check rise 2 fall 1```



