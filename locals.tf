locals {
  create_vpc      = var.network == ""
  enable_nuon_dns = contains(["1", "true"], var.enable_nuon_dns)

  public_domain   = trimsuffix(trimspace(var.public_root_domain), ".")
  internal_domain = trimsuffix(trimspace(var.internal_root_domain), ".")

  labels = merge(var.labels, var.tags, {
    "nuon-id"      = var.nuon_id
    "managed-by"   = "nuon"
    "sandbox-name" = "gcp-min"
  })
}
