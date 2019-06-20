#!/bin/bash

#export version=1.1.0
export fastaiversion=1.0.52
export torchversion=1.1.0
export tfversion=2.0.0-beta0

docker build --build-arg fastai_version=$fastaiversion --build-arg torch_version=$torchversion --build-arg tensorflow_version=$tfversion -t zerotosingularity/fastai_v3:$fastaiversion .
#docker build --build-arg fastai_version=$fastaiversion --build-arg torch_version=$torchversion  -t zerotosingularity/fastai:$fastaiversion .
docker push zerotosingularity/fastai_v3:$fastaiversion

#docker build -t zerotosingularity/fastai_v3:latest . --no-cache
#docker push zerotosingularity/fastai_v3:latest

#docker build -t zerotosingularity/aidl-docker:latest .
#docker build --build-arg fastai_version=$fastaiversion --build-arg torch_version=$torchversion  --build-arg tensorflow_version=$tfversion -t zerotosingularity/aidl-docker:latest .
#docker push zerotosingularity/aidl-docker:latest
