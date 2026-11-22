output "web_public_ip" {
  value = azurerm_public_ip.web.ip_address
}

output "monitoring_public_ip" {
  value = azurerm_public_ip.monitoring.ip_address
}

output "web_private_ip" {
  value = azurerm_network_interface.web.private_ip_address
}

output "monitoring_private_ip" {
  value = azurerm_network_interface.monitoring.private_ip_address
}
