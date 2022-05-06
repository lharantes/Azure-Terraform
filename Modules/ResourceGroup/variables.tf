variable "rg_name" {
    description = "Nome do Resource Group para esse ambiente"
    type = string
    default = "RG-ENV"
}

variable "rg_location" {
    description = "Localização do Resource Group para esse ambiente"
    type = string
    default = "brazilsouth"
}