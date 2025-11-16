resource "azurerm_public_ip" "nat_pip" {
  for_each = var.child_nat_gateway
  
  name                = each.value.nat_public_ip_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "natgw" {
    for_each = var.child_nat_gateway
  name                = each.value.nat_gateway_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "natgw_ip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.nat_pip.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_assoc" {
    for_each = var.child_nat_gateway
    
  subnet_id      = each.value.subnet_id
  nat_gateway_id = azurerm_nat_gateway.natgw.id
}
