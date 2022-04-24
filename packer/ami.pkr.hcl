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
  name      = "${var.ami_prefix}-ami-${var.ami_account_id}-${local.timestamp}"
}

source "amazon-ebs" "linux" {
  ami_name      = "${local.name}"
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
  run_tags = {
    COST_CENTER  = "COMMON"
    DATE_CREATED = "${local.timestamp}"
    OS_Type      = "AmazonLinux2"
    Source_AMI   = "{{ .SourceAMIName }}"
    Name         = "${local.name}"
  }
  tags = {
    COST_CENTER  = "COMMON"
    DATE_CREATED = "${local.timestamp}"
    OS_Type      = "AmazonLinux2"
    Source_AMI   = "{{ .SourceAMIName }}"
    Name         = "${local.name}"
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