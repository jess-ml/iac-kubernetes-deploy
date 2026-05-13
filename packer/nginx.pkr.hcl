packer {
  required_plugins {
    docker = {
      source  = "github.com/hashicorp/docker"
      version = "~> 1"
    }
  }
}

variable "image_name" {
  default = "custom-nginx"
}

variable "image_tag" {
  default = "1.0.0"
}

source "docker" "nginx" {
  image  = "nginx:alpine"
  commit = true
  changes = [
    "EXPOSE 80",
    "LABEL maintainer='Ingénieure Réseaux & Systèmes'",
    "LABEL version='${var.image_tag}'"
  ]
}

build {
  name    = "custom-nginx"
  sources = ["source.docker.nginx"]

  # Copie la page HTML personnalisée
  provisioner "file" {
    source      = "files/index.html"
    destination = "/usr/share/nginx/html/index.html"
  }

  # Configuration Nginx personnalisée
  provisioner "file" {
    source      = "files/nginx.conf"
    destination = "/etc/nginx/nginx.conf"
  }

  # Test que Nginx fonctionne
  provisioner "shell" {
    inline = [
      "nginx -t",
      "echo 'Image Nginx construite avec succès !'"
    ]
  }

  post-processor "docker-tag" {
    repository = var.image_name
    tags       = [var.image_tag, "latest"]
  }
}
