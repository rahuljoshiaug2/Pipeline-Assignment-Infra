resource "azurerm_virtual_network" "VNet1" {
  for_each = var.vnets
  name                = each.value.vnet_name
  address_space       = each.value.address_space
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = try(each.value.tags, null)
  dynamic "subnet"{
    for_each = try(each.value.subnet, [])
    content {
      name           = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
     
    }
 
}   
}