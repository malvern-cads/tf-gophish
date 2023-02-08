# tf-gophish

Terraform and Ansible scripts to setup a cheap and fast GoPhish instance on AWS. And with Cloudflare DNS record setup too.

This is designed to be a quick setup and should be considered a starting point rather than something for long term production use.

1. Run `terraform init` to download required Terraform modules
1. Set any required AWS and Cloudflare environment variables according to Terraform documentation for each module (e.g. `CLOUDFLARE_API_TOKEN` and `AWS_PROFILE`)
1. Optionally create a Terraform variables file with any edits to variables, otherwise you will be prompted each time
1. Run `terraform apply` to create infrastructure and Ansible inventory file
1. Run `ansible-playbook -i inventory.yaml playbook.yaml` to provision GoPhish
1. Visit the admin domain output by Terraform to see the GoPhish admin page. You will need to SSH into the EC2 instance and get the default password (`cat /var/log/gophish.log`)
