# Postgres Server
resource "azurerm_postgresql_server" "postsql_server" {
  name                          = var.psql_server_name
  location                      = var.location
  resource_group_name           = var.rgroup_name
  sku_name                      = "B_Gen5_1"
  storage_mb                    = 5120
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  auto_grow_enabled             = true
  administrator_login           = var.admin_username
  administrator_login_password  = var.admin_password
  version                       = "11"
  ssl_enforcement_enabled       = true
  tags                          = var.tags
}

# Posegres Database
resource "azurerm_postgresql_database" "database" {
  name                          = var.psql_db_name
  resource_group_name           = var.rgroup_name
  server_name                   = azurerm_postgresql_server.postsql_server.name
  charset                       = "UTF8"
  collation                     = "English_United States.1252"
  depends_on = [
    azurerm_postgresql_server.postsql_server
  ]
}
