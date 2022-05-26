#!/bin/bash
set -e

# Variables to define
#VPS_HOST
#VPS_USER

#CONTAINER_NAME
#IMAGE_TAG

#DOCKER_HOST
#DOCKER_REPONAME
#DOCKER_USERNAME
#DOCKER_PASSWORD
#DOCKER_RUN_COMMAND

echo "Variables:"

for ARGUMENT in "$@"; do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)
    declare $KEY="$VALUE"
    echo $KEY="$VALUE"

done

echo Logging in to Docker repo...

# login to Docker repo
echo "$DOCKER_PASSWORD" | docker login https://$DOCKER_HOST --username $DOCKER_USERNAME --password-stdin

CONTAINER=$CONTAINER_NAME

REPOSITORY_URI=$DOCKER_HOST/$DOCKER_REPONAME

echo Build started on $(date)
echo Building the Docker image...
# build image
docker build -t $REPOSITORY_URI:latest -t $REPOSITORY_URI:$IMAGE_TAG .

echo Build completed on $(date)
echo Pushing the Docker images
# push image
docker push $REPOSITORY_URI:latest

COMMAND_1="echo ""$DOCKER_PASSWORD"" | docker login https://"$DOCKER_HOST" --username "$DOCKER_USERNAME" --password-stdin"
COMMAND_2="sudo docker pull "$REPOSITORY_URI":latest"
COMMAND_3="sudo docker rm "$CONTAINER" -f || true"
COMMAND_4="sudo docker volume create data || true"
COMMAND_5="sudo docker run --restart=always -d --name "$CONTAINER" "$DOCKER_RUN_COMMAND" "$REPOSITORY_URI":latest"
COMMAND_6="curl -L https://raw.githubusercontent.com/lagenhetsbyte/build-scripts/master/container-health.sh | bash -s SLEEP="10" CONTAINER=""$CONTAINER"""
COMMAND_7="sudo docker image prune -a -f"

echo Connecting and running commands on remote server
ssh -o StrictHostKeyChecking=no "$VPS_USER"@"$VPS_HOST" ""$COMMAND_1"; "$COMMAND_2"; "$COMMAND_3"; "$COMMAND_4"; "$COMMAND_5"; "$COMMAND_6"; "$COMMAND_7";"
