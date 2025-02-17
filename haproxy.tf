locals {
  # TODO: move the CONSUL_ROLE into the haproxy-t1 image
  haproxy_t1_cloud_config = <<-EOF
runcmd:
  - /usr/bin/systemctl set-environment CONSUL_ROLE=haproxy-t1
  - /usr/bin/echo -e "[Manager]\nDefaultEnvironment=CONSUL_ROLE=haproxy-t1" | /usr/bin/tee /etc/systemd/system.conf.d/consul_role.conf
  
  # Overwrite hostname since HAProxy doesn't exist yet
  - /usr/bin/echo "VAULT_ADDR=https://hashi-vault-$(/usr/bin/hostname | /usr/bin/tail -c 2).us-homelab1.hl.rmb938.me:8200" | /usr/bin/tee /etc/vault.d/vault.env
  
  - /usr/bin/systemctl enable consul-template-consul.service
  - /usr/bin/systemctl start consul-template-consul.service
EOF
}

locals {
  # TODO: move the CONSUL_ROLE into the haproxy-t2 image
  haproxy_t2_cloud_config = <<-EOF
runcmd:
  - /usr/bin/systemctl set-environment CONSUL_ROLE=haproxy-t2
  - /usr/bin/echo -e "[Manager]\nDefaultEnvironment=CONSUL_ROLE=haproxy-t2" | /usr/bin/tee /etc/systemd/system.conf.d/consul_role.conf
  
  # Overwrite hostname since HAProxy doesn't exist yet
  - /usr/bin/echo "VAULT_ADDR=https://hashi-vault-$(/usr/bin/hostname | /usr/bin/tail -c 2).us-homelab1.hl.rmb938.me:8200" | /usr/bin/tee /etc/vault.d/vault.env
  
  - /usr/bin/systemctl enable consul-template-consul.service
  - /usr/bin/systemctl start consul-template-consul.service
EOF
}

module "haproxy-t1-1" {
  source       = "./modules/vm"
  name         = "haproxy-t1-1.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.47/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 2

  cloud_config = local.haproxy_t1_cloud_config
}

module "haproxy-t1-2" {
  source       = "./modules/vm"
  name         = "haproxy-t1-2.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.48/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 2

  cloud_config = local.haproxy_t1_cloud_config
}

module "haproxy-t2-1" {
  source       = "./modules/vm"
  name         = "haproxy-t2-1.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.49/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 2

  cloud_config = local.haproxy_t2_cloud_config
}

module "haproxy-t2-2" {
  source       = "./modules/vm"
  name         = "haproxy-t2-2.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.50/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 2

  cloud_config = local.haproxy_t2_cloud_config
}
