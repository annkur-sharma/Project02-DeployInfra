output "out_child_loadbalancer_name_ip" {
  value = {
    for k, v in azurerm_lb.child_loadbalancer_frontend :
    k => {
        lb_name = v.name
        lb_public_ip = v.public_ip_address_id
    }
  }
}