module "elasticsearch" {
  source       = "./modules/vm"
  name         = "elasticsearch.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_hardened
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.45/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 16 * 1024
  additional_disks = [100]
  replacement      = 3

  # Make sure elastic is started first
  # and it needs to wait 5 minutes
  startup_order = 1000
  startup_delay = 300
}
