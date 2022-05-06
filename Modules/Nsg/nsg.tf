resource azurerm_network_security_group nsg {
    name = var.nsg_name
    location = var.rg_location
    resource_group_name = var.rg_name
}

resource azurerm_network_security_rule nsg_regras {
    for_each = var.regras_entrada
    resource_group_name = var.rg_name
    name = "Allow_in_${each.value}"
    priority = each.key
    access = "Allow"
    direction = "Inbound"
    protocol = "Tcp"
    source_address_prefix = "*"
    source_port_range = "*"
    destination_address_prefix = "*"
    destination_port_range = each.value
    network_security_group_name = azurerm_network_security_group.nsg.name  
}
