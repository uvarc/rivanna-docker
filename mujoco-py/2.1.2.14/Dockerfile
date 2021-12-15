ARG VERSION=2.1.2.14
FROM nvidia/cuda:11.0-base-ubuntu18.04 AS lib

FROM python:3.8-slim-buster AS build
ARG VERSION

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget curl git \
        gcc libgl1-mesa-dev libgl1-mesa-glx libglew-dev libosmesa6-dev \
        net-tools \
        xpra \
        xserver-xorg-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl -o /usr/local/bin/patchelf https://s3-us-west-2.amazonaws.com/openai-sci-artifacts/manual-builds/patchelf_0.9_amd64.elf \
    && chmod +x /usr/local/bin/patchelf

WORKDIR /root/.mujoco
RUN wget https://mujoco.org/download/mujoco210-linux-x86_64.tar.gz -O mujoco.tar.gz \
    && tar -xf mujoco.tar.gz \
    && rm mujoco.tar.gz

WORKDIR /opt
RUN wget https://github.com/openai/mujoco-py/archive/refs/tags/v${VERSION}.tar.gz && \
    tar xf v${VERSION}.tar.gz && \
    rm v${VERSION}.tar.gz

WORKDIR /opt/mujoco-py-${VERSION}
RUN cp vendor/Xdummy /usr/local/bin/Xdummy && \
    chmod +x /usr/local/bin/Xdummy

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -r requirements.dev.txt
RUN sed -i 's#lockpath = .*$#lockpath = os.path.join("/tmp", "mujocopy-buildlock")#' mujoco_py/builder.py && \
    python setup.py install

RUN pip install --no-cache-dir torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

ENV LD_LIBRARY_PATH=/root/.mujoco/mujoco210/bin:$LD_LIBRARY_PATH
WORKDIR /
RUN python -c "import mujoco_py"

COPY --from=lib /usr/local/cuda /usr/local/cuda

RUN rm -rf /tmp/*
RUN mv /root/.mujoco /.mujoco
RUN chown -R 1000 /.mujoco 
USER 1000

ENV LD_LIBRARY_PATH=/.mujoco/mujoco210/bin:/usr/local/cuda/lib64:$LD_LIBRARY_PATH \
    LC_ALL=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/openai/mujoco-py \
      description="MuJoCo is a physics engine for detailed, efficient rigid body simulations with contacts. mujoco-py allows using MuJoCo from Python 3." \
      gpu=true \
      moduleclass=phys

ENTRYPOINT ["python"]
