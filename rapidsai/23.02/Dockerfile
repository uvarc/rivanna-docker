ARG VERSION=23.02
ARG CUDA_VERSION=11.4
ARG PYTHON_VERSION=3.10

FROM mambaorg/micromamba:1.4.1 AS py
ARG VERSION
ARG CUDA_VERSION
ARG PYTHON_VERSION

USER root
RUN micromamba create -p /rapids -c rapidsai -c nvidia -c conda-forge \
        rapids=${VERSION} python=${PYTHON_VERSION} cudatoolkit=${CUDA_VERSION} \
        ipykernel && \
    micromamba clean -ya

FROM debian:bullseye-slim
COPY --from=py /rapids /rapids

RUN apt-get update && apt-get install -y --no-install-recommends \
        libnuma1 && \
    rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

ENV PATH=/rapids/bin:$PATH \
    CONDA_PREFIX=/rapids \
    LC_ALL=C

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://rapids.ai/
LABEL description="The RAPIDS suite of open source software libraries and APIs gives you the ability to execute end-to-end data science and analytics pipelines entirely on GPUs. Licensed under Apache 2.0, RAPIDS is incubated by NVIDIA based on extensive hardware and data science science experience. RAPIDS utilizes NVIDIA CUDA primitives for low-level compute optimization, and exposes GPU parallelism and high-bandwidth memory speed through user-friendly Python interfaces."
LABEL gpu=true
LABEL moduleclass="data"

ENTRYPOINT ["python"]
