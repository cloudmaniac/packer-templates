#!/bin/bash

echo "Building Ubuntu 20.04 LTS (Focal Fossa) template"

packer build -var-file=var-ubuntu-20.04.json packer-ubuntu.json
