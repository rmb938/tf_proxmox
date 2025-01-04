resource "terraform_data" "elasticsearch_replacement" {
  input = 1
}

module "elasticsearch_data_vm" {
  source       = "./modules/data-vm"
  datastore_id = "freenas-nfs"
  size         = 100
}

resource "proxmox_virtual_environment_vm" "elasticsearch" {
  lifecycle {
    ignore_changes = [
      // ignore changes to clone vm id
      // since we don't want to remake every family update
      // we only want to update it when we tell it to
      clone[0].vm_id,
      // we also don't want to update tags since it'll
      // pull from the new image
      tags,
      // Ignore description so it's not updated with timestamp
      description,

      // ignoring disk size for manual resizing
      disk[0].size
    ]

    // trigger for manual rebuilds
    replace_triggered_by = [
      terraform_data.elasticsearch_replacement
    ]
  }

  name = "elasticsearch.rmb938.me"

  // Sadly this is in UTC, tf has no way to get local timezone
  description = "Managed by Terraform, Deployed on ${formatdate("YYYY-MM-DD'T'hh:mm:ss-ZZZZZ", timestamp())}"

  node_name = data.proxmox_virtual_environment_vms.family_ubuntu_noble_lts_amd64_hardened.vms[0].node_name

  tags = [for image_tag in setsubtract(data.proxmox_virtual_environment_vms.family_ubuntu_noble_lts_amd64_hardened.vms[0].tags, ["latest", "image"]) : "image-${image_tag}"]

  clone {
    datastore_id = "freenas-nfs"
    vm_id        = data.proxmox_virtual_environment_vms.family_ubuntu_noble_lts_amd64_hardened.vms[0].vm_id
    full         = true
  }

  dynamic "disk" {
    for_each = { for idx, val in module.elasticsearch_data_vm.disk : idx => val }
    iterator = data_disk
    content {
      datastore_id      = data_disk.value["datastore_id"]
      path_in_datastore = data_disk.value["path_in_datastore"]
      size              = data_disk.value["size"]
      # assign from scsi1 and up
      interface = "scsi${data_disk.key + 1}"

      discard  = "on"
      ssd      = true
      iothread = true
    }
  }

  network_device {
    bridge = "vmbr0v52"
  }

  initialization {
    datastore_id = "freenas-nfs"

    ip_config {
      ipv4 {
        address = "dhcp"
      }
      ipv6 {
        address = "dhcp"
      }
    }

    user_account {
      username = "ubuntu" # If this isn't provded the username ends up being " "
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJWVnbWnQpWJLEYMpIc4GcURFIQ574QSubXc5sfQ2Rzs rbelgrave@magic-muffin.rmb938.me"
      ]
    }
  }

  agent {
    enabled = true
  }

  cpu {
    cores = 1
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 2048
  }

  vga {
    memory = 16
    type   = "serial0"
  }
}
