resource "azurerm_network_security_group" "vm_nsg" {
  for_each = var.nsg_rule_name

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rg_name
}

resource "azurerm_network_security_rule" "allow_ssh" {
  for_each = var.nsg_rule_name

  name                        = "Allow-SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"

  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

  resource_group_name         = each.value.rg_name
  network_security_group_name = azurerm_network_security_group.vm_nsg[each.key].name
}

resource "azurerm_network_security_rule" "allow_http" {
  for_each = var.nsg_rule_name

  name                        = "Allow-HTTP"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"

  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

  resource_group_name         = each.value.rg_name
  network_security_group_name = azurerm_network_security_group.vm_nsg[each.key].name
}

# 🟢 Attach NSG to multiple NICs
locals {
  nic_to_nsg = {
    for entry in flatten([
      for nsg_key, nsg_obj in var.nsg_rule_name : [
        for nic in nsg_obj.nic_name : {
          nic     = nic
          nsg_key = nsg_key
        }
      ]
    ]) :
    entry.nic => entry.nsg_key
  }
}



data "azurerm_network_interface" "NIC" {
  for_each = local.nic_to_nsg

  name                = each.key
  resource_group_name = var.nsg_rule_name[each.value].rg_name
}



resource "azurerm_network_interface_security_group_association" "nic_assoc" {
  for_each = data.azurerm_network_interface.NIC

  network_interface_id      = each.value.id
  network_security_group_id = azurerm_network_security_group.vm_nsg[local.nic_to_nsg[each.key]].id
}



