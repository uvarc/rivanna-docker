FROM uvarc/mujoco-py:2.1.2.14

USER root
RUN pip install --no-cache-dir matplotlib pandas tensorflow==2.10.0

# python-control
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential gcc gfortran cmake libopenblas-dev && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir slycot control

RUN pip install --no-cache-dir ipykernel tensorrt

RUN ln -s /usr/local/lib/python3.8/site-packages/tensorrt_libs/libnvinfer.so.8 /usr/local/lib/libnvinfer.so.7
RUN ln -s /usr/local/lib/python3.8/site-packages/tensorrt_libs/libnvinfer_plugin.so.8 /usr/local/lib/libnvinfer_plugin.so.7

RUN pip install --no-cache-dir gym[mujoco]

USER 1000

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib/python3.8/site-packages/nvidia/cublas/lib:/usr/local/lib/python3.8/site-packages/nvidia/cudnn/lib:$LD_LIBRARY_PATH

ENTRYPOINT ["python"]
