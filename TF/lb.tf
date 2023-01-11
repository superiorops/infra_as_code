resource "azurerm_public_ip" "web_lb" {
  name                = "${var.prefix}-web_ln-pip"
  resource_group_name = azurerm_resource_group.myapp.name
  location            = azurerm_resource_group.myapp.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}


resource "azurerm_lb" "web" {
 name                = "${var.prefix}-web-lb"
 location            = azurerm_resource_group.myapp.location
 resource_group_name = azurerm_resource_group.myapp.name
 sku                 = "Standard"

 frontend_ip_configuration {
   name                 = "PublicIPAddress"
   public_ip_address_id = azurerm_public_ip.web_lb.id
 }

 tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "web" {
 loadbalancer_id     = azurerm_lb.web.id
 name                = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "web" {
 loadbalancer_id     = azurerm_lb.web.id
 name                = "web-probe"
 port                = var.application_port
}



resource "azurerm_network_interface_backend_address_pool_association" "web" {
  count = var.web_node_count
  network_interface_id    = element(azurerm_network_interface.web.*.id, count.index)
  ip_configuration_name   = "configuration-${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.web.id 

}


resource "azurerm_lb_rule" "lbnatrule" {
   loadbalancer_id                = azurerm_lb.web.id
   name                           = "http"
   protocol                       = "Tcp"
   frontend_port                  = var.frontend_port
   backend_port                   = var.application_port
   frontend_ip_configuration_name = "PublicIPAddress"
   probe_id                       = azurerm_lb_probe.web.id
   backend_address_pool_ids       = [azurerm_lb_backend_address_pool.web.id]
   disable_outbound_snat          = true
}


resource "azurerm_lb_outbound_rule" "example" {
  loadbalancer_id         = azurerm_lb.web.id
  name                    = "OutboundRule"
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.web.id

  frontend_ip_configuration {
    name = "PublicIPAddress"
  }
}
