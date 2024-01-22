FROM nvcr.io/nvidia/pytorch:23.08-py3

# dependencies for openslide, opencv, poppler
RUN apt-get update && apt-get install -y --no-install-recommends \
        openslide-tools \
        libgl1 libsm6 libxext6 libxrender1 libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev \
        libpoppler-cpp-dev && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
        seaborn==0.12.2 \
        scikit-image==0.21.0 \
        openslide-python==1.3.0 \
        opencv-python==4.8.0.76 \
        sox ipywidgets pyqt5-tools
        
# pytorch-lightning: need bleeding edge for compatibility with torchtext
RUN pip install --no-cache-dir https://github.com/PyTorchLightning/pytorch-lightning/archive/master.zip

# RIV-9432: PyG
RUN pip install --no-cache-dir \
        torch-geometric==2.3.1 \
        python-poppler==0.4.1

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://www.pytorch.org \
      description="PyTorch is a deep learning framework that puts Python first. It provides Tensors and Dynamic neural networks in Python with strong GPU acceleration." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["/opt/nvidia/nvidia_entrypoint.sh", "python"]
