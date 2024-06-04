#!/bin/bash
prefix=$0 


echo "AWS Access Key ID: $AWS_ACCOUNT_ID"
aws ecr get-login-password --region "${AWS_DEFAULT_REGION}" --profile "${AWS_PROFILE}" | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com
docker build -t "${prefix}-image" .
docker tag "${prefix}-image" "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/"${prefix}-ecr":latest
docker push "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/"${prefix}-ecr":latest

docker tag "${prefix}-image" "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/"${prefix}-ecr"-ecr:"${GITHUB_COMMIT_HASH}"
docker push "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/"${prefix}-ecr":"${GITHUB_COMMIT_HASH}"
