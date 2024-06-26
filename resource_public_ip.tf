resource "azurerm_public_ip" "public_ip" {
  for_each = local.public_ips

  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  name              = each.value.name
  allocation_method = each.value.allocation_method
  sku               = each.value.sku
  domain_name_label = each.value.domain_name_label
}

output "public_ips" {
  value = var.enable_output ? azurerm_public_ip.public_ip[*] : null
}
