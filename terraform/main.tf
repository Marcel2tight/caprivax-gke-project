# 1. Configure the Google Provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# 2. Configure the Backend
terraform {
  backend "gcs" {
    bucket  = "caprivax-tf-state" # The bucket you created in Step 1
    prefix  = "terraform/state"
  }
}

# 3. Enable the Kubernetes Engine API automatically
resource "google_project_service" "container_api" {
  project = var.project_id
  service = "container.googleapis.com"

  disable_on_destroy = false
}

# 4. Generate a random suffix for uniqueness
resource "random_id" "suffix" {
  byte_length = 2 
}

# 5. Define the Naming Logic
locals {
  full_name = "${var.env}-${var.company_name}-cluster-${random_id.suffix.hex}"
}

# 6. Provision the Cluster
resource "google_container_cluster" "primary" {
  name     = local.full_name
  location = var.region
  project  = var.project_id 

  remove_default_node_pool = true
  initial_node_count       = 1
  
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # CRITICAL: Wait for the API to be enabled before creating the cluster
  depends_on = [google_project_service.container_api]
}

# 7. Provision the Node Pool
resource "google_container_node_pool" "nodes" {
  name       = "${local.full_name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1 
  project    = var.project_id

  node_config {
    machine_type = "e2-standard-2"
    
    labels = {
      environment = var.env
      managed_by  = "terraform"
    }

    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}