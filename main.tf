provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_managed_disk" "os_disk" {
  name                 = "demo-os-disk"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 30
}

resource "azurerm_snapshot" "vm_snapshot" {
  name                = "demo-vm-snapshot"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  create_option       = "Copy"
  source_uri          = azurerm_managed_disk.os_disk.id
}

resource "azurerm_image" "vm_image" {
  name                = "demo-vm-image"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  os_disk {
    os_type  = "Linux"
    os_state = "Generalized"
    blob_uri = null
    managed_disk_id = azurerm_snapshot.vm_snapshot.id
  }
}
