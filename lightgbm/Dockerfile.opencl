# Copyright (c) 2020 The Rector and Visitors of the University of Virginia
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without
# limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
# Software, and to permit persons to whom the Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions
# of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
# TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
# CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

FROM nvidia/opencl:devel AS build
ARG DEBIAN_FRONTEND=noninteractive
ARG OPENCL_LIBRARIES=/usr/lib/x86_64-linux-gnu
ARG OPENCL_INCLUDE_DIR=/usr/include/CL

# SYSTEM
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        git ca-certificates \
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
RUN git clone --recursive --branch stable --depth 1 https://github.com/Microsoft/LightGBM && \
    cd LightGBM && mkdir build && cd build && \
    cmake -DUSE_GPU=1 -DOpenCL_LIBRARY=${OPENCL_LIBRARIES}/libOpenCL.so.1 -DOpenCL_INCLUDE_DIR=$OPENCL_INCLUDE_DIR .. && \
    make OPENCL_HEADERS=$OPENCL_INCLUDE_DIR LIBOPENCL=$OPENCL_LIBRARIES

FROM nvidia/opencl:runtime
RUN apt-get update && apt-get install -y --no-install-recommends \
        libxext6 \
        libsm6 \
        libxrender1 \
        libboost-system-dev \
        libboost-filesystem-dev \
        gcc \
        g++ && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build \
    /opt/LightGBM/lightgbm \
    /opt/LightGBM/lib_lightgbm.so \
    /opt/LightGBM/

ENV PATH /opt/LightGBM:${PATH}
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["lightgbm"]
