# CodeBuild & CodePipeline documentation

Launch CI/CD CloudFormation stack
```bash
export STACK_NAME=awsteam-serverless-portal-cicd-environment

aws cloudformation validate-template --template-body file://cfn-cicd-template.yaml

aws cloudformation create-stack \
--template-body file://cfn-cicd-template.yaml \
--stack-name $STACK_NAME \
--parameters file://params.json \
--capabilities CAPABILITY_NAMED_IAM
```

Update CI/CD CloudFormation stack
```bash
export STACK_NAME=awsteam-serverless-portal-cicd-environment

aws cloudformation update-stack \
--template-body file://cfn-cicd-template.yaml \
--stack-name $STACK_NAME \
--parameters file://params.json \
--capabilities CAPABILITY_NAMED_IAM

```

Deploy development environment
```bash
bash ./deploy-dev.sh
```

Run Codebuild locally
```bash
# Get docker image definition repostory
cd ~/environment/
git clone https://github.com/aws/aws-codebuild-docker-images.git

# Build the nodejs 8.11.0 image
cd aws-codebuild-docker-images/ubuntu/nodejs/8.11.0
docker build -t aws/codebuild/nodejs:8.11.0 .

docker pull amazon/aws-codebuild-local:latest --disable-content-trust=false

# Get local run file
cd ~/environment/aws-api-gateway-developer-portal/pipeline
wget https://raw.githubusercontent.com/aws/aws-codebuild-docker-images/master/local_builds/codebuild_build.sh

# Run local codebuild
cd ~/environment/aws-api-gateway-developer-portal/
bash pipeline/codebuild_build.sh  -i aws/codebuild/nodejs:8.11.0 -a build -e "S3_BUCKET=awsteam-serverless-portal-cd-bucket"
```