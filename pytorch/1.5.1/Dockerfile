FROM pytorch/pytorch:1.5.1-cuda10.1-cudnn7-devel AS build
WORKDIR /opt
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget g++ git && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/NVIDIA/apex && \
    cd apex && \
# 2020-07-09
    git reset --hard a0d99fdb2cfcc418809dde975f51097c3d6010ca && \
    pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./

FROM pytorch/pytorch:1.5.1-cuda10.1-cudnn7-runtime
COPY --from=build /opt/conda/lib/python3.7/site-packages/apex /opt/conda/lib/python3.7/site-packages/apex

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget zip unzip \
        gcc g++ openslide-tools \
        libsm6 libxext6 libxrender-dev && \
    rm -rf /var/lib/apt/lists/*

RUN conda install -c conda-forge mamba && \
    mamba install -c pytorch -c gpytorch -c conda-forge \
        pytorch==1.5.1 torchvision==0.6.1 \
        torchaudio==0.5.1 torchtext==0.6.0 botorch==0.2.5 ignite==0.3.0 \
        sox ipykernel ipywidgets \
        scipy==1.4.1 matplotlib==3.1.3 pandas==1.0.4 seaborn==0.10.1 \
        pytorch-lightning==0.7.6 scikit-learn==0.23.1 scikit-image==0.17.2 && \
    conda clean -ya

# downgrade setuptools; otherwise
# ImportError: cannot import name 'Feature' from 'setuptools'
RUN pip install --no-cache-dir setuptools==45.3.0 && \
    pip install --no-cache-dir \
        openslide-python==1.1.1 opencv-python==4.2.0.34 livelossplot==0.5.4

ENV LC_ALL C

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://www.pytorch.org
LABEL description="PyTorch is a deep learning framework that puts Python first. It provides Tensors and Dynamic neural networks in Python with strong GPU acceleration."
LABEL gpu=true
LABEL moduleclass=data

ENTRYPOINT ["python"]
