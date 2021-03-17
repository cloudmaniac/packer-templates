#!/bin/bash

echo "Building Ubuntu 20.04.2 LTS (Focal Fossa) template"

packer build -force -var-file=../clouds/var-infra-z67.json ubuntu-20.04.json
