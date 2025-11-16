variable "resource_group_name" {}
variable "location" {}
variable "subnet_id" {}

variable "nat_public_ip_name" {}
variable "nat_gateway_name" {}

variable "child_nat_gateway" {
  type = map(object(
    {
      resource_group_name = string
      location            = string
      subnet_id           = string

      nat_public_ip_name = string
      nat_gateway_name   = string

      child_nat_gatewa = string
    }
  ))
}
