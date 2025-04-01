provider "google" {
  credentials = file("Use your credentials .json.key")
  project     = var.project_id
  region      = var.region
}