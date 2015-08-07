* 文档  
  * [admin-guide](http://nginx.com/resources/admin-guide/) 
  * [wiki](http://wiki.nginx.org/Main)
  * [documentation](http://nginx.org/en/docs/)
  * [nginx-resources](https://github.com/fcambus/nginx-resources)  
  
* 应用
  * Nginx之正向代理  
  示例代码  
```
server{  
        resolver 114.114.114.114;  
        resolver_timeout 30s;   
        listen 1082;  
        location / {  
                proxy_pass http://$http_host$request_uri;  
                proxy_set_header Host $http_host;  
                proxy_buffers 256 4k;  
                proxy_max_temp_file_size 0;  
                proxy_connect_timeout 30;  
                proxy_cache_valid 200 302 10m;  
                proxy_cache_valid 301 1h;  
                proxy_cache_valid any 1m;  
        }  
}  
```  
  * Nginx之反向代理+负载均衡  
  示例代码
```
upstream test.com_static {
    server 10.10.7.106:80;
}
upstream test.com_dynamic { #负载均衡
    ip_hash; #负载算法
    server 10.10.7.109:80 max_fails=3 fail_timeout=5s; #健康检测
    server 10.10.7.110:80;
    server 10.10.7.113:80;
}
 
server {
    listen 80;
    server_name *.test.com;
    access_log  logs/test.com.access.log main buffer=32k flush=10s;
    
    location ~* \.(jpeg|jpg|png|gif|js|css)$ { #做动静分离
        proxy_pass http://test.com_static;
        proxy_read_timeout 300;
        proxy_buffering off;
        proxy_redirect off;
        proxy_intercept_errors on;
        proxy_http_version  1.1;
        proxy_set_header    Connection "";
        proxy_set_header    Host    $host;
        proxy_set_header    X-Real-IP       $remote_addr;
        proxy_set_header    x-forwarded-for $remote_addr;
        client_max_body_size  3072k;
        client_body_buffer_size 128k; 
    }
    
    location / {
        proxy_pass http://test.com_dynamic;
        proxy_read_timeout 300;
        proxy_buffering off;
        proxy_redirect off;
        proxy_intercept_errors on;
        proxy_http_version  1.1;
        proxy_set_header    Connection "";
        proxy_set_header    Host    $host;
        proxy_set_header    X-Real-IP       $remote_addr;
        proxy_set_header    x-forwarded-for $remote_addr;
        client_max_body_size  3072k;
        client_body_buffer_size 128k; 
    }
}
```  
  * Nginx之页面缓存  
  

