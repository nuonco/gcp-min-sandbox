data "google_project" "current" {}

data "google_compute_zones" "available" {
  region = var.region
}

data "google_compute_network" "default" {
  name = "default"
}
