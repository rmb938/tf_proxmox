provider "proxmox" {
  endpoint      = "https://freenas-pm.rmb938.me:8006"
  random_vm_ids = true

  ssh {
    agent    = true
    username = "githubActions"

    node {
      name    = "freenas-pm"
      address = "freenas-pm.rmb938.me"
    }
  }
}
