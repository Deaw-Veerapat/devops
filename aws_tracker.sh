#!/bin/bash

# track AWS
# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users

set -x
set -e
set -o pipefail
echo "print of s3 list"
aws s3 ls
echo "print of ec2 instance"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'
echo "list of lamda function" 
aws lambda list-functions
echo "aws list user"
aws iam list-users
