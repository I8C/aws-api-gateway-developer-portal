#!/bin/bash
export S3_DEV_BUCKET=awsteam-development-build-assets
export S3_PORTAL_ARTIFACTS=awsteam-vandes16-development-serverless-portal-artifacts-bucket
export STACK_NAME=awsteam-vandes16-development-stack
export DevPortalSiteS3BucketName=awsteam-vandes16-development-serverless-portal
export StaticAssetRebuildToken=$(date +'+%d%m%Y%H%M%S')
export StaticAssetRebuildMode='overwrite-content'
export DevPortalCustomersTableName='Vandes16DevPortalCustomers'
export CognitoDomainNameOrPrefix='i8c-vandes16-dev'

# Valdidate cloudformation template
aws cloudformation validate-template --template-body file://template.yaml

# Package cloudformation package
aws cloudformation package --template template.yaml --s3-bucket "$S3_DEV_BUCKET" --output-template template-export-dev.yaml

# Deploy cloudformation package
sam deploy --template-file template-export-dev.yaml --stack-name $STACK_NAME --s3-bucket $S3_DEV_BUCKET --capabilities CAPABILITY_NAMED_IAM --parameter-overrides DevPortalCustomersTableName=$DevPortalCustomersTableName DevPortalSiteS3BucketName=$DevPortalSiteS3BucketName ArtifactsS3BucketName=$S3_PORTAL_ARTIFACTS StaticAssetRebuildToken=$StaticAssetRebuildToken StaticAssetRebuildMode=$StaticAssetRebuildMode CognitoDomainNameOrPrefix=$CognitoDomainNameOrPrefix


sam deploy --template-file ./cloudformation/packaged.yaml --stack-name "dev-portal" --s3-bucket your-lambda-artifacts-bucket-name --capabilities CAPABILITY_NAMED_IAM 
--parameter-overrides 

DevPortalSiteS3BucketName="custom-prefix-dev-portal-static-assets" 
ArtifactsS3BucketName="custom-prefix-dev-portal-artifacts" 
CognitoDomainNameOrPrefix="custom-prefix"

# set metadata on s3
#aws s3 cp s3://awsteam-dewanst-development-serverless-portal/ s3://awsteam-dewanst-development-serverless-portal/ --exclude "*" --include "*.ico" --include "*.css" --include "*.jpg" --include "*.png" --recursive --metadata-directive REPLACE --expires 2034-01-01T00:00:00Z --cache-control max-age=60