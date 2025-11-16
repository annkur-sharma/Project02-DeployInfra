module "module_resource_group" {
  source                   = "../../modules/01-resource-group"
  var_child_resource_group = var.var_root_dev_resource_group
}

module "module_networking" {
  depends_on       = [module.module_resource_group]
  source           = "../../modules/02-networking"
  var_child_vnet   = var.var_root_dev_vnet
  var_child_subnet = var.var_root_dev_subnet
}

module "module_nsg" {
  depends_on    = [module.module_resource_group, module.module_networking]
  source        = "../../modules/03-nsg"
  var_child_nsg = var.var_root_dev_nsg
}

# module "module_public_ip" {
#   depends_on          = [module.module_resource_group]
#   source              = "../../modules/04-public-ip"
#   var_child_public_ip = var.var_root_dev_public_ip
# }

module "module_nic_vms" {
  depends_on    = [module.module_resource_group, module.module_networking, module.module_nsg ]
  source        = "../../modules/05-nic"
  var_child_nic = var.var_root_dev_nic_private_ip
  subnet_ids    = module.module_networking.out_child_subnet_ids
  nsg_ids       = module.module_nsg.out_child_nsg_name_ids
  public_ip_ids = {}
}

module "module_vm" {
  depends_on   = [module.module_resource_group, module.module_networking, module.module_nic_vms]
  source       = "../../modules/06-vm"
  var_child_vm = var.var_root_dev_vms
}

# module "module_mssql_server" {
#   depends_on           = [module.module_resource_group]
#   source               = "../../modules/08-azurerm_mssql_server"
#   var_child_sql_server = var.var_root_dev_sql_server
# }

# module "module_mssql_database" {
#   depends_on                = [module.module_resource_group, module.module_mssql_server]
#   source                    = "../../modules/09-azurerm_mssql_database"
#   var_child_mssql_databases = var.var_root_dev_mssql_databases
# }

module "module_bastion_host_subnet" {
  depends_on          = [module.module_resource_group, module.module_networking]
    source           = "../../modules/02a-subnet"
  var_child_subnet = var.var_root_dev_subnet_bastion
}

module "module_bastion_host_public_ip" {
  depends_on          = [module.module_resource_group, module.module_bastion_host_subnet]
  source              = "../../modules/04-public-ip"
  var_child_public_ip = var.var_root_dev_public_ip_bastion
}

module "module_bastion_host" {
  depends_on          = [module.module_resource_group, module.module_bastion_host_subnet, module.module_bastion_host_public_ip]
  source              = "../../modules/07-bastion"
  var_child_bastion = var.var_root_dev_bastion
}

module "module_public_ip_loadbalancer" {
  depends_on          = [module.module_resource_group, module.module_nic_vms, module.module_vm]
  source              = "../../modules/04-public-ip"
  var_child_public_ip = var.var_root_dev_public_ip_loadbalancer
}

module "module_loadbalancer" {
  depends_on          = [module.module_resource_group, module.module_public_ip_loadbalancer]
  source              = "../../modules/10-azurerm_loadbalancer"
  var_child_loadbalancer = var.var_root_dev_loadbalancer
}

module "module_loadbalancer_backend_pool_nic_association" {
  depends_on          = [module.module_loadbalancer, module.module_nic_vms]
  source              = "../../modules/11-azurerm_lb_association"
  var_child_nic_lb_backend_association = var.var_root_dev_nic_lb_backend_association
}

# module "module_nat_gateway" {
#   source = "../../modules/12-azurerm_nat_gateway"

#   resource_group_name = module.module_resource_group.out_child_resource_group_name
#   location            = module.module_resource_group.out_child_resource_group_location
#   subnet_id           = module.module_networking.out_child_subnet_ids["subnet1"]

#   nat_public_ip_name = "eagle-nat-pip"
#   nat_gateway_name   = "eagle-natgw"
# }