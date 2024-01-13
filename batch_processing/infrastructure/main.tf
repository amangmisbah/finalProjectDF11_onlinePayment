terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "4.51.0"
        }
    }
}

provider "google" {
    project     = "master-pager-401705"
    region      = "asia-southeast2"
    credentials = file("../keys/test-terraform-sa.json")
}

resource "google_compute_firewall" "airflow_firewall" {
    name    = "airflow-1"
    network = var.network

    allow {
        protocol = "tcp"
        ports    = ["8080"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["airflow-1"]
}

resource "google_compute_address" "batch_processing_address" {
    name   = "batch-processing"
    region = "asia-southeast2"
}

resource "google_compute_instance" "batch_processing_instance" {
    name         = "batch-processing"
    machine_type = var.vm_type
    zone         = "asia-southeast2-a"

    tags = ["airflow-1"]

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = var.network
        access_config {
            nat_ip = google_compute_address.batch_processing_address.address
        }
    }

    metadata = {
        ssh-keys = "myemail:${file("../keys/terraform-key.pub")}"
    }

    connection {
        type        = "ssh"
        user        = "myemail"
        host        = google_compute_address.batch_processing_address.address
        private_key = "${file(var.private_key_vm)}"
    }

    provisioner "file" {
        source      = "../docker-compose.yml"
        destination = "/home/myemail/docker-compose.yml"
    }

    provisioner "file" {
        source      = "../dags/online_payment_log_Oct2023.py"
        destination = "/home/myemail/online_payment_log_Oct2023.py"
    }

    provisioner "file" {
        source      = "../.env"
        destination = "/home/myemail/.env"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip",
            "curl -fsSL https://get.docker.com -o get-docker.sh",
            "sudo sh get-docker.sh",
            "pip3 install dbt-bigquery",
            "mkdir dags",
            "mv online_payment_log_Oct2023.py dags"
        ]
    }
}

resource "google_bigquery_dataset" "raw_table" {
    dataset_id = "online_payment"
    project    = var.project
    location   = "US"
}
