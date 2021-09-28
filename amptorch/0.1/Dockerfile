FROM mambaorg/micromamba:0.15.3 AS build
USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc g++ gfortran \
        git wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# amptorch 0.1 commit 173b96
# https://github.com/ulissigroup/amptorch/blob/173b966fb28feac149cb189d5304ffe83c17f2c3/env_cpu.yml
RUN micromamba create -p /amptorch -c conda-forge -c pytorch \
        python=3.7 \
        ase=3.21 \
        matplotlib=3.3 \
        pre-commit=2.2 \
        pytorch=1.6.0 \
        numpy=1.18.5 \
        tqdm=4.45 \
        h5py=2.10.0 \
        cpuonly \
        dask \
        ipykernel ipywidgets && \
    micromamba clean -ya

RUN /amptorch/bin/pip install --no-cache-dir \
        git+https://github.com/ulissigroup/amptorch.git@173b966fb28feac149cb189d5304ffe83c17f2c3 \
        pytest \
        cffi wandb \
        skorch==0.9.* \
        torch-geometric

RUN /amptorch/bin/pip install --no-cache-dir \
        -f https://pytorch-geometric.com/whl/torch-1.6.0+cpu.html \
        torch-cluster \
        torch-scatter==2.0.7 \
        torch-sparse==0.6.10 \
        torch-spline-conv

RUN /amptorch/bin/pip install --no-cache-dir \
        tensorflow==1.15.5 \
        git+https://github.com/mshuaibii/SIMPLE-NN.git

RUN /amptorch/bin/pip install --no-cache-dir \
        git+https://github.com/kirstenwinther/Protosearch.git@swarm_opt
    
WORKDIR /opt
RUN git clone https://github.com/kirstenwinther/Protosearch.git && \
    cd Protosearch && \
    git checkout swarm_opt && \
    /amptorch/bin/pip install --no-cache-dir -r requirements.txt

RUN /amptorch/bin/pip install --no-cache-dir git+https://github.com/ulissigroup/al_mlp

FROM debian:buster-slim
# SUP-1626: import _tkinter
RUN apt-get update && apt-get install -y --no-install-recommends \
        libx11-6 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /amptorch /amptorch

ARG SRC=/opt/Protosearch/protosearch \
    DEST=/amptorch/lib/python3.7/site-packages/protosearch
COPY --from=build $SRC/active_learning $DEST/active_learning
COPY --from=build $SRC/build_bulk $DEST/build_bulk
COPY --from=build $SRC/calculate $DEST/calculate
COPY --from=build $SRC/enumeration $DEST/enumeration
COPY --from=build $SRC/examples $DEST/examples
COPY --from=build $SRC/ml_modelling $DEST/ml_modelling
COPY --from=build $SRC/oqmd $DEST/oqmd

RUN sed -i '306s/\* n_parameters//' /amptorch/lib/python3.7/site-packages/protosearch/build_bulk/cell_parameters.py

ENV CONDA_PREFIX=/amptorch
ENV PATH=$CONDA_PREFIX/bin:$PATH \
    PYTHONPATH=/amptorch/lib/python3.7/site-packages \
    FONTCONFIG_PATH=$CONDA_PREFIX/etc/fonts \
    FONTCONFIG_FILE=$CONDA_PREFIX/etc/fonts/fonts.conf \
    LC_ALL=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage="https://github.com/ulissigroup/amptorch" \
      description="AMPtorch is a PyTorch implementation of the Atomistic Machine-learning Package (AMP) code that seeks to provide users with improved performance and flexibility as compared to the original code. The implementation does so by benefiting from state-of-the-art machine learning methods and techniques to be optimized in conjunction with high-throughput supercomputers. AMPtorch is built on top of PyTorch Geometric and Skorch." \
      gpu=false \
      moduleclass="chem"

ENTRYPOINT ["python"]
