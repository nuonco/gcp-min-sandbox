resource "google_artifact_registry_repository" "main" {
  location      = var.region
  repository_id = var.nuon_id
  format        = "DOCKER"
  labels        = local.labels

  cleanup_policies {
    id     = "keep-recent"
    action = "KEEP"

    most_recent_versions {
      keep_count = 10
    }
  }
}
