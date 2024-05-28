#!/bin/bash

if aws ecr describe-repositories --repository-names "project-stage-ecr" --profile "${AWS_PROFILE}" &> /dev/null; then
    echo "ECR repository exists"
    echo "::set-output name=exists::true"
else
    echo "ECR repository not exists"
    cd infrastructure/enviroments/stage/
    terragrunt apply -auto-approve -target=module.ecr_repo
fi