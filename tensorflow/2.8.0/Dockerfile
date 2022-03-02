ARG VERSION=2.8.0
ARG CUDA_MAJOR_VERSION=11
ARG CUDA_MINOR_VERSION=2
ARG CUDA_VERSION=${CUDA_MAJOR_VERSION}.${CUDA_MINOR_VERSION}
ARG CUDNN_MAJOR_VERSION=8
ARG NVINFER_MAJOR_VERSION=7
ARG NVINFER_VERSION=${NVINFER_MAJOR_VERSION}.2.3-1

FROM python:3.9-slim-bullseye AS py
ARG VERSION

# openslide
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates build-essential gcc pkg-config \
        libcairo2-dev libgdk-pixbuf-2.0-dev libglib2.0-dev libjpeg-dev liblcms2-dev libopenjp2-7-dev libtiff-dev libpng-dev \
        libxml2-dev libz-dev zlib1g-dev \
        libsqlite3-dev valgrind && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN wget https://github.com/openslide/openslide/releases/download/v3.4.1/openslide-3.4.1.tar.gz && \
    tar xf openslide-3.4.1.tar.gz && \
    rm openslide-3.4.1.tar.gz && \
    cd openslide-3.4.1 && \
    ./configure && make && make install

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
        tensorflow==$VERSION \
        numpy==1.22.2 \
        scipy==1.8.0 \
        keras==2.8.0 \
        keras-vis==0.4.1 \
        matplotlib==3.5.1 \
        seaborn==0.11.2 \
        pandas==1.4.1 \
        scikit-learn==1.0.2 \
        scikit-image==0.19.1 \
        openslide-python==1.1.2 \
        opencv-python==4.5.5.62 \
        jupyter ipykernel nbformat pydot typing_extensions

# libGL (opencv)
# hdf5, zmq3 (TF)
# These are now included in site-packages/opencv_python.libs:
#libsm6 libxext6 libxrender1 libgtk-3-dev \
#libavcodec-dev libavformat-dev libswscale-dev && \
RUN apt-get update && apt-get install -y --no-install-recommends \
        lsof libgl1 libhdf5-serial-dev libzmq3-dev && \
    rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

