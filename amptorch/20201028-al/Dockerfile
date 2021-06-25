FROM continuumio/miniconda3:4.9.2 AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc g++ gfortran \
        git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN conda install -c conda-forge conda-pack && \
    conda create -n amptorch -c conda-forge -c pytorch \
        python=3.6 \
        cudatoolkit=10.2 \
        pytorch=1.6.0 \
        ase=3.21 \
        numpy=1.18.5 \
        matplotlib=2.2.5 \
        tqdm=4.45 \
        h5py=2.10.0 \
        ipykernel ipywidgets && \
    conda clean -ya

RUN /opt/conda/envs/amptorch/bin/pip install --no-cache-dir \
        git+https://github.com/ulissigroup/amptorch.git@active_learning \
        amp-atomistics && \
    /opt/conda/envs/amptorch/bin/pip install --no-cache-dir \
        -f https://pytorch-geometric.com/whl/torch-1.6.0+cu102.html \
        torch-scatter \
        torch-sparse

RUN /opt/conda/envs/amptorch/bin/pip install --no-cache-dir \
        tensorflow==1.15.5 \
        git+https://github.com/mshuaibii/SIMPLE-NN.git

WORKDIR /amptorch
RUN conda-pack -n amptorch -o /tmp/amptorch.tar && \
    tar xf /tmp/amptorch.tar && rm /tmp/amptorch.tar
    
FROM debian:buster-slim
COPY --from=build /amptorch /amptorch

ENV PATH=/amptorch/bin:$PATH \
    CONDA_PREFIX=/amptorch \
    LC_ALL=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage="https://github.com/ulissigroup/amptorch" \
      description="AMPtorch is a PyTorch implementation of the Atomistic Machine-learning Package (AMP) code that seeks to provide users with improved performance and flexibility as compared to the original code. The implementation does so by benefiting from state-of-the-art machine learning methods and techniques to be optimized in conjunction with high-throughput supercomputers. AMPtorch is built on top of PyTorch Geometric and Skorch." \
      gpu=true \
      moduleclass="chem"

ENTRYPOINT ["python"]
