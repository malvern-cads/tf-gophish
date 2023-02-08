output "ip_address" {
  value       = aws_instance.this.public_ip
  description = "The IPv4 address of the EC2 instance"
}
