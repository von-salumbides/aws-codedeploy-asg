packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "linux" {
  ami_name      = "${var.ami_prefix}-ami-${var.ami_account_id}-${local.timestamp}"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
  tags = {
    COST_CENTER  = "COMMON"
    DATE_CREATED = "{{timestamp}}"
    OS_Version   = "AmazonLinux2"
    Name         = "{{ .SourceAMIName }}"
  }
}

build {
  name = "aws-packer"
  sources = [
    "source.amazon-ebs.linux"
  ]
  provisioner "shell" {
    script       = "${path.root}/scripts/ansible.sh"
    pause_before = "10s"
    timeout      = "10s"
  }
  provisioner "ansible-local" {
    playbook_file = "${path.root}/playbook/ansible.yml"
    playbook_dir  = "${path.root}"
  }
  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}