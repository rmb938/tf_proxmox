
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
  replacement      = 3

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
  replacement      = 3

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
  replacement      = 3

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
  replacement = 6

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
  replacement = 6

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
  replacement = 6

  cloud_config = local.openstack_keystone_cloud_config
}
