variable "region" {
  type        = string
  description = "The default region"
  default     = "eu-west-1"
}

variable "prefix" {
  type        = string
  description = "The prefix for all resource names"
  default     = "gophish"
}

variable "zone" {
  type        = string
  description = "The Cloudflare zone to use for DNS entries"
}

variable "gophish_admin_subdomain" {
  type        = string
  description = "The subdomain to setup for the GoPhish admin interface"
  default     = "gophish"
}

variable "gophish_web_subdomain" {
  type        = string
  description = "The subdomain to setup for GoPhish web"
  default     = "2f6c81e77beb4956b47493578ac1384919f68a84ac1c4522bd9b321b87dbb46.jh7ri7c797innfofsfp66icxkkf9096uvv3ey07zff7e1wa1dpwfyritbudt6aq"
}
