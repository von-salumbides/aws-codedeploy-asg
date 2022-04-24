#!/bin/bash
# Install ansible
sudo yum update -y
sudo amazon-linux-extras install ansible2 -y
ansible --version