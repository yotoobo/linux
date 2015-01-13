## 更合理的运用PHP  
_安装_
  * 源码编译，最小化安装！  
_修改php.ini_
  * disable_functions  
  * memory_limit
  * register_globals = Off
  * upload_max_filesize
  * max_execution_time
  * error_log  
_修改php-fpm_
  * 使用多个进程池
  * 采用socket连接
  * pm = static  

## 参考
  * [优化杂谈](http://huoding.com/2014/12/25/398)
