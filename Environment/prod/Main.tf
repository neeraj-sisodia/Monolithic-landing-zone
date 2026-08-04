module "resource_group" {
  source         = "../../modules/azurerm_resource_group"
  resource_group = var.resource_group
}

module "virtual_network" {
  depends_on      = [module.resource_group]
  source          = "../../modules/azurerm_virtual_network"
  virtual_network = var.virtual_network

}
module "subnet" {
  depends_on = [module.virtual_network]
  source     = "../../modules/azurerm_subnet"
  subnet     = var.subnet
}
module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_public_ip"
  public_ip  = var.public_ip
}
module "virtual_machine" {
  depends_on = [module.subnet, module.public_ip]
  source     = "../../modules/azurerm_virtual_machine"
  vms        = var.vms
}