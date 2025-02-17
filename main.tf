terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.69.0"
    }
  }

  backend "gcs" {
    bucket = "rmb-lab-tf_proxmox"
  }
}

locals {
  freenas_nfs_datastore                     = "freenas-nfs"
  family_ubuntu_noble_lts_amd64_hardened    = "ubuntu-noble-lts-amd64-hardened"
  family_ubuntu_noble_lts_amd64_application = "ubuntu-noble-lts-amd64-application"

  vmbr0v23_cidr    = "24"
  vmbr0v23_gateway = "192.168.23.254"
}
