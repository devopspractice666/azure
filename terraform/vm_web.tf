resource "azurerm_linux_virtual_machine" "web" {
  name                            = "vm-web"
  resource_group_name             = data.azurerm_resource_group.main.name
  location                        = local.location
  size                            = var.web_vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.web.id]
  custom_data                     = local.web_custom_data
  tags                            = merge(local.tags, { role = "web" })

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  os_disk {
    name                 = "osdisk-vm-web"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  boot_diagnostics {}
}
