resource "google_compute_instance" "default" {
    project = var.project_id
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  tags = var.tags
 boot_disk {
    initialize_params {
      image = var.boot_disk.initialize_params.image
      labels = {
        my_label = var.boot_disk.initialize_params.labels.my_label
      }
    }
  }

 network_interface {
    network = var.network_interface.network
  }
metadata_startup_script = var.metadata_startup_script
# depends_on = google_compute_subnetwork.name[0]
}