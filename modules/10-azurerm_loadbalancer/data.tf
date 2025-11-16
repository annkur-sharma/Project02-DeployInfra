data "azurerm_public_ip" "get_child_public_ip_loadbalancer_frontend" {
  for_each = var.var_child_loadbalancer
  
  name                = each.value.azurerm_lb_frontend_ip_configuration_public_ip_address_name
  resource_group_name = each.value.resource_group_name
}





