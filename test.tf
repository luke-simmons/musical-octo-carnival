provider "azurerm" {
}
resource "azurerm_resource_group" "rg" {
        name = "ls-maps-terraform-test"
        location = "ukwest"
}
resource "azurerm_template_deployment" "test" {
  name                = "ls_maps_terraform_test_maps"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  template_body = <<DEPLOY
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "accounts_ls_maps_terraform_test_name": {
            "defaultValue": "ls-maps-terraform-test",
            "type": "String"
        }
    },
    "variables": {},
    "resources": [
        {
            "type": "Microsoft.Maps/accounts",
            "apiVersion": "2018-05-01",
            "name": "[parameters('accounts_ls_maps_terraform_test_name')]",
            "location": "global",
            "sku": {
                "name": "s0",
                "tier": "Standard"
            },
            "properties": {
                "x-ms-client-id": "18317496-3d58-4fdc-ac7b-664f095276e3"
            }
        }
    ]
}
DEPLOY

  deployment_mode = "Incremental"
}
