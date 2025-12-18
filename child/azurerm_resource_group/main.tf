resource "azurerm_resource_group" "RG1"{
  for_each= var.rgs
  name     = each.value.name
  location = each.value.location
  managed_by = lookup(each.value, "managed_by", null)
  tags     = try(each.value.tags, null)
}