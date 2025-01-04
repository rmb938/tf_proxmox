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

data "proxmox_virtual_environment_vms" "family_ubuntu_noble_lts_amd64_hardened" {
  tags = [
    "image",
    "family-ubuntu-noble-lts-amd64-hardened",
    "latest",
  ]

  filter {
    name   = "template"
    values = ["true"]
  }
}
