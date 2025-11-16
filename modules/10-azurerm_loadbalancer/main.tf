# --------------------------------------
# Load Balancer
# --------------------------------------
resource "azurerm_lb" "child_loadbalancer_frontend" {
  for_each = var.var_child_loadbalancer

  name                = each.value.azurerm_lb_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.azurerm_lb_sku

  dynamic "frontend_ip_configuration" {
    for_each = each.value.frontend_ip_configuration_name_dynamic
    content {
      name                 = frontend_ip_configuration.value.azurerm_lb_frontend_ip_configuration_name
      public_ip_address_id = data.azurerm_public_ip.get_child_public_ip_loadbalancer_frontend[each.key].id
    }
  }
}

# --------------------------------------
# Backend Address Pool
# --------------------------------------
resource "azurerm_lb_backend_address_pool" "child_loadbalancer_backend_pool" {
  for_each = var.var_child_loadbalancer

  name            = each.value.azurerm_lb_backend_address_pool_name
  loadbalancer_id = azurerm_lb.child_loadbalancer_frontend[each.key].id
}

# --------------------------------------
# Health Probe
# --------------------------------------
resource "azurerm_lb_probe" "app_probe" {
  for_each = var.var_child_loadbalancer

  name                = each.value.azurerm_lb_probe_name
  loadbalancer_id     = azurerm_lb.child_loadbalancer_frontend[each.key].id
  protocol            = each.value.azurerm_lb_probe_protocol
  port                = each.value.azurerm_lb_probe_port
  interval_in_seconds = each.value.azurerm_lb_probe_interval_in_seconds
  number_of_probes    = each.value.azurerm_lb_probe_number_of_probes
}

# --------------------------------------
# LB Rule
# --------------------------------------
resource "azurerm_lb_rule" "app_lbrule" {
  for_each = var.var_child_loadbalancer

  name                           = each.value.azurerm_lb_rule_name
  loadbalancer_id                = azurerm_lb.child_loadbalancer_frontend[each.key].id
  protocol                       = each.value.azurerm_lb_rule_protocol
  frontend_port                  = each.value.azurerm_lb_rule_frontend_port
  backend_port                   = each.value.azurerm_lb_rule_backend_port
  frontend_ip_configuration_name = each.value.azurerm_lb_rule_frontend_ip_configuration_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.child_loadbalancer_backend_pool[each.key].id]
  probe_id                       = azurerm_lb_probe.app_probe[each.key].id
  disable_outbound_snat          = true
}




