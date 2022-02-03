#!/usr/bin/env bash

echo "### ssh-keypair.sh"
set -x #echo on

# ../setup/skel/vagrant.key
cat /etc/skel/vagrant.key >> /root/authorized_keys
cat /etc/skel/vagrant.key >> ~/.ssh/authorized_keys

# .vagrant.d/insecure_private_key
ssh-keygen -y -f /etc/skel/private_key > /etc/skel/private_key.pub
cat /etc/skel/private_key > ~/.ssh/private_key
cat /etc/skel/private_key.pub > ~/.ssh/private_key.pub

# sshd: passwd auth enable
augtool --autosave 'set /files/etc/ssh/sshd_config/PasswordAuthentication yes'
systemctl restart sshd
