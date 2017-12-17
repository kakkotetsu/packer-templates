#!/bin/bash

#set -e
#set -x

# disable selinux
sudo /usr/sbin/setenforce 0
sudo sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config

# setup ssh
sudo sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
sudo sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config
sudo rm -f /root/.ssh/authorized_keys

# enable epel repository
sudo yum -y install https://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm
sudo sed -i -e 's/^enabled=1/enabled=0/' /etc/yum.repos.d/epel.repo

# PROXY setting (if use)
#PROXY="http://example.com:8080/"
#echo "proxy=$PROXY" >> /etc/yum.conf

# install dev tools
sudo yum -y install gcc make automake autoconf libtool gcc-c++ kernel-headers-`uname -r` kernel-devel-`uname -r` zlib-devel openssl openssl-devel readline-devel wget

# upgrade yum
sudo yum -y upgrade

# clean yum
if rpm -q --whatprovides kernel | grep -Fqv "$(uname -r)"; then
  rpm -q --whatprovides kernel | grep -Fv "$(uname -r)" | xargs sudo yum -y autoremove
fi

sudo yum --enablerepo=epel clean all
sudo yum history new
sudo truncate -c -s 0 /var/log/yum.log
