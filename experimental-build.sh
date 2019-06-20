#!/bin/bash

export version=0.0.4

docker build -t zerotosingularity/aidl-docker-experimental:$version . --no-cache
docker push zerotosingularity/aidl-docker-experimental:$version
docker build -t zerotosingularity/aidl-docker-experimental:latest . 
docker push zerotosingularity/aidl-docker-experimental:latest
