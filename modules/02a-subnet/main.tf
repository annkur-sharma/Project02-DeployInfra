# ===================
# Subnet Resource
# ===================
resource "azurerm_subnet" "child_subnet" {
  
  for_each = var.var_child_subnet

  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  # virtual_network_name = azurerm_virtual_network.child_virtual_network[each.value.vnet_key].vnet_name

  # Either address_prefixes or ip_address_pool must be defined
  address_prefixes = try(each.value.address_prefixes, null)

  default_outbound_access_enabled               = try(each.value.default_outbound_access_enabled, true)
  private_endpoint_network_policies             = try(each.value.private_endpoint_network_policies, null)
  private_link_service_network_policies_enabled = try(each.value.private_link_service_network_policies_enabled, true)
  sharing_scope                                 = try(each.value.sharing_scope, null)
  service_endpoints                             = try(each.value.service_endpoints, null)
  service_endpoint_policy_ids                   = try(each.value.service_endpoint_policy_ids, null)

  # Optional: IP Address Pool block
  dynamic "ip_address_pool" {
    for_each = try(each.value.ip_address_pool, null) != null ? [each.value.ip_address_pool] : []
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }

  # Optional: Delegation block
  dynamic "delegation" {
    for_each = try(each.value.delegation, null) != null ? [each.value.delegation] : []
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = try(delegation.value.service_delegation.actions, null)
      }
    }
  }
}