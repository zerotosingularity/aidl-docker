# Base image
FROM nvidia/cuda:10.1-runtime-ubuntu18.04

ARG fastai_version
ARG torch_version
ARG tensorflow_version

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
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.3.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN . /opt/conda/etc/profile.d/conda.sh

ENV PATH /opt/conda/bin:$PATH
ENV CONDA_AUTO_UPDATE_CONDA=false

WORKDIR /code

RUN mkdir -p ~/.kaggle

RUN conda update -n base -c defaults conda -y


#RUN apt-get install -y build-essential software-properties-common && \
#RUN 
#	CC="cc -mavx2" pip install --no-cache-dir -U --force-reinstall --no-binary :all: --compile pillow-simd

RUN jupyter notebook --generate-config --allow-root && \
	echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py && \
	echo "c.NotebookApp.open_browser = False" >> ~/.jupyter_notebook_config.py

# Jupyter has issues running directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/

# Install Latest Tensorflow GPU
RUN pip install tensorflow-gpu==$tensorflow_version

# Install all packages
RUN apt-get install -y libjpeg-turbo8 && \
    pip install --upgrade pip && \
    conda uninstall -y pillow && \
    conda install -c fastai/label/test pillow && \
    conda install jupyter -y && \
    pip install torch==$torch_version torchvision && \
    conda install -c pytorch -c fastai fastai=$fastai_version -y && \
    conda install -y -c haasad eidl7zip && \
    conda install -y nbconvert && \
    conda install -y fire -c conda-forge && \
    conda update --all -y && \
    pip install --upgrade kaggle && \
    pip install pdl

# Expose Ports
EXPOSE 6006 8888

ENTRYPOINT ["jupyter", "notebook", "--allow-root"]
