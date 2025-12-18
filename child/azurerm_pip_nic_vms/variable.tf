variable "pip_nic_vms" {
  description = "A map of public IPs, network interfaces, and virtual machines to create"
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