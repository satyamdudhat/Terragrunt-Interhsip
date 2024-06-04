#!/bin/bash



echo "AWS Access Key ID: $AWS_ACCOUNT_ID"
aws ecr get-login-password --region "${AWS_DEFAULT_REGION}" --profile "${AWS_PROFILE}" | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com
docker build -t "${IMAGE_TAG}-Image" .
docker tag "${IMAGE_TAG}-Image" "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/project-dev-ecr:latest
docker push "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/project-dev-ecr:latest

docker tag "${IMAGE_TAG}-Image" "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/project-dev-ecr:"${GITHUB_COMMIT_HASH}"
docker push "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/project-dev-ecr:"${GITHUB_COMMIT_HASH}"
