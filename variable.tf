variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "swift-implement-405417"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "gke-cluster" # Ensure it's lowercase, no spaces, and no special characters.
}


variable "artifact_registry_name" {
  description = "The name of the artifact_registry"
  type        = string
  default     = "repo"
}