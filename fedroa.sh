#!/bin/bash
#make fedroa20 to useful for me,ha
sudo yum -y update

#use fcitx and sougou
sudo yum -y remove ibus
sduo yum -y install fcitx fcitx-devel fcitx-configtool
cd ~
cat >> ~/.bashrc << EOF
export GTK_IM_MODULE=fcitx  
export QT_IM_MODULE=fcitx  
export XMODIFIERS="@im=fcitx"
EOF
wget http://mirrors.ustc.edu.cn/deepin/pool/non-free/f/fcitx-sogoupinyin-release/fcitx-sogoupinyin_0.0.6-1_amd64.deb
ar vx fcitx-sogoupinyin_0.0.6-1_amd64.deb
sudo tar -Jxvf data.tar.xz -C /
sudo cp /usr/lib/x86_64-linux-gnu/fcitx/fcitx-sogoupinyin.so /usr/lib64/fcitx/
sudo chmod +x /usr/lib64/fcitx/fcitx-sogoupinyin.so

#install flash
sudo rpm -Uvh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
sudo yum -y install flash-plugin

#install gnome-tweak-tool
sudo yum -y install gnome-tweak-tool

#install software-center
sudo yum -y install gnome-software


