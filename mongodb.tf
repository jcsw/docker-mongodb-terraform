provider "docker" {}

data "docker_registry_image" "mongo" {
  name = "mongo:3.7-jessie"
}

resource "docker_image" "mongo" {
  name          = "${data.docker_registry_image.mongo.name}"
  pull_triggers = ["${data.docker_registry_image.mongo.sha256_digest}"]
}

resource "docker_container" "mongo" {
  name  = "mongo-terraform"
  image = "${docker_image.mongo.latest}"
}
