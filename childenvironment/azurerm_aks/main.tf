resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.kubernetes_clusters

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = lookup(each.value, "dns_prefix", "${each.value.name}-dns")
  sku_tier            = lookup(each.value, "sku_tier", "Standard")

  default_node_pool {
    name                = lookup(each.value, "default_node_pool_name", "systempool")
    node_count          = lookup(each.value, "node_count", 2)
    vm_size             = lookup(each.value, "vm_size", "Standard_D2s_v3")
    zones               = lookup(each.value, "zones", ["1", "2", "3"])
    auto_scaling_enabled = lookup(each.value, "auto_scaling_enabled", true)
    min_count           = lookup(each.value, "min_count", 3)
    max_count           = lookup(each.value, "max_count", 6)
    os_disk_size_gb     = lookup(each.value, "os_disk_size_gb", 128)
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = lookup(each.value, "network_plugin", "azure")
    load_balancer_sku = "standard"
  }

  tags = lookup(each.value, "tags", {})
}