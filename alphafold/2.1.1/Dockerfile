# Copyright 2021 DeepMind Technologies Limited
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#----------
#
# Copyright (c) 2021 The Rector and Visitors of the University of Virginia
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without
# limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
# Software, and to permit persons to whom the Software is furnished to do so, subject to the following
# conditions:
# 
# The above copyright notice and this permission notice shall be included in all copies or substantial portions 
# of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
# TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
# CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
# 2021-11-11
# Modified from DeepMind's Dockerfile_old by Ruoshi Sun, UVA Research Computing
#
# Summary of changes:
#   [Official] -> [Current]
#   - Two sets of CUDA libraries in system and conda env -> Only use conda env
#   - Cuda base image with miniconda installation -> Micromamba base image during build stage
#   - Single stage -> Three stages
# The resulting image is about 3 GB smaller.

ARG VERSION=2.1.1
ARG CUDA=11.0
ARG CUDNN=8.0
ARG CONDADIR=/opt/alphafoldenv

FROM mambaorg/micromamba AS build
ARG VERSION
ARG CUDA
ARG CUDNN
ARG CONDADIR

# Use bash to support string substitution.
SHELL ["/bin/bash", "-c"]
USER root

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      tzdata \
      build-essential cmake \
      git wget \
      hmmer kalign \
    && rm -rf /var/lib/apt/lists/*

# Compile HHsuite from source.
RUN git clone --branch v3.3.0 https://github.com/soedinglab/hh-suite.git /tmp/hh-suite
WORKDIR /tmp/hh-suite/build
RUN cmake -DCMAKE_INSTALL_PREFIX=/opt/hhsuite .. \
    && make -j 4 && make install \
    && ln -s /opt/hhsuite/bin/* /usr/bin \
    && rm -rf /tmp/hh-suite

# Install conda packages.
RUN micromamba create -p $CONDADIR -c conda-forge \
      python=3.8 \
      openmm=7.5.1 \
      cudatoolkit=${CUDA}.3 \
      cudnn=${CUDNN} \
      pdbfixer \
      pip \
    && micromamba clean -ya

WORKDIR /app
RUN wget -q https://github.com/deepmind/alphafold/archive/refs/tags/v$VERSION.tar.gz && \
    tar xf v$VERSION.tar.gz && \
    rm v$VERSION.tar.gz && \
    mv alphafold-$VERSION alphafold

RUN wget -q -P /app/alphafold/alphafold/common/ \
  https://git.scicore.unibas.ch/schwede/openstructure/-/raw/7102c63615b64735c4941278d92b554ec94415f8/modules/mol/alg/src/stereo_chemical_props.txt

# Install pip packages.
RUN $CONDADIR/bin/pip install --upgrade --no-cache-dir pip \
    && $CONDADIR/bin/pip install --no-cache-dir -r /app/alphafold/requirements.txt
RUN $CONDADIR/bin/pip install --upgrade --no-cache-dir jax jaxlib==0.1.69+cuda${CUDA/./} -f https://storage.googleapis.com/jax-releases/jax_releases.html

# Apply OpenMM patch.
WORKDIR $CONDADIR/lib/python3.8/site-packages
RUN patch -p0 < /app/alphafold/docker/openmm.patch

FROM nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04 AS lib

FROM debian:bullseye-slim
ARG CONDADIR
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y --no-install-recommends \
      hmmer \
      kalign \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /app /app
COPY --from=build $CONDADIR $CONDADIR
COPY --from=build /opt/hhsuite /opt/hhsuite

# needed by jax
COPY --from=lib /usr/local/cuda/bin/ptxas /usr/bin/ptxas

# hhsuite executable path hardcoded as /usr/bin in run_alphafold.py
RUN ln -s /opt/hhsuite/bin/* /usr/bin

# We need to run `ldconfig` first to ensure GPUs are visible, due to some quirk
# with Debian. See https://github.com/NVIDIA/nvidia-docker/issues/1399 for
# details.
# ENTRYPOINT does not support easily running multiple commands, so instead we
# write a shell script to wrap them up.

WORKDIR /app/alphafold
RUN echo $'#!/bin/bash\n\
ldconfig\n\
python /app/alphafold/run_alphafold.py "$@"' > /app/run_alphafold.sh \
  && chmod +x /app/run_alphafold.sh

ENV PATH=$CONDADIR/bin:$PATH \
    PYTHONPATH=$CONDADIR/lib/python3.8/site-packages \
    LC_ALL=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/deepmind/alphafold \
      description="Open source code for AlphaFold" \
      gpu=true \
      moduleclass=bio

ENTRYPOINT ["/app/run_alphafold.sh"]
