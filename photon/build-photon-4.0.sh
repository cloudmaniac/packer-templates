#!/bin/bash

echo "Building Photon OS 4.0 template"

packer build -force -var-file=../clouds/var-infra-z67.json photon-4.0.json
