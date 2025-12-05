#!/bin/bash
# Creates ECR pull secret for the specified namespace

NAMESPACE=${1:-fullstack-devops-k0s}
SECRET_NAME=${2:-ecr-secret}
AWS_REGION=${3:-us-east-1}
AWS_ACCOUNT_ID=355446107250

echo "Creating ECR secret '$SECRET_NAME' in namespace '$NAMESPACE'..."

kubectl create secret docker-registry $SECRET_NAME \
  --docker-server=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password --region $AWS_REGION) \
  -n $NAMESPACE

echo "Done!"
