ARG CUDA_MAJOR_VERSION=10
ARG CUDA=${CUDA_MAJOR_VERSION}.0
ARG CUDNN_MAJOR_VERSION=7
ARG CUDNN=${CUDNN_MAJOR_VERSION}.4.2.24-1
ARG LIBNVINFER_MAJOR_VERSION=6
ARG LIBNVINFER=${LIBNVINFER_MAJOR_VERSION}.0.1-1

FROM python:3.7.9-slim-buster AS py
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc g++ libc6-dev zlib1g-dev lsof && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
        dragonn==0.4.1 \
        numpy==1.16 \
        keras==2.3.0 \
        tensorflow-gpu==1.15 \
        deeplift>=0.6.9.0 \
        shapely \
        matplotlib==3.3.3 \
        plotnine==0.4.0 \
        scikit-learn>=0.20.0 \
        pydot_ng==1.0.0 \
        h5py \
        seqdataloader>=0.124 \
        simdna_dragonn \
        abstention

FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu16.04 AS lib
ARG CUDA
ARG LIBNVINFER_MAJOR_VERSION
ARG LIBNVINFER
RUN apt-get update && apt-get install -y --no-install-recommends \
        libnvinfer${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda$CUDA \
        libnvinfer-plugin${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda$CUDA && \
    rm -rf /var/lib/apt/lists/*

FROM gcr.io/distroless/python3-debian10
ARG CUDA
ARG CUDNN_MAJOR_VERSION
ARG LIBNVINFER_MAJOR_VERSION

COPY --from=py /usr/local/lib/python3.7/site-packages /site-packages
COPY --from=py \
    /lib/x86_64-linux-gnu/libbz2.so.1 \
    /lib/x86_64-linux-gnu/libexpat.so.1 \
    /lib/x86_64-linux-gnu/libgcc_s.so.1 \
    /lib/x86_64-linux-gnu/liblzma.so.5 \
    /lib/x86_64-linux-gnu/librt-2.28.so \
    /lib/x86_64-linux-gnu/libuuid.so.1 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    /lib/x86_64-linux-gnu/
COPY --from=py \
    /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 \
    /usr/lib/x86_64-linux-gnu/libffi.so.6 \
    /usr/lib/x86_64-linux-gnu/libsqlite3.so.0 \
    /usr/lib/x86_64-linux-gnu/libssl.so.1.1 \
    /usr/lib/x86_64-linux-gnu/libstdc++.so.6 \
    /usr/lib/x86_64-linux-gnu/

COPY --from=lib /usr/local/cuda/compat/libcuda.so.1 /usr/local/cuda/compat/libcuda.so.1
COPY --from=lib \
    /usr/local/cuda/lib64/libcublas.so.$CUDA \
    /usr/local/cuda/lib64/libcudart.so.$CUDA \
    /usr/local/cuda/lib64/libcufft.so.$CUDA \
    /usr/local/cuda/lib64/libcufftw.so.$CUDA \
    /usr/local/cuda/lib64/libcurand.so.$CUDA \
    /usr/local/cuda/lib64/libcusolver.so.$CUDA \
    /usr/local/cuda/lib64/libcusparse.so.$CUDA \
    /usr/local/cuda/lib64/libnvrtc.so.$CUDA \
    /usr/local/cuda/lib64/libnvrtc-builtins.so.$CUDA \
    /usr/local/cuda/lib64/
COPY --from=lib \
    /usr/lib/x86_64-linux-gnu/libcudnn.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libnvinfer.so.$LIBNVINFER_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libnvinfer_plugin.so.$LIBNVINFER_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/

ENV PYTHONPATH /site-packages

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://kundajelab.github.io/dragonn/
LABEL description="The dragonn package implements Deep RegulAtory GenOmic Neural Networks (DragoNNs) for predictive modeling of regulatory genomics, nucleotide-resolution feature discovery, and simulations for systematic development and benchmarking."
LABEL gpu=true
LABEL moduleclass=data

ENTRYPOINT ["python"]
