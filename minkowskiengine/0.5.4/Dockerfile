FROM nvidia/cuda:10.2-devel-ubuntu18.04 AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
        lsof wget ca-certificates \
        g++-7 && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-py38_4.9.2-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

ENV PATH=/opt/conda/bin:$PATH \
    LANG=C.UTF-8 \
    CXX=g++-7

RUN conda install -c conda-forge conda-pack && \
    conda create -n mink -c pytorch-lts -c conda-forge -c anaconda \
        python=3.8 \
        openblas-devel \
        pytorch torchvision cudatoolkit=10.2 && \
    conda clean -ya

RUN apt-get update && apt-get install -y --no-install-recommends \
        git && \
    rm -rf /var/lib/apt/lists/*

ENV TORCH_CUDA_ARCH_LIST="3.5 5.2 6.0 6.1 7.0+PTX"
RUN /opt/conda/envs/mink/bin/pip install --no-deps --no-cache -U git+https://github.com/NVIDIA/MinkowskiEngine -v \
                --install-option="--blas_include_dirs=/opt/conda/envs/mink/include" \
                --install-option="--blas=openblas" \
                --install-option="--force_cuda" \
                --install-option="--cuda_home=/usr/local/cuda"

WORKDIR /mink
RUN conda-pack -n mink -o /tmp/mink.tar && \
    tar xf /tmp/mink.tar && rm /tmp/mink.tar

RUN /mink/bin/conda-unpack

FROM debian:buster-slim

ENV CONDA_PREFIX=/mink
ENV PATH=$CONDA_PREFIX/bin:$PATH \
    LANG=C.UTF-8

COPY --from=build $CONDA_PREFIX $CONDA_PREFIX

SHELL ["/bin/bash", "-c"]
RUN source /$CONDA_PREFIX/bin/activate

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/NVIDIA/MinkowskiEngine \
      description="The Minkowski Engine is an auto-differentiation library for sparse tensors. It supports all standard neural network layers such as convolution, pooling, unpooling, and broadcasting operations for sparse tensors." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["python"]
