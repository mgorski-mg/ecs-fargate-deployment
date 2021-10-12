param(
    [Parameter(Mandatory = $True)]
    [string]$ServiceName,

    [Parameter(Mandatory = $True)]
    [string]$DeployBucketName
)

$ErrorActionPreference = "Stop"

$stackType = "rolling-repo"

Write-Host "Deploying $ServiceName-$stackType"

aws cloudformation deploy `
    --template-file $PSScriptRoot/../Environment/rolling-repo.yaml `
    --stack-name $ServiceName-$stackType `
    --s3-bucket $DeployBucketName `
    --s3-prefix $ServiceName/$stackType `
    --parameter-overrides "ServiceName=$ServiceName" `
    --capabilities CAPABILITY_NAMED_IAM `
    --no-fail-on-empty-changeset;