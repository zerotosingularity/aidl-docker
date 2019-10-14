#!/bin/bash

#docker build -t zerotosingularity/fastai_v3:1.0.50.post1 
#docker push zerotosingularity/fastai_v3:1.0.50.post1

export torch_version=1.1.0
export fastai_version=1.0.57

#docker build --build-arg fastai_version=$fastai_version --build-arg torch_version=$torch_version --build-arg tensorflow_version=$tfversion -t zerotosingularity/fastai_v3:$fastai_version .
docker build --build-arg fastai_version=$fastai_version --build-arg torch_version=$torch_version  -t zerotosingularity/fastai_v3:$fastai_version . --no-cache
docker push zerotosingularity/fastai_v3:$fastai_version

#docker build -t zerotosingularity/fastai_v3:latest . --no-cache
#docker push zerotosingularity/fastai_v3:latest

#docker build -t zerotosingularity/aidl-docker:latest .
#docker push zerotosingularity/aidl-docker-experimental:latest
