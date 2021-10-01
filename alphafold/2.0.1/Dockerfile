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

# modified Ruoshi Sun
# 2021-09-30

ARG CUDA=11.0
FROM nvidia/cuda:${CUDA}-base AS build
ARG CUDA

# Use bash to support string substitution.
SHELL ["/bin/bash", "-c"]

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      cuda-command-line-tools-${CUDA/./-} \
      git \
      hmmer \
      kalign \
      tzdata \
      wget \
    && rm -rf /var/lib/apt/lists/*

# Compile HHsuite from source.
RUN git clone --branch v3.3.0 https://github.com/soedinglab/hh-suite.git /tmp/hh-suite
WORKDIR /tmp/hh-suite/build
RUN cmake -DCMAKE_INSTALL_PREFIX=/opt/hhsuite .. \
    && make -j 4 && make install \
    && ln -s /opt/hhsuite/bin/* /usr/bin \
    && rm -rf /tmp/hh-suite

# Install Miniconda package manger.
RUN wget -q -P /tmp https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm /tmp/Miniconda3-latest-Linux-x86_64.sh

# Install conda packages.
ENV PATH="/opt/conda/bin:$PATH"
RUN /opt/conda/bin/conda create -y -p /opt/alphafoldenv -c conda-forge \
      python=3.8 \
      openmm=7.5.1 \
      cudatoolkit==${CUDA}.3 \
      pdbfixer \
      pip \
    && /opt/conda/bin/conda clean -ya

WORKDIR /app
RUN wget -q https://github.com/deepmind/alphafold/archive/refs/tags/v2.0.1.tar.gz && \
    tar xf v2.0.1.tar.gz && \
    rm v2.0.1.tar.gz && \
    mv alphafold-2.0.1 alphafold
#git clone https://github.com/deepmind/alphafold.git

RUN wget -q -P /app/alphafold/alphafold/common/ \
  https://git.scicore.unibas.ch/schwede/openstructure/-/raw/7102c63615b64735c4941278d92b554ec94415f8/modules/mol/alg/src/stereo_chemical_props.txt

# Install pip packages.
RUN /opt/alphafoldenv/bin/pip install --upgrade --no-cache-dir pip \
    && /opt/alphafoldenv/bin/pip install --no-cache-dir -r /app/alphafold/requirements.txt
RUN /opt/alphafoldenv/bin/pip install --upgrade --no-cache-dir jax jaxlib==0.1.69+cuda${CUDA/./} -f https://storage.googleapis.com/jax-releases/jax_releases.html

# Apply OpenMM patch.
WORKDIR /opt/alphafoldenv/lib/python3.8/site-packages
RUN patch -p0 < /app/alphafold/docker/openmm.patch

FROM nvidia/cuda:${CUDA}-base
ARG CUDA

SHELL ["/bin/bash", "-c"]

# add cudnn and cusolver
RUN apt-get update && apt-get install -y --no-install-recommends \
      libcudnn8 libcusolver-11-0 \
      cuda-command-line-tools-${CUDA/./-} \
      hmmer \
      kalign \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /app /app
COPY --from=build /opt/alphafoldenv /opt/alphafoldenv
COPY --from=build /opt/hhsuite /opt/hhsuite

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

ENV PATH=/opt/alphafoldenv/bin:$PATH \
    PYTHONPATH=/opt/alphafoldnev/lib/python3.8/site-packages \
    LC_ALL=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/deepmind/alphafold \
      description="Open source code for AlphaFold" \
      gpu=true \
      moduleclass=bio

ENTRYPOINT ["/app/run_alphafold.sh"]
