#!/bin/sh

# Variables to define:
# PASSWORD
# NAME

echo "Variables:"

for ARGUMENT in "$@"; do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)
    declare $KEY="$VALUE"
    echo $KEY

done

CONTAINER="$NAME"
IMAGE=mysql:latest
DATA=/var/lib/"$NAME"/data
USER_GROUP=$(id -u):$(id -g)

mkdir -p $DATA

echo "Stopping $CONTAINER..."
sudo docker stop $CONTAINER

echo "Removing $CONTAINER..."
sudo docker rm $CONTAINER -f

echo "Initiating $CONTAINER..."
sudo docker run --name $CONTAINER --user $USER_GROUP --restart=always -p3306:3306 -p8080:8080 -d -v $DATA:/var/lib/mysql --env MYSQL_ROOT_PASSWORD="$PASSWORD" $IMAGE
