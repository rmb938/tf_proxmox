
# Postgres
locals {
  # TODO: move the CONSUL_ROLE into the openstack-postgres image
  openstack_postgres_cloud_config = <<-EOF
runcmd:
  - /usr/bin/systemctl set-environment CONSUL_ROLE=openstack-postgres
  - /usr/bin/echo -e "[Manager]\nDefaultEnvironment=CONSUL_ROLE=openstack-postgres" | /usr/bin/tee /etc/systemd/system.conf.d/consul_role.conf
  - /usr/bin/systemctl enable consul-template-consul.service
  - /usr/bin/systemctl start consul-template-consul.service
EOF

  openstack_postgres_cloud_config_new = <<-EOF
bootcmd:
  - /usr/bin/echo "CONSUL_ROLE=openstack-postgres" >> /etc/cloud-environment
EOF
}

module "openstack-postgres-1" {
  source       = "./modules/vm"
  name         = "openstack-postgres-1.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.70/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 6

  cloud_config = local.openstack_postgres_cloud_config
}

module "openstack-postgres-2" {
  source       = "./modules/vm"
  name         = "openstack-postgres-2.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.71/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 6

  cloud_config = local.openstack_postgres_cloud_config
}

module "openstack-postgres-3" {
  source       = "./modules/vm"
  name         = "openstack-postgres-3.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.72/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 7

  cloud_config = local.openstack_postgres_cloud_config_new
}

# RabbitMQ
locals {
  # TODO: move the CONSUL_ROLE into the openstack-rabbitmq image
  openstack_rabbitmq_cloud_config = <<-EOF
runcmd:
  - /usr/bin/systemctl set-environment CONSUL_ROLE=openstack-rabbitmq
  - /usr/bin/echo -e "[Manager]\nDefaultEnvironment=CONSUL_ROLE=openstack-rabbitmq" | /usr/bin/tee /etc/systemd/system.conf.d/consul_role.conf
  - /usr/bin/systemctl enable consul-template-consul.service
  - /usr/bin/systemctl start consul-template-consul.service
EOF
}

module "openstack-rabbitmq-1" {
  source       = "./modules/vm"
  name         = "openstack-rabbitmq-1.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.73/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 2

  cloud_config = local.openstack_rabbitmq_cloud_config
}

module "openstack-rabbitmq-2" {
  source       = "./modules/vm"
  name         = "openstack-rabbitmq-2.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.74/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 2

  cloud_config = local.openstack_rabbitmq_cloud_config
}

module "openstack-rabbitmq-3" {
  source       = "./modules/vm"
  name         = "openstack-rabbitmq-3.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.75/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 2

  cloud_config = local.openstack_rabbitmq_cloud_config
}

# Keystone
locals {
  # TODO: move the CONSUL_ROLE into the openstack-keystone image
  openstack_keystone_cloud_config = <<-EOF
runcmd:
  - /usr/bin/systemctl set-environment CONSUL_ROLE=openstack-keystone
  - /usr/bin/echo -e "[Manager]\nDefaultEnvironment=CONSUL_ROLE=openstack-keystone" | /usr/bin/tee /etc/systemd/system.conf.d/consul_role.conf
  - /usr/bin/systemctl enable consul-template-consul.service
  - /usr/bin/systemctl start consul-template-consul.service
EOF
}

module "openstack-keystone-1" {
  source       = "./modules/vm"
  name         = "openstack-keystone-1.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.76/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 2

  cloud_config = local.openstack_keystone_cloud_config
}

module "openstack-keystone-2" {
  source       = "./modules/vm"
  name         = "openstack-keystone-2.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.77/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 2

  cloud_config = local.openstack_keystone_cloud_config
}

module "openstack-keystone-3" {
  source       = "./modules/vm"
  name         = "openstack-keystone-3.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.78/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 2

  cloud_config = local.openstack_keystone_cloud_config
}
