# Base image
FROM nvidia/cuda:9.2-runtime-ubuntu18.04

SHELL ["/bin/bash", "-c"]

# Tools
RUN apt-get update --fix-missing && apt-get install -y \
	bzip2 \
	ca-certificates \
	curl \
	git \
	libjpeg-turbo8 \
	p7zip-full \
	software-properties-common \
	sudo \
	unzip \
	vim \
	wget \
&& rm -rf /var/lib/apt/lists/*

# Install Anaconda
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN . /opt/conda/etc/profile.d/conda.sh

ENV PATH /opt/conda/bin:$PATH
ENV CONDA_AUTO_UPDATE_CONDA=false

COPY . /code
WORKDIR /code


# Install all packages
## Uninstall Notebook and force version 5.6: https://github.com/jupyter/notebook/issues/3946 
RUN apt-get install -y libjpeg-turbo8 && \
	pip install --upgrade pip && \
	conda install -c pytorch pytorch-nightly cuda92 -y && conda clean -ya  &&\
	conda install -c fastai torchvision-nightly -y && \
	conda install -c fastai fastai -y && \
	conda install jupyter -y && \
	pip uninstall notebook -y && \
	pip install notebook==5.6.0 && \
	apt-get install -y python-opengl

RUN conda list > conda_info.txt && \
	pip list > pip_info.txt

RUN jupyter notebook --generate-config --allow-root && \
	echo "c.NotebookApp.ip = '*'" >> ~/.jupyter/jupyter_notebook_config.py && \
	echo "c.NotebookApp.open_browser = False" >> ~/.jupyter_notebook_config.py

# Jupyter has issues running directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/

# Expose Ports
EXPOSE 6006 8888

ENTRYPOINT ["jupyter", "notebook", "--allow-root"]
