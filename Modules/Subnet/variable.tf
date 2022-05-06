variable "subnets" {
    type = map
    default = {
        subnet1 = {
            snet_name = "sNet_Server"
            snet_address = ["192.168.0.0/24"]
        },
        subnet2 = {
            snet_name = "sNet_User"
            snet_address = ["192.168.1.0/24"]
        }
    }
}

variable "rg_name" {
}

variable "vnet_name" {
}

variable "nsg_id" {
}