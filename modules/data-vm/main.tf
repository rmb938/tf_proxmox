terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}

resource "random_uuid" "data_vm" {
}

# https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#example-attached-disks
resource "proxmox_virtual_environment_vm" "data_vm" {
  lifecycle {
    prevent_destroy = true

    ignore_changes = [
      // unsure if this is needed, but just incase
      disk[0].size
    ]
  }

  name      = "data-${random_uuid.data_vm.result}"
  node_name = var.node_name
  started   = false
  on_boot   = false

  tags = ["data-vm", "vm-${var.name}"]

  // this set to unknown bridge to prevent poweron
  network_device {
    bridge = "unknown"
  }

  disk {
    datastore_id = var.datastore_id
    file_format  = "qcow2"
    interface    = "scsi1"
    size         = var.size
  }

}
