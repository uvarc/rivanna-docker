ARG VERSION=2.4.1
ARG CUDA_MAJOR_VERSION=11
ARG CUDA_VERSION=${CUDA_MAJOR_VERSION}.0
ARG CUDNN_MAJOR_VERSION=8
ARG CUDNN_VERSION=${CUDNN_MAJOR_VERSION}.0.2.39-1
ARG LIBNVINFER_MAJOR_VERSION=7
ARG LIBNVINFER_VERSION=${LIBNVINFER_MAJOR_VERSION}.1.3-1

FROM python:3.7.4-slim-buster AS py
ARG VERSION
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
        tensorflow==$VERSION
RUN pip install --no-cache-dir \
        numpy==1.19.4 \
        scipy==1.5.4 \
        keras==2.4.3 \
        keras-vis==0.4.1 \
        matplotlib==3.3.3 \
        seaborn==0.11.0 \
        pandas==1.1.5 \
        scikit-learn==0.23.2 \
        scikit-image==0.17.2 \
        opencv-python==4.4.0.46

RUN pip install --no-cache-dir \
        jupyter==1.0.0 \
        ipykernel==5.4.2 \
        nbformat==5.0.8 \
        pydot==1.4.1 \
        typing_extensions==3.7.4.3

FROM nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN_MAJOR_VERSION}-devel-ubuntu18.04 AS lib
ARG CUDA_MAJOR_VERSION
ARG CUDA_VERSION
ARG LIBNVINFER_MAJOR_VERSION
ARG LIBNVINFER_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends \
        libnvinfer${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER_VERSION}+cuda${CUDA_VERSION} \
        libnvinfer-plugin${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER_VERSION}+cuda${CUDA_VERSION} \
        libhdf5-serial-dev \
        libzmq3-dev && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
        libgl1 libsm6 libxext6 libxrender1 libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev && \
    rm -rf /var/lib/apt/lists/*

# Python version 3.7.3
FROM gcr.io/distroless/python3-debian10
ARG CUDA_MAJOR_VERSION
ARG CUDA_VERSION
ARG CUDNN_MAJOR_VERSION
ARG LIBNVINFER_MAJOR_VERSION
ARG LIBNVINFER_VERSION

# Python packages
COPY --from=py /usr/local/lib/python3.7/site-packages /site-packages

# CUDA libraries
COPY --from=lib /usr/local/cuda/compat /usr/local/cuda/compat
COPY --from=lib /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1
COPY --from=lib \
    /usr/local/cuda/lib64/libcublas.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcublasLt.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcudart.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/libcufft.so.10 \
    /usr/local/cuda/lib64/libcufftw.so.10 \
    /usr/local/cuda/lib64/libcuinj64.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/libcupti.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/libcurand.so.10 \
    /usr/local/cuda/lib64/libcusolver.so.10 \
    /usr/local/cuda/lib64/libcusolverMg.so.10 \
    /usr/local/cuda/lib64/libcusparse.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libnvperf_* \
    /usr/local/cuda/lib64/libnvrtc.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/libnvrtc-builtins.so.$CUDA_VERSION \
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
COPY --from=lib /usr/include/gtk-3.0 /usr/include/gtk-3.0
COPY --from=lib /usr/include/x86_64-linux-gnu/libavcodec /usr/include/x86_64-linux-gnu/libavcodec
COPY --from=lib /usr/include/x86_64-linux-gnu/libavformat /usr/include/x86_64-linux-gnu/libavformat
COPY --from=lib /usr/include/x86_64-linux-gnu/libswscale /usr/include/x86_64-linux-gnu/libswscale
COPY --from=lib \
    /usr/lib/x86_64-linux-gnu/hdf5 \
    /usr/lib/x86_64-linux-gnu/libhdf5* \
    /usr/lib/x86_64-linux-gnu/pkgconfig/hdf5-serial.pc \
    /usr/lib/x86_64-linux-gnu/libzmq.a \
    /usr/lib/x86_64-linux-gnu/libzmq.so \
    /usr/lib/x86_64-linux-gnu/pkgconfig/libzmq.pc \
    /usr/lib/x86_64-linux-gnu/libSM.so.6 \
    /usr/lib/x86_64-linux-gnu/libGL.so.1 \
    /usr/lib/x86_64-linux-gnu/libGLdispatch.so.0 \
    /usr/lib/x86_64-linux-gnu/libGLX_mesa.so.0 \
    /usr/lib/x86_64-linux-gnu/libGLX.so.0 \
    /usr/lib/x86_64-linux-gnu/libGLESv2.so.2 \
    /usr/lib/x86_64-linux-gnu/libGLESv1_CM.so.1 \
    /usr/lib/x86_64-linux-gnu/libGL.so.1 \
    /usr/lib/x86_64-linux-gnu/libEGL_mesa.so.0 \
    /usr/lib/x86_64-linux-gnu/libEGL.so.1 \
    /usr/lib/x86_64-linux-gnu/libgthread-2.0.so.0 \
    /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0 \
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
    /usr/lib/x86_64-linux-gnu/

ENV PYTHONPATH=/site-packages \
    LD_LIBRARY_PATH=/usr/local/cuda/lib64 \
    LANG=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://www.tensorflow.org \
      description="TensorFlow is an open-source software library for Machine Intelligence." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["/usr/bin/python"]
