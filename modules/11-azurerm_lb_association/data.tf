data "azurerm_lb" "get_child_azurerm_lb" {
  for_each = var.var_child_nic_lb_backend_association
  
  name                = each.value.azurerm_lb_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_lb_backend_address_pool" "get_child_azurerm_lb_backend_address_pool" {
  for_each = var.var_child_nic_lb_backend_association

  name            = each.value.azurerm_lb_backend_address_pool_name
  loadbalancer_id = data.azurerm_lb.get_child_azurerm_lb[each.key].id
}

data "azurerm_network_interface" "get_child_network_interface" {
  for_each = var.var_child_nic_lb_backend_association

  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}