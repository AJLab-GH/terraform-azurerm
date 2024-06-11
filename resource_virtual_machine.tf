resource "azurerm_virtual_machine" "virtual_machine" {
  for_each = local.virtual_machines

  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  vm_size               = each.value.vm_size
  network_interface_ids = each.value.network_interface_ids
  primary_network_interface_id = each.value.primary_network_interface_id


  storage_os_disk {
    name                 = each.value.storage_os_disk.name
    caching              = each.value.storage_os_disk.caching
    create_option        = each.value.storage_os_disk.create_option
  }

  storage_image_reference {
   publisher = each.value.storage_image_reference.publisher
   offer = each.value.storage_image_reference.offer
   version = each.value.storage_image_reference.version
   sku = each.value.storage_image_reference.sku
  }

  os_profile {
    computer_name  = each.value.os_profile.computer_name
    admin_username = each.value.os_profile.admin_username
    admin_password = each.value.os_profile.admin_password
    custom_data = each.value.os_profile.custom_data
  }

  plan {
  name = each.value.plan.name
  publisher = each.value.plan.publisher
  product = each.value.plan.product

  }

  os_profile_linux_config {
    disable_password_authentication = each.value.os_profile_linux_config.disable_password_authentication
  }

  tags = {
    "environment" = each.value.tags.environment
  }
}
