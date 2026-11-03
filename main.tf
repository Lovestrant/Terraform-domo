terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.2.0"
    }
  }
}

provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_volume" "volume1" {
  name         = "volume1"
}

resource "docker_network" "Network1" {
    name = "FirstTerraNet"
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
  volumes {
    volume_name = docker_volume.volume1.name
    container_path = "/usr/share/nginx/html"
  }
  networks_advanced {
    name = docker_network.Network1.name
  }
}
