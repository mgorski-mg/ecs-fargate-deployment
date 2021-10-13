param(
    [Parameter(Mandatory = $True)]
    [string]$ServiceName,

    [Parameter(Mandatory = $True)]
    [string]$DeployBucketName,

    [Parameter(Mandatory = $True)]
    [string]$ImageVersion,

    [Parameter(Mandatory = $True)]
    [string]$VpcId
)

$ErrorActionPreference = "Stop"

$stackType = "rolling-app"

Write-Host "Deploying $ServiceName-$stackType"

$albSubnetAId = "[alb-subnet-a-id]"
$albSubnetBId = "[alb-subnet-b-id]"
$albSubnetCId = "[alb-subnet-c-id]"
$ecsSubnetAId = "[ecs-subnet-a-id]"
$ecsSubnetBId = "[ecs-subnet-b-id]"
$ecsSubnetCId = "[ecs-subnet-c-id]"

aws cloudformation deploy `
    --template-file $PSScriptRoot/../Environment/rolling-application.yaml `
    --stack-name $ServiceName-$stackType `
    --s3-bucket $DeployBucketName `
    --s3-prefix $ServiceName/$stackType `
    --parameter-overrides "ServiceName=$ServiceName" "ImageVersion=$ImageVersion" "VpcId=$VpcId" "AlbSubnetAId=$albSubnetAId" "AlbSubnetBId=$albSubnetBId" "AlbSubnetCId=$albSubnetCId" "EcsSubnetAId=$ecsSubnetAId" "EcsSubnetBId=$ecsSubnetBId" "EcsSubnetCId=$ecsSubnetCId" `
    --capabilities CAPABILITY_NAMED_IAM `
    --no-fail-on-empty-changeset;