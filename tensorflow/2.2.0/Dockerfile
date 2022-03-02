FROM tensorflow/tensorflow:2.2.0-gpu-jupyter
LABEL maintainer=rs7wz@virginia.edu

RUN pip install --no-cache-dir --upgrade \
        pip setuptools && \
    pip install --no-cache-dir \
        numpy==1.18.4 tensorflow-federated==0.14.0 \
        jupyter_http_over_ws ipykernel==5.1.1 nbformat==4.4.0 \
        matplotlib==3.2.1 \
        jupyter==1.0.0 \
        keras-vis==0.4.1 \
        opencv-python==4.2.0.32 \
        pandas==1.0.4 \
        pydot==1.4.1 \
        scikit-learn==0.23.1 \
        seaborn==0.10.1 \
        tflearn==0.3.2

RUN apt-get update && apt-get install -y --no-install-recommends \
        libgl1 libsm6 libxext6 libxrender1 libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["python"]
