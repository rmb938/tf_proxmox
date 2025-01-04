module "elasticsearch" {
  source                = "./modules/vm"
  name                  = "elasticsearch.rmb938.me"
  image_family          = "ubuntu-noble-lts-amd64-hardened"
  datastore_id          = "freenas-nfs"
  network_device_bridge = "vmbr0v52"
  cpu                   = 1
  memory                = 2048
  additional_disks      = [100]
  replacement           = 1
}
