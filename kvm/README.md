* 安装kvm  
on centos/rhel 6,  
```	
yum install kvm libvirt python-virtinst qemu-kvm bridge-utils 
service libvirtd start

```  

* 创建guest  
use virt-install,  
```
virt-install --name=vm1_171 --ram 512 --vcpus=1 --disk path=/home/kvm/vm1_171.img,size=20,bus=virtio --accelerate --cdrom /home/nginx/CentOS-6.5-x86_64-bin-DVD1.iso --vnc --vncport=5910 --vnclisten=0.0.0.0 --network bridge=br0,model=virtio --noautoconsole
```  

