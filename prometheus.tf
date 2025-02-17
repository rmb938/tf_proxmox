locals {
  # TODO: move the CONSUL_ROLE into the prometheus image
  haproxy_t1_cloud_config = <<-EOF
runcmd:
  - /usr/bin/systemctl set-environment CONSUL_ROLE=prometheus
  - /usr/bin/echo -e "[Manager]\nDefaultEnvironment=CONSUL_ROLE=prometheus" | /usr/bin/tee /etc/systemd/system.conf.d/consul_role.conf
  - /usr/bin/systemctl enable consul-template-consul.service
  - /usr/bin/systemctl start consul-template-consul.service
EOF
}

module "prometheus" {
  source       = "./modules/vm"
  name         = "prometheus.us-homelab1.hl.rmb938.me"
  image_family = local.family_ubuntu_noble_lts_amd64_application
  datastore_id = local.freenas_nfs_datastore

  network_device_bridge = "vmbr0v23"
  ip_config_ipv4 = {
    address = "192.168.23.58/${local.vmbr0v23_cidr}"
    gateway = local.vmbr0v23_gateway
  }

  cpu              = 1
  memory           = 2 * 1024
  additional_disks = [100]
  replacement      = 1

  cloud_config = local.haproxy_t1_cloud_config
}

