#!/bin/bash

#docker build -t zerotosingularity/fastai_v3:1.0.50.post1 
#docker push zerotosingularity/fastai_v3:1.0.50.post1

docker build -t zerotosingularity/fastai_v3:latest . --no-cache
docker push zerotosingularity/fastai_v3:latest

#docker build -t zerotosingularity/aidl-docker:latest .
#docker push zerotosingularity/aidl-docker-experimental:latest
