module "minecraft" {
  source       = "./modules/vm"
  name         = "minecraft.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-minecraft"

  # Using normal hardened image cause we are doing things manually
  datastore_id = local.family_ubuntu_noble_lts_amd64_hardened

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.104/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 4
  memory           = 16 * 1024
  additional_disks = [500]
  replacement      = 1
}
