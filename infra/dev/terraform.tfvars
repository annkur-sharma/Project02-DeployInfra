var_root_dev_resource_group = {
  resource_group1 = {
    resource_group_name = "eagle-rg1"
    location            = "francecentral"
    tags = {
      env      = "dev"
      resource = "resource_group"
      app      = "terraform"
      env_type = "common"
    }
  }
}


var_root_dev_vnet = {
  vnet1 = {
    # Required variables of VNet
    vnet_name           = "eagle-vnet1"
    location            = "francecentral"
    resource_group_name = "eagle-rg1"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]

    tags = {
      env      = "dev"
      resource = "vnet"
      app      = "terraform"
      env_type = "common"
    }
  }
}


var_root_dev_subnet = {
  subnet1 = {
    subnet_name          = "eagle-subnet1-frontend"
    virtual_network_name = "eagle-vnet1"
    vnet_key             = "vnet1"
    resource_group_name  = "eagle-rg1"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    subnet_name          = "eagle-subnet2-backend"
    virtual_network_name = "eagle-vnet1"
    vnet_key             = "vnet1"
    resource_group_name  = "eagle-rg1"
    address_prefixes     = ["10.0.2.0/24"]
  }
}


var_root_dev_public_ip = {
  public_ip1 = {
    # Required variables of Public IP
    vnet_name           = "eagle-vnet1"
    location            = "francecentral"
    public_ip_name      = "eagle-pip1-frontend"
    allocation_method   = "Static"
    resource_group_name = "eagle-rg1"

    # Optional variables of Public IP
    sku                     = "Standard"
    sku_tier                = "Regional"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = 10
    zones                   = ["1", "2", "3"]

    public_ip_tags = {
      env      = "dev"
      resource = "public_ip"
      app      = "terraform"
      env_type = "frontend"
    }
  }
  public_ip2 = {
    # Required variables of Public IP
    vnet_name           = "eagle-vnet1"
    location            = "francecentral"
    public_ip_name      = "eagle-pip2-backend"
    allocation_method   = "Static"
    resource_group_name = "eagle-rg1"

    # Optional variables of Public IP
    sku                     = "Standard"
    sku_tier                = "Regional"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = 10
    zones                   = ["1", "2", "3"]

    public_ip_tags = {
      env      = "dev"
      resource = "public_ip"
      app      = "terraform"
      env_type = "backend"
    }
  }
}


