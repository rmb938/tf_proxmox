locals {
  hashi_consul_cloud_config = <<-EOF
runcmd:
  - systemctl set-environment CONSUL_ROLE=hashi-consul
  - echo -e "[Manager]\nDefaultEnvironment=CONSUL_ROLE=hashi-consul" | tee /etc/systemd/system.conf.d/consul_role.conf
  # Not enabling or starting because consul needs to overwrite it's config
  # - systemctl enable consul-template-consul.service
  # - systemctl start consul-template-consul.service
EOF
}

module "hashi-consul-1" {
  source       = "./modules/vm"
  name         = "hashi-consul-1.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.55/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 1

  cloud_config = local.hashi_consul_cloud_config
}

module "hashi-consul-2" {
  source       = "./modules/vm"
  name         = "hashi-consul-2.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.56/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 1

  cloud_config = local.hashi_consul_cloud_config
}

module "hashi-consul-3" {
  source       = "./modules/vm"
  name         = "hashi-consul-3.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.57/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 1

  cloud_config = local.hashi_consul_cloud_config
}

