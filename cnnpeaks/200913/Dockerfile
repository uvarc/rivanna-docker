ARG CUDA_MAJOR_VERSION=10
ARG CUDA=${CUDA_MAJOR_VERSION}.1
ARG CUDNN_MAJOR_VERSION=7
ARG CUDNN=${CUDNN_MAJOR_VERSION}.6.4.38-1
ARG LIBNVINFER_MAJOR_VERSION=6
ARG LIBNVINFER_VERSION=${LIBNVINFER_MAJOR_VERSION}.0.1-1

FROM python:3.7.9-slim-buster AS build
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates git build-essential autoconf \
        libbz2-dev libcurl4-openssl-dev libreadline-dev liblzma-dev \
        libncurses5-dev libncursesw5-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# HTSlib
ARG HTSLIB_VERSION=1.11
WORKDIR /opt/htslib
RUN wget -q https://github.com/samtools/htslib/releases/download/${HTSLIB_VERSION}/htslib-${HTSLIB_VERSION}.tar.bz2 && \
    tar xf htslib-${HTSLIB_VERSION}.tar.bz2 && \
    cd htslib-${HTSLIB_VERSION} && \
    autoheader && autoconf && ./configure --prefix=/opt/htslib && make && make install && \
    rm -rf htslib-${HTSLIB_VERSION} htslib-${HTSLIB_VERSION}.tar.bz2

# samtools
ARG SAMTOOLS_VERSION=1.11
WORKDIR /opt/samtools
RUN wget -q https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
    tar xf samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
    cd samtools-${SAMTOOLS_VERSION} && \
    autoheader && autoconf && ./configure --prefix=/opt/samtools && make && make install && \
    rm -rf samtools-${SAMTOOLS_VERSION} samtools-${SAMTOOLS_VERSION}.tar.bz2

# clone CNNPeaks
WORKDIR /opt/cnnpeaks
RUN git clone https://github.com/odb9402/CNNPeaks.git

FROM nvidia/cuda:${CUDA}-cudnn${CUDNN_MAJOR_VERSION}-devel-ubuntu18.04 AS lib
ARG CUDA_MAJOR_VERSION
ARG CUDA
ARG CUDNN_MAJOR_VERSION
ARG CUDNN
ARG LIBNVINFER_MAJOR_VERSION
ARG LIBNVINFER_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends --allow-downgrades --allow-change-held-packages \
        libcudnn${CUDNN_MAJOR_VERSION}=${CUDNN}+cuda${CUDA} \
        libnvinfer${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER_VERSION}+cuda${CUDA} \
        libnvinfer-plugin${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER_VERSION}+cuda${CUDA}

FROM python:3.7.9-slim-buster
ARG CUDA_MAJOR_VERSION
ARG CUDA
ARG CUDNN_MAJOR_VERSION
ARG LIBNVINFER_MAJOR_VERSION
ARG LIBNVINFER_VERSION

# python packages
RUN pip install --no-cache-dir \
        tensorflow==1.15 tensorflow-gpu==1.15 \
        numpy scipy matplotlib sklearn pandas progressbar2 pysam cython

# copy HTSlib, samtools, and dependencies
COPY --from=build /opt/htslib/bin /usr/include/bin
COPY --from=build /opt/htslib/include /usr/include
COPY --from=build /opt/htslib/lib /usr/local/lib
COPY --from=build /opt/samtools/bin /usr/bin

COPY --from=build \
    /lib/x86_64-linux-gnu/libbz2.so.1.0 \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libcom_err.so.2 \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libgcrypt.so.20 \
    /lib/x86_64-linux-gnu/libgpg-error.so.0 \
    /lib/x86_64-linux-gnu/libkeyutils.so.1 \
    /lib/x86_64-linux-gnu/liblzma.so.5 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libncursesw.so.6 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libresolv.so.2 \
    /lib/x86_64-linux-gnu/libtinfo.so.6 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    /lib/x86_64-linux-gnu/

COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2

COPY --from=build \
    /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 \
    /usr/lib/x86_64-linux-gnu/libcurl.so.4 \
    /usr/lib/x86_64-linux-gnu/libffi.so.6 \
    /usr/lib/x86_64-linux-gnu/libgmp.so.10 \
    /usr/lib/x86_64-linux-gnu/libgnutls.so.30 \
    /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2 \
    /usr/lib/x86_64-linux-gnu/libhogweed.so.4 \
    /usr/lib/x86_64-linux-gnu/libidn2.so.0 \
    /usr/lib/x86_64-linux-gnu/libk5crypto.so.3 \
    /usr/lib/x86_64-linux-gnu/libkrb5.so.3 \
    /usr/lib/x86_64-linux-gnu/libkrb5support.so.0 \
    /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2 \
    /usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2 \
    /usr/lib/x86_64-linux-gnu/libnettle.so.6 \
    /usr/lib/x86_64-linux-gnu/libnghttp2.so.14 \
    /usr/lib/x86_64-linux-gnu/libp11-kit.so.0 \
    /usr/lib/x86_64-linux-gnu/libpsl.so.5 \
    /usr/lib/x86_64-linux-gnu/librtmp.so.1 \
    /usr/lib/x86_64-linux-gnu/libsasl2.so.2 \
    /usr/lib/x86_64-linux-gnu/libssh2.so.1 \
    /usr/lib/x86_64-linux-gnu/libssl.so.1.1 \
    /usr/lib/x86_64-linux-gnu/libtasn1.so.6 \
    /usr/lib/x86_64-linux-gnu/libunistring.so.2 \
    /usr/lib/x86_64-linux-gnu/

# CUDA libraries
COPY --from=lib /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/libcuda.so.$CUDA
COPY --from=lib \
    /usr/local/cuda/lib64/libcudart.so.$CUDA \
    /usr/local/cuda/lib64/libcufft.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcufftw.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcuinj64.so.$CUDA \
    /usr/local/cuda/lib64/libcurand.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcusolver.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcusolverMg.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcusparse.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libnvrtc.so.$CUDA \
    /usr/local/cuda/lib64/libnvrtc-builtins.so.$CUDA \
    /usr/local/cuda/lib64/
COPY --from=lib \
    /usr/lib/x86_64-linux-gnu/libcublas.so.$CUDA_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcublasLt.so.$CUDA_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libnvinfer.so.$LIBNVINFER_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libnvinfer_plugin.so.$LIBNVINFER_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/

# CNNPeaks
RUN apt-get update && apt-get install -y --no-install-recommends \
        perl gcc libc6-dev && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/cnnpeaks/CNNPeaks /opt/CNNPeaks
WORKDIR /opt/CNNPeaks
RUN ./build.sh

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://github.com/odb9402/CNNPeaks
LABEL description="CNN-peaks is a Convolution Neural Network(CNN) based ChIP-Seq peak calling software."
LABEL gpu=true
LABEL moduleclass=bio

ENV PATH /opt/CNNPeaks:/opt/CNNPeaks/scripts:$PATH

ENTRYPOINT ["python", "/opt/CNNPeaks/CNNpeaks"]