FROM nvidia/cuda:${CUDA_VERSION}.2-cudnn${CUDNN_MAJOR_VERSION}-devel-ubuntu18.04 AS lib
ARG CUDA_MAJOR_VERSION
ARG NVINFER_MAJOR_VERSION
ARG NVINFER_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends \
        libnvinfer${NVINFER_MAJOR_VERSION}=${NVINFER_VERSION}+cuda${CUDA_MAJOR_VERSION}.1 \
        libnvinfer-plugin${NVINFER_MAJOR_VERSION}=${NVINFER_VERSION}+cuda${CUDA_MAJOR_VERSION}.1 && \
    rm -rf /var/lib/apt/lists/*

FROM python:3.9-slim-bullseye
ARG CUDA_MAJOR_VERSION
ARG CUDA_VERSION
ARG CUDNN_MAJOR_VERSION
ARG NVINFER_MAJOR_VERSION
ARG NVINFER_VERSION

# Python packages and libopenslide
COPY --from=py /usr/local/lib /usr/local/lib

# CUDA libraries
COPY --from=lib /usr/local/cuda/compat /usr/local/cuda/compat
COPY --from=lib /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1
COPY --from=lib \
    /usr/local/cuda/lib64/libcublas.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcublasLt.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcudart.so.${CUDA_MAJOR_VERSION}.0 \
    /usr/local/cuda/lib64/libcufft.so.10 \
    /usr/local/cuda/lib64/libcufftw.so.10 \
    /usr/local/cuda/lib64/libcuinj64.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/libcupti.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/libcurand.so.10 \
    /usr/local/cuda/lib64/libcusolver.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcusolverMg.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcusparse.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libnvperf_*.so \
    /usr/local/cuda/lib64/libnvrtc-builtins.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/libnvrtc.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/
COPY --from=lib \
    /usr/lib/x86_64-linux-gnu/libcudnn.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_adv_infer.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_adv_train.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_cnn_infer.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_cnn_train.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_ops_infer.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_ops_train.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libnvinfer.so.$NVINFER_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libnvinfer_plugin.so.$NVINFER_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/

# python modules
COPY --from=py \
    /lib/x86_64-linux-gnu/libbz2.so.1.0.4 \
    /lib/x86_64-linux-gnu/libexpat.so.1.6.12 \
    /lib/x86_64-linux-gnu/libgcc_s.so.1 \
    /lib/x86_64-linux-gnu/liblzma.so.5.2.5 \
    /lib/x86_64-linux-gnu/libncursesw.so.6.2 \
    /lib/x86_64-linux-gnu/libpcre.so.3.13.3 \
    /lib/x86_64-linux-gnu/libresolv-2.31.so \
    /lib/x86_64-linux-gnu/librt-2.31.so \
    /lib/x86_64-linux-gnu/libselinux.so.1 \
    /lib/x86_64-linux-gnu/libtinfo.so.6.2 \
    /lib/x86_64-linux-gnu/libz.so.1.2.11 \
    /lib/x86_64-linux-gnu/

# hdf5, zmq, python modules
COPY --from=py \
    /usr/lib/x86_64-linux-gnu/hdf5 \
    /usr/lib/x86_64-linux-gnu/libhdf5* \
    /usr/lib/x86_64-linux-gnu/libzmq.a \
    /usr/lib/x86_64-linux-gnu/libzmq.so \
    /usr/lib/x86_64-linux-gnu/libGL.so.1 \
    /usr/lib/x86_64-linux-gnu/libGLX.so.0 \
    /usr/lib/x86_64-linux-gnu/libGLdispatch.so.0 \
    /usr/lib/x86_64-linux-gnu/libX11.so.6 \
    /usr/lib/x86_64-linux-gnu/libXau.so.6 \
    /usr/lib/x86_64-linux-gnu/libXdmcp.so.6 \
    /usr/lib/x86_64-linux-gnu/libXext.so.6 \
    /usr/lib/x86_64-linux-gnu/libXrender.so.1 \
    /usr/lib/x86_64-linux-gnu/libblkid.so.1 \
    /usr/lib/x86_64-linux-gnu/libbrotlicommon.so.1 \
    /usr/lib/x86_64-linux-gnu/libbrotlidec.so.1 \
    /usr/lib/x86_64-linux-gnu/libbsd.so.0\
    /usr/lib/x86_64-linux-gnu/libcairo.so.2\
    /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 \
    /usr/lib/x86_64-linux-gnu/libdeflate.so.0 \
    /usr/lib/x86_64-linux-gnu/libffi.so.7\
    /usr/lib/x86_64-linux-gnu/libfontconfig.so.1\
    /usr/lib/x86_64-linux-gnu/libfreetype.so.6\
    /usr/lib/x86_64-linux-gnu/libgdk_pixbuf-2.0.so.0\
    /usr/lib/x86_64-linux-gnu/libgio-2.0.so.0\
    /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0\
    /usr/lib/x86_64-linux-gnu/libgmodule-2.0.so.0\
    /usr/lib/x86_64-linux-gnu/libgobject-2.0.so.0\
    /usr/lib/x86_64-linux-gnu/libgthread-2.0.so.0\
    /usr/lib/x86_64-linux-gnu/libicudata.so.67 \
    /usr/lib/x86_64-linux-gnu/libicuuc.so.67 \
    /usr/lib/x86_64-linux-gnu/libjbig.so.0 \
    /usr/lib/x86_64-linux-gnu/libjpeg.so.62\
    /usr/lib/x86_64-linux-gnu/libmd.so.0\
    /usr/lib/x86_64-linux-gnu/libmount.so.1\
    /usr/lib/x86_64-linux-gnu/libopenjp2.so.7 \
    /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0\
    /usr/lib/x86_64-linux-gnu/libpixman-1.so.0\
    /usr/lib/x86_64-linux-gnu/libpng16.so.16\
    /usr/lib/x86_64-linux-gnu/libsqlite3.so.0\
    /usr/lib/x86_64-linux-gnu/libssl.so.1.1 \
    /usr/lib/x86_64-linux-gnu/libstdc++.so.6\
    /usr/lib/x86_64-linux-gnu/libtiff.so.5\
    /usr/lib/x86_64-linux-gnu/libuuid.so.1\
    /usr/lib/x86_64-linux-gnu/libwebp.so.6\
    /usr/lib/x86_64-linux-gnu/libxcb-render.so.0\
    /usr/lib/x86_64-linux-gnu/libxcb-shm.so.0\
    /usr/lib/x86_64-linux-gnu/libxcb.so.1\
    /usr/lib/x86_64-linux-gnu/libxml2.so.2\
    /usr/lib/x86_64-linux-gnu/libzstd.so.1\
    /usr/lib/x86_64-linux-gnu/

COPY --from=lib /usr/local/cuda/bin/ptxas /usr/local/cuda/bin/ptxas

ENV PATH=/usr/local/cuda/bin:$PATH \
    LD_LIBRARY_PATH=/usr/local/lib:/usr/local/cuda/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH \
    LC_ALL=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://www.tensorflow.org \
      description="TensorFlow is an open-source software library for Machine Intelligence." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["python"]
