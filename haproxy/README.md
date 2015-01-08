## HAProxy 是什么？
  **HAProxy** 是一款自由，快速，可靠的解决方案。它用以提供高可用性、负载均衡和基于tcp和http应用的代理。    

## HAProxy 有什么特点？
  * 支持虚拟主机，工作在4，7层
  * 支持url检测后端服务器
  * 更强大的session保持，cookie的引导
  * 支持多的负载均衡算法

## 示例
![示例](https://github.com/yotoobo/config/blob/master/haproxy/haproxy-pmode.png)

## [官方文档](http://cbonte.github.io/haproxy-dconv/configuration-1.5.html)

## haproxy.cfg
```global
	log 127.0.0.1	local0
	log 127.0.0.1	local1 notice 
	#log 127.0.0.1	local1 notice
	#log loghost	local0 info
	
	maxconn 10240  #最大连接数
	chroot /usr/share/haproxy
	uid 99
	gid 99
	daemon
	nbproc 1   #
	#debug
	#quiet

defaults
	log	global
	mode	http
	option	httplog
	option	dontlognull
	log	127.0.0.1 local3
	retries	3
	option redispatch
	maxconn 10240

	timeout check	1s
	timeout http-request 10s
	timeout queue	1m
	timeout connect	10s
	timeout client	1m
	timeout server	1m
	timeout http-keep-alive 30s

listen stats
	mode  http
	#bind  0.0.0.0:8090
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
	acl url_dynamic path_end -i .php
	acl url_thinkphp hdr_beg(host) -i localhost

	default_backend webservers
	use_backend dynamic if url_dynamic
	use_backend weba if url_thinkphp

backend webservers
	balance roundrobin
	server web1 IP:80 check rise 2 fall 1 weight 2
	server web2 IP:80 check rise 2 fall 1 weight 2

backend dynamic
	balance source
	server lamp IP:80 check rise 2 fall 1

backend weba
	balance roundrobin
	server web1 IP:80 check rise 2 fall 1 weight 2```



