locals {
  devstack_cloud_config = <<-EOF
bootcmd:
  - /usr/bin/echo "CONSUL_ROLE=devstack" >> /etc/cloud-environment
EOF
}

module "devstack" {
  source       = "./modules/vm"
  name         = "devstack.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-devstack"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.101/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 4
  memory           = 16 * 1024
  additional_disks = [5]
  replacement      = 3

  cloud_config = local.devstack_cloud_config
}
