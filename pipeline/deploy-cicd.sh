#!/bin/bash
export STACK_NAME=awsteam-serverless-portal-cicd-environment

aws cloudformation validate-template --template-body file://cfn-cicd-template.yaml

aws cloudformation create-stack \
--template-body file://cfn-cicd-template.yaml \
--stack-name $STACK_NAME \
--parameters file://params.json \
--capabilities CAPABILITY_NAMED_IAM


aws cloudformation update-stack \
--template-body file://cfn-cicd-template.yaml \
--stack-name $STACK_NAME \
--parameters file://params.json \
--capabilities CAPABILITY_NAMED_IAM