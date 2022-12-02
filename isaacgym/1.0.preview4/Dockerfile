FROM python:3.8-slim-buster AS py
ARG VERSION=1.12.0

RUN pip install --no-cache-dir -U pip numpy==1.20.1 scipy==1.6.1 && \
    pip install --no-cache-dir \
        torch==${VERSION}+cu113 torchvision==0.13.0+cu113 torchaudio==0.12.0 --extra-index-url https://download.pytorch.org/whl/cu113

WORKDIR /opt/isaacgym
ADD isaacgym-src/ .

RUN cd python && pip install --no-cache-dir .

FROM nvidia/cuda:11.3.1-devel-ubuntu20.04 AS lib

# build horovod
FROM python:3.8-slim-buster AS horovod
COPY --from=py /usr/local /usr/local
COPY --from=lib /usr/local/cuda /usr/local/cuda

ENV PATH=/usr/local/cuda/bin:$PATH \
    CPATH=/usr/local/cuda/include:$CPATH \
    CUDA_HOME=/usr/local/cuda

RUN apt-get update && apt-get install -y --no-install-recommends \
        libgomp1 g++ make cmake && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
        tensorflow==2.8.0 horovod

FROM python:3.8-slim-buster
COPY --from=horovod /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages
COPY --from=py /opt/isaacgym/python /opt/isaacgym/python
COPY --from=py /opt/isaacgym/docker/nvidia_icd.json /usr/share/vulkan/icd.d/nvidia_icd.json
COPY --from=py /opt/isaacgym/docker/10_nvidia.json /usr/share/glvnd/egl_vendor.d/10_nvidia.json
COPY --from=lib \
    /usr/local/cuda/targets/x86_64-linux/lib/libcublas.so.11 \
    /usr/local/cuda/targets/x86_64-linux/lib/libcublasLt.so.11 \
    /usr/local/cuda/targets/x86_64-linux/lib/libcudart.so.11.0  \
    /usr/local/cuda/targets/x86_64-linux/lib/libcufft.so.10 \
    /usr/local/cuda/targets/x86_64-linux/lib/libcurand.so.10 \
    /usr/local/cuda/targets/x86_64-linux/lib/libcusolver.so.11 \
    /usr/local/cuda/targets/x86_64-linux/lib/libcusolverMg.so.11 \
    /usr/local/cuda/targets/x86_64-linux/lib/libcusparse.so.11 \
    /usr/local/cuda/targets/x86_64-linux/lib/

COPY --from=lib /usr/local/cuda/bin/nvcc /usr/local/cuda/bin/nvcc
COPY --from=lib /usr/local/cuda/include /usr/local/cuda/include

RUN apt-get update && apt-get install -y --no-install-recommends \
        libxcursor-dev \
        libxrandr-dev \
        libxinerama-dev \
        libxi-dev \
        mesa-common-dev \
        vulkan-utils \
        mesa-vulkan-drivers \
        pigz \
        libegl1 && \
    rm -rf /var/lib/apt/lists/* && \
    rm /usr/lib/x86_64-linux-gnu/libEGL_mesa.so.0 \
       /usr/lib/x86_64-linux-gnu/libEGL_mesa.so.0.0.0 \
       /usr/share/glvnd/egl_vendor.d/50_mesa.json

# need c++: subprocess.CalledProcessError: Command '['which', 'c++']' returned non-zero exit status 1.
RUN apt-get update && apt-get install -y --no-install-recommends \
        libgomp1 g++ && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
        hydra-core==1.2.0 gym==0.23.0 omegaconf==2.2.2 rl-games==1.5.2 wandb==0.12.21

COPY --from=py \
    /opt/isaacgym/python/isaacgym/_bindings/src \
    /usr/local/lib/python3.8/site-packages/isaacgym/_bindings/src

COPY --from=py /usr/local/bin/ninja /usr/local/bin/ninja

ENV LANG=C.UTF-8 \
    NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=all \
    LD_LIBRARY_PATH=/opt/isaacgym/python/isaacgym/_bindings/linux-x86_64:/usr/local/cuda/targets/x86_64-linux/lib:$LD_LIBRARY_PATH

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://developer.nvidia.com/isaac-gym \
      description="NVIDIA’s physics simulation environment for reinforcement learning research." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["python"]
