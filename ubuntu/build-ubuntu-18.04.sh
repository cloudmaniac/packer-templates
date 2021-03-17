#!/bin/bash

echo "Building Ubuntu 18.04.5 LTS (Bionic Beaver) template"

packer build -force -var-file=../clouds/var-infra-z67.json ubuntu-18.04.json
