#!/bin/bash

echo "Building Photon OS 3.0 template"

packer build -var-file=../clouds/var-infra-z67.json photon-3.0.json
