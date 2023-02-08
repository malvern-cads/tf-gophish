data "aws_ami" "this" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.this.image_id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.this.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.this.id]

  root_block_device {
    volume_type = "standard"
    volume_size = 20
  }

  tags = {
    Name = var.prefix
  }
}

resource "local_file" "this" {
  content = yamlencode({
    all = {
      hosts = {
        "${aws_instance.this.id}" = {
          ansible_user = "ubuntu"
          ansible_host = aws_instance.this.public_ip
          ansible_port = 22
        }
      }
    }
  })
  filename = "${path.root}/inventory.yaml"
}

resource "aws_key_pair" "this" {
  key_name   = "${var.prefix}-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "this" {
  name   = "${var.prefix}-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = concat([var.cidr_block], var.access_cidrs)
  }

  ingress {
    description      = "HTTP access from internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTPS access from internet"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "All traffic to internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
