cd vim74
./configure --prefix=/usr/local/ --with-features=huge --enable-multibyte --enable-cscope --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config --enable-python3interp --with-python3-config-dir=/usr/lib/python3.3/config --enable-rubyinterp --enable-perlinterp --enable-luainterp 
make VIMRUNTIMEDIR=/usr/local/share/vim/vim74
sudo make install
