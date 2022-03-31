FROM nvidia/cuda:11.2.0-cudnn8-devel-ubuntu20.04
USER root

ARG DEBIAN_FRONTEND=noninteractive
RUN apt clean
RUN apt-get update  -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    build-essential \
    zlib1g \
    libgoogle-glog-dev \
    protobuf-compiler \
    libprotobuf-dev \
    python3-opencv \
    libopencv-dev \
    git-all \
    cmake \
    sudo \
    caffe-cpu \
    libboost-all-dev \
    &&  rm -rf /var/lib/apt/lists/* && pkg-config --modversion opencv4

RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose
RUN cd openpose && git submodule update --init --recursive --remote
RUN bash openpose/scripts/ubuntu/install_deps.sh &&  rm -rf /var/lib/apt/lists/*

RUN cd openpose && mkdir build
RUN cmake -S ../openpose -B build
RUN cd build && make -j `nproc`

LABEL maintainer=uvahrc \
      homepage=https://github.com/CMU-Perceptual-Computing-Lab/openpose \
      description="OpenPose has represented the first real-time multi-person system to jointly detect \
                   human body, hand, facial, and foot keypoints (in total 135 keypoints) on single images." \
      gpu=true \
      moduleclass=data