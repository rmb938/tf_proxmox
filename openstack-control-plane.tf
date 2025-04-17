
# Postgres
locals {
  openstack_postgres_cloud_config = <<-EOF
bootcmd:
  - /usr/bin/echo "CONSUL_ROLE=openstack-postgres" >> /etc/cloud-environment
EOF
}

module "openstack-postgres-1" {
  source       = "./modules/vm"
  name         = "openstack-postgres-1.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-patroni"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.70/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 8

  cloud_config = local.openstack_postgres_cloud_config
}

module "openstack-postgres-2" {
  source       = "./modules/vm"
  name         = "openstack-postgres-2.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-patroni"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.71/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 8

  cloud_config = local.openstack_postgres_cloud_config
}

module "openstack-postgres-3" {
  source       = "./modules/vm"
  name         = "openstack-postgres-3.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-patroni"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.72/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 8

  cloud_config = local.openstack_postgres_cloud_config
}

# RabbitMQ
locals {
  openstack_rabbitmq_cloud_config = <<-EOF
bootcmd:
  - /usr/bin/echo "CONSUL_ROLE=openstack-rabbitmq" >> /etc/cloud-environment
EOF
}

module "openstack-rabbitmq-1" {
  source       = "./modules/vm"
  name         = "openstack-rabbitmq-1.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-rabbitmq"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.73/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 7

  cloud_config = local.openstack_rabbitmq_cloud_config
}

module "openstack-rabbitmq-2" {
  source       = "./modules/vm"
  name         = "openstack-rabbitmq-2.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-rabbitmq"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.74/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 7

  cloud_config = local.openstack_rabbitmq_cloud_config
}

module "openstack-rabbitmq-3" {
  source       = "./modules/vm"
  name         = "openstack-rabbitmq-3.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-rabbitmq"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.75/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 7

  cloud_config = local.openstack_rabbitmq_cloud_config
}

# Keystone
locals {
  openstack_keystone_cloud_config = <<-EOF
bootcmd:
  - /usr/bin/echo "CONSUL_ROLE=openstack-keystone" >> /etc/cloud-environment
EOF
}

module "openstack-keystone-1" {
  source       = "./modules/vm"
  name         = "openstack-keystone-1.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-openstack-keystone"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.76/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 13

  cloud_config = local.openstack_keystone_cloud_config
}

module "openstack-keystone-2" {
  source       = "./modules/vm"
  name         = "openstack-keystone-2.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-openstack-keystone"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.77/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 13

  cloud_config = local.openstack_keystone_cloud_config
}

module "openstack-keystone-3" {
  source       = "./modules/vm"
  name         = "openstack-keystone-3.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-openstack-keystone"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.78/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 13

  cloud_config = local.openstack_keystone_cloud_config
}


# Glance
locals {
  openstack_glance_cloud_config = <<-EOF
bootcmd:
  - /usr/bin/echo "CONSUL_ROLE=openstack-glance" >> /etc/cloud-environment
EOF
}

module "openstack-glance-1" {
  source       = "./modules/vm"
  name         = "openstack-glance-1.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-openstack-glance"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.79/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 2

  cloud_config = local.openstack_glance_cloud_config

  hostpci_mappings = [
    "connectx-4-vf-5"
  ]
}

module "openstack-glance-2" {
  source       = "./modules/vm"
  name         = "openstack-glance-2.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-openstack-glance"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.80/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 3

  cloud_config = local.openstack_glance_cloud_config

  hostpci_mappings = [
    "connectx-4-vf-6"
  ]
}

module "openstack-glance-3" {
  source       = "./modules/vm"
  name         = "openstack-glance-3.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-openstack-glance"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.81/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 3

  cloud_config = local.openstack_glance_cloud_config

  hostpci_mappings = [
    "connectx-4-vf-7"
  ]
}

# Cinder
locals {
  openstack_cinder_cloud_config = <<-EOF
bootcmd:
  - /usr/bin/echo "CONSUL_ROLE=openstack-cinder" >> /etc/cloud-environment
EOF
}

module "openstack-cinder-1" {
  source       = "./modules/vm"
  name         = "openstack-cinder-1.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-openstack-cinder"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.82/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 4

  cloud_config = local.openstack_cinder_cloud_config

  hostpci_mappings = [
    "connectx-4-vf-2"
  ]
}

module "openstack-cinder-2" {
  source       = "./modules/vm"
  name         = "openstack-cinder-2.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-openstack-cinder"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.83/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 4

  cloud_config = local.openstack_cinder_cloud_config

  hostpci_mappings = [
    "connectx-4-vf-3"
  ]
}

module "openstack-cinder-3" {
  source       = "./modules/vm"
  name         = "openstack-cinder-3.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-openstack-cinder"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.84/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 4

  cloud_config = local.openstack_cinder_cloud_config

  hostpci_mappings = [
    "connectx-4-vf-4"
  ]
}


# OVN NorthD
locals {
  openstack_ovn_northd_cloud_config = <<-EOF
bootcmd:
  - /usr/bin/echo "CONSUL_ROLE=openstack-ovn-northd" >> /etc/cloud-environment
EOF
}

module "openstack-ovn-northd-1" {
  source       = "./modules/vm"
  name         = "openstack-ovn-northd-1.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application # TODO:
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.97/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 8

  cloud_config = local.openstack_ovn_northd_cloud_config
}

module "openstack-ovn-northd-2" {
  source       = "./modules/vm"
  name         = "openstack-ovn-northd-2.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application # TODO:
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.98/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 8

  cloud_config = local.openstack_ovn_northd_cloud_config
}

module "openstack-ovn-northd-3" {
  source       = "./modules/vm"
  name         = "openstack-ovn-northd-3.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application # TODO:
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.99/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 8

  cloud_config = local.openstack_ovn_northd_cloud_config
}
