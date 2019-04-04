# aidl-docker
AI & Deep learning docker container(s) to go...

# Versions

Tensorflow: 2.0.0-alpha0

Fastai: 1.0.51

# Requirements

* Make sure the host system for running the container has CUDA 10.1 installed.
* 

# How to use this container

0. Install CUDA 10.1 on the host system
https://developer.nvidia.com/cuda-toolkit

1. Install Docker: (docker-ce or docker-ee)
https://docs.docker.com/install/

2. Install Nvidia-docker:
https://github.com/NVIDIA/nvidia-docker

3. Checkout code and run container
```bash
git clone https://github.com/fastai/course-v3.git
cd course-v3
docker run --runtime=nvidia -it -p 8888:8888 -v $HOME/.fastai:/root/.fastai -v $(pwd):/code/fastai --ipc=host zerotosingularity/fastai_v3:latest
```

It uses two volumes:
* /root/.fastai: store the data for later use, so you don't have to redownload every time
* /code/fastai: maps to the current (course-v3) repository, which lets you save changes over time, and simply pull updates


# License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

# Acknowledgments

- Inspired by: https://github.com/MattKleinsmith/dockerfiles/blob/master/fastai/Dockerfile;
- Learned from: Run Jupyter script was seen at: Floydhub - dl-docker: https://github.com/floydhub/dl-docker/blob/master/run_jupyter.sh;
- Thanks to: Seppe De Loore for the initial fastai installation steps when we needed them.

