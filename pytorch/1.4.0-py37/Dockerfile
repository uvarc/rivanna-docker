FROM python:3.7.4-slim-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget zip unzip \
        openslide-tools python3-openslide \
        libsm6 libxext6 libxrender-dev \
        libsndfile1 && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -U pip

RUN pip install --no-cache-dir \
        torch==1.4.0 torchvision==0.5.0 \
        torchaudio==0.4.0 torchtext==0.4.0 botorch==0.2.2 pytorch-ignite==0.3.0 \
        sox \
        numpy==1.17.4 scipy==1.4.1 matplotlib==3.1.3 pandas==1.0.1 \
        livelossplot==0.5.4 \
        pandoc==1.0.2 pillow==7.0.0 protobuf==3.12.1 tensorboard==2.2.1 tornado==6.0.4 tqdm==4.46.0 \
        ipykernel==5.3.0 ipywidgets==7.5.1 \
        pytorch-lightning==0.7.5 \
        scikit-learn==0.22.1 scikit-image==0.16.2 opencv-python==4.2.0.34

ENV PYTHONPATH=$PYTHONPATH:/usr/lib/python3/dist-packages \
    LANG=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://www.pytorch.org \
      description="PyTorch is a deep learning framework that puts Python first. It provides Tensors and Dynamic neural networks in Python with strong GPU acceleration." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["python"]
