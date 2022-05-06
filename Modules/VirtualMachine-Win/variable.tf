variable "vm_win_instances" {
}

variable "vm_name" {
    type = string
    default = "VM-WIN"
}

//variable "subnet_id" {
//}

variable "vnet_name" {
  
}

variable ip_allocation {
    type = string
    default = "Dynamic"
}

variable "vm_size" {
}

variable admin_username {
      type = string
      default = "azadmin"
  }

variable admin_passowrd {
      type = string
      default = ""
  }

##### Disk CONFIG
variable disk_caching {
    default = "ReadWrite"
}

variable storage_type {
    default = "Standard_LRS"
}

##### OS CONFIG
variable "vm_version" {
  default = "latest"
}

variable "vm_sku" {
}

variable "vm_offer" {
  default = "Windows-10"
}

variable "vm_publisher" {
  default = "MicrosoftWindowsDesktop"
}

##### Resource Group
variable "rg_name" {  
}

variable "rg_location" {  
}

/*"imageReference": {
                        "publisher": "MicrosoftWindowsDesktop",
                        "offer": "Windows-10",
                        "sku": "win10-21h2-pro-g2",
                        "version": "latest"
                        */