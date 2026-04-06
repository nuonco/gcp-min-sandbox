locals {
  enable_nuon_dns = contains(["1", "true"], var.enable_nuon_dns)

  sanitized_tags = { for k, v in var.tags : replace(k, "/", "-") => v }
  default_tags = merge(local.sanitized_tags, {
    "install.nuon.co-id"   = var.nuon_id
    "sandbox.nuon.co-name" = "gcp-min"
  })
  labels = merge(
    { for k, v in var.additional_tags : replace(k, "/", "-") => v },
    local.default_tags,
  )
}
