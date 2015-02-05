* 文档  
  * [admin-guide](http://nginx.com/resources/admin-guide/) 
  * [wiki](http://wiki.nginx.org/Main)
  * [documentation](http://nginx.org/en/docs/)
  * [nginx-resources](https://github.com/fcambus/nginx-resources)  
  
* 应用
  * Nginx之反向代理
  示例代码
  ```
upstream test.com_static {
    server 10.10.7.106:80;
}
upstream test.com_dynamic { #负载均衡
    ip_hash;
    server 10.10.7.109:80;
    server 10.10.7.110:80;
    server 10.10.7.113:80;
}
 
server {
    listen 80;
    server_name *.test.com;
    access_log  logs/www.test.com.access.log main buffer=32k flush=10s;
    
    location ~* \.(jpeg|jpg|png|gif|js|css)$ {
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
