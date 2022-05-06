provider "azurerm" {
  features {}
}

module "resource_group_module" {
  source = "./Modules/ResourceGroup"
}

module "virtual_network_module" {
  source = "./Modules/VirtualNetwork"
  depends_on = [
    module.resource_group_module
  ]
  rg_name     = module.resource_group_module.rg_name
  rg_location = module.resource_group_module.rg_location
}

module "subnet_module" {
  source = "./Modules/Subnet"
  depends_on = [
    module.virtual_network_module,
    module.nsg_module
  ]
  rg_name   = module.resource_group_module.rg_name
  vnet_name = module.virtual_network_module.vnet_name
  nsg_id    = module.nsg_module.nsg_id
}

module "nsg_module" {
  source      = "./Modules/Nsg"
  rg_name     = module.resource_group_module.rg_name
  rg_location = module.resource_group_module.rg_location

  # Portas que serão liberadas no NSG, onde o primeiro numero será a prioridade e o segundo é a porta a ser liberada
  regras_entrada = {
    101 = "3389"
    102 = "22"
  }
}

module "keyvault_module" {
  source = "./Modules/Keyvault"
}

/* Data: 15/04/2022
Size              vCPU	RAM		Preço VMs
Standard_B1ls     1 		 0.5	R$    20,83
Standard_B1s      1	  	 1		R$    41,65
Standard_B1ms     1		   2		R$    83,31
Standard_B2s      2		   4		R$   166,62
Standard_B2ms     2		   8		R$   333,24
Standard_B4ms     4  		16		R$   664,87
Standard_B8ms     8	  	32		R$ 1.333,75

Standard_D2s_v3		2		   8		R$   384,51
Standard_D4s_v3		4		  16		R$   769,01
Standard_D8s_v3		8		  32		R$ 1.538,02
*/

module "vm_windows_module" {
  source = "./Modules/VirtualMachine-Win"
  depends_on = [
    module.resource_group_module,
    module.virtual_network_module,
    module.subnet_module
  ]

  rg_name        = module.resource_group_module.rg_name
  rg_location    = module.resource_group_module.rg_location
  vnet_name = module.virtual_network_module.vnet_name
  admin_passowrd = module.keyvault_module.secret
  vm_sku         = "win10-21h2-pro-g2"
  vm_size        = "Standard_B2ms"
  # Quantidade de VMs que deseja criar
  vm_win_instances   = 1
}

module "vm_linux_module" {
  source = "./Modules/VirtualMachine-Linux"
  depends_on = [
    module.resource_group_module,
    module.virtual_network_module,
    module.subnet_module
  ]

  rg_name        = module.resource_group_module.rg_name
  rg_location    = module.resource_group_module.rg_location
  subnet_id      = "sNet_Server"
  admin_passowrd = module.keyvault_module.secret
  vm_sku         = "18.04-LTS"
  vm_size        = "Standard_B2s"
  # Quantidade de VMs que deseja criar
  vm_linux_instances   = 0      
}

output "ips_windows" {
  value = module.vm_windows_module.public_ip
}

output "ips_linux" {
  value = module.vm_linux_module.public_ip
}