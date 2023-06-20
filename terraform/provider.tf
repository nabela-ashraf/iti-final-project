provider "google" {
    project = "iti-final"
    region = "us-central-1"
}

terraform {
    backend "gcs" {
        bucket = "terraform-state-iti-final"
        prefix = "terraform/state"
    }
}

required_providers {
    google = {
        source = "hashicorp/google"
        version = "4.0"
    }
}