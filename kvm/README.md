* 准备工作  
CPU是否支持虚拟化  
```egrep '(vmx|svm)' --color=always /proc/cpuinfo```  
关闭selinux  
调整iptables(测试环境可直接关闭)  

* 安装kvm  
on centos/rhel 6,  
```	
yum install kvm libvirt python-virtinst qemu-kvm bridge-utils libguestfs-tools virt-top  
service libvirtd start  
```  
on ubuntu 14/mint 17,  
```sudo apt-get install kvm qemu virtinst python-libvirt virt-viewer virt-manager```  

* 配置bridge  
on centos/rhel 6,  
```
#cd /etc/sysconfig/network-scripts/
#cat ifcfg-br0 
DEVICE="br0"
NM_CONTROLLED="yes"
ONBOOT=yes
TYPE=Bridge
BOOTPROTO=none
IPADDR=10.49.1.170
PREFIX=16
GATEWAY=10.49.0.1
DNS1=221.228.255.1
DNS2=114.114.114.114
DEFROUTE=yes
IPV4_FAILURE_FATAL=yes
IPV6INIT=no
NAME="System br0"

#cat ifcfg-eth0
DEVICE=eth0
HWADDR=B8:2A:72:D4:89:2D
TYPE=Ethernet
UUID=f52780a4-f34c-4301-8aca-f0b31808f222
ONBOOT=yes
NM_CONTROLLED=yes
BOOTPROTO=none
BRIDGE=br0
```
on ubuntu 14/mint 17,   
```
$cat /etc/network/interfaces
auto lo
iface lo inet loopback
auto eth0
iface eth0 inet manual
auto br0
iface br0 inet static
address 10.49.1.171
netmask 255.255.0.0
gateway 10.49.0.1
bridge_ports eth0

```   

* 创建guest  
use virt-install,  
```
virt-install --name=vm1_171 --ram 2048 --vcpus=2 --disk path=/home/kvm/vm1_171.img,size=50,bus=virtio --accelerate --cdrom /home/nginx/CentOS-6.5-x86_64-bin-DVD1.iso --hvm --vnc --vncport=5910 --vnclisten=0.0.0.0 --network bridge=br0,model=virtio --noautoconsole
```  

* 使用vnc viewer连接guest  
windows，  
  tightvnc viewer  

* guest 基本操作    
查看    
```virsh list --all```    
启动  
```virsh start vm1_171```    
```virsh create /etc/libvirt/qemu/vm1_171.xml```    
guest自动启动    
```virsh autostart vm1_171```  
关机  
```virsh shutdown vm1_171```  
强制关闭  
```virsh destroy vm1_171```  
导出guest配置文件  
```virsh dumpxml vm1_171 > /etc/libvirt/qemu/name2.xml ```  
编辑guest配置文件  
```virsh edit vm1_171```  
删除  
```virsh undefine vm1_171```  

* 克隆  
```virt-clone -o vm1_171 -n vm1_172 --file /home/kvm/vm1_172.img```  
修改vm1_172的网卡配置,  
```virt-edit -d vm1_172 /etc/sysconfig/network-scripts/ifcfg-eth0```  

* 虚拟化管理平台  
ConVirt   

* 参考  
http://www.linux-kvm.org/page/Main_Page  
http://koumm.blog.51cto.com/703525/1288795  
