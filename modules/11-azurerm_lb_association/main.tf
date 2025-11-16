# --------------------------------------
# NIC Association with LB Backend Pool
# --------------------------------------
resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_assoc" {
  

  for_each = var.var_child_nic_lb_backend_association

  network_interface_id    = data.azurerm_network_interface.get_child_network_interface[each.key].id
  ip_configuration_name   = each.value.ip_configuration_name
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.get_child_azurerm_lb_backend_address_pool[each.key].id
}