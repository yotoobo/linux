### rundeck

* 测试环境  
centos 6.5 x86_64  
jre 1.7  
rundeck-version 2.5.1

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

* 账户  
添加新用户  
```
cd $RDECK_BASE
java -cp server/lib/jetty-all-7.6.0.v20120127.jar org.eclipse.jetty.util.security.Password user passwd
#此时会输出原密码和加密后的密码，此处采用的是md5加密
echo "user:MD5:xxxxxx,admin" >> server/config/realm.properties 
```  
