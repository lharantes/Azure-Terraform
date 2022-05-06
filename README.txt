Modules\VirtualNetwork\variables.tf
    vnet_name = nome da vnet
    vnet_address = endereçamento da vnet

Modules\Nsg\variable.tf
    nsg_name = nome do NSG

Modules\ResourceGroup\variables.tf
    rg_name = nome do resource group
    rg_location = localização do resource group

Modules\Subnet\variable.tf
    subnets = nome e endereçamento das subnets

Modules\VirtualMachine-Linux\variable.tf
    vm_name = prefixo das VMs (VM-LINUX) onde dependendo da quantidade será sequencial - VM-LINUX-1

Modules\VirtualMachine-Win
    vm_name = prefixo das VMs (VM-WIN) onde dependendo da quantidade será sequencial - VM-WIN-1

Modules\Keyvault\keyvault.tf
    data "azurerm_key_vault" "getkeyvault" {
    name                = "kv-arantes"  -> nome do meu KeyVault onde armazeno a senha padrao que uso
    resource_group_name = "RG-KeyVault"

Arquivo principal: main.tf
    regras_entrada = portas de entradas que serão liberadas no nsg
    subnet_id = qual a subnet que a VM irá usar
    vm_sku = verão do SO da VM
    vm_size = tamanho da VMm, consultar tabela abaixo
    vm_linux_instances = quantidade de VM Linux que será criada
    vm_windows_instances = quantidade de VM Windows que será criada