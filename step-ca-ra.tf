module "step_ca_ra" {
  source       = "./modules/vm"
  name         = "step-ca-ra.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_hardened
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.51/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [10]
  replacement      = 2
}
