locals {
  openstack_compute_cloud_config = <<-EOF
bootcmd:
  - /usr/bin/echo "CONSUL_ROLE=openstack-nova-compute" >> /etc/cloud-environment
EOF
}

module "openstack-compute-1" {
  source       = "./modules/vm"
  name         = "openstack-compute-1.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.100/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  additional_network_device_bridges = [
    "vmbr0v72",
    "vmbr0v52"
  ]

  cpu         = 1
  memory      = 2 * 1024
  replacement = 2

  cloud_config = local.openstack_compute_cloud_config

  # TODO: remove this when we adjust compute ansible to allow network-only nodes
  hostpci_mappings = [
    "connectx-4-vf-8"
  ]
}
