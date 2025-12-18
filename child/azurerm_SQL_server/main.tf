resource "azurerm_mssql_server" "SQL_server1" {
    for_each = var.sql_servers
   name                         = each.value.name
  resource_group_name          = each.value.rg_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
  
  }