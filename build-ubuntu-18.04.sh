#!/bin/bash

echo "Building Ubuntu 18.04.3 LTS (Bionic Beaver) template"

packer build -var-file=var-ubuntu-18.04.json packer-ubuntu.json
