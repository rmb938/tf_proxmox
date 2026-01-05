resource "proxmox_virtual_environment_hardware_mapping_pci" "connextx-4" {
  count = 7

  name = "connectx-4-vf-${count.index + 1}"

  map = [
    {
      id = "15b3:1016"

      iommu_group = 73 + count.index
      node        = "freenas-pm"
      path        = "0000:e1:00.${count.index + 1}"

      subsystem_id = "15b3:0006"
    },
  ]

}

resource "proxmox_virtual_environment_hardware_mapping_pci" "connextx-4-8" {
  name = "connectx-4-vf-8"

  map = [
    {
      id = "15b3:1016"

      iommu_group = 80
      node        = "freenas-pm"
      path        = "0000:e1:01.0"

      subsystem_id = "15b3:0006"
    },
  ]

}
