#!/bin/bash

# Update the box
apt-get -y update
apt-get -y upgrade

# Base tools
apt-get -y install open-vm-tools vim curl wget traceroute net-tools

# Additional management tools 
apt-get -y install tree nmap

# (optional) Debug tools
#apt-get -y install iftop iotop htop
