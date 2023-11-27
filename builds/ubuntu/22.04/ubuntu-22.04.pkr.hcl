/*
    DESCRIPTION: Ubuntu 22.04 LTS (Jammy Jellyfish) vSphere template.
    - Author: Romain Decker
    - Blog: https://cloudmaniac.net
    - Twitter: https://twitter.com/woueb
    - Build command: packer build -force -var-file="../../clouds/infra-z67.pkrvars.hcl" -var-file="../../common.pkrvars.hcl" .
*/

// Packer
packer {
  required_version = ">= 1.8.5"
  required_plugins {
    vsphere = {
      version = ">= v1.2.1"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

// Data
locals {
  build_date = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  vm_notes = "OS: ${var.os_name} (build on: ${local.build_date})"
  data_source_content = {
    "/meta-data" = file("${abspath(path.root)}/data/meta-data")
    "/user-data" = templatefile("${abspath(path.root)}/data/user-data.pkrtpl.hcl", {
      guest_username           = var.guest_username
      guest_password_encrypted = var.guest_password_encrypted
    })
  }
}

// Source
source "vsphere-iso" "ubuntu" {

  // Endpoint
  vcenter_server       = var.vsphere_vcenter
  username             = var.vsphere_username
  password             = var.vsphere_password
  insecure_connection  = var.vsphere_insecure_connection

  datacenter           = var.vsphere_datacenter
  cluster              = var.vsphere_cluster
  folder               = var.vsphere_template_folder
  datastore            = var.vsphere_datastore

  // Virtual Machine Settings
  vm_name              = var.vm_name
  guest_os_type        = var.vm_guestos
  CPUs                 = var.vm_cpu_size
  RAM                  = var.vm_ram_size

  disk_controller_type = var.vm_disk_controller

  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = true
  }

  network_adapters {
    network               = var.vsphere_network
    network_card          = "vmxnet3"
  }

  vm_version = 15
  notes      = local.vm_notes
 
  // Operating System & Boot
  iso_urls             = var.iso_url
  iso_checksum         = "${var.iso_checksum_type}:${var.iso_checksum}"
  http_content         = local.data_source_content

  boot_command         = ["c<wait>", "linux /casper/vmlinuz --- autoinstall ds='nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'", "<enter><wait>", "initrd /casper/initrd", "<enter><wait>", "boot", "<enter>"]
  boot_wait            = "5s"

  shutdown_command       = "echo '${var.guest_password}' | sudo -S -E shutdown -P now"

  // Communicator
  communicator         = "ssh"

  ssh_username           = var.guest_username
  ssh_password           = var.guest_password
  ssh_timeout            = "30m"

  // Output
  convert_to_template  = "true"
}

// Build
build {
  sources = ["source.vsphere-iso.ubuntu"]

  provisioner "shell" {
    execute_command = "echo '${var.guest_password}' | sudo -S -E bash '{{ .Path }}'"
    scripts         = ["../scripts/update.sh", "../scripts/cleanup.sh"]
  }

  provisioner "shell" {
    inline = ["echo 'Template build complete (${local.build_date})!'"]
  }
}