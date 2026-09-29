module "resource_groups" {
  source          = "../../childenvironment/azurerm_resource_group"
  resource_groups = var.resourcegroups
}

module "acr" {
  source     = "../../childenvironment/azurerm_acr"
  acrs       = var.acr
  depends_on = [module.resource_groups]
}

module "aks" {
  source              = "../../childenvironment/azurerm_aks"
  kubernetes_clusters = var.akclusters
  depends_on          = [module.resource_groups, module.acr]
}

module "key_vault" {
  source     = "../../childenvironment/azurerm_key_vault"
  key_vaults = var.keyvaults
  depends_on = [module.resource_groups]
}

module "app_service" {
  source       = "../../childenvironment/azurerm_app_service"
  app_services = var.appservices
  depends_on   = [module.resource_groups]
}