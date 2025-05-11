module "hashi-vault-1" {
  source       = "./modules/vm"
  name         = "hashi-vault-1.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_hardened
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.52/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 2

  startup_order = 1001
}

module "hashi-vault-2" {
  source       = "./modules/vm"
  name         = "hashi-vault-2.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_hardened
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.53/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 2

  startup_order = 1001
}

module "hashi-vault-3" {
  source       = "./modules/vm"
  name         = "hashi-vault-3.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_hardened
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.54/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 2

  startup_order = 1002
  startup_delay = 300
}

