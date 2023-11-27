/*
    DESCRIPTION: Photon OS 4.0 variables values.
*/

// Operating System
os_name           = "Photon OS 4.0 Rev 2"
iso_url           = ["https://packages.vmware.com/photon/4.0/Rev2/iso/photon-minimal-4.0-c001795b8.iso"]
iso_checksum      = "c6a5de1098228728b5d189854f387e6fe6edb87582be4d9a4568ae0405929383"
iso_checksum_type = "sha256"

// Virtual Machine Settings
vm_guestos         = "vmwarePhoton64Guest"
vm_name            = "packer-photon-4.0"
vm_cpu_size        = 1
vm_ram_size        = 1024
vm_disk_controller = ["pvscsi"]
vm_disk_size       = 20480

// Deployment Settings
vsphere_template_folder = "templates/packer/photon"