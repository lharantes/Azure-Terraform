output public_ip {
    value = azurerm_windows_virtual_machine.vm[*].public_ip_address
}

output private_ip {
    value = azurerm_windows_virtual_machine.vm[*].private_ip
}