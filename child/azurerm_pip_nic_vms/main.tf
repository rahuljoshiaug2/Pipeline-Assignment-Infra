data "azurerm_subnet" "subnetdatablck" {
    for_each = var.pip_nic_vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

resource "azurerm_public_ip" "PIP" {
    for_each= var.pip_nic_vms
    name= each.value.pip_name
    location= each.value.location
    resource_group_name= each.value.rg_name
  allocation_method = each.value.allocation_method
  }

resource "azurerm_network_interface" "NIC" {
    for_each= var.pip_nic_vms
    name= each.value.nic_name
    location= each.value.location
    resource_group_name= each.value.rg_name

    dynamic "ip_configuration" {
        for_each = each.value.nic_name != null ? [each.value.nic_name] : []
        content {
        name                          = "internal"
        subnet_id                     = data.azurerm_subnet.subnetdatablck[each.key].id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.PIP[each.key].id
    }
  } 
}

resource "azurerm_linux_virtual_machine" "vms" {
    for_each= var.pip_nic_vms
    name= each.value.vm_name
    resource_group_name= each.value.rg_name
    location= each.value.location
    size= each.value.size
    admin_username= each.value.admin_username
    admin_password = each.value.admin_password
    network_interface_ids= [azurerm_network_interface.NIC[each.key].id]
  disable_password_authentication = false
    
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
   
    source_image_reference {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts-gen2"
  version   = "latest"
}
custom_data = (each.value.custom_data != null ? base64encode(file(each.value.custom_data)) : null)
  
}