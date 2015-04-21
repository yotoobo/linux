# 常用docker选项  
搜索并拉取镜像
```
$ docker search image-name
$ docker pull image-name
```  
运行容器  
```$ docker run -t -i image-name ```  
查看镜像  
```$ docker images ```  
查看all容器  
```$ docker ps -a```  
提交更改
```$ docker commit -m "说明" -a "维护者信息" 容器ID 目标镜像仓库名:tag ```
