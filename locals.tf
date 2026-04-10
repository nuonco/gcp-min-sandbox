locals {
  create_vpc      = var.network == ""
  enable_nuon_dns = contains(["1", "true"], var.enable_nuon_dns)

  sanitized_tags = {
    for k, v in var.tags :
    substr(replace(replace(replace(lower(k), "/", "-"), ".", "-"), "_", "-"), 0, 63) =>
    substr(replace(replace(replace(lower(tostring(v)), "/", "-"), ".", "-"), "_", "-"), 0, 63)
  }
  default_labels = merge(var.labels, local.sanitized_tags, {
    "nuon-id"      = var.nuon_id
    "managed-by"   = "nuon"
    "sandbox-name" = "gcp-min"
  })
  labels = merge(
    {
      for k, v in var.additional_tags :
      substr(replace(replace(replace(lower(k), "/", "-"), ".", "-"), "_", "-"), 0, 63) =>
      substr(replace(replace(replace(lower(tostring(v)), "/", "-"), ".", "-"), "_", "-"), 0, 63)
    },
    local.default_labels,
  )
}
