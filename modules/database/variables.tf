variable "rgroup_name"{
    type = string
}

variable "location" {
    type = string
}

variable "tags" {
  type = map(string)
}

variable "admin_username" {
  default = "rutul"
}

variable "admin_password" {
  default = "Humber@3099"
}

variable "psql_server_name" {
    type = string
}

variable "psql_db_name" {
    type = string
}
