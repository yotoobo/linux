#/bin/bash

################
#               #
# name:zhiliang  ##########
# email:yotoobo@gmail.com #
#                         #
###########################

#It's test OK for Centos6.4
#check user
if [ `id -u` -ne 0 ];then
  echo "Sorry,please use root to do it"
  exit
fi

#variables
read -p "Please input some other name for you,because root will be control ..." NAME

echo "Creating /root/passwd.txt ...... "
cat /dev/urandom |strings -n 12|head -12 > /root/passwd.txt
sed -i "s/ //g" /root/passwd.txt
echo "It's Ok, please be careful"

read -p "Input a port number that for ssh,the range is 1024 < number < 65535" PORT

#read -p ""

#disable selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

#services
function SERVICE () {
  sed -i "s/#Port 22/Port $PORT" /etc/sshd/sshd_config
  sed -i "s/#PermitRootLogin yes/PermitRootLogin no/" /etc/sshd/sshd_config
  cat "AllowUsers $NAME" >> /etc/sshd/sshd_config
}

#iptables
function IPTABLES (){
  iptables -F
  iptables -X
  
  iptables -A INPUT -p tcp --dport $PORT -j ACCEPT
  
  iptables -P INPUT DROP
  iptables -P FORWARD DROP
  iptables -P OUTPUT ACCEPT
  
  iptables -A INPUT -i lo -j ACCEPT
  
  service iptables save
  
}

#
function USER {
  
}

