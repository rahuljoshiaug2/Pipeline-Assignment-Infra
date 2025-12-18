data "azurerm_mssql_server" "SQL_serdblock" {
    for_each = var.SQL_DB
    name     = each.value.server_name
    resource_group_name = each.value.rg_name
  
}

resource "azurerm_mssql_database" "SQL_DB_1" {
    for_each = var.SQL_DB
  name         = "example-db"
  server_id    = data.azurerm_mssql_server.SQL_serdblock[each.key].id
  max_size_gb  = 2
  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}