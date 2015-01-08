## What's Keepalived
  **Keepalived** 是一款路由软件。它的主要目标就是解决单点故障，确保服务高可用。而且它还可以做服务器群的健康监测，自动  
剔除群中的故障机器，待其服务可用时，在添加到群中。

## 文档
  * [官方文档](http://www.keepalived.org/documentation.html)  
  * [VRRP协议](http://bbs.nanjimao.com/thread-790-1-1.html)  
  * [Keepalived原理与实战精讲](http://bbs.nanjimao.com/thread-845-1-1.html)  

## 应用场景
  * LVS+Keepalived
  * Nginx+Keepalived
  * HAProxy+Keepalived

## keepalived.cfg 示例
```
! Configuration File for keepalived

global_defs { #配置邮件通知，可省略
	notification_email {
	}	
}

vrrp_script check { #执行检查
	script "/opt/sh/check.sh"
	interval 1
	weight -2
}


vrrp_instance Haproxy {
    state MASTER  #备机此处为BACKUP
    interface eth0
    virtual_router_id 51
    priority 100  #备机此处数值应小于100 
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }

    virtual_ipaddress {  #虚拟IP
	10.0.0.1  
    }

    track_script { #执行
	check
    }
} ```



