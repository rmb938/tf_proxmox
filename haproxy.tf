locals {
  haproxy_t1_cloud_config = <<-EOF
bootcmd:
  - /usr/bin/echo "CONSUL_ROLE=haproxy-t1" >> /etc/cloud-environment
  - /usr/bin/echo "HAPROXY_HTTP_BACKEND_CONSUL_SERVICE=haproxy-t2-http" >> /etc/cloud-environment
  - /usr/bin/echo "HAPROXY_HTTPS_BACKEND_CONSUL_SERVICE=haproxy-t2-https" >> /etc/cloud-environment
  - /usr/bin/echo "VIP_ROUTER_ID=51" >> /etc/cloud-environment
  - /usr/bin/echo "VIP_ADDRESS=192.168.23.46/24" >> /etc/cloud-environment
  # Overwrite hostname since HAProxy doesn't exist yet
  - /usr/bin/echo "VAULT_ADDR=https://hashi-vault-$(/usr/bin/hostname | /usr/bin/tail -c 2).us-homelab1.hl.rmb938.me:8200" | /usr/bin/tee /etc/vault.d/vault.env
EOF
}

locals {
  # TODO: move the CONSUL_ROLE into the haproxy-t2 image
  haproxy_t2_cloud_config = <<-EOF
bootcmd:
  - /usr/bin/echo "CONSUL_ROLE=haproxy-t2" >> /etc/cloud-environment
  # Overwrite hostname since HAProxy doesn't exist yet
  - /usr/bin/echo "VAULT_ADDR=https://hashi-vault-$(/usr/bin/hostname | /usr/bin/tail -c 2).us-homelab1.hl.rmb938.me:8200" | /usr/bin/tee /etc/vault.d/vault.env
EOF
}

module "haproxy-t1-1" {
  source       = "./modules/vm"
  name         = "haproxy-t1-1.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-haproxy-t1"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.47/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 5

  cloud_config = local.haproxy_t1_cloud_config

  startup_order = 1003
  startup_delay = 300
}

module "haproxy-t1-2" {
  source       = "./modules/vm"
  name         = "haproxy-t1-2.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-haproxy-t1"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.48/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 5

  cloud_config = local.haproxy_t1_cloud_config

  startup_order = 1003
  startup_delay = 300
}

module "haproxy-t2-1" {
  source       = "./modules/vm"
  name         = "haproxy-t2-1.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-haproxy-t2"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.49/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 5

  cloud_config = local.haproxy_t2_cloud_config

  startup_order = 1003
  startup_delay = 300
}

module "haproxy-t2-2" {
  source       = "./modules/vm"
  name         = "haproxy-t2-2.us-homelab1.hl.rmb938.me"
  image_family = "ubuntu-noble-lts-amd64-haproxy-t2"
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.50/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu         = 1
  memory      = 2 * 1024
  replacement = 5

  cloud_config = local.haproxy_t2_cloud_config

  startup_order = 1003
  startup_delay = 300
}
