output "out_child_subnet_name_to_subnet_id" {
  description = "Map of subnet names to subnet IDs"
  value = { 
    for k, v in azurerm_subnet.child_subnet : 
    v.name => v.id 
    }
}

###############################
# Below is the output
# 👉 Maps subnet name → subnet ID
###############################
# subnet_ids = {
#   "subnet1" = "/subscriptions/xxx-xxx-xxx-xxx/resourceGroups/eagle-rg1/providers/Microsoft.Network/virtualNetworks/eagle-vnet1/subnets/eagle-subnet1"
#   "subnet2" = "/subscriptions/xxx-xxx-xxx-xxx/resourceGroups/eagle-rg1/providers/Microsoft.Network/virtualNetworks/eagle-vnet1/subnets/AzureBastionSubnet"
# }
###############################