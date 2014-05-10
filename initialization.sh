#!/bin/sh
# Add yum repo "
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-11.ius.centos6.noarch.rpm
sed -i 's/enabled=1/enabled=0/' /etc/yum.repo.d/epel.repo
sed -i 's/enabled=1/enabled=0/' /etc/yum.repo.d/ius.repo
yum -y install make gcc gcc-c++ wget unzip sysstat

echo "clock some users..."
usermod -L vcsa
usermod -L games
usermod -L nobody
usermod -L gopher
usermod -L ftp
usermod -L mail
usermod -L shutdown
usermod -L halt
usermod -L uucp
usermod -L operator
usermod -L sync
usermod -L adm
usermod -L lp

# clock these files
chattr +i /etc/passwd
chattr +i /etc/shadow
chattr +i /etc/group
chattr +i /etc/gshadow

# Set the password lock 5 minutes after the mistyped 3 times in a row
sed -i 's#auth        required      pam_env.so#auth        required      pam_env.so\nauth       required       pam_tally.so  onerr=fail deny=3 unlock_time=300\nauth           required     /lib/security/$ISA/pam_tally.so onerr=fail deny=3 unlock_time=300#' /etc/pam.d/system-auth

# Set the timeout for users 
echo "TMOUT=300" >>/etc/profile

# Set history size
sed -i "s/HISTSIZE=1000/HISTSIZE=10/" /etc/profile
source /etc/profile

# disabled SElinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

# config /etc/sysctl.conf
cat >> /etc/sysctl.conf << EOF
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 1
net.ipv4.tcp_keepalive_time = 20
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.ip_local_port_range = 3000 65535
EOF
sysctl -p 

# config sshd_config
sed -i "s/#MaxAuthTries 6/MaxAuthTries 6/" /etc/ssh/sshd_config
sed -i  "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config

# Limit command authority
chmod 700 /bin/ping
chmod 700 /usr/bin/finger
chmod 700 /usr/bin/who
chmod 700 /usr/bin/w
chmod 700 /usr/bin/locate
chmod 700 /usr/bin/whereis
chmod 700 /sbin/ifconfig
chmod 700 /usr/bin/pico
chmod 700 /bin/vi
chmod 700 /usr/bin/vim
chmod 700 /usr/bin/which
chmod 700 /usr/bin/gcc
chmod 700 /usr/bin/make
chmod 700 /bin/rpm
chmod 700 /bin/kill
chmod 700 /usr/bin/pkill
chmod 700 /usr/bin/killall





