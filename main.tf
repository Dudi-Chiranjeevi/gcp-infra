resource "google_container_cluster" "gke_cluster" {
  name                     = var.cluster_name
  location                 = var.region
  deletion_protection      = false
  remove_default_node_pool = true # Remove the default node pool

  # Initial node count is not needed because we are managing the node pool separately
  initial_node_count = 1 # Explicitly set this to 0 or remove the line completely
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "node-pool"
  location   = var.zone
  cluster    = google_container_cluster.gke_cluster.id
  node_count = 1 # Ensure only 1 node in the node pool

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_artifact_registry_repository" "artifact_registry" {
  project       = var.project_id
  provider      = google
  location      = var.region
  repository_id = lower(var.artifact_registry_name) # Ensure the repository_id is lowercase
  format        = "DOCKER"
}

resource "google_service_account" "argocd_sa" {
  account_id   = "argocd-sa"
  display_name = "ArgoCD Service Account"
  project      = var.project_id
}

resource "google_project_iam_member" "argocd_sa_roles" {
  project = var.project_id
  role    = "roles/container.admin"

  member = "serviceAccount:${google_service_account.argocd_sa.email}"
}

resource "google_project_iam_member" "artifact_registry_acess" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"

  member = "serviceAccount:${google_service_account.argocd_sa.email}"
}