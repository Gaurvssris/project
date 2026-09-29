resourcegroups = {
  "rg1" = {
    name     = "Prod-Core-Rg"
    location = "centralindia"
    tags = {
      Environment = "Production"
      ManagedBy   = "Terraform"
    }
  }
}

acr = {
  "acr1" = {
    name                = "prodenterpriseregistry01"
    resource_group_name = "Prod-Core-Rg"
    location            = "centralindia"
    sku                 = "Premium"
    admin_enabled       = false
    georeplications = [
      {
        location                = "East US"
        zone_redundancy_enabled = true
      }
    ]
  }
}

akclusters = {
  "aks1" = {
    name                = "prod-aks-cluster"
    resource_group_name = "Prod-Core-Rg"
    location            = "centralindia"
    sku_tier            = "Standard"
    node_count          = 2
    min_count           = 2
    max_count           = 4
    vm_size             = "Standard_D2s_v3"
    zones               = ["1", "2"]
  }
}

keyvaults = {
  "kv1" = {
    name                     = "prod-core-kv-010719850"
    resource_group_name      = "Prod-Core-Rg"
    location                 = "centralindia"
    sku_name                 = "premium"
    purge_protection_enabled = true
  }
}

appservices = {
  "app1" = {
    name                = "prod-core-webapp-001"
    resource_group_name = "Prod-Core-Rg"
    location            = "centralindia"
    sku_name            = "B1"
    dotnet_version      = "8.0"
  }
}