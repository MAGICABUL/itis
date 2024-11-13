# resource "google_container_cluster" "itis" {
#   name               = "itis"
#   project            = "itis-441214"
#   location           = "europe-west12-a"
#   deletion_protection = false
#   initial_node_count = 1
#   node_config {
#     service_account = "sa-gke-itis@itis-441214.iam.gserviceaccount.com"
#   }
# }

resource "google_artifact_registry_repository" "itis-repo" {
  location      = "europe-west12"
  repository_id = "itis-repo"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}

resource "google_service_account" "gke_sa" {
  account_id   = "sa-gke-itis"
  display_name = "sa-gke-itis" 
}

locals {
  roles = [
    "roles/artifactregistry.reader",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/file.editor",
    "roles/storage.objectAdmin"
  ]
}

resource "google_project_iam_member" "member_role" {
  for_each = { for sa in local.roles : sa => sa }

  project = "itis-441214"
  role    = each.value
  member  = "serviceAccount:sa-gke-itis@itis-441214.iam.gserviceaccount.com"
  depends_on = [
    google_service_account.gke_sa
  ]
}

resource "google_service_account" "alunno_sa" {
  for_each = toset([ for num in range(16) : "alunno-${num}" ])
  account_id   = "sa-${each.value}"
  display_name = "sa-${each.value}" 
}

resource "google_project_iam_member" "user_role" {
  for_each = toset([ for num in range(16) : "alunno-${num}" ])

  project = "itis-441214"
  role    = "roles/container.developer"
  member  = "serviceAccount:sa-${each.value}@itis-441214.iam.gserviceaccount.com"
  depends_on = [
    google_service_account.alunno_sa
  ]
}
