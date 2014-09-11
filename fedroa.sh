#!/bin/bash
#
#update system and install some softwares
#
sudo yum -y update

sudo rpm -Uvh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
sudo rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
sudo rpm -ivh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm
sudo yum -y yum-plugin-fastestmirror flash-plugin gnome-tweak-tool gnome-software mplayer smplayer teamview terminator

#
#use fcitx and sougou
#
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

#
#config terminator
#
cd ~/config/
[ !-d ~/.config/terminator ] && mkdir ~/.config/terminator
mv config ~/.config/terminator/
mv dircolors ~/.dircolors

#
#中文字体发虚
#
sudo rpm -Uvh http://www.infinality.net/fedora/linux/infinality-repo-1.0-1.noarch.rpm
sudo yum -y install freetype-infinality infinality-settings
mkfontdir
mkfontscale
fc-cache -fv
