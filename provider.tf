provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = var.gcp_credentials_base64 != "" ? base64decode(var.gcp_credentials_base64) : null
}
