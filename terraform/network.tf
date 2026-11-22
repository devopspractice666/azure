resource "azurerm_virtual_network" "main" {
  name                = "vnet-azure1"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = local.location
  address_space       = ["10.0.0.0/16"]
  tags                = local.tags
}

resource "azurerm_subnet" "web" {
  name                 = "snet-web"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.web_subnet_cidr]
}

resource "azurerm_subnet" "monitoring" {
  name                 = "snet-monitoring"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.monitoring_subnet_cidr]
}

resource "azurerm_public_ip" "web" {
  name                = "pip-web"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = local.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}

resource "azurerm_public_ip" "monitoring" {
  name                = "pip-monitoring"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = local.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}

resource "azurerm_network_interface" "web" {
  name                = "nic-web"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = local.location
  tags                = local.tags

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Static"
    private_ip_address            = local.web_private_ip
    public_ip_address_id          = azurerm_public_ip.web.id
  }
}

resource "azurerm_network_interface" "monitoring" {
  name                = "nic-monitoring"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = local.location
  tags                = local.tags

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.monitoring.id
    private_ip_address_allocation = "Static"
    private_ip_address            = local.monitoring_private_ip
    public_ip_address_id          = azurerm_public_ip.monitoring.id
  }
}
