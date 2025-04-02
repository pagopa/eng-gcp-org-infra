terraform {
  required_version = ">= 1.7.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.28.0"
    }
  }

  backend "gcs" {}
}

provider "google" {
  project               = var.project_id
  billing_project       = var.project_id
  user_project_override = true
  region                = var.region
  zone                  = var.zone
}

# data "google_project" "current" {}

data "google_project" "project" {
  project_id = "organization-443016"
}