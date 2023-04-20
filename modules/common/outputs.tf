output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "la_workspace_name" {
  value = azurerm_log_analytics_workspace.la_workspace.name
}

output "recovery_vault_name" {
  value = azurerm_recovery_services_vault.recovery_vault.name
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.storage_account.primary_blob_endpoint
}