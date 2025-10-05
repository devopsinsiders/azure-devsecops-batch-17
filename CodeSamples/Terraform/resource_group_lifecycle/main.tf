resource "azurerm_resource_group" "rg" {
  name     = "tiptop-rg54"
  location = "centralindia"

  lifecycle {
    create_before_destroy = true
    #prevent_destroy       = true
    ignore_changes = [name]
  }
}
