#!/bin/bash

if aws ecr describe-repositories --repository-names "project-dev-ecr" --profile "${AWS_PROFILE}" &> /dev/null; then
    echo "ECR repository exists"
    echo "::set-output name=exists::true"
else
    echo "ECR repository not exists"
    cd infrastructure/enviroments/dev/
    terragrunt apply -auto-approve -target=aws_ecr_repository.serverless_ecr_repository
fi