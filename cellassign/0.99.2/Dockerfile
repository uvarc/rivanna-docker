FROM nvidia/cuda:11.1.1-cudnn8-runtime-ubuntu18.04 AS lib
ARG LIBNVINFER_MAJOR_VERSION=7 \
    CUDA_MAJOR_VERSION=11
ARG LIBNVINFER_VERSION=${LIBNVINFER_MAJOR_VERSION}.2.3-1

RUN apt-get update && apt-get install -y --no-install-recommends \
        libnvinfer${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER_VERSION}+cuda${CUDA_MAJOR_VERSION}.1 \
        libnvinfer-plugin${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER_VERSION}+cuda${CUDA_MAJOR_VERSION}.1 && \
    rm -rf /var/lib/apt/lists/*

FROM rocker/ml:4.0.5-cuda11.1

RUN apt-get update && apt-get install -y --no-install-recommends \
        libglpk40 && \
    rm -rf /var/lib/apt/lists/*

RUN R -e 'BiocManager::install("bluster")'
RUN R -e 'BiocManager::install("scran")'

RUN R -e 'install.packages("tensorflow")'
RUN R -e 'tensorflow::install_tensorflow(version="2.8.0-gpu", extra_packages="tensorflow-probability")'
RUN R -e 'devtools::install_github("Irrationone/cellassign")'

ARG CUDNN_MAJOR_VERSION=8
COPY --from=lib \
    /usr/lib/x86_64-linux-gnu/libcudnn.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_ops_train.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_ops_infer.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_cnn_train.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_cnn_infer.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_adv_train.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_adv_infer.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libnvinfer.so.7 \
    /usr/lib/x86_64-linux-gnu/libnvinfer_plugin.so.7 \
    /usr/lib/x86_64-linux-gnu/

RUN apt-get update && apt-get install -y --no-install-recommends \
        libxt-dev && \
    rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/irrationone/cellassign \
      description="cellassign automatically assigns single-cell RNA-seq data to known cell types across thousands of cells accounting for patient and batch specific effects. Information about a priori known markers cell types is provided as input to the model in the form of a (binary) marker gene by cell-type matrix. cellassign then probabilistically assigns each cell to a cell type, removing subjective biases from typical unsupervised clustering workflows." \
      gpu=true \
      moduleclass="bio"

ENTRYPOINT ["Rscript"]
