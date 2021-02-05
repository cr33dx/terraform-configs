provider "docker" {}

resource "docker_container" "web_app" {
   image             = "sha256:377c0837328ff83bf96e0f93719c05a1ed855e073573138103e6b37cf060c6b2"
    name              = "nginx"
    ports {
    external = 8081
    internal = 80
  }
  }
