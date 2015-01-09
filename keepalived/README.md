## What's Keepalived
  **Keepalived** 是一款路由软件。它的主要目标就是解决单点故障，确保服务高可用。而且它还可以做服务器群的健康监测，自动  
剔除群中的故障机器，待其服务可用时，在添加到群中。

## 文档
  * [官方文档](http://www.keepalived.org/documentation.html)  
  * [VRRP协议](http://bbs.nanjimao.com/thread-790-1-1.html)  
  * [Keepalived原理与实战精讲](http://bbs.nanjimao.com/thread-845-1-1.html)  
  * [keepalived工作原理和配置说明](http://outofmemory.cn/wiki/keepalived-configuration)

## 应用场景
  * LVS+Keepalived
  * Nginx+Keepalived
  * HAProxy+Keepalived

## 故障排查
  1. 关闭防火墙
  2. 查看message
  3. 配置文件是否正确？因为那怕文件错了，keepalived也可以正常启动。