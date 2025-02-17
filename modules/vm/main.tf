terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}

data "proxmox_virtual_environment_vms" "family" {
  tags = [
    "image",
    "family-${var.image_family}",
    "latest",
  ]

  filter {
    name   = "template"
    values = ["true"]
  }
}

module "data_vm" {
  count        = length(var.additional_disks)
  name         = "${var.name}-${count.index}"
  source       = "../data-vm"
  node_name    = data.proxmox_virtual_environment_vms.family.vms[0].node_name
  datastore_id = var.datastore_id
  size         = var.additional_disks[count.index]
}

resource "terraform_data" "replacement" {
  input = var.replacement
}

resource "proxmox_virtual_environment_file" "user_data" {
  content_type = "snippets"
  datastore_id = var.datastore_id
  node_name    = data.proxmox_virtual_environment_vms.family.vms[0].node_name

  source_raw {
    data = <<-EOF
#cloud-config
manage_etc_hosts: true
hostname: ${split(".", "${var.name}")[0]}
fqdn: ${var.name}
users:
  - name: ubuntu
    ssh_authorized_keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJWVnbWnQpWJLEYMpIc4GcURFIQ574QSubXc5sfQ2Rzs rbelgrave@magic-muffin.rmb938.me
${var.cloud_config}
EOF

    file_name = "${var.name}-user-data-cloud-config.yaml"
  }
}

resource "random_uuid" "instance_id" {
}

resource "proxmox_virtual_environment_file" "meta_data" {
  content_type = "snippets"
  datastore_id = var.datastore_id
  node_name    = data.proxmox_virtual_environment_vms.family.vms[0].node_name

  source_raw {
    data = <<-EOF
instance-id: ${random_uuid.instance_id.result}
local-hostname: ${var.name}
hostname: ${split(".", "${var.name}")[0]}
EOF

    file_name = "${var.name}-meta-data-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
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
      disk
    ]

    // trigger for manual rebuilds
    replace_triggered_by = [
      terraform_data.replacement
    ]
  }

  name = var.name

  // Sadly this is in UTC, tf has no way to get local timezone
  description = "Managed by Terraform, Deployed on ${formatdate("YYYY-MM-DD'T'hh:mm:ss-ZZZZZ", timestamp())}"

  node_name = data.proxmox_virtual_environment_vms.family.vms[0].node_name

  tags = [for image_tag in setsubtract(data.proxmox_virtual_environment_vms.family.vms[0].tags, ["latest", "image"]) : "image-${image_tag}"]

  clone {
    datastore_id = var.datastore_id
    vm_id        = data.proxmox_virtual_environment_vms.family.vms[0].vm_id
    full         = true
  }

  dynamic "disk" {
    for_each = { for idx, val in module.data_vm : idx => val }
    iterator = data_vm
    content {
      datastore_id      = data_vm.value.disk["datastore_id"]
      path_in_datastore = data_vm.value.disk["path_in_datastore"]
      size              = data_vm.value.disk["size"]
      # assign from scsi1 and up
      interface = "scsi${data_vm.key + 1}"

      discard  = "on"
      ssd      = true
      iothread = true
    }
  }

  startup {
    order    = tostring(var.startup_order)
    up_delay = tostring(var.startup_delay)
  }

  network_device {
    bridge = var.network_device_bridge
  }

  initialization {
    datastore_id = var.datastore_id

    ip_config {
      ipv4 {
        address = var.ip_config_ipv4.address
        gateway = var.ip_config_ipv4.gateway
      }
      ipv6 {
        address = "dhcp"
      }
    }

    meta_data_file_id = proxmox_virtual_environment_file.meta_data.id
    user_data_file_id = proxmox_virtual_environment_file.user_data.id
  }

  agent {
    enabled = true
  }

  cpu {
    cores = var.cpu
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.memory
  }

  vga {
    memory = 16
    type   = "serial0"
  }
}
