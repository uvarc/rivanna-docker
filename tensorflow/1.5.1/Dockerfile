ARG VERSION=1.5.1
ARG CUDA_MAJOR_VERSION=9
ARG CUDA=${CUDA_MAJOR_VERSION}.0
ARG CUDNN_MAJOR_VERSION=7
ARG CUDNN=${CUDNN_MAJOR_VERSION}.0.5.15-1
ARG LIBNVINFER_MAJOR_VERSION=6
ARG LIBNVINFER_VERSION=${LIBNVINFER_MAJOR_VERSION}.0.1-1

FROM python:2.7.18-slim-buster AS py
ARG VERSION
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
        tensorflow-gpu==$VERSION
RUN touch /usr/local/lib/python2.7/site-packages/google/__init__.py
RUN pip install --no-cache-dir \
        keras==2.2.5 scipy scikit-learn==0.20.4 opencv-python==4.2.0.32
RUN pip install --no-cache-dir \
        np_utils jupyter ipykernel

FROM nvidia/cuda:${CUDA}-cudnn${CUDNN_MAJOR_VERSION}-devel-ubuntu16.04 AS lib
ARG CUDA_MAJOR_VERSION
ARG CUDA
ARG CUDNN_MAJOR_VERSION
ARG CUDNN
ARG LIBNVINFER_MAJOR_VERSION
ARG LIBNVINFER_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends --allow-downgrades --allow-change-held-packages \
        libcudnn${CUDNN_MAJOR_VERSION}=${CUDNN}+cuda${CUDA} \
        libnvinfer${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER_VERSION}+cuda${CUDA} \
        libnvinfer-plugin${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER_VERSION}+cuda${CUDA} \
        libhdf5-serial-dev \
        libzmq3-dev \
        libgl1 libsm6 libxext6 libxrender1 libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev && \
    rm -rf /var/lib/apt/lists/*

FROM gcr.io/distroless/python2.7-debian10
ARG CUDA_MAJOR_VERSION
ARG CUDA
ARG CUDNN_MAJOR_VERSION
ARG LIBNVINFER_MAJOR_VERSION
ARG LIBNVINFER_VERSION

# Python packages
COPY --from=py /usr/local/lib/python2.7/site-packages /site-packages

# CUDA libraries
COPY --from=lib /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/libcuda.so.$CUDA
COPY --from=lib \
    /usr/local/cuda/lib64/libcublas.so.$CUDA \
    /usr/local/cuda/lib64/libcudart.so.$CUDA \
    /usr/local/cuda/lib64/libcufft.so.$CUDA \
    /usr/local/cuda/lib64/libcufftw.so.$CUDA \
    /usr/local/cuda/lib64/libcuinj64.so.$CUDA \
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

# system libraries
COPY --from=lib \
    /usr/include/hdf5 \
    /usr/include/zmq.h \
    /usr/include/zmq.hpp \
    /usr/include/zmq_utils.h \
    /usr/include/
COPY --from=lib /usr/lib/x86_64-linux-gnu/libglib-2.0.so /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
COPY --from=lib \
    /usr/lib/x86_64-linux-gnu/hdf5 \
    /usr/lib/x86_64-linux-gnu/libhdf5* \
    /usr/lib/x86_64-linux-gnu/pkgconfig/hdf5-serial.pc \
    /usr/lib/x86_64-linux-gnu/libzmq.a \
    /usr/lib/x86_64-linux-gnu/libzmq.so \
    /usr/lib/x86_64-linux-gnu/pkgconfig/libzmq.pc \
    /usr/lib/x86_64-linux-gnu/libSM.so.6 \
    /usr/lib/x86_64-linux-gnu/mesa/libGL.so.1 \
    /usr/lib/x86_64-linux-gnu/mesa-egl/libEGL.so.1 \
    /usr/lib/x86_64-linux-gnu/libgthread-2.0.so.0 \
    /usr/lib/x86_64-linux-gnu/libgdk-3.so \
    /usr/lib/x86_64-linux-gnu/libgtk-3.so \
    /usr/lib/x86_64-linux-gnu/pkgconfig/gdk-3.0.pc \
    /usr/lib/x86_64-linux-gnu/pkgconfig/gdk-broadway-3.0.pc \
    /usr/lib/x86_64-linux-gnu/pkgconfig/gdk-wayland-3.0.pc \
    /usr/lib/x86_64-linux-gnu/pkgconfig/gdk-x11-3.0.pc \
    /usr/lib/x86_64-linux-gnu/pkgconfig/gtk+-3.0.pc \
    /usr/lib/x86_64-linux-gnu/pkgconfig/gtk+-broadway-3.0.pc \
    /usr/lib/x86_64-linux-gnu/pkgconfig/gtk+-unix-print-3.0.pc \
    /usr/lib/x86_64-linux-gnu/pkgconfig/gtk+-wayland-3.0.pc \
    /usr/lib/x86_64-linux-gnu/pkgconfig/gtk+-x11-3.0.pc \
    /usr/lib/x86_64-linux-gnu/libavcodec.a \
    /usr/lib/x86_64-linux-gnu/libavcodec.so \
    /usr/lib/x86_64-linux-gnu/pkgconfig/libavcodec.pc \
    /usr/lib/x86_64-linux-gnu/libavformat.a \
    /usr/lib/x86_64-linux-gnu/libavformat.so \
    /usr/lib/x86_64-linux-gnu/pkgconfig/libavformat.pc \
    /usr/lib/x86_64-linux-gnu/libswscale.a \
    /usr/lib/x86_64-linux-gnu/libswscale.so \
    /usr/lib/x86_64-linux-gnu/pkgconfig/libswscale.pc \
    /usr/lib/x86_64-linux-gnu/libpcre32.so.3 \
    /usr/lib/x86_64-linux-gnu/libpcre16.so.3 \
    /usr/lib/x86_64-linux-gnu/libpcreposix.so.3 \
    /usr/lib/x86_64-linux-gnu/libpcrecpp.so.0 \
    /lib/x86_64-linux-gnu/libpcre.so.3 \
    /usr/lib/x86_64-linux-gnu/libX11.so.6 \
    /usr/lib/x86_64-linux-gnu/libX11-xcb.so.1 \
    /usr/lib/x86_64-linux-gnu/libxcb.so.1 \
    /usr/lib/x86_64-linux-gnu/libXxf86vm.so.1 \
    /usr/lib/x86_64-linux-gnu/libXtst.so.6 \
    /usr/lib/x86_64-linux-gnu/libXrender.so.1 \
    /usr/lib/x86_64-linux-gnu/libXrandr.so.2 \
    /usr/lib/x86_64-linux-gnu/libXinerama.so.1 \
    /usr/lib/x86_64-linux-gnu/libXi.so.6 \
    /usr/lib/x86_64-linux-gnu/libXft.so.2 \
    /usr/lib/x86_64-linux-gnu/libXfixes.so.3 \
    /usr/lib/x86_64-linux-gnu/libXext.so.6 \
    /usr/lib/x86_64-linux-gnu/libXdmcp.so.6 \
    /usr/lib/x86_64-linux-gnu/libXdamage.so.1 \
    /usr/lib/x86_64-linux-gnu/libXcursor.so.1 \
    /usr/lib/x86_64-linux-gnu/libXcomposite.so.1 \
    /usr/lib/x86_64-linux-gnu/libXau.so.6 \
    /lib/x86_64-linux-gnu/libbsd.so.0 \
    /lib/x86_64-linux-gnu/libuuid.so.1 \
    /usr/lib/x86_64-linux-gnu/libICE.so.6 \
    /usr/lib/x86_64-linux-gnu/

ENV PYTHONPATH=/site-packages
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64
ENV LANG C.UTF-8

LABEL maintainer=rs7wz@virginia.edu
LABEL gpu=true

ENTRYPOINT ["/usr/bin/python"]
