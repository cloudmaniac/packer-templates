#!/bin/bash

# Update
tdnf -y update

# Base tools
tdnf install -y \
  wget \
  unzip

# Ping
tdnf install iputils

# Misc
# traceroute net-tools
