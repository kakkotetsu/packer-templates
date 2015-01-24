VBOX_VERSION=$(cat /home/kotetsu/.vbox_version)
echo "Installing VirtualBox guest additions..."
mount -o loop /home/kotetsu/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm VBoxGuestAdditions_$VBOX_VERSION.iso
