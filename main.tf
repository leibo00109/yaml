provider "google" {
  credentials = file("evocative-volt-305213-ab06ab824d9e.json")
  project = "evocative-volt-305213"
  region  = "asia-east2"
  zone    = "asia-east2-b"
}

provider "google-beta" {
  credentials = file("evocative-volt-305213-ab06ab824d9e.json")
  project = "evocative-volt-305213"
  region  = "asia-east2"
  zone    = "asia-east2-b"

}

data "google_compute_image" "my_image" {
  family  = "centos-7"
  project = "centos-cloud"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.my_image.self_link
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}

resource "google_compute_machine_image" "image" {
  provider        = google-beta
  name            = "myimage"
  source_instance = google_compute_instance.vm_instance.self_link
}
