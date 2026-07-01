resource "google_dns_managed_zone" "public" {
  count = local.enable_nuon_dns ? 1 : 0

  project     = var.project_id
  name        = "${var.nuon_id}-public"
  dns_name    = "${var.public_root_domain}."
  labels      = local.labels
  description = "Public DNS zone for install ${var.nuon_id}"

  force_destroy = true

  depends_on = [google_project_service.dns]
}

resource "google_dns_managed_zone" "internal" {
  count = var.internal_root_domain != "" ? 1 : 0

  project     = var.project_id
  name        = "${var.nuon_id}-internal"
  dns_name    = "${var.internal_root_domain}."
  visibility  = "private"
  labels      = local.labels
  description = "Internal DNS zone for install ${var.nuon_id}"

  private_visibility_config {
    networks {
      network_url = local.network_self_link
    }
  }

  force_destroy = true

  depends_on = [google_project_service.dns]
}
