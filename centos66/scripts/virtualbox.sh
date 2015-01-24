#!/bin/bash

# install virtualbox guest additions
cd /tmp
sudo mount -o loop /home/kotetsu/VBoxGuestAdditions.iso /mnt
sudo sh /mnt/VBoxLinuxAdditions.run
sudo umount /mnt
sudo /etc/rc.d/init.d/vboxadd setup
rm /home/kotetsu/VBoxGuestAdditions.iso
