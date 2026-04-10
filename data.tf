data "google_project" "current" {
  project_id = var.project_id
}

data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
  status  = "UP"
}

resource "google_compute_network" "main" {
  count = local.create_vpc ? 1 : 0

  project                 = var.project_id
  name                    = "${var.nuon_id}-vpc"
  auto_create_subnetworks = true
}

data "google_compute_network" "existing" {
  count   = local.create_vpc ? 0 : 1
  project = var.project_id
  name    = var.network
}

locals {
  network           = local.create_vpc ? google_compute_network.main[0].name : data.google_compute_network.existing[0].name
  network_id        = local.create_vpc ? google_compute_network.main[0].id : data.google_compute_network.existing[0].id
  network_self_link = local.create_vpc ? google_compute_network.main[0].self_link : data.google_compute_network.existing[0].self_link
}
