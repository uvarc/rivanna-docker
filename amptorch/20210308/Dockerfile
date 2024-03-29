FROM continuumio/miniconda3:4.9.2 AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc g++ gfortran \
        git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone https://github.com/ulissigroup/amptorch.git && \
    cd amptorch && \
    conda install -c conda-forge conda-pack && \
    conda env create -f env_gpu.yml && \
    conda install -n amptorch -c conda-forge ipykernel ipywidgets && \
    conda clean -ya

WORKDIR /opt/amptorch
RUN /opt/conda/envs/amptorch/bin/pip install . && \
    /opt/conda/envs/amptorch/bin/pre-commit install

RUN /opt/conda/envs/amptorch/bin/pip install --no-cache-dir git+https://bitbucket.org/andrewpeterson/amp

WORKDIR /amptorch
RUN conda-pack -n amptorch -o /tmp/amptorch.tar && \
    tar xf /tmp/amptorch.tar && rm /tmp/amptorch.tar
    
FROM debian:buster-slim

COPY --from=build /amptorch /amptorch
COPY --from=build /usr/lib/x86_64-linux-gnu/libgfortran.so.5 /usr/lib/x86_64-linux-gnu/libgfortran.so.5

RUN apt-get update && apt-get install -y --no-install-recommends \
        openssh-server \
    && rm -rf /var/lib/apt/lists/*

ENV PATH=/amptorch/bin:$PATH \
    CONDA_PREFIX=/amptorch \
    LC_ALL=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage="https://github.com/ulissigroup/amptorch" \
      description="AMPtorch is a PyTorch implementation of the Atomistic Machine-learning Package (AMP) code that seeks to provide users with improved performance and flexibility as compared to the original code. The implementation does so by benefiting from state-of-the-art machine learning methods and techniques to be optimized in conjunction with high-throughput supercomputers. AMPtorch is built on top of PyTorch Geometric and Skorch." \
      gpu=true \
      moduleclass="chem"

ENTRYPOINT ["python"]
