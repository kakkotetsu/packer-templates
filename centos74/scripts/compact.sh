#!/bin/bash

# clear yum cache
sudo yum clean all

# zero out the free space to save space
sudo dd if=/dev/zero of=/empty bs=1M
sudo rm -f /empty
