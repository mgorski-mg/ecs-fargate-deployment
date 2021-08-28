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

$subnetAId = "[subnet-a-id]"
$subnetBId = "[subnet-b-id]"
$subnetCId = "[subnet-c-id]"

aws cloudformation deploy `
    --template-file $PSScriptRoot/../Environment/rolling-application.yaml `
    --stack-name $ServiceName-$stackType `
    --s3-bucket $DeployBucketName `
    --s3-prefix $ServiceName/$stackType `
    --parameter-overrides "ServiceName=$ServiceName" "ImageVersion=$ImageVersion" "VpcId=$VpcId" "SubnetAId=$subnetAId" "SubnetBId=$subnetBId" "SubnetCId=$subnetCId" `
    --capabilities CAPABILITY_NAMED_IAM `
    --no-fail-on-empty-changeset;