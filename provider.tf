provider "proxmox" {
  endpoint = "https://freenas-pm.tailnet-047c.ts.net/"

  ssh {
    agent    = true
    username = "githubActions"

    node {
      name    = "freenas-pm"
      address = "freenas-pm.tailnet-047c.ts.net"
    }
  }
}
