#!/bin/bash

#dir define
myfonts_dir=/usr/share/fonts/truetype/myfonts
remote_dir=http://files.cnblogs.com/DengYangjun

#fonts define
monaco=monaco-linux.ttf
lucida=lucida-console.ttf
msyh=msyh.ttf
msyhbd=msyhbd.ttf
agencyr=agencyr.ttf
agencyrb=agencyrb.ttf

screen=0

sudo mkdir $myfonts_dir 2>/dev/null

echo "Ubuntu字体自动安装工具"
echo "(C)2008-2009 Deng.Yangjun@Gmail.com"

echo "安装等宽英文台字体:Monaco"
wget -O $monaco.zip $remote_dir/$monaco.zip
unzip -o $monaco.zip 1>/dev/null
sudo mv $monaco $myfonts_dir
rm $monaco.zip

echo "安装等宽英文字体:Lucida Console"
wget -O $lucida.zip $remote_dir/$lucida.zip
unzip -o $lucida.zip 1>/dev/null
sudo mv $lucida $myfonts_dir
rm $lucida.zip

echo "安装英文字体:Agency FB"
wget -O $agencyr.zip $remote_dir/$agencyr.zip
unzip -o $agencyr.zip 1>/dev/null
sudo mv $agencyr $myfonts_dir
rm $agencyr.zip

wget -O $agencyrb.zip $remote_dir/$agencyrb.zip
unzip -o $agencyrb.zip 1>/dev/null
sudo mv $agencyrb $myfonts_dir
rm $agencyrb.zip

echo "安装字体:微软雅黑"
wget -O $msyh.zip $remote_dir/$msyh.zip
unzip -o $msyh.zip 1>/dev/null
sudo mv $msyh $myfonts_dir
rm $msyh.zip

wget -O $msyhbd.zip $remote_dir/$msyhbd.zip
unzip -o $msyhbd.zip 1>/dev/null
sudo mv $msyhbd $myfonts_dir
rm $msyhbd.zip

#Ubuntu 7.10
#wget http://www.cnblogs.com/Files/DengYangjun/language-selector.conf.zip
#unzip -o language-selector.conf.zip
#sudo mv language-selector.conf /etc/fonts
#rm language-selector.conf.zip

#Ubuntu 8.04 
echo "请选择显示器类型(1-2)：1-LED	2-CRT"
read screen
case $screen in
1) 
	wget -O local.conf.zip  $remote_dir/local.conf.led.zip
	;;
2)	
	wget -O local.conf.zip  $remote_dir/local.conf.crt.zip
	;;
?) 
	echo "无效选择，退出安装，安装未完成。"
	exit 1;
esac

unzip -o local.conf.zip 1>/dev/null
sudo mv /etc/fonts/conf.avail/51-local.conf /etc/fonts/conf.avail/51-local.conf.old
sudo mv local.conf /etc/fonts/conf.avail/51-local.conf
rm local.conf.zip

cd /etc/fonts/conf.avail
sudo mv 69-language-selector-zh-cn.conf 69-language-selector-zh-cn.conf.old 2>/dev/null

echo "请稍等，正在刷新系统字体..."
cd $myfonts_dir
sudo chmod 555 *
sudo mkfontscale 1>/dev/null
sudo mkfontdir 1>/dev/null
sudo fc-cache -v 1>/dev/null

echo "安装字体结束，谢谢使用。请退出X-Server，重新登录，查看字体效果。"

