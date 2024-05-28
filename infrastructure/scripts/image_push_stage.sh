#!/bin/bash



echo "AWS Access Key ID: $AWS_ACCOUNT_ID"
aws ecr get-login-password --region "${AWS_DEFAULT_REGION}" --profile "${AWS_PROFILE}" | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com
docker build -t stage_fucntion1 .
docker tag stage_fucntion1 "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/project-stage-ecr:latest
docker push "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/project-stage-ecr:latest

docker tag stage_fucntion1 "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/project-stage-ecr:"${GITHUB_COMMIT_HASH}"
docker push "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/project-stage-ecr:"${GITHUB_COMMIT_HASH}"
