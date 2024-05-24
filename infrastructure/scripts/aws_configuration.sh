#!/bin/bash


aws configure set aws_access_key_id "${AWS_ACCESS_KEY_ID}" --profile satyam
aws configure set aws_secret_access_key "${AWS_SECRET_ACCESS_KEY}" --profile satyam
aws configure set region "${AWS_DEFAULT_REGION}" --profile satyam
echo "AWS Access Key ID: $AWS_ACCESS_KEY_ID"