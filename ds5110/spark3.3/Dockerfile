# RIV-10494
# Need TF 1.x which only works with Python 3.7- (see RIV-6193)

FROM mambaorg/micromamba:1.3.0
USER root

ARG JAVA_VERSION=11

RUN mkdir -p /usr/share/man/man1 && \
    apt-get update && apt-get install -y --no-install-recommends \
# "base" https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile
        wget ca-certificates unzip \
        locales fonts-liberation \
# "minimal" https://github.com/jupyter/docker-stacks/blob/master/minimal-notebook/Dockerfile
        build-essential git \
        libsm6 libxext-dev libxrender1 \
        lmodern netcat \
# for nbconvert
        texlive-xetex texlive-fonts-recommended texlive-plain-generic \
# "scipy" https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile
        ffmpeg dvipng cm-super \
# "pyspark" https://github.com/jupyter/docker-stacks/blob/master/pyspark-notebook/Dockerfile
        openjdk-${JAVA_VERSION}-jre-headless ca-certificates-java \
    && rm -rf /var/lib/apt/lists/*

USER $MAMBA_USER

COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
RUN micromamba install -n base -f /tmp/env.yaml && micromamba clean -ya

WORKDIR $HOME

ENV PATH=/opt/conda/bin:$PATH \
    LD_LIBRARY_PATH=/opt/conda/lib:$LD_LIBRARY_PATH \
    PYTHONPATH=/opt/conda/lib/python3.7/site-packages \
    LC_ALL=C.UTF-8 \
    NUMBA_CACHE_DIR=/tmp

ARG MAMBA_DOCKERFILE_ACTIVATE=1
LABEL maintainer=rs7wz@virginia.edu
