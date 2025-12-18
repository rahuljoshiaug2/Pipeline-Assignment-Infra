variable "vnets" {
  description = "A map of virtual networks to create"
  type = map(object({
    vnet_name                = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
    tags                = optional(map(string))
    subnet = optional(map(object({
      name             = string
      address_prefixes = list(string)
    })))
  }))
  
}