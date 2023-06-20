resource "google_compute_router" "router" {
    name = "router"
    network = google_compute_network.main.id
    region = "us-central-1"
}