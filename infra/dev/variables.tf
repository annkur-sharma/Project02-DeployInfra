variable "var_root_dev_resource_group" {}

# "Map of Virtual Network, Subnet, Public IP"
variable "var_root_dev_vnet" {}

# "Subnet definitions for each VNet"
variable "var_root_dev_subnet" {}

# Public IP resource
variable "var_root_dev_public_ip" {}

# "Map of Network Security Groups to create with optional security rules."
variable "var_root_dev_nsg" {}

# "Map of virtual machines with configuration"
variable "var_root_dev_vms" {}

variable "var_root_dev_sql_server" {}

# "Map of MSSQL Databases to be created"
variable "var_root_dev_mssql_databases" {}

# "Map of Bastion Hosts with configuration details"
variable "var_root_dev_bastion" {}

variable "var_root_dev_subnet_bastion" {}

variable "var_root_dev_public_ip_bastion" {}

variable "var_root_dev_public_ip_loadbalancer" {}

variable "var_root_dev_nic_private_ip_loadbalancer" {}

# "Map of Network Interfaces with their IP configuration details."
variable "var_root_dev_nic_private_ip" {}

# Load Balancer
variable "var_root_dev_loadbalancer" {}

variable "var_root_dev_nic_lb_backend_association" {}