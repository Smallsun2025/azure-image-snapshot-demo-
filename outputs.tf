output "snapshot_id" {
  value = azurerm_snapshot.vm_snapshot.id
}

output "image_id" {
  value = azurerm_image.vm_image.id
}
