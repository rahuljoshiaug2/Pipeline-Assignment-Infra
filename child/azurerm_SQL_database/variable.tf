variable "SQL_DB"{
    description = "A map of SQL databases to create"
    type = map(object({
    name         = string
    server_name   = string
    rg_name      = string
    max_size_gb  = number
    
  }))
  
}