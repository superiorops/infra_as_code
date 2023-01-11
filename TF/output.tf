output "agent_ip" {
  value = azurerm_public_ip.agent.ip_address
}

output "lb" {
   value = azurerm_public_ip.web_lb.ip_address
}

output "web_ip" {
   value = [azurerm_network_interface.web.*.private_ip_address]
}

output "app_ip" {
   value = [azurerm_network_interface.web.*.private_ip_address]
}

output "db_ip" {
   value = [azurerm_network_interface.db.*.private_ip_address]
}