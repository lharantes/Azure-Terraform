data "azurerm_virtual_network" "vnet" {
  name                 = var.vnet_name
  resource_group_name  = var.rg_name
}


data "azurerm_subnet" "snet" {
    name                 = data.azurerm_virtual_network.vnet.subnets[count.index]
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
    count                = 2
    //length(data.azurerm_virtual_network.vnet.subnets)
}

resource azurerm_windows_virtual_machine vm {
    count = var.vm_win_instances
        name = "${var.vm_name}-${count.index+1}"
        resource_group_name = var.rg_name
        location = var.rg_location
        admin_username = var.admin_username
        admin_password = var.admin_passowrd
        size = var.vm_size
        network_interface_ids = [azurerm_network_interface.nic.*.id[count.index]]

    os_disk {
        caching              = var.disk_caching
        storage_account_type = var.storage_type
        disk_size_gb = 512
    }

    source_image_reference {
        publisher = var.vm_publisher
        offer     = var.vm_offer
        sku       = var.vm_sku
        version   = var.vm_version
  }
}

resource "azurerm_public_ip" "ip_public" {
    count = var.vm_win_instances
    name                = join("-",["pip", lower(var.vm_name), "${count.index}"]) 
    resource_group_name = var.rg_name
    location            = var.rg_location
    allocation_method   = var.ip_allocation
}

resource "azurerm_network_interface" "nic" {
    count = var.vm_win_instances
        name                = join("-",["nic", lower(var.vm_name), "${count.index}"]) 
        location            = var.rg_location
        resource_group_name = var.rg_name

    ip_configuration {
        name                          = "internal"
        //subnet_id                     = data.terraform_remote_state.networking.outputs.virtualnetwork_subnets_ids[1]
        subnet_id      = data.azurerm_subnet.snet.*.id[0]
        private_ip_address_allocation = var.ip_allocation
        public_ip_address_id = azurerm_public_ip.ip_public.*.id[count.index]
    }
}
