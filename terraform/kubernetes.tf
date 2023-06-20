resource "google_container_cluster" "primary" {
    name = "primary"
    location = "us-central1-a"
    remove_default_node_pool = true
    initial_node_count = 1
    network = google_compute_network.main.self_link
    subnetwork = google_compute_subnetwork.private.self_link
    logging_service = "logging.googlepis.com/kubernetes"
    monitoring_service = "monitoring.googlepis.com/kubernetes"
    networking_mode = "VPC_NATIVE"

    node_locations = ["us-central1-b"]

    addons_config {
      http_load_balancing {
        disabled = true
      }
      horizontal_pod_autoscaling {
        disabled = false
      }
    }

    release_channel {
        channel = "REGULAR"
    }

    ip_allocation_policy {
      cluster_secondary_range_name = "k8s-pod-range"
      services_secondary_range_name = "k8s-service-range"
    }

    private_cluster_config {
        enable_private_endpoint = false
        enable_private_nodes = true
        master_ipv4_cidr_block = "172.16.0.0/28"
    }

    master_authorized_networks_config {
      cidr_blocks {
        cidr_block = "10.0.00/18"
        display_name = "private-subnet-jenkins"
      }
    }
}