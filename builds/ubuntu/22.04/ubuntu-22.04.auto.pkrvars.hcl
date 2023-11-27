/*
    DESCRIPTION: Ubuntu 22.04 LTS (Jammy Jellyfish) variables values.
*/

// Operating System
os_name           = "Ubuntu 22.04.3 LTS (Jammy Jellyfish)"
iso_url           = ["https://releases.ubuntu.com/jammy/ubuntu-22.04.3-live-server-amd64.iso"]
iso_checksum      = "a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
iso_checksum_type = "sha256"

// Virtual Machine Settings
vm_guestos         = "ubuntu64Guest"
vm_name            = "packer-ubuntu-22.04"
vm_cpu_size        = 2
vm_ram_size        = 2048
vm_disk_controller = ["pvscsi"]
//vm_disk_size       = 81920
vm_disk_size       = 40960

// Deployment Settings
vsphere_template_folder = "templates/packer/ubuntu"
