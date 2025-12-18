variable "rgs" {
  description = "A map of resource groups to create"
  type = map(object({
    name     = string
    location = string
    managed_by = optional(string)
    tags = optional(map(string))
  }))
  
}

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

variable "vms" {
  description = "A map of virtual machines to create"
 type = map(object({
    rg_name        = string
    vnet_name      = string
    subnet_name    = string
    pip_name       = string
    allocation_method = string
    nic_name       = string
    location       = string
    vm_name        = string
    size = string
    admin_password = string
    admin_username = string
    custom_data    = string
  
  }))
  
}
variable "sql_servers" {
  description = "A map of SQL servers to create"
  type = map(object({
    name                = string
    rg_name             = string
    location            = string
    version             = string
    administrator_login = string
    administrator_login_password = string
   
  }))
  
}

variable "SQL_DB"{
    description = "A map of SQL databases to create"
    type = map(object({
        name         = string
        server_name   = string
        rg_name      = string
        max_size_gb  = number
    }))
}


variable "nsg_rule_name" {
  description = "The name of the Network Security Group rule."
  type = map(object({
    name     = string
    location = string
    rg_name  = string
    nic_name = list(string)
  }))
}


