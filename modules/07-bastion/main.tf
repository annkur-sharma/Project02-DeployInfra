# ===========================================================
# Azure Bastion Host - Generic Module (Supports for_each)
# ===========================================================
resource "azurerm_bastion_host" "child_bastion" {
  for_each = var.var_child_bastion

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  sku                         = try(each.value.sku, "Basic")
  copy_paste_enabled           = try(each.value.copy_paste_enabled, true)
  file_copy_enabled            = try(each.value.file_copy_enabled, false)
  ip_connect_enabled           = try(each.value.ip_connect_enabled, false)
  kerberos_enabled             = try(each.value.kerberos_enabled, false)
  scale_units                  = try(each.value.scale_units, 2)
  shareable_link_enabled       = try(each.value.shareable_link_enabled, false)
  tunneling_enabled            = try(each.value.tunneling_enabled, false)
  session_recording_enabled    = try(each.value.session_recording_enabled, false)
  # virtual_network_id           = try(data.azurerm_virtual_network.data_child_virtual_network[each.key].id, null)
  tags                         = try(each.value.tags, {})
  zones                        = try(each.value.zones, null)

  # ==========================
  # Dynamic IP Configuration
  # ==========================
  dynamic "ip_configuration" {
    for_each = try(each.value.ip_configuration, [])
    content {
      name                 = ip_configuration.value.name
      subnet_id            = data.azurerm_subnet.data_child_subnet[each.key].id
      public_ip_address_id = data.azurerm_public_ip.data_child_public_ip[each.key].id
    }
  }
}