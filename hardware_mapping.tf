resource "proxmox_virtual_environment_hardware_mapping_pci" "connextx-4" {
  count = 8

  name = "connectx-4-vf-${count.index + 1}"

  map = [
    {
      comment = "This is a device specific comment"

      id = "15b3:0006"

      iommu_group = 67 + count.index
      node        = "freenas-pm"
      path        = "0000:e1:00.${count.index + 1}"

      subsystem_id = "15b3:0006"
    },
  ]

}
