#!/bin/bash

################
# Clean up APT #
################
apt-get autoremove
apt-get clean

#############################
# Clean up temp directories #
#############################
rm -rf /tmp/*
rm -rf /var/tmp/*

#################
# Clean up logs #
#################
if [ -f /var/log/wtmp ]; then
    truncate -s0 /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
    truncate -s0 /var/log/lastlog
fi

#####################
# Clean up SSH keys #
#####################
rm -f /etc/ssh/ssh_host_*

#################################################################
# Regenerate SSH keys (otherwhise, impossible to log using SSH) #
# Error message: "Connection closed by 10.67.10.7 port 22"      #
#################################################################
tee /etc/rc.local >/dev/null <<EOL
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#

# By default this script does nothing.
test -f /etc/ssh/ssh_host_dsa_key || dpkg-reconfigure openssh-server
exit 0
EOL

##############################################
# Don't forget to make the script executable #
##############################################
chmod +x /etc/rc.local

#####################################################################
# Reset /etc/machine-id (as it is used to request IP using DHCP)    #
# http://manpages.ubuntu.com/manpages/bionic/man5/machine-id.5.html #
#####################################################################
truncate -s0 /etc/machine-id

##################
# Hostname reset #
##################
# Prevent cloudconfig to preserve current hostname
#sed -i 's/preserve_hostname: false/preserve_hostname: true/g' /etc/cloud/cloud.cfg
truncate -s0 /etc/hostname
hostnamectl set-hostname localhost

###############################
# Clean network configuration #
###############################
rm /etc/netplan/*.yaml

####################
# Clean up history #
####################
history -c && history -w
