# Finds available k8s version
data "google_container_engine_versions" "us-central1-c" {
  provider       = google-beta
  location       = var.gke_config["region"]
  version_prefix = var.gke_config["node_version"]
}


# Enables all services needed for a project
resource "null_resource" "enable-api" {
  # Execute always
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<-EOT
        gcloud services enable compute.googleapis.com
        gcloud services enable dns.googleapis.com
        gcloud services enable storage-api.googleapis.com
        gcloud services enable container.googleapis.com
        gcloud services enable file.googleapis.com
        gcloud services enable artifactregistry.googleapis.com
        gcloud services enable cloudresourcemanager.googleapis.com
    EOT
  }
}

# Creates a cluster
resource "google_container_cluster" "primary" {
  # Explicit dependency on API services
  depends_on = [
    null_resource.enable-api,
  ]
  name                     = var.gke_config["cluster_name"]
  location                 = var.gke_config["region"]
  remove_default_node_pool = false
  node_version             = data.google_container_engine_versions.us-central1-c.latest_node_version
  initial_node_count       = var.gke_config["node_count"]
  node_config {
    disk_size_gb = var.gke_config["disk_size_gb"] 
  }
  node_locations = [
    "${var.gke_config["region"]}-a",
    "${var.gke_config["region"]}-b",
    "${var.gke_config["region"]}-c",
  ]
  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum       = 1
      maximum       = 48
    }
    resource_limits {
      resource_type = "memory"
      minimum       = 4
      maximum       = 96
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

# Get credentials
resource "null_resource" "set-kubeconfig" {
  depends_on = [
    google_container_cluster.primary,
  ]
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.gke_config["cluster_name"]} --region ${var.gke_config["region"]} --project $GOOGLE_PROJECT"
  }
}

