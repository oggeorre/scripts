#!/bin/sh

# Variables to define:
# PASSWORD
# NAME
# NETWORK

echo "Variables:"

for ARGUMENT in "$@"; do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)
    declare $KEY="$VALUE"
    echo $KEY

done

CONTAINER="$NAME"_neo4j
IMAGE=neo4j:4.1
DATA=/var/lib/"$NAME"/data
USER_GROUP=$(id -u):$(id -g)

mkdir -p $DATA

echo "Stopping $CONTAINER..."
sudo docker stop $CONTAINER

echo "Removing $CONTAINER..."
sudo docker rm $CONTAINER -f

echo "Initiating $CONTAINER..."
sudo docker run --NETWORK $NETWORK --name $CONTAINER --user $USER_GROUP --restart=always -p7474:7474 -p7687:7687 -d -v $DATA/neo4j:/data --env NEO4J_AUTH=neo4j/"$PASSWORD" --env NEO4J_dbms_allow__upgrade=true --env NEO4J_cypher_lenient__create__relationship=true $IMAGE
