locals {
  prometheus_cloud_config = <<-EOF
bootcmd:
  - /usr/bin/echo "CONSUL_ROLE=prometheus" >> /etc/cloud-environment
EOF
}

module "prometheus" {
  source       = "./modules/vm"
  name         = "prometheus.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-prometheus"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.58/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 2

  cloud_config = local.prometheus_cloud_config
}

