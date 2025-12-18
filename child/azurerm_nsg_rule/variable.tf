
variable "nsg_rule_name" {
  description = "The name of the Network Security Group rule."
  type = map(object({
    name     = string
    location = string
    rg_name  = string
    nic_name = list(string)
  }))
}