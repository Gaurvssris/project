resource "azurerm_container_registry" "acr" {
  for_each = var.acrs

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = lookup(each.value, "sku", "Premium")
  admin_enabled       = lookup(each.value, "admin_enabled", false)

  dynamic "georeplications" {
    for_each = lookup(each.value, "georeplications", [])
    content {
      location                = georeplications.value.location
      zone_redundancy_enabled = lookup(georeplications.value, "zone_redundancy_enabled", true)
      tags                    = lookup(georeplications.value, "tags", {})
    }
  }

  tags = lookup(each.value, "tags", {})
}