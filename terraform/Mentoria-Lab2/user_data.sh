#!/bin/bash
sudo apt update
sudo apt  install w3m -y
sudo apt  install awscli -y
aws s3 cp s3://s3-cloudops-bucket-webapp.carancas.com-files/script_ubuntu.sh .
sudo chmod +x script_ubuntu.sh
sudo sh script_ubuntu.sh