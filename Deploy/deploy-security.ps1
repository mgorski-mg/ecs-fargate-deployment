param(
    [Parameter(Mandatory = $True)]
    [string]$ServiceName,

    [Parameter(Mandatory = $True)]
    [string]$DeployBucketName,

    [Parameter(Mandatory = $True)]
    [string]$VpcId
)

$ErrorActionPreference = "Stop"

$stackType = "sec"

Write-Host "Deploying $ServiceName-$stackType"

aws cloudformation deploy `
    --template-file $PSScriptRoot/../Environment/security.yaml `
    --stack-name $ServiceName-$stackType `
    --s3-bucket $DeployBucketName `
    --s3-prefix $ServiceName/$stackType `
    --parameter-overrides "VpcId=$VpcId" "ServiceName=$ServiceName" `
    --capabilities CAPABILITY_NAMED_IAM `
    --no-fail-on-empty-changeset;