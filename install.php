#yum
yum -y install libicu-devel

#download php5.5
cd ~
wget http://mirrors.sohu.com/php/php-5.5.17.tar.bz2

#install php
tar jxf php-5.5.17.tar.bz2
cd php-5.5.17
./configure --prefix=/usr/local/php55 --with-config-file-path=/usr/local/php55/etc --with-config-file-scan-dir=/usr/local/php55/etc/php.d --enable-bcmath --enable-exif --enable-sockets --enable-mbstring --enable-fpm --enable-soap --with-mcrypt --with-bz2 --with-openssl --with-zlib --with-mhash --with-mysqli --with-pdo-mysql
make
make install
cp php.ini-production /usr/local/php55/etc/php.ini
cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod u+x /etc/init.d/php-fpm
cp /usr/local/php55/etc/php-fpm.conf.default /usr/local/php55/etc/php-fpm.conf
[ -d /usr/local/php55/etc/php.d ] || mkdir /usr/local/php55/etc/php.d

#install extension
cd ~
wget http://pecl.php.net/get/intl-3.0.0.tgz
tar zxf intl-3.0.0.tgz
cd intl-3.0.0
phpize
./configure --enable-intl
make && make install
echo "extension=intl.so" >> /usr/local/php5/etc/php.d/extension.ini
cd ..

wget http://pecl.php.net/get/memcache-3.0.8.tgz
tar zxf memcache-3.0.8.tgz
cd memcache-3.0.8
phpize
./configure --enable-memcache
make && make install
echo "extension=memcache.so" >> /usr/local/php5/etc/php.d/extension.ini
cd ..


