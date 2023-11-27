/*
    DESCRIPTION: Ubuntu 18.04 LTS (Bionic Beaver) variables values.
*/

// Operating System
os_name           = "Ubuntu 18.04.6 LTS (Bionic Beaver)"
iso_url           = ["http://cdimage.ubuntu.com/releases/18.04/release/ubuntu-18.04.6-server-amd64.iso"]
iso_checksum      = "f5cbb8104348f0097a8e513b10173a07dbc6684595e331cb06f93f385d0aecf6"
iso_checksum_type = "sha256"

// Virtual Machine Settings
vm_guestos         = "ubuntu64Guest"
vm_name            = "packer-ubuntu-18.04"
vm_cpu_size        = 2
vm_ram_size        = 2048
vm_disk_controller = ["pvscsi"]
vm_disk_size       = 40960

// Deployment Settings
vsphere_template_folder = "templates/packer/ubuntu"
