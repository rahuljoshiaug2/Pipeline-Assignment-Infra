module "azurerm_resource_group" {
  source = "../../child/azurerm_resource_group"
  rgs=var.rgs
  
}

module "azurerm_virtual_network" {
    depends_on = [ module.azurerm_resource_group ]
    source = "../../child/azurerm_vnet_subnet"
    vnets=var.vnets
 
}

module "azurerm_virtual_machine" {
    depends_on = [ module.azurerm_virtual_network ]
  source = "../../child/azurerm_pip_nic_vms"
    pip_nic_vms=var.vms
  
}

module "azurerm_network_security_group" {
  depends_on = [ module.azurerm_virtual_machine ]
  source = "../../child/azurerm_nsg_rule"
  nsg_rule_name= var.nsg_rule_name

}


module "azurerm_SQL_server" {
  depends_on = [ module.azurerm_resource_group ]
  source = "../../child/azurerm_SQL_server"
  sql_servers=var.sql_servers

  
}

module "azurerm_SQL_database" {
  depends_on = [ module.azurerm_SQL_server ]
  source = "../../child/azurerm_SQL_database"
  SQL_DB=var.SQL_DB
  
}