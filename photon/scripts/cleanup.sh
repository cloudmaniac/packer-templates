#!/bin/bash

#######################
# Clean up TDNF cache #
#######################
tdnf clean all

#################
# Clean up logs #
#################
cat /dev/null > /var/log/wtmp 2>/dev/null
logrotate -f /etc/logrotate.conf 2>/dev/null
find /var/log -type f -delete
rm -rf /var/log/journal/*
rm -f /var/lib/dhcp/*

# Zero out the free space to save space in the final image, blocking 'til
# written otherwise, the disk image won't be zeroed, and/or Packer will try to
# kill the box while the disk is still full and that's bad.  The dd will run
# 'til failure, so (due to the 'set -e' above), ignore that failure.  Also,
# really make certain that both the zeros and the file removal really sync; the
# extra sleep 1 and sync shouldn't be necessary, but...)

#echo '> Zeroing device to make space...'
dd if=/dev/zero of=/EMPTY bs=1M || true; sync; sleep 1; sync
rm -f /EMPTY; sync; sleep 1; sync

#unset HISTFILE && history -c && rm -fr /root/.bash_history

##################
# Done / Version #
##################
cat /etc/photon-release
date
