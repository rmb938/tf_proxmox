variable "name" {
  type = string
}

variable "image_family" {
  type = string
}

variable "datastore_id" {
  type = string
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "network_device_bridge" {
  type = string
}

variable "ip_config_ipv4" {
  type = object({
    address = string
    gateway = string
  })
  default = {
    address = "dhcp"
    gateway = null
  }
}

variable "replacement" {
  type = number
}

variable "additional_disks" {
  type    = list(number)
  default = []
}

variable "startup_order" {
  type    = number
  default = 2000
}

variable "startup_delay" {
  type    = number
  default = 0
}

variable "cloud_config" {
  type    = string
  default = ""
}

variable "hostpci_mappings" {
  type    = list(string)
  default = []
}
