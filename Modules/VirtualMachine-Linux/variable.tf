variable "vm_linux_instances" {
}

variable "vm_name" {
    type = string
    default = "VM-LINUX"
}

variable "subnet_id" {
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
  default = "UbuntuServer"
}

variable "vm_publisher" {
  default = "Canonical"
}

##### Resource Group
variable "rg_name" {  
}

variable "rg_location" {  
}