
resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  for_each = local.linux_virtual_machines

  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  name = each.value.name
  size = each.value.size

  disable_password_authentication = each.value.disable_password_authentication
  allow_extension_operations      = each.value.allow_extension_operations

  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  custom_data = each.value.custom_data

  network_interface_ids = each.value.network_interface_ids

  identity {
    type = each.value.identity_type
  }

  os_disk {
    name                 = each.value.os_disk.name
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference_publisher
    offer     = each.value.source_image_reference_offer
    version   = each.value.source_image_reference_version
    sku       = each.value.source_image_reference_sku
  }

  plan {
    publisher = each.value.plan_publisher
    product   = each.value.plan_product
    name      = each.value.plan_name
  }

  boot_diagnostics {
    storage_account_uri = ""
  }

  tags = {
    ComputeType = each.value.tags_ComputeType
  }
  depends_on = [
    null_resource.marketplace_agreement
  ]
}

output "linux_virtual_machines" {
  value     = var.enable_output ? azurerm_linux_virtual_machine.linux_virtual_machine[*] : null
  sensitive = true
}
