/*
    DESCRIPTION: Ubuntu 22.04 LTS (Jammy Jellyfish) variables definition.
*/

// vSphere Credentials
variable "vsphere_vcenter" {
  type = string
  description = "vSphere server instance FQDN or IP (e.g., 'vcsa01-z67.sddc.lab')."
}

variable "vsphere_username" {
  type = string
  description = "Username to connect to the vCenter server instance."
}

variable "vsphere_password" {
  type = string
  description = "The password of the vSphere account used to connect to the vCenter instance."
}

variable "vsphere_insecure_connection" {
  type = bool
  description = "Do not validate the vCenter Server TLS certificate."
  default = false
}


// Template Account Credentials
variable "guest_username" {
  type = string
  description = "The username for the guest operating system."
}

variable "guest_password" {
  type = string
  description = "The password to login to the guest operating system."
}

variable "guest_password_encrypted" {
  type = string
  description = "The encrypted password to login to the guest operating system."
}


// vSphere Deployment Settings
variable "vsphere_datacenter" {
  type = string
  description = "The name of the target vSphere datacenter where to deploy the template."
}

variable "vsphere_cluster" {
  type = string
  description = "The name of the target vSphere cluster where to deploy the template."
}

variable "vsphere_datastore" {
  type = string
  description = "The name of the target datastore where to deploy the template."
}

variable "vsphere_network" {
  type = string
  description = "The name of the target network to connect the template."
}


// Operating System
variable "os_name" {
  type = string
  description = "Name and version of the guest operating system."
}

variable "iso_url" {
  type = list(string)
  description = "URL(s) for the ISO to download. If multiple URLs are provided, Packer will try these in order. If anything goes wrong attempting to download or while downloading a single URL, it will move on to the next. All URLs must point to the same file (same checksum)."
}

variable "iso_checksum" {
  type = string
  description = "The checksum for the ISO file."
}


variable "iso_checksum_type" {
  type = string
  description = "The type of the checksum for the ISO file checksum."
}


// Virtual Machine Settings
variable "vm_guestos" {
  type = string
  description = "Guest operating system identifier for vSphere, also known as guestid (e.g., 'ubuntu64Guest')."
}

variable "vm_name" {
  type = string
  description = "Name of the new VM to create."
}

variable "vm_cpu_size" {
  type    = number
  description = "Number of CPU cores."
  default = 1
}

variable "vm_ram_size" {
  type = number
  description = "Amount of RAM in MB."
}

variable "vm_disk_controller" {
  type        = list(string)
  description = "VM disk controller type(s) in sequence (e.g. 'pvscsi' or 'lsilogic')"
  default     = ["pvscsi"]
}

variable "vm_disk_size" {
  type = number
  description = "The size of the disk in MB."
}

// Deployment Settings
variable "vsphere_template_folder" {
  type = string
  description = "The name of the target vSphere folder where to deploy the template."
}
