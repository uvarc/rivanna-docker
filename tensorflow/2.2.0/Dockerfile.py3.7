# Copyright 2019 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================
#
# THIS IS A GENERATED DOCKERFILE.
#
# This file was assembled from multiple pieces, whose use is documented
# throughout. Please refer to the TensorFlow dockerfiles documentation
# for more information.
# ============================================================================
# Modified Ruoshi Sun <rs7wz@virginia.edu>
# Research Computing, Univerity of Virginia

FROM nvidia/cuda:10.1-base-ubuntu18.04
LABEL maintainer=rs7wz@virginia.edu

ARG ARCH
ARG CUDA=10.1
ARG CUDNN=7.6.4.38-1
ARG CUDNN_MAJOR_VERSION=7
ARG LIB_DIR_PREFIX=x86_64
ARG LIBNVINFER=6.0.1-1
ARG LIBNVINFER_MAJOR_VERSION=6

# Needed for string substitution
SHELL ["/bin/bash", "-c"]

# Install all dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cuda-command-line-tools-${CUDA/./-} \
        # There appears to be a regression in libcublas10=10.2.2.89-1 which
        # prevents cublas from initializing in TF. See
        # https://github.com/tensorflow/tensorflow/issues/9489#issuecomment-562394257
        libcublas10=10.2.1.243-1 \ 
        cuda-nvrtc-${CUDA/./-} \
        cuda-cufft-${CUDA/./-} \
        cuda-curand-${CUDA/./-} \
        cuda-cusolver-${CUDA/./-} \
        cuda-cusparse-${CUDA/./-} \
        curl \
        libcudnn7=${CUDNN}+cuda${CUDA} \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libffi-dev libssl-dev \
        libzmq3-dev \
        pkg-config \
        unzip \
        libnvinfer${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda${CUDA} \
        libnvinfer-plugin${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda${CUDA} \
        libsm6 libxext6 libxrender1 && \
        rm -rf /var/lib/apt/lists/*

# Install Python 3.7.7 from source
ARG PYTHON_VERSION=3.7.7

WORKDIR /opt
RUN curl -LO https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xf Python-${PYTHON_VERSION}.tgz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure && make && make install && \
    rm -rf Python*

RUN ln -s $(which python3) /usr/local/bin/python && \
    curl -LO https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py

# For CUDA profiling, TensorFlow requires CUPTI.
ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8
ENV LC_ALL C

# Link the libcuda stub to the location where tensorflow is searching for it and reconfigure
# dynamic linker run-time bindings
RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 \
    && echo "/usr/local/cuda/lib64/stubs" > /etc/ld.so.conf.d/z-cuda-stubs.conf \
    && ldconfig

ARG TF_PACKAGE=tensorflow
ARG TF_PACKAGE_VERSION=2.2.0

RUN pip install --no-cache-dir --upgrade \
        pip setuptools && \
    pip install --no-cache-dir \
        ${TF_PACKAGE}==${TF_PACKAGE_VERSION} \
        numpy==1.18.4 tensorflow-federated==0.14.0 \
        jupyter_http_over_ws ipykernel==5.1.1 nbformat==4.4.0 \
        matplotlib==3.2.1 \
        jupyter==1.0.0 \
        keras-vis==0.4.1 \
        opencv-python==4.2.0.32 \
        pandas==1.0.4 \
        pydot==1.4.1 \
        scikit-learn==0.23.1 \
        seaborn==0.10.1 \
        tflearn==0.3.2 && \
    jupyter serverextension enable --py jupyter_http_over_ws

ENTRYPOINT ["python"]
