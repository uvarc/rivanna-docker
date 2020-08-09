# modified from https://github.com/microsoft/LightGBM/blob/master/docker/gpu/dockerfile.gpu
ARG VERSION=2.3.1

FROM nvidia/opencl:devel AS build
ARG DEBIAN_FRONTEND=noninteractive
ARG VERSION

# Global Path Setting
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV OPENCL_LIBRARIES /usr/lib/x86_64-linux-gnu
ENV OPENCL_INCLUDE_DIR /usr/include/CL

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

# LightGBM
WORKDIR /opt
RUN wget -q https://github.com/microsoft/LightGBM/archive/v${VERSION}.tar.gz && \
    tar xf v${VERSION}.tar.gz && \
    cd LightGBM-$VERSION && mkdir build && cd build && \
    cmake -DUSE_GPU=1 -DOpenCL_LIBRARY=${OPENCL_LIBRARIES}/libOpenCL.so.1 -DOpenCL_INCLUDE_DIR=$OPENCL_INCLUDE_DIR .. && \
    make OPENCL_HEADERS=$OPENCL_INCLUDE_DIR LIBOPENCL=$OPENCL_LIBRARIES

FROM nvidia/opencl:runtime
ARG VERSION
COPY --from=build /opt/LightGBM-${VERSION}/lightgbm /opt/LightGBM-${VERSION}/lightgbm
COPY --from=build /opt/LightGBM-${VERSION}/lib_lightgbm.so /opt/LightGBM-${VERSION}/lib_lightgbm.so

ENV PATH /opt/LightGBM-${VERSION}:${PATH}
ENV LD_LIBRARY_PATH /opt/LightGBM-${VERSION}:/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}

RUN apt-get update && apt-get install -y --no-install-recommends \
        libxext6 \
        libsm6 \
        libxrender1 \
        libboost-system-dev \
        libboost-filesystem-dev \
        gcc \
        g++ && \
    rm -rf /var/lib/apt/lists/*

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://github.com/microsoft/LightGBM
LABEL description="LightGBM is a gradient boosting framework that uses tree based learning algorithms."
LABEL gpu=true
LABEL moduleclass=data

ENTRYPOINT ["lightgbm"]
