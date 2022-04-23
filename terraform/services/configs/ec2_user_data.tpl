#!/bin/bash

yum update -y  
yum install httpd -y  
service httpd start  
chkconfig httpd on  
cd /var/www/html  
echo 'Hi DevOps!' > index.html 

yum -y update
yum install -y aws-cli ruby jq
wget https://aws-codedeploy-${region}.s3.amazonaws.com/latest/install
chmod +x ./install
./install auto