ARG VERSION=0.17
ARG CUDA_VERSION=11.0
ARG PYTHON_VERSION=3.7

FROM continuumio/miniconda3:4.9.2 AS py
ARG VERSION
ARG CUDA_VERSION
ARG PYTHON_VERSION

RUN conda create -n rapids -c rapidsai -c nvidia -c conda-forge -c defaults \
        rapids-blazing=${VERSION} cudatoolkit=${CUDA_VERSION} python=${PYTHON_VERSION} \
        ipykernel && \
    conda clean -ya

RUN conda install -c conda-forge conda-pack && \
    conda clean -ya

WORKDIR /rapids
RUN conda-pack -n rapids -o /tmp/rapids.tar && \
    tar xf /tmp/rapids.tar && rm /tmp/rapids.tar

RUN /rapids/bin/conda-unpack

FROM nvidia/cuda:${CUDA_VERSION}-cudnn8-devel-ubuntu18.04 AS lib

FROM debian:buster-slim

COPY --from=lib /usr/local/cuda/compat /usr/local/cuda/compat

COPY --from=py /rapids /rapids

SHELL ["/bin/bash", "-c"]
RUN source /rapids/bin/activate

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES="compute,utility" \
    NVIDIA_REQUIRE_CUDA="cuda>=11.0 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441 brand=tesla,driver>=450,driver<451" \
    CUDA_VERSION=11.0.3 \
    CUDNN_VERSION=8.0.4.30 \
    NCCL_VERSION=2.7.8 \
    PATH=/rapids/bin:$PATH \
    LD_LIBRARY_PATH=/usr/local/cuda/compat:$LD_LIBRARY_PATH \
    CONDA_PREFIX=/rapids \
    LC_ALL=C

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://rapids.ai/
LABEL description="The RAPIDS suite of open source software libraries and APIs gives you the ability to execute end-to-end data science and analytics pipelines entirely on GPUs. Licensed under Apache 2.0, RAPIDS is incubated by NVIDIA based on extensive hardware and data science science experience. RAPIDS utilizes NVIDIA CUDA primitives for low-level compute optimization, and exposes GPU parallelism and high-bandwidth memory speed through user-friendly Python interfaces."
LABEL gpu=true
LABEL moduleclass="data"

ENTRYPOINT ["python"]
