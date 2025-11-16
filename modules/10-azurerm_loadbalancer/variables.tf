variable "var_child_loadbalancer" {
  type = map(object(
    {
      # Load Balancer
      azurerm_lb_name     = string
      location            = string
      resource_group_name = string
      azurerm_lb_sku      = string # "Standard"

      frontend_ip_configuration_name_dynamic = list(object({
        azurerm_lb_frontend_ip_configuration_name                   = string
      }))
      azurerm_lb_frontend_ip_configuration_public_ip_address_name = string

      # Backend Address Pool
      azurerm_lb_backend_address_pool_name = string

      # Health Probe
      azurerm_lb_probe_name                = string # http-probe
      azurerm_lb_probe_protocol            = string # "Tcp"
      azurerm_lb_probe_port                = number # 80
      azurerm_lb_probe_interval_in_seconds = number # 5
      azurerm_lb_probe_number_of_probes    = number # 2

      # LB Rule
      azurerm_lb_rule_name                           = string
      azurerm_lb_rule_protocol                       = string # "Tcp"
      azurerm_lb_rule_frontend_port                  = number # 80
      azurerm_lb_rule_backend_port                   = number # 80
      azurerm_lb_rule_frontend_ip_configuration_name = string

    }
  ))
}