var_root_dev_nsg = {
  nsg1 = {
    name                = "eagle-nsg1-frontend"
    location            = "francecentral"
    resource_group_name = "eagle-rg1"

    tags = {
      env      = "dev"
      resource = "nsg"
      app      = "terraform"
      env_type = "frontend"
    }

    security_rules = [
      {
        name                       = "Allow-SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-HTTP"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  nsg2 = {
    name                = "eagle-nsg2-backend"
    location            = "francecentral"
    resource_group_name = "eagle-rg1"

    tags = {
      env      = "dev"
      resource = "nsg"
      app      = "terraform"
      env_type = "backend"
    }

    security_rules = [
      {
        name                       = "Allow-SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-HTTP"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}


# var_root_dev_nic = {
#   nic_vm1 = {
#     name                           = "eagle-nic1-frontend"
#     location                       = "francecentral"
#     resource_group_name            = "eagle-rg1"
#     accelerated_networking_enabled = false
#     ip_forwarding_enabled          = false

#     tags = {
#       env      = "dev"
#       resource = "nic"
#       app      = "terraform"
#       env_type = "frontend"
#     }

#     subnet_key           = "subnet1"
#     subnet_name          = "eagle-subnet1-frontend"
#     virtual_network_name = "eagle-vnet1"
#     public_ip_name       = "eagle-pip1-frontend"
#     nsg_key              = "eagle-nsg1-frontend"

#     ip_configurations = [
#       {
#         name                          = "eagle-ipconfig1-frontend"
#         private_ip_address_allocation = "Dynamic"
#         primary                       = true
#       }
#     ]
#   }

#   nic_vm2 = {
#     name                = "eagle-nic2-backend"
#     location            = "francecentral"
#     resource_group_name = "eagle-rg1"

#     tags = {
#       env      = "dev"
#       resource = "nic"
#       app      = "terraform"
#       env_type = "backend"
#     }
#     subnet_key           = "subnet2"
#     subnet_name          = "eagle-subnet2-backend"
#     virtual_network_name = "eagle-vnet1"
#     public_ip_name       = "eagle-pip2-backend"
#     nsg_key              = "eagle-nsg2-backend"

#     ip_configurations = [
#       {
#         name                          = "eagle-ipconfig2-backend"
#         private_ip_address_allocation = "Dynamic"
#         primary                       = true
#       }
#     ]
#   }
# }

var_root_dev_nic_private_ip = {
  nic_vm1 = {
    name                           = "eagle-nic1-frontend"
    location                       = "francecentral"
    resource_group_name            = "eagle-rg1"
    accelerated_networking_enabled = false
    ip_forwarding_enabled          = false

    tags = {
      env      = "dev"
      resource = "nic"
      app      = "terraform"
      env_type = "frontend"
    }

    subnet_key           = "subnet1"
    subnet_name          = "eagle-subnet1-frontend"
    virtual_network_name = "eagle-vnet1"
    nsg_key              = "eagle-nsg1-frontend"


    ip_configurations = [
      {
        name                          = "eagle-ipconfig1-frontend"
        private_ip_address_allocation = "Dynamic"
        primary                       = true
      }
    ]
  }

  nic_vm2 = {
    name                = "eagle-nic2-backend"
    location            = "francecentral"
    resource_group_name = "eagle-rg1"
    accelerated_networking_enabled = false
    ip_forwarding_enabled          = false
    
    tags = {
      env      = "dev"
      resource = "nic"
      app      = "terraform"
      env_type = "backend"
    }
    subnet_key           = "subnet2"
    subnet_name          = "eagle-subnet2-backend"
    virtual_network_name = "eagle-vnet1"
    nsg_key              = "eagle-nsg2-backend"


    ip_configurations = [
      {
        name                          = "eagle-ipconfig2-backend"
        private_ip_address_allocation = "Dynamic"
        primary                       = true
      }
    ]
  }
}


var_root_dev_vms = {
  vm1 = {
    name                = "eagle-vm1-frontend"
    location            = "francecentral"
    resource_group_name = "eagle-rg1"
    size                = "Standard_B1ms"

    key_Vault_name                = "ankurKeyVault5"
    key_Vault_resource_group_name = "ankurbackend01"

    admin_username_key              = "vmuser"
    admin_password_key              = "vmpassword"
    disable_password_authentication = false

    # network_interface_id         = "/subscriptions/xxxx/resourceGroups/eagle-rg1/providers/Microsoft.Network/networkInterfaces/eagle-nic-frontend"
    nic_name             = "eagle-nic1-frontend"
    storage_account_type = "Standard_LRS"

    image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }

    computer_name          = "frontendvm"
    child_custom_data_file = "../scripts/init_blue.sh"
    tags = {
      env      = "dev"
      resource = "vm"
      app      = "terraform"
      env_type = "frontend"
    }
  }

  vm2 = {
    name                = "eagle-vm2-backend"
    location            = "francecentral"
    resource_group_name = "eagle-rg1"
    size                = "Standard_B1s"

    key_Vault_name                = "ankurKeyVault5"
    key_Vault_resource_group_name = "ankurbackend01"

    admin_username_key              = "vmuser"
    admin_password_key              = "vmpassword"
    disable_password_authentication = false

    # network_interface_id = "/subscriptions/xxxx/resourceGroups/eagle-rg1/providers/Microsoft.Network/networkInterfaces/eagle-nic-backend"
    nic_name             = "eagle-nic2-backend"
    storage_account_type = "Standard_LRS"

    image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }

    computer_name          = "backendvm"
    child_custom_data_file = "../scripts/init_green.sh"
    tags = {
      env      = "dev"
      resource = "vm"
      app      = "terraform"
      env_type = "backend"
    }
  }
}

var_root_dev_sql_server = {
  sql_server_1 = {
    sql_server_name               = "eagle-sql-server1"
    resource_group_name           = "eagle-rg1"
    location                      = "francecentral"
    sql_server_version            = "12.0"
    minimum_tls_version           = "1.2"
    public_network_access_enabled = true
    identity_type                 = "SystemAssigned"

    # Key Vault variables
    key_Vault_name                = "ankurKeyVault5"
    key_Vault_resource_group_name = "ankurbackend01"

    sql_username_key = "sqluser"
    sql_password_key = "sqlpassword"

    # # Will be called using Azure Key Vault
    # administrator_login = string
    # administrator_login_password = string
  }
}



var_root_dev_mssql_databases = {
  db1 = {
    name = "eagle-sql-database1"
    # server_id    = data.azurerm_mssql_server.get_child_sql_server[each.key].id
    collation    = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    max_size_gb  = 2 # Size in GB
    sku_name     = "S0"
    enclave_type = "VBS"

    tags = {
      env      = "dev"
      resource = "sql-database"
      app      = "terraform"
      env_type = "common"
    }

    sql_server_name     = "eagle-sql-server1"
    resource_group_name = "eagle-rg1"
  }
}



var_root_dev_subnet_bastion = {
  subnet1 = {
    subnet_name          = "AzureBastionSubnet"
    virtual_network_name = "eagle-vnet1"
    vnet_key             = "vnet1"
    resource_group_name  = "eagle-rg1"
    address_prefixes     = ["10.0.5.0/26"]
  }
}

var_root_dev_public_ip_bastion = {
  public_ip1 = {
    # Required variables of Public IP
    vnet_name           = "eagle-vnet1"
    location            = "francecentral"
    public_ip_name      = "eagle-pip1-bastion"
    allocation_method   = "Static"
    resource_group_name = "eagle-rg1"

    # Optional variables of Public IP
    sku                     = "Standard"
    sku_tier                = "Regional"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = 10
    zones                   = ["1", "2", "3"]

    public_ip_tags = {
      env      = "dev"
      resource = "public_ip"
      app      = "terraform"
      env_type = "bastion"
    }
  }
}

var_root_dev_bastion = {
  bastion-1 = {
    name                   = "eagle-bastion-eastus"
    location               = "francecentral"
    resource_group_name    = "eagle-rg1"
    sku                    = "Basic"
    scale_units            = 2
    copy_paste_enabled     = false
    file_copy_enabled      = false
    tunneling_enabled      = false
    shareable_link_enabled = false

    tags = {
      env  = "dev"
      team = "network"
    }

    ip_configuration = [
      {
        name = "bastion-ipconfig1"
        # subnet_id            = "/subscriptions/xxxx/resourceGroups/eagle-rg1/providers/Microsoft.Network/virtualNetworks/eagle-vnet1/subnets/AzureBastionSubnet"
        # public_ip_address_id = "/subscriptions/xxxx/resourceGroups/eagle-rg1/providers/Microsoft.Network/publicIPAddresses/eagle-bastion-pip"
      }
    ]

    subnet_name            = "AzureBastionSubnet"
    public_ip_address_name = "eagle-pip1-bastion"
    virtual_network_name   = "eagle-vnet1"
    # virtual_network_name   = {}
  }
}

var_root_dev_nic_private_ip_loadbalancer = {
  nic_lb1 = {
    name                           = "eagle-nic2-loadbalancer"
    location                       = "francecentral"
    resource_group_name            = "eagle-rg1"
    accelerated_networking_enabled = false
    ip_forwarding_enabled          = false

    tags = {
      env      = "dev"
      resource = "nic"
      app      = "terraform"
      env_type = "frontend"
    }


    # subnet_name            = "eagle-subnet1-frontend"
    virtual_network_name   = "eagle-vnet1"
public_ip_name       = "eagle-pip1-loadbalancer"

    ip_configurations = [
      {
        name                          = "eagle-ipconfig1-lb"
        private_ip_address_allocation = "Dynamic"
        primary                       = true
      }
    ]
  }


}


var_root_dev_public_ip_loadbalancer = {
  public_ip1 = {
    # Required variables of Public IP
    vnet_name           = "eagle-vnet1"
    location            = "francecentral"
    public_ip_name      = "eagle-pip1-loadbalancer"
    allocation_method   = "Static"
    resource_group_name = "eagle-rg1"

    # Optional variables of Public IP
    sku                     = "Standard"
    sku_tier                = "Regional"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = 10
    zones                   = ["1", "2", "3"]

    public_ip_tags = {
      env      = "dev"
      resource = "public_ip"
      app      = "terraform"
      env_type = "loadbalancer"
    }
  }
}


# var_root_dev_nic = {
#   nic_lb1 = {
#     name                           = "eagle-nic1-loadbalancer"
#     location                       = "francecentral"
#     resource_group_name            = "eagle-rg1"
#     accelerated_networking_enabled = false
#     ip_forwarding_enabled          = false

#     tags = {
#       env      = "dev"
#       resource = "nic"
#       app      = "terraform"
#       env_type = "frontend"
#     }

#     subnet_key           = "subnet1"
#     subnet_name          = "eagle-subnet1-frontend"
#     virtual_network_name = "eagle-vnet1"
#     public_ip_name       = "eagle-pip1-frontend"
#     nsg_key              = "eagle-nsg1-frontend"

#     ip_configurations = [
#       {
#         name                          = "eagle-ipconfig1-frontend"
#         private_ip_address_allocation = "Dynamic"
#         primary                       = true
#       }
#     ]
#   }
# }

var_root_dev_loadbalancer = {
  lb1 = {
    # Load Balancer
    azurerm_lb_name     = "eagle-load-balancer-1"
    location            = "francecentral"
    resource_group_name = "eagle-rg1"
    azurerm_lb_sku      = "Standard"

    frontend_ip_configuration_name_dynamic = [
      {
        azurerm_lb_frontend_ip_configuration_name = "lb1-frontend-configname1"
      }
    ]

    azurerm_lb_frontend_ip_configuration_public_ip_address_name = "eagle-pip1-loadbalancer"

    # Backend Address Pool
    azurerm_lb_backend_address_pool_name = "lb1-backend-poolame1"

    # Health Probe
    azurerm_lb_probe_name                = "lb1-probe-1"
    azurerm_lb_probe_protocol            = "Tcp"
    azurerm_lb_probe_port                = 22
    azurerm_lb_probe_interval_in_seconds = 5
    azurerm_lb_probe_number_of_probes    = 2

    # LB Rule
    azurerm_lb_rule_name                           = "lb1-rule-1"
    azurerm_lb_rule_protocol                       = "Tcp"
    azurerm_lb_rule_frontend_port                  = 80
    azurerm_lb_rule_backend_port                   = 80
    azurerm_lb_rule_frontend_ip_configuration_name = "lb1-frontend-configname1"
  }
}

# NIC Association with LB Backend Pool
var_root_dev_nic_lb_backend_association = {
  nic1_lb1 = {
    nic_name              = "eagle-nic1-frontend"
    resource_group_name   = "eagle-rg1"
    ip_configuration_name = "eagle-ipconfig1-frontend"
    azurerm_lb_name     = "eagle-load-balancer-1"
    azurerm_lb_backend_address_pool_name = "lb1-backend-poolame1"
  }
  nic2_lb1 = {
    nic_name              = "eagle-nic2-backend"
    resource_group_name   = "eagle-rg1"
    ip_configuration_name = "eagle-ipconfig2-backend"
    azurerm_lb_name     = "eagle-load-balancer-1"
    azurerm_lb_backend_address_pool_name = "lb1-backend-poolame1"
  }
}