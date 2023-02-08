module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name            = "${var.prefix}-vpc"
  cidr            = "10.0.0.0/16"
  azs             = ["eu-west-1a"]
  private_subnets = []
  public_subnets  = ["10.0.0.0/24"]
}

module "compute" {
  source = "./modules/compute"

  prefix       = var.prefix
  subnet_id    = module.vpc.public_subnets[0]
  vpc_id       = module.vpc.vpc_id
  cidr_block   = module.vpc.vpc_cidr_block
  access_cidrs = ["${chomp(data.http.ip_address.response_body)}/32"]
}

data "http" "ip_address" {
  url = "https://ipv4.icanhazip.com"

  request_headers = {
    Accept = "text/plain"
  }
}

data "cloudflare_zone" "this" {
  name = var.zone
}

resource "cloudflare_record" "admin_a" {
  zone_id = data.cloudflare_zone.this.id
  name    = var.gophish_admin_subdomain
  value   = module.compute.ip_address
  type    = "A"
  proxied = true
  comment = "GoPhish Admin for ${var.prefix}"
}

resource "cloudflare_record" "web_a" {
  zone_id = data.cloudflare_zone.this.id
  name    = var.gophish_web_subdomain
  value   = module.compute.ip_address
  type    = "A"
  proxied = true
  comment = "GoPhish Web for ${var.prefix}"
}
