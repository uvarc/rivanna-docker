FROM python:3.7.4-slim-buster AS py
ARG VERSION=2.3.0
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
        tensorflow==$VERSION

FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04 AS lib
ARG LIBNVINFER=6.0.1-1
ARG LIBNVINFER_MAJOR_VERSION=6
RUN apt-get update && apt-get install -y --no-install-recommends \
        libnvinfer${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda10.1 \
        libnvinfer-plugin${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda10.1 \
        libhdf5-serial-dev \
        libzmq3-dev && \
    rm -rf /var/lib/apt/lists/*

# Python version 3.7.3
FROM gcr.io/distroless/python3-debian10

# Python packages
COPY --from=py /usr/local/lib/python3.7/site-packages /site-packages

# CUDA libraries
COPY --from=lib /usr/local/cuda/compat /usr/local/cuda/compat
COPY --from=lib /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1
COPY --from=lib \
    /usr/local/cuda/lib64/libcudart.so.10.1 \
    /usr/local/cuda/lib64/libcufft.so.10 \
    /usr/local/cuda/lib64/libcufftw.so.10 \
    /usr/local/cuda/lib64/libcuinj64.so.10.1 \
    /usr/local/cuda/lib64/libcurand.so.10 \
    /usr/local/cuda/lib64/libcusolver.so.10 \
    /usr/local/cuda/lib64/libcusolverMg.so.10 \
    /usr/local/cuda/lib64/libcusparse.so.10 \
    /usr/local/cuda/lib64/libnvrtc.so.10.1 \
    /usr/local/cuda/lib64/libnvrtc-builtins.so.10.1 \
    /usr/local/cuda/lib64/
COPY --from=lib \
    /usr/lib/x86_64-linux-gnu/libcublas.so.10 \
    /usr/lib/x86_64-linux-gnu/libcublasLt.so.10 \
    /usr/lib/x86_64-linux-gnu/libcudnn.so.7 \
    /usr/lib/x86_64-linux-gnu/libnvinfer.so.6 \
    /usr/lib/x86_64-linux-gnu/libnvinfer_plugin.so.6 \
    /usr/lib/x86_64-linux-gnu/
COPY --from=lib /usr/local/cuda/extras/CUPTI/lib64 /usr/local/cuda/extras/CUPTI/lib64

# system libraries
COPY --from=lib \
    /usr/include/hdf5 \
    /usr/include/zmq.h \
    /usr/include/zmq.hpp \
    /usr/include/zmq_utils.h \
    /usr/include/
COPY --from=lib \
    /usr/lib/x86_64-linux-gnu/hdf5 \
    /usr/lib/x86_64-linux-gnu/libhdf5* \
    /usr/lib/x86_64-linux-gnu/pkgconfig/hdf5-serial.pc \
    /usr/lib/x86_64-linux-gnu/libzmq.a \
    /usr/lib/x86_64-linux-gnu/libzmq.so \
    /usr/lib/x86_64-linux-gnu/pkgconfig/libzmq.pc \
    /usr/lib/x86_64-linux-gnu/

ENV PYTHONPATH=/site-packages
ENV LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64
ENV LANG C.UTF-8

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["/usr/bin/python"]
