#!/bin/bash

echo "Building Ubuntu 22.04 LTS (Jammy Jellyfish) template"

packer build -force -var-file=../clouds/var-infra-z67.json ubuntu-22.04.json
