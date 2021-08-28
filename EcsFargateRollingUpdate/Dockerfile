# Build app - because of this part, the docker needs to be build from the solution perspective, not the project
FROM mcr.microsoft.com/dotnet/sdk:3.1-alpine AS build-env
WORKDIR /app
COPY . .
WORKDIR /app/EcsFargateRollingUpdate
RUN dotnet publish -c Release -o /app/output

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:3.1-alpine

# required for healthcheck defined in the application.yaml template
RUN apk add curl

WORKDIR /app
COPY --from=build-env /app/output .

ENV ASPNETCORE_URLS=http://+:80
ENTRYPOINT ["dotnet", "EcsFargateRollingUpdate.dll"]