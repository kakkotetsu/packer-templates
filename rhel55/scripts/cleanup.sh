echo "Cleaning up repos..."
yum -q -y clean all

echo "Removing guest additions ISO file..."
rm -rf VBoxGuestAdditions_*.iso

echo "Removing traces of MAC address from network configuration..."
sed -i /HWADDR/d /etc/sysconfig/network-scripts/ifcfg-eth0