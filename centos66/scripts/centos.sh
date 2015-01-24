bin/bash

# disable selinux
sudo /usr/sbin/setenforce 0
sudo sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config

# setup ssh
sudo sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
sudo sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config
sudo rm -f /root/.ssh/authorized_keys

# enable epel repository
sudo sh -c 'echo "[epel]" >> /etc/yum.repos.d/epel.repo'
sudo sh -c 'echo "name=epel" >> /etc/yum.repos.d/epel.repo'
sudo sh -c 'echo "baseurl=http://download.fedoraproject.org/pub/epel/6/\$basearch" >> /etc/yum.repos.d/epel.repo'
sudo sh -c 'echo "enabled=0" >> /etc/yum.repos.d/epel.repo'
sudo sh -c 'echo "gpgcheck=0" >> /etc/yum.repos.d/epel.repo'

# PROXY setting (if use)
#PROXY="http://example.com:8080/"
#echo "proxy=$PROXY" >> /etc/yum.conf

# install dev tools
sudo yum -y install gcc make automake autoconf libtool gcc-c++ kernel-headers-`uname -r` kernel-devel-`uname -r` zlib-devel openssl openssl-devel readline-devel wget

# install dkms
sudo yum -y --enablerepo=epel install dkms

# upgrade yum
sudo yum -y upgrade
