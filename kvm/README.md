* 安装kvm  
on centos/rhel 6,  
```	
yum install kvm libvirt python-virtinst qemu-kvm bridge-utils 
service libvirtd start

```  

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
```virsh start name```  
```virsh create /etc/libvirt/qemu/name.xml```  
guest自动启动  
```virsh autostart name
关机  
```virsh shutdown name```  
强制关闭  
```virsh destroy name```  
导出guest配置文件  
```virsh dumpxml name > /etc/libvirt/qemu/name2.xml ```  
编辑guest配置文件  
```virsh edit name```  
删除  
```virsh undefine name```  

