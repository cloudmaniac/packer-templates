# Automated template creation using Hashicorp Packer

## News

(2023/01/16) Switched all templates to HCL...finally! 😅

(2023/01/16) Added Ubuntu 22.04 LTS template; validated usage with Packer 1.8.5.

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

* [Photon OS 3.0](https://github.com/cloudmaniac/packer-templates/tree/main/builds/photon/3.0)
* [Photon OS 4.0](https://github.com/cloudmaniac/packer-templates/tree/main/builds/photon/4.0)
* [Ubuntu 18.04 LTS](https://github.com/cloudmaniac/packer-templates/tree/main/builds/ubuntu/18.04)
* [Ubuntu 20.04 LTS](https://github.com/cloudmaniac/packer-templates/tree/main/builds/ubuntu/20.04)
* [Ubuntu 22.04 LTS](https://github.com/cloudmaniac/packer-templates/tree/main/builds/ubuntu/22.04)

## Usage

Step 1 - Clone the git repository.

Step 2 - Make a copy (or change) and adapt the [cloud definition file](https://github.com/cloudmaniac/packer-templates/tree/main/builds/clouds) to your environment (you will find them in the `builds/clouds` folder).

Step 3 - Update the `buils/common.pkrvars.hcl` file with your desired user credentials (or SSH key).

Step 4 - Navigate to the folder that matches the operating system (and version) that you want to build. E.g.: `builds/ubuntu/22.04`.

Step 4 - From that folder, edit the respective HCL file with your values, e.g. `ubuntu-22.04.auto.pkrvars.hcl` file or `photon-4.0.auto.pkrvars.hcl`. For Ubuntu 20.04 and 22.04, adapt the `user-data` cloud-init file with the desired configuration ([documentation](https://ubuntu.com/server/docs/install/autoinstall-reference) for reference).

Step 5 - Run `packer init .` to install the required plugin(s).

Step 6 - Build your template with `packer build -force -var-file="../../clouds/infra-z67.pkrvars.hcl" -var-file="../../common.pkrvars.hcl" .`.
*Note: adapt to filenames and location relevant to your environment.*

Step 7 - Rinse and repeat for all templates you want to build. \o/

## Todo

* Add support for additional OS (Debian, CentOS, Windows)
* Zero the disk before export
* Use the Content Library to store the ISOs
* Export the result in the Content Library
