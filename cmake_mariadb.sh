#
yum -y install ncurses-devel cmake 

#install jemalloc 
wget http://www.canonware.com/download/jemalloc/jemalloc-3.6.0.tar.bz2
tar jxf jemalloc-3.6.0.tar.bz2
cd jemalloc-3.6.0
./configure
make
make install
echo '/usr/local/lib' > /etc/ld.so.conf.d/local.conf
ldconfig

#install mariadb for source 
wget http://mirrors.neusoft.edu.cn/mariadb/mariadb-5.5.40/source/mariadb-5.5.40.tar.gz
tar zxf mariadb-5.5.40.tar.gz
cd mariadb-5.5.40
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mariadb55 -DMYSQL_DATADIR=/home/data/mysql \
-DWITH_READLINE=on -DCMAKE_EXE_LINKER_FLAGS="-ljemalloc" -DWITH_SAFEMALLOC=OFF \
-DWITH_XTRADB_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_XTRADB_STORAGE_ENGINE=1 \
-DWITH_SPHINX_STORAGE_ENGINE=1 \
-DWITH_ZLIB=bundled \
-DWITH_SSL=bundled \
-DENABLED_LOCAL_INFILE=1 \
-DWITH_EXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DWITH_DEBUG=0
make
make install
cd support-files/
cp mysql.server /etc/init.d/mysql
chmod u+x /etc/init.d/mysql
cp my-innodb-heavy-4G.cnf /etc/my.cnf
