module "step_ca_ra" {
  source                = "./modules/vm"
  name                  = "step-ca-ra.rmb938.me"
  image_family          = "ubuntu-noble-lts-amd64-hardened"
  datastore_id          = "freenas-nfs"
  network_device_bridge = "vmbr0v52"
  cpu                   = 1
  memory                = 2048
  additional_disks      = [10]
  replacement           = 1
}
