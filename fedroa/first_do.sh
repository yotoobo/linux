#!/bin/bash

# When you installed Fedora,then you first do it
# It's test on Fedora 22+
# 8/22/2015

echo "Step 1, Now it's update system ... "
sleep 2
sudo dnf -y -q update

clear

echo "Step 2, Install softwares:
1. gnome-tweak-tool 
2. cairo-dock 
3. VLC
4. Adobe Flash
5. google-chrome
"
sleep 3

# add repo
su -c 'yum install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'
## Adobe Repository 64-bit x86_64 ##
sudo rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
# chrome
sudo cat >> /etc/yum.repo.d/google-chrome.repo << EOF
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
# Add google public key
if [ -f './google_signing_key.pub' ]:then
    sudo rpm --import ./google_signing_key.pub
else
    sudo sed -i 's/gpgcheck=1/gpgcheck=0/' /etc/yum.repo.d/google-chrome.repo
fi

sudo dnf -y -q cairo-dock gnome-tweak-tool vlc flash-plugin google-chrome-stable

exit 0

# config terminator
cd ~/config/
[ !-d ~/.config/terminator ] && mkdir ~/.config/terminator
mv config ~/.config/terminator/
mv dircolors ~/.dircolors

#中文字体发虚
#sudo rpm -Uvh http://www.infinality.net/fedora/linux/infinality-repo-1.0-1.noarch.rpm
#sudo yum -y install freetype-infinality infinality-settings
#sudo mkfontdir
#sudo mkfontscale
#fc-cache -fv

#install orchis-gtk-theme
#sudo wget http://download.opensuse.org/repositories/home:/snwh:/orchis-gtk-theme/Fedora_20/home:snwh:orchis-gtk-theme.repo -O /etc/yum.repos.d/orchis-gtk-theme.repo
#sudo yum update
#sudo yum install orchis-gtk-theme

#vim
#./configure --prefix=/usr/local/ --with-features=huge --enable-multibyte --enable-cscope --enable-sniff --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config --enable-python3interp --with-python3-config-dir=/usr/lib/python3.3/config --enable-rubyinterp --enable-perlinterp --enable-luainterp
#make VIMRUNTIMEDIR=/usr/local/share/vim/vim74
#sudo make install
