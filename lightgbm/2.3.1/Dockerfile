# modified from https://github.com/microsoft/LightGBM/blob/master/docker/gpu/dockerfile.gpu
FROM nvidia/cuda:10.2-cudnn8-devel AS build

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ARG DEBIAN_FRONTEND=noninteractive

# Global Path Setting
ENV CUDA_HOME /usr/local/cuda
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:${CUDA_HOME}/lib64:/usr/local/lib
ENV OPENCL_LIBRARIES /usr/local/cuda/lib64
ENV OPENCL_INCLUDE_DIR /usr/local/cuda/include

# SYSTEM
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        wget \
        ca-certificates \
        libglib2.0-0 \
        libxext6 \
        libsm6 \
        libxrender1 \
        cmake \
        libboost-dev \
        libboost-system-dev \
        libboost-filesystem-dev \
        gcc \
        g++ && \
    rm -rf /var/lib/apt/lists/*

# Add OpenCL ICD files for LightGBM
WORKDIR /etc/OpenCL/vendors
RUN echo "libnvidia-opencl.so.1" > nvidia.icd

# LightGBM
ARG VERSION=2.3.1
WORKDIR /opt
RUN wget -q https://github.com/microsoft/LightGBM/archive/v${VERSION}.tar.gz && \
    tar xf v${VERSION}.tar.gz && \
    cd LightGBM-$VERSION && mkdir build && cd build && \
    cmake -DUSE_GPU=1 -DOpenCL_LIBRARY=/usr/local/cuda/lib64/libOpenCL.so -DOpenCL_INCLUDE_DIR=/usr/local/cuda/include/ .. && \
    make OPENCL_HEADERS=/usr/local/cuda-10.2/targets/x86_64-linux/include LIBOPENCL=/usr/local/cuda-10.2/targets/x86_64-linux/lib

# Use runtime
FROM nvidia/cuda:10.2-cudnn8-runtime
ARG VERSION=2.3.1
COPY --from=build /etc/OpenCL/vendors/nvidia.icd /etc/OpenCL/vendors/nvidia.icd
COPY --from=build /usr/local/cuda/targets/x86_64-linux/include/CL /usr/local/cuda/targets/x86_64-linux/include/CL
COPY --from=build /usr/local/cuda/lib64/libOpenCL.so /usr/local/cuda/lib64/libOpenCL.so
COPY --from=build /usr/local/cuda/lib64/libOpenCL.so.1 /usr/local/cuda/lib64/libOpenCL.so.1
COPY --from=build /opt/LightGBM-${VERSION}/lightgbm /opt/LightGBM-${VERSION}/lightgbm
COPY --from=build /opt/LightGBM-${VERSION}/lib_lightgbm.so /opt/LightGBM-${VERSION}/lib_lightgbm.so
COPY --from=build /opt/LightGBM-${VERSION}/python-package /opt/LightGBM-${VERSION}/python-package

WORKDIR /usr/local/cuda
RUN ln -s targets/x86_64-linux/include/CL include

# Global Path Setting
ENV CUDA_HOME /usr/local/cuda
ENV PATH /opt/LightGBM-${VERSION}:${PATH}
ENV LD_LIBRARY_PATH /opt/LightGBM-${VERSION}:${CUDA_HOME}/lib64:/usr/local/lib:${LD_LIBRARY_PATH}
ENV OPENCL_LIBRARIES /usr/local/cuda/lib64
ENV OPENCL_INCLUDE_DIR /usr/local/cuda/include

# SYSTEM
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
        ca-certificates \
        libglib2.0-0 \
        libxext6 \
        libsm6 \
        libxrender1 \
        libboost-dev \
        libboost-system-dev \
        libboost-filesystem-dev \
        gcc \
        g++ && \
    rm -rf /var/lib/apt/lists/*

# TINI
ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# CONDA
ARG CONDA_DIR=/opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
WORKDIR /opt

RUN echo "export PATH=$CONDA_DIR/bin:"'$PATH' > /etc/profile.d/conda.sh && \
    wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p $CONDA_DIR && \
    rm ~/miniconda.sh

RUN conda install -c conda-forge -c anaconda \
        python=3.7 \
        mkl=2020.2 \
        numpy=1.19.1 \
        scipy=1.5.2 \
        scikit-learn=0.23.2 \
        jupyter=1.0.0 \
        notebook=6.1.1 \
        ipython=7.17.0 \
        pandas=1.1.0 \
        matplotlib=3.3.0 && \
    conda clean -a

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://github.com/microsoft/LightGBM
LABEL description="LightGBM is a gradient boosting framework that uses tree based learning algorithms."
LABEL gpu=true
LABEL moduleclass=data

ENTRYPOINT ["lightgbm"]
