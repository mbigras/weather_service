variable "domain" {
  type = string
}

resource "digitalocean_record" "weather" {
  domain = var.domain
  type   = "A"
  name   = "weather"
  value  = digitalocean_loadbalancer.lb.ip
}

resource "digitalocean_loadbalancer" "lb" {
  name   = "lb"
  region = "sfo2"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 80
    protocol = "http"
    path = "/"
  }

  droplet_ids = [
    digitalocean_droplet.app01.id,
    digitalocean_droplet.app02.id,
    digitalocean_droplet.app03.id,
  ]
}

resource "digitalocean_droplet" "app01" {
  name = "app01-prod"
  image = "ubuntu-18-04-x64"
  region = "sfo2"
  size = "512mb"
  ssh_keys = [
    digitalocean_ssh_key.root.fingerprint,
  ]
}

resource "digitalocean_droplet" "app02" {
  name = "app02-prod"
  image = "ubuntu-18-04-x64"
  region = "sfo2"
  size = "512mb"
  ssh_keys = [
    digitalocean_ssh_key.root.fingerprint,
  ]
}

resource "digitalocean_droplet" "app03" {
  name = "app03-prod"
  image = "ubuntu-18-04-x64"
  region = "sfo2"
  size = "512mb"
  ssh_keys = [
    digitalocean_ssh_key.root.fingerprint,
  ]
}

resource "digitalocean_record" "app01" {
  domain = var.domain
  type   = "A"
  name   = "app01-prod.prod"
  value  = digitalocean_droplet.app01.ipv4_address
}

resource "digitalocean_record" "app02" {
  domain = var.domain
  type   = "A"
  name   = "app02-prod.prod"
  value  = digitalocean_droplet.app02.ipv4_address
}

resource "digitalocean_record" "app03" {
  domain = var.domain
  type   = "A"
  name   = "app03-prod.prod"
  value  = digitalocean_droplet.app03.ipv4_address
}

resource "digitalocean_ssh_key" "root" {
  name = "root key"
  public_key = file("~/.ssh/id_rsa.pub")
}
