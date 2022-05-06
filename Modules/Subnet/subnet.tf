resource "azurerm_subnet" "subnet" {
    for_each = var.subnets
    name = each.value.snet_name
    resource_group_name = var.rg_name
    address_prefixes = each.value.snet_address
    virtual_network_name = var.vnet_name
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet" {
    for_each                    = azurerm_subnet.subnet
      subnet_id                 = each.value.id
      network_security_group_id = var.nsg_id
}