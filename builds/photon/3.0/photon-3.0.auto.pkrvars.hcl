/*
    DESCRIPTION: Photon OS 3.0 variables values.
*/

// Operating System
os_name           = "Photon OS 3.0 Revision 3 Update1"
iso_url           = ["https://packages.vmware.com/photon/3.0/Rev3/iso/Update1/photon-minimal-3.0-913b49438.iso"]
iso_checksum      = "e97c2fdf27043194730a12af4b0df0067e567aac1ddfbefd11f565b5d3c65744"
iso_checksum_type = "sha256"

// Virtual Machine Settings
vm_guestos         = "vmwarePhoton64Guest"
vm_name            = "packer-photon-3.0"
vm_cpu_size        = 1
vm_ram_size        = 1024
vm_disk_controller = ["pvscsi"]
vm_disk_size       = 20480

// Deployment Settings
vsphere_template_folder = "templates/packer/photon"