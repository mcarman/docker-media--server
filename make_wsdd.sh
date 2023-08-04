#!/bin/bash

trap on_error ERR

on_error() {
    "Error on line $(caller): ${BASH_COMMAND}"
}

get_latest_wsdd2_release() {
    # grep to get tag_name
    # sed to print only version
    curl --silent https://api.github.com/repos/Netgear/wsdd2/releases/latest | \
    grep '"tag_name":' | \
    sed 's/^ *"[^"]*": "\([0-9.]*\)".*, *$/\1/'
}

APP_NAME="wsdd2"
IMAGE_TAG="${APP_NAME}-build"
LATEST_RELEASE_TAG="$(get_latest_wsdd2_release)"
BUILD_ARGS="--build-arg WSDD2_VERSION=$LATEST_RELEASE_TAG"

# Uncomment BUILD_PATH if using this Dockerfile as part of an Ansible deployment
#BUILD_PATH="/tmp/build"
#mkdir $BUILD_PATH
#cd $BUILD_PATH

echo "BUILD_ARGS=$BUILD_ARGS"

docker build -t $IMAGE_TAG $BUILD_ARGS . 
ID=$(docker create $IMAGE_TAG) 
docker cp $ID:/build/ . 
docker rm -v $ID 
docker rmi $IMAGE_TAG 
