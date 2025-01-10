## Resource Group da Rimuovere e sostituire con quello creato su Azure ##
resource "azurerm_resource_group" "log_analytics_rg" {
  name     = "${local.project}-log-analytics-rg"
  location = "Italy North"
}

resource "azapi_resource" "log_analytics_cluster" {
  type      = "Microsoft.OperationalInsights/clusters@2023-09-01"
  name      = "${local.project}-log-cluster"
  parent_id = azurerm_resource_group.log_analytics_rg.id

  identity {
    type = "SystemAssigned"
  }
  location = "Italy North"

  body = {
    sku = {
      capacity = 100
      name     = "CapacityReservation"
    }
    properties = {
      associatedWorkspaces = [
        {
        }
      ]
      billingType = "Workspaces"
    }
  }
}