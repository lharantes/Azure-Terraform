data "azurerm_key_vault" "getkeyvault" {
  name                = "kv-prod"
  resource_group_name = "RG-KeyVault"
}

data "azurerm_key_vault_secret" "secretget" {
  name         = "secret-vms"
  key_vault_id = data.azurerm_key_vault.getkeyvault.id
}