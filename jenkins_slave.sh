#!/bin/bash
sudo yum update -y
sudo yum install -y git
sudo yum install -y ruby
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo yum groupinstall -y development
sudo yum install -y zlib-dev openssl-devel sqlite-devel bzip2-devel
