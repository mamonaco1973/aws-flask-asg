#!/bin/bash

# Second phase - Run the packer build to build the application after we have a network

cd 02-packer
echo "NOTE: Building AMI with packer."
vpc_id=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=challenge-vpc" --query "Vpcs[0].VpcId" --output text)
subnet_id=$(aws ec2 describe-subnets --filters "Name=tag:Name,Values=challenge-subnet-1" --query "Subnets[0].SubnetId" --output text)
packer init ./flask_ami.pkr.hcl
packer build -var "vpc_id=$vpc_id" -var "subnet_id=$subnet_id" ./flask_ami.pkr.hcl || { echo "NOTE: Packer build failed. Aborting."; exit 1; }
cd ..
