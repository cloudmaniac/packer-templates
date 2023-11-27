/*
    DESCRIPTION:
    VMware vSphere variables used for all builds.
    - Variables are use by the source blocks.
*/

// vSphere Credentials
vsphere_vcenter             = "vcsa01-z67.sddc.lab"
vsphere_username            = "administrator@vsphere.local"
vsphere_password            = "VMware1!"
vsphere_insecure_connection = true

// vSphere Deployment Settings
vsphere_datacenter = "Z67-DC01"
vsphere_cluster    = "Z67-CL01"
vsphere_datastore  = "nfs01"
vsphere_network    = "PG-10.67.10.0"
