#!/bin/bash

if aws ecr describe-repositories --repository-names "project-dev-ecr" --profile "${AWS_PROFILE}" &> /dev/null; then
    echo "ECR repository exists"
    echo "::set-output name=exists::true"
else
    echo "ECR repository not exists"
    # terragrunt plan
    # terragrunt apply -auto-approve -target=module.ecr_repo
fi