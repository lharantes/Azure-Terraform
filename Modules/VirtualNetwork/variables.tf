variable "vnet_name" {
    description = "Virtual Network Name"
    type = string
    default = "vnet-env-teste"
}

variable "vnet_address" {
    description = "Address Space to Vnet"
    type = list
    default = ["192.168.0.0/16"]
}

variable "rg_name" {
}

variable "rg_location" {
}


