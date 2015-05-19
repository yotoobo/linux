## 分布式文件系统  

#常见DFS  
  * GFS  
  * HDFS  
  * TFS  
  * Fastdfs  
  * mogilefs  

# Fastdfs 部署  
1. 建议使用单盘mount，多盘配置多个store_path

2. max_connections: max_connections * butter_size = 消耗内存

3. work_threads
  * tracker server: work_threads +1 = CPU数  
  * storage server: work_threads +1 +(disk_reader_threads +disk_writer_threads)* store_path_count = CPU数  

4. subdir_count_per_path: 如启用trunk存储，则适当调小  

5. sync_binlog_buff_interval :将binlog buffer 写入磁盘的时间间隔  
   sync_wait_msec :如果没有同步到文件，对binlog进行轮询的时间间隔  
   sync_interval :同步完一个文件后，休眠的毫秒数
   如发现文件同步延迟过大，可适当调小上述参数  

6. 交流  
   论坛 http://bbs.chinaunix.net/forum-240-1.html
   QQ   164684842
