#!/bin/bash

# Third phase - Re-run infrastructure code with the application AMI and two instances spread across to two AZs

cd 01-infrastructure
ami_id=$(aws ec2 describe-images --filters "Name=name,Values=flask_server_ami*" "Name=state,Values=available" --query "Images | sort_by(@, &CreationDate) | [-1].ImageId" --output text) 
echo $ami_id

echo "NOTE: Building infrastructure phase 3."
terraform init
terraform apply -var="default_ami=$ami_id" -var="asg_instances=2" -auto-approve
cd ..
