### Gogs

一款极易搭建的自助 Git 服务 :

- 易安装
- 开源
- 轻量级

### 部署

在虚拟机(IP：192.168.148.132)中使用 docker 命令安装 :

`docker run -d --name gogs -p 10022:22 -p 10081:3000 -v $PWD/gogs:/data gogs/gogs`

打开浏览器，访问 **http://182.168.148.132:10081** .

1. 为了简单，这里使用 SQLite3 数据库：

![](https:/img.pycoder.org/blog/20200202193557.png)

2. 修改域名及应用 URL：

![](https:/img.pycoder.org/blog/20200202193949.png)

3. 添加管理员账号：

![](https:/img.pycoder.org/blog/20200202194058.png)

其他配置直接默认即可，点击立即安装。
