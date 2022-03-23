ARG VERSION=2.7.0
ARG CUDA_MAJOR_VERSION=11
ARG CUDA_MINOR_VERSION=2
ARG CUDA_VERSION=${CUDA_MAJOR_VERSION}.${CUDA_MINOR_VERSION}
ARG CUDNN_MAJOR_VERSION=8
ARG NVINFER_MAJOR_VERSION=7
ARG NVINFER_VERSION=${NVINFER_MAJOR_VERSION}.2.3-1

FROM nvidia/cuda:${CUDA_VERSION}.2-cudnn${CUDNN_MAJOR_VERSION}-devel-ubuntu18.04 AS lib
ARG CUDA_MAJOR_VERSION
ARG NVINFER_MAJOR_VERSION
ARG NVINFER_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends \
        libnvinfer${NVINFER_MAJOR_VERSION}=${NVINFER_VERSION}+cuda${CUDA_MAJOR_VERSION}.1 \
        libnvinfer-plugin${NVINFER_MAJOR_VERSION}=${NVINFER_VERSION}+cuda${CUDA_MAJOR_VERSION}.1 && \
    rm -rf /var/lib/apt/lists/*

FROM python:3.9-slim-bullseye
ARG VERSION
ARG CUDA_MAJOR_VERSION
ARG CUDA_VERSION
ARG CUDNN_MAJOR_VERSION
ARG NVINFER_MAJOR_VERSION
ARG NVINFER_VERSION

# CUDA libraries
COPY --from=lib /usr/local/cuda/compat /usr/local/cuda/compat
COPY --from=lib /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1
COPY --from=lib \
    /usr/local/cuda/lib64/libcublas.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcublasLt.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcudart.so.${CUDA_MAJOR_VERSION}.0 \
    /usr/local/cuda/lib64/libcufft.so.10 \
    /usr/local/cuda/lib64/libcufftw.so.10 \
    /usr/local/cuda/lib64/libcuinj64.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/libcupti.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/libcurand.so.10 \
    /usr/local/cuda/lib64/libcusolver.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcusolverMg.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libcusparse.so.$CUDA_MAJOR_VERSION \
    /usr/local/cuda/lib64/libnvperf_*.so \
    /usr/local/cuda/lib64/libnvrtc-builtins.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/libnvrtc.so.$CUDA_VERSION \
    /usr/local/cuda/lib64/
COPY --from=lib \
    /usr/lib/x86_64-linux-gnu/libcudnn.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_adv_infer.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_adv_train.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_cnn_infer.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_cnn_train.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_ops_infer.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libcudnn_ops_train.so.$CUDNN_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libnvinfer.so.$NVINFER_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/libnvinfer_plugin.so.$NVINFER_MAJOR_VERSION \
    /usr/lib/x86_64-linux-gnu/

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
        tensorflow==$VERSION \
        numpy==1.21.4 \
        scipy==1.7.3 \
        keras==2.7.0 \
        xgboost==1.5.1 \
        matplotlib==3.5.0 \
        seaborn==0.11.2 \
        pandas==1.3.4 \
        scikit-learn==1.0.1 \
        category-encoders==2.3.0 \
        shap==0.40.0 \
        spacy==3.2.1 \
        tqdm==4.62.3 \
        textblob==0.17.1 \
        NRCLex==3.0.0 \
        gensim==4.1.2 \
        ipykernel

RUN pip install --no-cache-dir dill==0.3.4

RUN apt-get update && apt-get install -y --no-install-recommends \
        graphviz && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir dtreeviz==1.3.2

# 2022-03-23
RUN pip install --no-cache-dir ipywidgets

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/cuda/lib64:$LD_LIBRARY_PATH \
    LC_ALL=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://www.tensorflow.org \
      description="TensorFlow is an open-source software library for Machine Intelligence." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["python"]
