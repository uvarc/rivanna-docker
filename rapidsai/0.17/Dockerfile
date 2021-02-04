ARG VERSION=0.17
ARG CUDA_VERSION=11.0
ARG PYTHON_VERSION=3.7

FROM continuumio/miniconda3:4.9.2 AS py
ARG VERSION
ARG CUDA_VERSION
ARG PYTHON_VERSION

RUN conda install -c rapidsai -c nvidia -c conda-forge -c defaults \
        rapids-blazing=${VERSION} cudatoolkit=${CUDA_VERSION} python=${PYTHON_VERSION} \
        ipykernel && \
    conda clean -ya

RUN apt-get update && apt-get install -y --no-install-recommends lsof && \
    rm -rf /var/lib/apt/lists/*

FROM nvidia/cuda:${CUDA_VERSION}-cudnn8-devel-ubuntu18.04 AS lib

FROM gcr.io/distroless/python3-debian10

ARG CUDA_VERSION
ARG CUDA_MAJOR_VERSION=11
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
    /usr/local/cuda/lib64/libnvrtc.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/libnvrtc-builtins.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/
COPY --from=lib /usr/local/cuda/compat /usr/local/cuda/compat

COPY --from=lib \
    /usr/lib/x86_64-linux-gnu/libnccl.so.2 \
    /usr/lib/x86_64-linux-gnu/

COPY --from=py /opt/conda/lib/python3.7/site-packages /opt/conda/lib/python3.7/site-packages
COPY --from=py /opt/conda/lib/python3.7/lib-dynload /opt/conda/lib/python3.7/lib-dynload

COPY --from=py \
    /opt/conda/lib/libcudf* \
    /opt/conda/lib/libcuml* \
    /opt/conda/lib/libkrb5support.so.0 \
    /opt/conda/lib/libaws-checksums.so.1.0.0 \
    /opt/conda/lib/libcom_err.so.3 \
    /opt/conda/lib/libgssapi_krb5.so.2 \
    /opt/conda/lib/libk5crypto.so.3 \
    /opt/conda/lib/libkrb5.so.3 \
    /opt/conda/lib/libnghttp2.so.14 \
    /opt/conda/lib/libssh2.so.1 \
    /opt/conda/lib/libssl.so.1.1 \
    /opt/conda/lib/libaws-c-common.so.1 \
    /opt/conda/lib/libaws-c-event-stream.so.0unstable \
    /opt/conda/lib/libbrotlicommon.so.1 \
    /opt/conda/lib/libcrypto.so.1.1 \
    /opt/conda/lib/libcurl.so.4 \
    /opt/conda/lib/libprotobuf.so.24 \
    /opt/conda/lib/libarrow.so.100 \
    /opt/conda/lib/libarrow_cuda.so.100 \
    /opt/conda/lib/libarrow_dataset.so.100 \
    /opt/conda/lib/libarrow_flight.so.100 \
    /opt/conda/lib/libarrow_python.so.100 \
    /opt/conda/lib/libarrow_python_flight.so.100 \
    /opt/conda/lib/libgandiva.so.100 \
    /opt/conda/lib/libhdf5_hl.so.100 \
    /opt/conda/lib/libhdf5_hl_cpp.so.100 \
    /opt/conda/lib/libhdf5hl_fortran.so.100 \
    /opt/conda/lib/libparquet.so.100 \
    /opt/conda/lib/libplasma.so.100 \
    /opt/conda/lib/libaws-cpp-sdk-core.so \
    /opt/conda/lib/libaws-cpp-sdk-s3.so \
    /opt/conda/lib/libbrotlidec.so.1 \
    /opt/conda/lib/libbrotlienc.so.1 \
    /opt/conda/lib/libbz2.so.1.0 \
    /opt/conda/lib/liblz4.so.1 \
    /opt/conda/lib/liborc.so \
    /opt/conda/lib/libsnappy.so.1 \
    /opt/conda/lib/libutf8proc.so.2 \
    /opt/conda/lib/libzstd.so.1 \
    /opt/conda/lib/libfaiss.so \
    /opt/conda/lib/libthrift.so.0.13.0 \
    /opt/conda/lib/libgomp.so.1 \
    /opt/conda/lib/libtreelite.so \
    /opt/conda/lib/libcumlprims.so \
    /opt/conda/lib/libnvToolsExt.so.1 \
    /opt/conda/lib/libblas.so.3 \
    /opt/conda/lib/libboost_filesystem.so.1.72.0 \
    /opt/conda/lib/libcblas.so.3 \
    /opt/conda/lib/libffi.so.7.1.0 \
    /opt/conda/lib/libgcc_s.so.1 \
    /opt/conda/lib/libgfortran.so.5 \
    /opt/conda/lib/liblapack.so.3 \
    /opt/conda/lib/liblzma.so.5.2.5 \
    /opt/conda/lib/libopenblasp-r0.3.12.so \
    /opt/conda/lib/libquadmath.so.0 \
    /opt/conda/lib/libLLVM-10.so \
    /opt/conda/lib/libssl.so.1.1 \
    /opt/conda/lib/libstdc++.so.6 \
    /opt/conda/lib/libtinfo.so.6 \
    /opt/conda/lib/libtinfow.so.6.2\
    /opt/conda/lib/libyaml-0.so.2.0.9 \
    /opt/conda/lib/libz.so.1 \
# ipykernel
    /opt/conda/lib/libzmq.so.5 \
    /opt/conda/lib/libsodium.so.23 \
    /opt/conda/lib/

COPY --from=py \
    /lib/x86_64-linux-gnu/libc.so.6 \
	/lib/x86_64-linux-gnu/libdl.so.2 \
	/lib/x86_64-linux-gnu/libpthread.so.0 \
	/lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/librt.so.1 \
	/lib/x86_64-linux-gnu/

COPY --from=py /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES "compute,utility"
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.0 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441 brand=tesla,driver>=450,driver<451"
ENV CUDA_VERSION 11.0.3
ENV CUDNN_VERSION 8.0.4.30
ENV NCCL_VERSION 2.7.8

ENV PYTHONPATH /opt/conda/lib/python3.7/site-packages
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64:/opt/conda/lib:/usr/local/cuda/compat:/opt/conda/lib/python3.7/lib-dynload:/opt/conda/lib/python3.7/site-packages/rmm/_lib:/opt/conda/lib/python3.7/site-packages/rmm/_gpu:/opt/conda/lib/python3.7/site-packages/llvmlite/binding:$LD_LIBRARY_PATH
ENV LC_ALL C

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://rapids.ai/
LABEL description="The RAPIDS suite of open source software libraries and APIs gives you the ability to execute end-to-end data science and analytics pipelines entirely on GPUs. Licensed under Apache 2.0, RAPIDS is incubated by NVIDIA based on extensive hardware and data science science experience. RAPIDS utilizes NVIDIA CUDA primitives for low-level compute optimization, and exposes GPU parallelism and high-bandwidth memory speed through user-friendly Python interfaces."
LABEL gpu=true
LABEL moduleclass="data"

ENTRYPOINT ["python"]
