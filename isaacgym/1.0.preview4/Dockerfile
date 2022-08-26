FROM python:3.8-slim-buster AS py
ARG VERSION=1.10.0

RUN pip install --no-cache-dir -U pip numpy==1.20.1 scipy==1.6.1 && \
    pip install --no-cache-dir \
        torch==${VERSION}+cu113 torchvision==0.11.1+cu113 torchaudio==0.10.0+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html

WORKDIR /opt/isaacgym
ADD isaacgym-src/ .

RUN cd python && pip install --no-cache-dir .

FROM python:3.8-slim-buster
COPY --from=py /usr/local /usr/local
COPY --from=py /opt/isaacgym/python /opt/isaacgym/python
COPY --from=py /opt/isaacgym/docker/nvidia_icd.json /usr/share/vulkan/icd.d/nvidia_icd.json
COPY --from=py /opt/isaacgym/docker/10_nvidia.json /usr/share/glvnd/egl_vendor.d/10_nvidia.json

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

ENV LANG=C.UTF-8 \
    NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=all \
    LD_LIBRARY_PATH=/opt/isaacgym/python/isaacgym/_bindings/linux-x86_64:$LD_LIBRARY_PATH

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://developer.nvidia.com/isaac-gym \
      description="NVIDIA’s physics simulation environment for reinforcement learning research." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["python"]
