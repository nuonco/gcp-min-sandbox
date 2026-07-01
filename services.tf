resource "google_project_service" "compute" {
  project            = var.project_id
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "artifact_registry" {
  project            = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "dns" {
  project            = var.project_id
  service            = "dns.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloud_resource_manager" {
  project            = var.project_id
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

# The Google provider calls iamcredentials.googleapis.com during provider
# init, which happens before any resource — including this one — can apply.
# On a project where this API has never been enabled, bootstrap it once:
#   gcloud services enable iamcredentials.googleapis.com --project=<project_id>
# or:
#   terraform apply -target=google_project_service.iam_credentials
resource "google_project_service" "iam_credentials" {
  project            = var.project_id
  service            = "iamcredentials.googleapis.com"
  disable_on_destroy = false
}
