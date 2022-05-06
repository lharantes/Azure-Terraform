resource azurerm_linux_virtual_machine vm {
    count = var.vm_linux_instances
        name = "${var.vm_name}-${count.index+1}"
        resource_group_name = var.rg_name
        location = var.rg_location
        admin_username = var.admin_username
        admin_password = var.admin_passowrd
        size = var.vm_size
        disable_password_authentication = false
        network_interface_ids = [azurerm_network_interface.nic.*.id[count.index]]

    os_disk {
        caching              = var.disk_caching
        storage_account_type = var.storage_type
    }

    source_image_reference {
        publisher = var.vm_publisher
        offer     = var.vm_offer
        sku       = var.vm_sku
        version   = var.vm_version
  }
}

resource "azurerm_public_ip" "ip_public" {
    count = var.vm_linux_instances
        name                = join("-",["pip", lower(var.vm_name), "${count.index}"]) 
        resource_group_name = var.rg_name
        location            = var.rg_location
        allocation_method   = var.ip_allocation
}

resource "azurerm_network_interface" "nic" {
    count = var.vm_linux_instances
        name                = join("-",["nic", lower(var.vm_name), "${count.index}"]) 
        location            = var.rg_location
        resource_group_name = var.rg_name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = var.subnet_id
        private_ip_address_allocation = var.ip_allocation
        public_ip_address_id = azurerm_public_ip.ip_public.*.id[count.index]
    }
}