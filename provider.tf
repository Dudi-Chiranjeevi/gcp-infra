terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.18.1"
    }
  }
}


provider "google" {
  credentials = var.GCP_SA_KEY
  project     = var.project_id
  region      = var.region
}