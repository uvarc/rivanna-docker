# SUP-2215
# Using commit 3deaec5 on Mar 31, 2019

FROM tensorflow/tensorflow:1.8.0-gpu-py3
RUN apt-get update && apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

RUN pip install -U pip
RUN pip install --no-cache-dir \
        cython scikit-image keras==2.1.6 opencv-python imgaug

WORKDIR /opt
RUN git clone https://github.com/matterport/Mask_RCNN.git && \
    cd Mask_RCNN && \
    python setup.py install

RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1

ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64/stubs:$LD_LIBRARY_PATH

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["python"]
