# 安装字体  
``` $ sudo sh get-fonts.sh ```  

# 安装flash  
```
$ sudo apt-get install flashplugin-installer
```  

# 管理服务  
``` $ sudo apt-get install sysv-rc-conf ```

# 自定义默认软件  
```
$ sudo update-alternatives --install /usr/bin/java java /usr/java/jdk/bin/java 300
$ sudo update-alternatives --install /usr/bin/javac javac /usr/java/jdk/bin/javac 300
更多用法请参考help
```  

# 使用Terminator作为默认终端
安装
```
$ sudo add-apt-repository ppa:gnome-terminator
$ sudo apt-get update
$ sudo apt-get install terminator
```
自定义terminator
```
$ [ -d ~/.config/terminator ] || mkdir ~/.config/terminator
$ mv config ~/.config/terminator/
$ mv dircolors ~/.dircolors
$ cat >> ~/.zshrc << EOF
if [ -f `which terminator` ];then
	if [ -x /usr/bin/dircolors ]; then
		test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	fi
fi
EOF

```
使用
```
$ terminator
Ctrl+Shift+E 垂直分割窗口
Ctrl+Shift+O 水平分割窗口
F11 全屏
Ctrl+Shift+C 复制
Ctrl+Shift+V 粘贴
Ctrl+Shift+N 或者 Ctrl+Tab 在分割的各窗口之间切换
Ctrl+Shift+X 将分割的某一个窗口放大至全屏使用
Ctrl+Shift+Z 从放大至全屏的某一窗口回到多窗格界面
```

# ubuntu-make  
```
Installing Ubuntu Make

If you are on Ubuntu 14.04 LTS, first, add the Ubuntu Make ppa:

    $ sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make 
    $ sudo apt-get update 

Then, installing Ubuntu Make:

    $ sudo apt-get install ubuntu-make 

How to install android-studio

    $ umake android 
```

# 常用软件 
软件包管理:新立得软件包管理器  
docky:类似苹果的任务栏  
系统管理:ubuntu tweak  
vpn插件:network-manager-vpnc  
虚拟化:virtualbox  
ftp:Filezilla  
邮件:thunderbird  
截图:shutter  
词典:星际译王  
影视:VLC,smplayer  
IDE:Eclipse  
制图:yEd  
