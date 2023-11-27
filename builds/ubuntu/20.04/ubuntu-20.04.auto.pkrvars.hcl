/*
    DESCRIPTION: Ubuntu 20.04 LTS (Focal Fossa) variables values.
*/

// Operating System
os_name           = "Ubuntu 20.04.6.0 LTS (Focal Fossa)"
iso_url           = ["https://releases.ubuntu.com/focal/ubuntu-20.04.6-live-server-amd64.iso"]
iso_checksum      = "b8f31413336b9393ad5d8ef0282717b2ab19f007df2e9ed5196c13d8f9153c8b"
iso_checksum_type = "sha256"

// Virtual Machine Settings
vm_guestos         = "ubuntu64Guest"
vm_name            = "packer-ubuntu-20.04"
vm_cpu_size        = 2
vm_ram_size        = 2048
vm_disk_controller = ["pvscsi"]
vm_disk_size       = 40960

// Deployment Settings
vsphere_template_folder = "templates/packer/ubuntu"
