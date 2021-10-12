param(
    [Parameter(Mandatory = $True)]
    [string]$ImageVersion
)

$ErrorActionPreference = "Stop"

$deployBucketName = "[s3-bucket-name]"
$serviceName = "ecs-deploy"
$vpcId = "[vpcId]"

. $PSScriptRoot/deploy-security.ps1 $serviceName $deployBucketName $vpcId

. $PSScriptRoot/deploy-rolling-repo.ps1 $serviceName $deployBucketName
. $PSScriptRoot/publish-rolling-docker.ps1 $serviceName $ImageVersion
. $PSScriptRoot/deploy-rolling-app.ps1 $serviceName $deployBucketName $ImageVersion $vpcId