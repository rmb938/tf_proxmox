module "step_ca_ra" {
  source       = "./modules/vm"
  name         = "step-ca-ra.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-hardened"
  datastore_id = "freenas-nfs"

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.51/24"
    gateway = "192.168.23.254"
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [10]
  replacement      = 1
}
