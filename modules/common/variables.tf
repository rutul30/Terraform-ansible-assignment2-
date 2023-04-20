variable "location" {
  type = string
}

variable "rgroup_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "storage_account" {
  type = string
}

variable "container_name" {
  type = string  
}

variable "la_workspace" {
  type = object({
    law_name   = string
    log_sku    = string
    retention  = number
  })
}

variable "rs_vault" {
  type = object({
    vault_name = string
    vault_sku  = string
  })
}
