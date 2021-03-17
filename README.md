# Automated template creation using Hashicorp Packer

## News

(2021/03/17) Added Photon OS 4.0 and Ubuntu 20.04 LTS templates; validated usage with Packer 1.7.0.

(2020/11/10) Added Photon OS 3.0 template; validated usage with Packer 1.6.5.

(2020/10/03) Reorganized the structure of the repository for an easier consumption (manual and through pipelines). I also validated usage with Packer 1.6.4.

~~(2020/04/27) Added support for Ubuntu 20.04 LTS (Focal Fosssa).~~

(2020/02/18) I updated my template to leverage the vsphere-iso builder (instead of vmware-iso); The vsphere-iso builder, previously maintained by JetBrains, has been merged with the Packer core in [Packer 1.5.2](https://github.com/hashicorp/packer/blob/v1.5.4/CHANGELOG.md#152-february-12-2020). It will be officially supported by the Packer team at HashiCorp moving forward.

I moved to the vsphere-iso builder for 2 main reasons:

* This builder uses the vSphere API and does neither require the SSH service running on the ESXi host nor ESXi host modification (GuestIPHack enabled).
* I can use a distributed port group to connect my template during the creation.

## Overview

> **Note**: Ubuntu and Photon OS are the only templates provided in this repository for now. Others coming soon, stay tuned!

* [Photon OS 3.0](https://github.com/cloudmaniac/packer-templates/tree/master/photon)
* [Photon OS 4.0](https://github.com/cloudmaniac/packer-templates/tree/master/photon)
* [Ubuntu 18.04 LTS](https://github.com/cloudmaniac/packer-templates/tree/master/ubuntu)
* [Ubuntu 20.04 LTS](https://github.com/cloudmaniac/packer-templates/tree/master/ubuntu)

## Usage

Step 1 - Clone the git repository.

Step 2 - Edit the respective JSON files, e.g. `ubuntu/ubuntu-18.04.json` file or `photon/photon-3.0.json`

Step 3 - Adapt one of the [cloud definition JSON file](https://github.com/cloudmaniac/packer-templates/tree/master/clouds) to your environment (you will find them in the `clouds` folder).

Step 4 - Build the template(s).

* Either manually by using the `packer` CLI: `packer build -var-file=../clouds/var-infra-z67.json ubuntu-20.04.json`
* Or by using a quick script, e.g.: `./ubuntu/build-ubuntu-20.04.sh`

## Todo

* Add support for additional OS (Debian, CentOS, Windows)
* Zero the disk before export
* Use the Content Library to store the ISOs
* Export the result in the Content Library
* Migrate from JSON to HCL2
