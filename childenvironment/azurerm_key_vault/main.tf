data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  for_each = var.key_vaults

  name                       = each.value.name
  location                   = each.value.location
  resource_group_name        = each.value.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = lookup(each.value, "sku_name", "premium")
  soft_delete_retention_days = lookup(each.value, "soft_delete_retention_days", 90)
  purge_protection_enabled   = lookup(each.value, "purge_protection_enabled", true)
  rbac_authorization_enabled  = lookup(each.value, "rbac_authorization_enabled", true)

  network_acls {
    bypass         = "AzureServices"
    default_action = lookup(each.value, "default_action", "Allow")
  }

  timeouts {
    create = "30m"
    read   = "10m"
    delete = "30m"
  }

  tags = lookup(each.value, "tags", {})
}