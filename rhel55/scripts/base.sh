# Make ssh faster by not waiting on DNS
echo "UseDNS no" >> /etc/ssh/sshd_config

# Don't require tty for sudo
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# PROXY setting (if use)
#PROXY="http://example.com:8080/"
#echo "proxy=$PROXY" >> /etc/yum.conf

# Update packages
echo "Installing updates..."
yum -y update > /tmp/yum-update.log 2>&1 || \
    { echo "Command 'yum update' failed - see /tmp/yum-update.log for details."; exit 1; }

# Install base packages
echo "Installing base packages..."
yum -q -y install gcc make gcc-c++ zlib-devel \
    openssl-devel readline-devel sqlite-devel perl wget dkms nfs-utils unzip > /tmp/yum-install-base.log 2>&1 || \
    { echo "Command 'yum install ...' for base packages failed - see /tmp/yum-install-base.log for details."; exit 1; }

# Install gcc, etc.
echo "Installing development tools..."
yum -q -y groupinstall "development tools" > /tmp/yum-groupinstall-development-tools.log 2>&1 || \
    { echo "Command 'yum group install \"development-tools\"' failed - see /tmp/yum-groupinstall-development-tools.log for details."; exit 1; }

# Install kernel headers for the current release
echo "Installing kernel headers..."
yum -q -y install kernel-devel > /tmp/yum-install-kernel-devel.log 2>&1
if [ $? -ne 0 ]; then
    PACKAGE=kernel-devel-`uname -r`
    echo "Could not find 'kernel-devel' package; trying ${PACKAGE}..."
    yum -q -y install ${PACKAGE} >> /tmp/yum-install-kernel-devel.log 2>&1 || \
        { echo "Failed to install kernel headers - see /tmp/yum-install-kernel-devel.log for details."; exit 1; }
fi

# Reboot so that VBoxGuestAdditions can find kernel headers
reboot

# Long sleep to ensure reboot occurs before the script finishes
sleep 1000
