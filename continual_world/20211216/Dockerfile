FROM nvidia/cuda:11.0-base-ubuntu18.04 AS lib

FROM uvarc/mujoco-py:2.0.2.5
USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
        git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone https://github.com/awarelab/continual_world.git && \
    cd continual_world && \
    pip install --no-cache-dir .

COPY --from=lib /usr/local/cuda/compat/libcuda.so.1 /usr/local/cuda/compat/libcuda.so.1
USER 1000

ENV LD_LIBRARY_PATH=/usr/local/cuda/compat:$LD_LIBRARY_PATH

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/awarelab/continual_world \
      description="Continual World is a benchmark for continual reinforcement learning. It contains realistic robotic tasks which come from MetaWorld." \
      gpu=true \
      moduleclass=phys

ENTRYPOINT ["python"]
