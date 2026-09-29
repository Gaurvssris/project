resource "azurerm_service_plan" "asp" {
  for_each = var.app_services

  name                = "${each.value.name}-asp"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  os_type             = lookup(each.value, "os_type", "Linux")
  sku_name            = lookup(each.value, "sku_name", "P1v3")

  tags = lookup(each.value, "tags", {})
}

resource "azurerm_linux_web_app" "app" {
  for_each = var.app_services

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  service_plan_id     = azurerm_service_plan.asp[each.key].id
  https_only          = true

  site_config {
    always_on        = true
    ftps_state       = "Disabled"
    minimum_tls_version = "1.2"

    application_stack {
      dotnet_version = lookup(each.value, "dotnet_version", "8.0")
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = lookup(each.value, "tags", {})
}