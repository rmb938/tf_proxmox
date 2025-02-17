locals {
  # TODO: move the CONSUL_ROLE into the openstack-postgres image
  openstack_postgres_cloud_config = <<-EOF
runcmd:
  - /usr/bin/systemctl set-environment CONSUL_ROLE=openstack-postgres
  - /usr/bin/echo -e "[Manager]\nDefaultEnvironment=CONSUL_ROLE=openstack-postgres" | /usr/bin/tee /etc/systemd/system.conf.d/consul_role.conf
  - /usr/bin/systemctl enable consul-template-consul.service
  - /usr/bin/systemctl start consul-template-consul.service
EOF
}

# Postgres
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
  replacement      = 1

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
  replacement      = 1

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
  replacement      = 1

  cloud_config = local.openstack_postgres_cloud_config
}
