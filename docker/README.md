# 安装Docker  
* ubuntu >= 14.04  
```
$ sudo apt-get install apt-transport-https
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
$ sudo bash -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
$ sudo apt-get update
$ sudo apt-get install lxc-docker
```  
* ubuntu < 14.04  
首先要更新内核，在执行上述步骤
```
$ sudo apt-get update
$ sudo apt-get install linux-image-generic-lts-raring linux-headers-generic-lts-raring
$ sudo reboot
```  

* Centos 6  
如果是centos 7，直接yum install docker即可
```
$ sudo yum install http://mirrors.yun-idc.com/epel/6/x86_64/epel-release-6-8.noarch.rpm
$ sudo yum install docker-io
```  

* 启动服务  
```service docker start```

# 常用docker选项  
* 搜索并拉取镜像
```
$ docker search image-name
$ docker pull image-name
```  
* 查看镜像  
```$ docker images ```  

* 运行容器  
启动一个新容器  
```$ docker run -t -i image-name ```  
其中，-t 选项让Docker分配一个伪终端（pseudo-tty）并绑定到容器的标准输入上， -i 则让容器的标准输入保持打开  
启动已终止容器  
```$ docker start ID ```  
如果需要容器在后台保持运行，添加参数 -d  

* 查看all容器  
```$ docker ps -a```  

* 终止容器  
```$ docker stop ID```  

* 进入容器  
使用docker attach ID  
使用nsenter  

* 提交更改  
```$ docker commit -m "说明" -a "维护者信息" 容器ID 目标镜像仓库名:tag ```  

* 移除  
移除镜像  
```docker rmi image-name```  
移除容器  
```docker rm ID```  

