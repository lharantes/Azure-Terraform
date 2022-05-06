variable "nsg_name" {
    type = string
    default = "nsg-servers" 
}

variable "rg_name" {  
}

variable "rg_location" {  
}

variable "regras_entrada" {
    type = map
}