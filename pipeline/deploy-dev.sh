#!/bin/bash
export S3_DEV_BUCKET=awsteam-development-build-assets
export S3_PORTAL_ARTIFACTS=awsteam-samuel-development-serverless-portal-artifacts-bucket
export STACK_NAME=awsteam-samuel-development-stack
export DevPortalSiteS3BucketName=awsteam-samuel-development-serverless-portal

# Valdidate cloudformation template
aws cloudformation validate-template --template-body file://template.yaml

# Package cloudformation package
aws cloudformation package --template template.yaml --s3-bucket "$S3_DEV_BUCKET" --output-template template-export-dev.yaml

# Deploy cloudformation package
sam deploy --template-file template-export-dev.yaml --stack-name $STACK_NAME --capabilities CAPABILITY_NAMED_IAM --parameter-overrides DevPortalSiteS3BucketName=$DevPortalSiteS3BucketName ArtifactsS3BucketName=$S3_PORTAL_ARTIFACTS