locals {
  create_vpc      = var.network == ""
  enable_nuon_dns = contains(["1", "true"], var.enable_nuon_dns)

  sanitized_tags = { for k, v in var.tags : replace(replace(k, "/", "-"), ".", "-") => tostring(v) }
  default_tags = merge(local.sanitized_tags, {
    "nuon-install-id" = var.nuon_id
    "managed-by"      = "nuon"
    "sandbox-name"    = "gcp-min"
  })
  labels = merge(
    { for k, v in var.additional_tags : replace(replace(k, "/", "-"), ".", "-") => tostring(v) },
    local.default_tags,
  )
}
