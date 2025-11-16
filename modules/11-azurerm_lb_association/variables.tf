# NIC Association with LB Backend Pool
variable "var_child_nic_lb_backend_association" {
  type = map(object(
    {
    nic_name              = string
    resource_group_name   = string
    ip_configuration_name = string
    azurerm_lb_name     = string
    azurerm_lb_backend_address_pool_name = string
  }
  ))
}