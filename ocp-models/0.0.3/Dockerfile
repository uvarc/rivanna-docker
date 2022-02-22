ARG DIR=/ocp-models

FROM mambaorg/micromamba:0.15.3 AS build
ARG DIR

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc g++ gfortran \
        git wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN micromamba create -p $DIR -c pytorch -c conda-forge \
        python=3.8 \
        ase=3.21 \
        matplotlib=3.3 \
        pre-commit=2.10 \
        tqdm=4.58 \
        h5py=2.10.0 \
        pymatgen=2020.12.31 \
        pyyaml=5.4 \
        tensorboard=2.5.* \
        tqdm=4.58.* \
        sphinx \
        nbsphinx \
        pandoc \
        black \
        numba \
        ipykernel && \
    micromamba clean -ya

ENV PATH=$DIR/bin:$PATH

RUN pip install --no-cache-dir \
        -f https://download.pytorch.org/whl/torch_stable.html \
        torch==1.9.0+cu111 \
        torchvision==0.10.0+cu111 \
        torchaudio==0.9.0

RUN pip install --no-cache-dir \
        -f https://pytorch-geometric.com/whl/torch-1.9.0+cu111.html \
        torch-cluster \
        torch-scatter==2.0.7 \
        torch-sparse==0.6.10 \
        torch-spline-conv

RUN pip install --no-cache-dir setuptools==57.5.0 && \
    pip install --no-cache-dir \
        demjson==2.2.4 lmdb==1.1.1 wandb==0.11.2 \
        torch-geometric

WORKDIR /opt
RUN wget https://github.com/Open-Catalyst-Project/ocp/archive/refs/tags/v0.0.3.tar.gz && \
    tar xf v0.0.3.tar.gz && rm v0.0.3.tar.gz

RUN cd ocp-0.0.3 && pip install --no-cache-dir .

FROM nvidia/cuda:11.1.1-devel AS lib

FROM debian:bullseye-slim
ARG DIR
ARG SRC=/opt/ocp-0.0.3 \
    DEST=/opt/ocp

COPY --from=build $DIR $DIR

# need wget to download data separately
RUN apt-get update && apt-get install -y --no-install-recommends \
        git wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build $SRC/licenses   $DEST/licenses
COPY --from=build $SRC/scripts    $DEST/scripts
COPY --from=build $SRC/LICENSE.md $DEST/LICENSE.md

ENV PATH=$DIR/bin:$PATH \
    PYTHONPATH=$DIR/lib/python3.8/site-packages \
    FONTCONFIG_PATH=$DIR/etc/fonts \
    FONTCONFIG_FILE=$DIR/etc/fonts/fonts.conf \
    LC_ALL=C.UTF-8

# missing dependencies, functions, libraries
RUN pip install --no-cache-dir ray
COPY --from=build $SRC/ocpmodels/models/gemnet /ocp-models/lib/python3.8/site-packages/ocpmodels/models/gemnet
COPY --from=build $SRC/ocpmodels/models/utils  /ocp-models/lib/python3.8/site-packages/ocpmodels/models/utils
COPY --from=lib /usr/local/cuda/lib64/libcusparse.so.11 /usr/local/cuda/lib64/libcusparse.so.11
COPY --from=lib /usr/local/cuda/lib64/libcudart.so.11.0 /usr/local/cuda/lib64/libcudart.so.11.0

ENV LD_LIBRARY_PATH=$DIR/lib:$DIR/lib/python3.8/site-packages/torch:/usr/local/cuda/lib64:$LD_LIBRARY_PATH

LABEL maintainer=rs7wz@virginia.edu \
      homepage="https://github.com/Open-Catalyst-Project/ocp" \
      description="ocp-models is the modeling codebase for the Open Catalyst Project. It provides implementations of state-of-the-art ML algorithms for catalysis that take arbitrary chemical structures as input to predict energy / forces / positions" \
      gpu=true \
      moduleclass="chem"

ENTRYPOINT ["python"]
