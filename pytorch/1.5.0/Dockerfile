FROM pytorch/pytorch:1.5-cuda10.1-cudnn7-runtime
LABEL maintainer=rs7wz@virginia.edu

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc openslide-tools \
        libsm6 libxext6 libxrender-dev && \
    rm -rf /var/lib/apt/lists/*

RUN conda install -c conda-forge \
        sox jupyter ipykernel ipywidgets \
        scipy==1.4.1 matplotlib==3.1.3 pandas==1.0.4 seaborn==0.10.1 \
        pytorch-lightning==0.7.6 scikit-learn==0.23.1 scikit-image==0.17.2 && \
    conda install -c pytorch -c gpytorch \
        torchaudio==0.5.0 torchtext==0.6.0 botorch==0.2.5 ignite==0.3.0 && \
    conda clean --all

RUN pip install --no-cache-dir \
        openslide-python==1.1.1 opencv-python==4.2.0.34

ENV LC_ALL C

ENTRYPOINT ["python"]
