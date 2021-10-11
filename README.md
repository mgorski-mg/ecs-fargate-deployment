# AWS Fargate Rolling Update

Sample app showing how to configure rolling update in AWS Fargate.

## Setup

### Prerequisites

* .NET Core SDK 3.1
* Docker
* Powershell Core

### Required variables to be set

#### deploy.ps1

* deployBucketName -> name of the Amazon S3 Bucket used to deploy AWS CloudFormation stacks.
* vpcId -> Id of the Amazon VPC where resources will be placed.

#### deploy-rolling-app.ps1

* subnetAId, subnetBId, subnetCId -> Ids of the Subnets where resources will be placed. Three subnets are used to achieve High Availability using three Availability Zones.

## Deployment

```powershell
cd Deploy
deploy.ps1 $ImageVersion
```

ImageVersion is used in AWS ECR and needs to be incremented when you want to deploy new version of the image.

## Project structure

### AWS CloudFormation stacks

All AWS CloudFormation stacks are located in the `Environment` folder.

#### ecs-deploy-net

File: Environment/network.yaml

Stack containing SecurityGroups for ALB and Fargate.

#### ecs-deploy-rolling-repo

File: Environment/rolling-repo.yaml

Stack containing ECR Repository.

#### ecs-deploy-rolling-app

File: EcsFargateRollingUpdate/application.yaml

Stack containing all resources connected to ALB and AWS Fargate.

### Deployment scripts

All deployment scripts are located in the `Deploy` folder.

### Code

Project EcsFargateRollingUpdate contains ASP.NET core API and Docker container definition.