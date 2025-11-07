locals {
  clickhouse_cloud_config = <<-EOF
bootcmd:
  - /usr/bin/echo "CONSUL_ROLE=clickhouse" >> /etc/cloud-environment
EOF
}

module "clickhouse-1" {
  source       = "./modules/vm"
  name         = "clickhouse-1.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-clickhouse"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.103/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 2
  memory           = 8 * 1024
  additional_disks = [100]
  replacement      = 3

  cloud_config = local.clickhouse_cloud_config
}
