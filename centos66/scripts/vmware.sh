# import vmware repository keys
#sudo rpm --httpproxy proxy.example.com --httpport 8080 --import http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-DSA-KEY.pub
#sudo rpm --httpproxy proxy.example.com --httpport 8080 --import http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-RSA-KEY.pub
sudo rpm --import http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-DSA-KEY.pub
sudo rpm --import http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-RSA-KEY.pub

# add repository
sudo sh -c 'echo '[vmware-tools]' > /etc/yum.repos.d/vmware-tools.repo'
sudo sh -c 'echo 'name=VMware Tools' >> /etc/yum.repos.d/vmware-tools.repo'
sudo sh -c 'echo 'baseurl=http://packages.vmware.com/tools/esx/5.5p01/rhel6/x86_64/' >> /etc/yum.repos.d/vmware-tools.repo'
sudo sh -c 'echo 'enabled=1' >> /etc/yum.repos.d/vmware-tools.repo'
sudo sh -c 'echo 'gpgcheck=1' >> /etc/yum.repos.d/vmware-tools.repo'

# Installing the VMware guest additions
sudo yum -y install vmware-tools-esx-nox
