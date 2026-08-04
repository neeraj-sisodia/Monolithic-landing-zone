resource_group = {
  rg1 = {
    name     = "rg-prod-prod"
    location = "Central India"
  }
}

virtual_network = {
  vnet-1 = {
    name                = "vnet-prod-prod"
    resource_group_name = "rg-prod-prod"
    location            = "Central India"
    address_space       = ["10.0.0.0/16"]
  }
}

subnet = {
  subnet-1 = {
    name                 = "frontend-subnet-prod"
    resource_group_name  = "rg-prod-prod"
    virtual_network_name = "vnet-prod-prod"
    address_prefixes     = ["10.0.1.0/24"]
  }

  subnet-2 = {
    name                 = "backend-subnet-prod"
    resource_group_name  = "rg-prod-prod"
    virtual_network_name = "vnet-prod-prod"
    address_prefixes     = ["10.0.2.0/24"]
  }

  subnet-3 = {
    name                 = "database-subnet-prod"
    resource_group_name  = "rg-prod-prod"
    virtual_network_name = "vnet-prod-prod"
    address_prefixes     = ["10.0.3.0/24"]
  }
}

public_ip = {
  pip-1 = {
    public_ip_name      = "pip-frontend-vm-prod"
    resource_group_name = "rg-prod-prod"
    location            = "Central India"
    allocation_method   = "Static"
  }

  pip-2 = {
    public_ip_name      = "pip-backend-vm-prod"
    resource_group_name = "rg-prod-prod"
    location            = "Central India"
    allocation_method   = "Static"
  }

  pip-3 = {
    public_ip_name      = "pip-database-vm-prod"
    resource_group_name = "rg-prod-prod"
    location            = "Central India"
    allocation_method   = "Static"
  }
}

vms = {

  vm-1 = {
    nic_name             = "nic-frontend-vm-prod"
    location             = "Central India"
    rg_name              = "rg-prod-prod"
    pip_name             = "pip-frontend-vm-prod"
    vm_name              = "frontend-vm-prod"
    virtual_network_name = "vnet-prod-prod"
    subnet_name          = "frontend-subnet-prod"
    size                 = "Standard_B1ms"
    admin_username       = "Devopsadmin"
    admin_password       = "Devops@1234"
  }

  vm-2 = {
    nic_name             = "nic-backend-vm-prod"
    location             = "Central India"
    rg_name              = "rg-prod-prod"
    pip_name             = "pip-backend-vm-prod"
    vm_name              = "backend-vm-prod"
    virtual_network_name = "vnet-prod-prod"
    subnet_name          = "backend-subnet-prod"
    size                 = "Standard_B1ms"
    admin_username       = "Devopsadmin"
    admin_password       = "Devops@1234"
  }

  vm-3 = {
    nic_name             = "nic-database-vm-prod"
    location             = "Central India"
    rg_name              = "rg-prod-prod"
    pip_name             = "pip-database-vm-prod"
    vm_name              = "database-vm-prod"
    virtual_network_name = "vnet-prod-prod"
    subnet_name          = "database-subnet-prod"
    size                 = "Standard_B1ms"
    admin_username       = "Devopsadmin"
    admin_password       = "Devops@1234"
  }
}