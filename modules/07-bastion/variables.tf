variable "var_child_bastion" {
  description = "Map of Bastion Hosts with configuration details"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    # Accepted values: Developer, Basic, Standard, Premium. Defaults to Basic.
    # Downgrading the SKU will force a new resource to be created.
    sku = optional(string)

    # Enable or disable Copy/Paste feature (default: true).
    copy_paste_enabled = optional(bool)

    # Enable or disable File Copy feature.
    # file_copy_enabled is only supported when sku is Standard or Premium.
    file_copy_enabled = optional(bool)

    # Enable or disable IP Connect feature.
    # ip_connect_enabled is only supported when sku is Standard or Premium.
    ip_connect_enabled = optional(bool)

    # Enable or disable Kerberos authentication.
    # kerberos_enabled is only supported when sku is Standard or Premium.
    kerberos_enabled = optional(bool)

    # Number of scale units (2–50). Defaults to 2.
    # scale_units can only be changed when sku is Standard or Premium.
    scale_units = optional(number)

    # Enable or disable Shareable Link feature.
    # shareable_link_enabled is only supported when sku is Standard or Premium.
    shareable_link_enabled = optional(bool)

    # Enable or disable Tunneling feature.
    # tunneling_enabled is only supported when sku is Standard or Premium.
    tunneling_enabled = optional(bool)

    # Enable or disable Session Recording feature.
    # session_recording_enabled is only supported when sku is Premium.
    session_recording_enabled = optional(bool)

    # ID of VNet (used only for Developer SKU).
    virtual_network_id = optional(string)

    # Resource tags.
    tags = optional(map(string))

    # List of Availability Zones.
    zones = optional(list(string))

    # Bastion IP Configuration block
    ip_configuration = list(object({
      name = string
      #   subnet_id            = string  # The subnet must be named 'AzureBastionSubnet' and have at least a /26 mask.
      #   public_ip_address_id = string  # Reference to a Public IP Address for Bastion Host.
    }))

    subnet_name            = string # The subnet must be named 'AzureBastionSubnet' and have at least a /26 mask.
    public_ip_address_name = string # Reference to a Public IP Address for Bastion Host.
    virtual_network_name   = optional(string)
  }))
}
