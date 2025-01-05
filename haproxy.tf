module "haproxy-t1-1" {
  source       = "./modules/vm"
  name         = "haproxy-t1-1.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_hardened
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.47/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 1
}

module "haproxy-t1-2" {
  source       = "./modules/vm"
  name         = "haproxy-t1-1.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-hardened"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.48/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 1
}

module "haproxy-t2-1" {
  source       = "./modules/vm"
  name         = "haproxy-t2-1.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_hardened
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.49/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 1
}

module "haproxy-t2-2" {
  source       = "./modules/vm"
  name         = "haproxy-t2-1.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-hardened"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.50/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 1
}
