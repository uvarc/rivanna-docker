FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc g++ openslide-tools \
        libsm6 libxext6 libxrender-dev && \
    rm -rf /var/lib/apt/lists/*

RUN conda install -c conda-forge \
        sox jupyter ipykernel ipywidgets \
        scipy==1.5.2 matplotlib==3.3.0 pandas==1.1.0 seaborn==0.10.1 \
        pytorch-lightning==0.8.5 scikit-learn==0.23.1 scikit-image==0.17.2 && \
    conda install -c pytorch -c gpytorch \
        torchaudio==0.6.0 torchtext==0.7.0 botorch==0.3.0 ignite==0.4.1 && \
    conda clean --all

# downgrade setuptools; otherwise
# ImportError: cannot import name 'Feature' from 'setuptools'
RUN pip install --no-cache-dir setuptools==45.3.0 && \
    pip install --no-cache-dir \
        openslide-python==1.1.1 opencv-python==4.3.0.36

ENV LC_ALL C

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://www.pytorch.org
LABEL description="PyTorch is a deep learning framework that puts Python first. It provides Tensors and Dynamic neural networks in Python with strong GPU acceleration."
LABEL gpu=true
LABEL moduleclass=data

ENTRYPOINT ["python"]
