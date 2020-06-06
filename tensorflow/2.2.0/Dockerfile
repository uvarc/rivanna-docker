FROM tensorflow/tensorflow:2.2.0-gpu-jupyter
LABEL maintainer=rs7wz@virginia.edu

RUN apt-get update && apt-get install -y --no-install-recommends \
        libsm6 libxext6 libxrender1 \
        python3.7 && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/local/bin/python python /usr/bin/python3.6 1 && \
    update-alternatives --install /usr/local/bin/python python /usr/bin/python3.7 2 && \
    update-alternatives --set python /usr/bin/python3.7

RUN pip install --no-cache-dir \
        keras-vis==0.4.1 \
        opencv-python==4.2.0.32 \
        pandas==1.0.4 \
        pydot==1.4.1 \
        scikit-learn==0.22.1 \
        seaborn==0.10.1 \
        tflearn==0.3.2

ENV LC_ALL C

ENTRYPOINT ["python"]
