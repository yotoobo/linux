* install vim from source
```
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev  
cd vim74/  
./configure --prefix=/usr/local/ --enable-gui=auto --with-x --with-features=huge --enable-sniff --enable-multibyte --enable-xim --enable-cscope --enable-luainterp=yes --enable-perlinterp=yes --enable-pythoninterp=yes --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu  --enable-python3interp=yes --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu/  --enable-rubyinterp=yes --disable-gpm   
make VIMRUNTIMEDIR=/usr/share/vim/vim74  
sudo make install
```
