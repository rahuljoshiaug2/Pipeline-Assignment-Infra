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