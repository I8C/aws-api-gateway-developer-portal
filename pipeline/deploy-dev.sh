#!/bin/bash
export S3_DEV_BUCKET=awsteam-development-build-assets
export S3_PORTAL_ARTIFACTS=awsteam-dewanst-development-serverless-portal-artifacts-bucket
export STACK_NAME=awsteam-dewanst-development-stack
export DevPortalSiteS3BucketName=awsteam-dewanst-development-serverless-portal
export StaticAssetRebuildToken=$(date +'+%d%m%Y%H%M%S')
export StaticAssetRebuildMode='overwrite-content'

# Valdidate cloudformation template
aws cloudformation validate-template --template-body file://template.yaml

# Package cloudformation package
aws cloudformation package --template template.yaml --s3-bucket "$S3_DEV_BUCKET" --output-template template-export-dev.yaml

# Deploy cloudformation package
sam deploy --template-file template-export-dev.yaml --stack-name $STACK_NAME --capabilities CAPABILITY_NAMED_IAM --parameter-overrides DevPortalSiteS3BucketName=$DevPortalSiteS3BucketName ArtifactsS3BucketName=$S3_PORTAL_ARTIFACTS StaticAssetRebuildToken=$StaticAssetRebuildToken StaticAssetRebuildMode=$StaticAssetRebuildMode

# set metadata on s3
#aws s3 cp s3://awsteam-dewanst-development-serverless-portal/ s3://awsteam-dewanst-development-serverless-portal/ --exclude "*" --include "*.ico" --include "*.css" --include "*.jpg" --include "*.png" --recursive --metadata-directive REPLACE --expires 2034-01-01T00:00:00Z --cache-control max-age=60