data "azurerm_subnet" "data_child_subnet" {
  for_each = var.var_child_bastion
  
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "data_child_public_ip" {
    for_each = var.var_child_bastion

  name                = each.value.public_ip_address_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_virtual_network" "data_child_virtual_network" {
    for_each = var.var_child_bastion

  name                = each.value.virtual_network_name
  resource_group_name = each.value.resource_group_name
}