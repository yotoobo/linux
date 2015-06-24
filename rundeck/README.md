### rundeck

* 系统要求  
centos 6.5 x86_64  
jre 1.7  
4440(port)

* install rundeck  
Installing with yum  
```
rpm -Uvh http://repo.rundeck.org/latest.rpm 
yum install rundeck
service rundeckd start
```  
Installing with Launcher  
```
#download launcher jar file to $RDECK_BASE
export RDECK_BASE="path/to/rundeck"
mkdir $RDECK_BASE
cd $RDECK_BASE
java -XX:MaxPermSize=256m -Xmx1024m -jar rundeck-launcher-2.5.1.jar
```  

