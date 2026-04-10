output "account" {
  value = {
    project_id = var.project_id
    region     = var.region
  }
}

output "vpc" {
  value = {
    network           = local.network
    network_self_link = local.network_self_link
  }
}

output "gar" {
  value = {
    repository_id  = google_artifact_registry_repository.main.repository_id
    repository_url = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.main.repository_id}"
    registry_url   = "${var.region}-docker.pkg.dev"
  }
}

output "nuon_dns" {
  value = {
    enabled = local.enable_nuon_dns
    public_domain = local.enable_nuon_dns ? {
      zone_id     = google_dns_managed_zone.public[0].managed_zone_id
      name        = trimsuffix(google_dns_managed_zone.public[0].dns_name, ".")
      nameservers = google_dns_managed_zone.public[0].name_servers
    } : { zone_id = "", name = "", nameservers = tolist([""]) }
    internal_domain = var.internal_root_domain != "" ? {
      zone_id     = google_dns_managed_zone.internal[0].managed_zone_id
      name        = trimsuffix(google_dns_managed_zone.internal[0].dns_name, ".")
      nameservers = google_dns_managed_zone.internal[0].name_servers
    } : { zone_id = "", name = "", nameservers = tolist([""]) }
  }
}
