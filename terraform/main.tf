resource "google_container_cluster" "primary" {
  name     = "flux-managed-cluster"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "preemptible_nodes" {
  name       = "preemtible-node-pool"
  cluster    = google_container_cluster.primary.name
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = "e2-small"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#    service_account = google_service_account.default.email
#    oauth_scopes    = [
#      "https://www.googleapis.com/auth/cloud-platform"
#    ]
  }
}
