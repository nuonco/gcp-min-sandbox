locals {
  create_vpc      = var.network == ""
  enable_nuon_dns = contains(["1", "true"], var.enable_nuon_dns)

  public_domain   = trimsuffix(trimspace(var.public_root_domain), ".")
  internal_domain = trimsuffix(trimspace(var.internal_root_domain), ".")

  # GCP labels: lowercase, alphanumeric, dashes, underscores only; max 63 chars per key/value.
  # Replace characters not supported in GCP labels (e.g. "." and "/") with dashes.
  _sanitize = { for k, v in merge(var.tags, var.additional_tags) :
    substr(replace(replace(lower(k), ".", "-"), "/", "-"), 0, 63) =>
    substr(replace(replace(lower(tostring(v)), ".", "-"), "/", "-"), 0, 63)
  }

  labels = merge(var.labels, local._sanitize, {
    "nuon-id"      = var.nuon_id
    "managed-by"   = "nuon"
    "sandbox-name" = "gcp-min"
  })
}
