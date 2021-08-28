param(
    [Parameter(Mandatory = $True)]
    [string]$ServiceName,

    [Parameter(Mandatory = $True)]
    [string]$ImageVersion
)

$ErrorActionPreference = "Stop"

$stackType = "rolling-repo"

Write-Host "Building and pushing $ServiceName docker image"

$accountId = aws sts get-caller-identity | ConvertFrom-Json | Select-Object -ExpandProperty "Account"
$loginUrl = "$accountId.dkr.ecr.eu-west-1.amazonaws.com"
$repositoryName = "$ServiceName-$stackType"
$imageUri = "$loginUrl/${repositoryName}:$ImageVersion"

aws ecr get-login-password | docker login --username AWS --password-stdin $loginUrl;

docker build $PSScriptRoot/.. -f $PSScriptRoot/../EcsFargateRollingUpdate/Dockerfile -t $imageUri --pull;

docker push $imageUri;
docker rmi $imageUri;