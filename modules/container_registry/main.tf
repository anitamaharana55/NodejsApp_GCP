# resource "google_container_registry" "registry" {
#   project  = var.project
#   location = var.location
# }
resource "google_artifact_registry_repository" "my-repo" {
    project  = var.project
  location      = var.location
  repository_id = var.repository_id
  description   = var.description
  format        = var.format
}