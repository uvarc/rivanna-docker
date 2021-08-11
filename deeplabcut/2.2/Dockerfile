FROM mambaorg/micromamba:0.15.2 AS py
USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc g++ \
        libgtk-3-dev \
        libgstreamer1.0-dev \
        freeglut3-dev \
        libjpeg-dev libpng-dev libtiff-dev \
        libsdl2-dev \
        libnotify-dev \
        libsm-dev && \
    rm -rf /var/lib/apt/lists/*

RUN micromamba install -n base -c anaconda -c conda-forge \
        python=3.8.10 pip jupyter nb_conda ffmpeg cudatoolkit=11.0 cudnn=8.0 && \
    micromamba clean -ya

RUN micromamba install -n base -c conda-forge \
        wxpython=4.0.7 && \
    micromamba clean -ya

RUN pip install --no-cache-dir deeplabcut[gui]==2.2 tensorflow==2.4.1

RUN apt-get update && apt-get install -y --no-install-recommends \
        lsof wget && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://downloads.sourceforge.net/project/virtualgl/2.6.5/virtualgl_2.6.5_amd64.deb

FROM debian:buster-slim
COPY --from=py /opt/conda /opt/conda
COPY --from=py \
    /lib/x86_64-linux-gnu/libblkid.so.1.1.0 \
    /lib/x86_64-linux-gnu/libmount.so.1.1.0 \
    /lib/x86_64-linux-gnu/libpcre.so.3.13.3 \
    /lib/x86_64-linux-gnu/libresolv-2.28.so \
    /lib/x86_64-linux-gnu/libselinux.so.1 \
    /lib/x86_64-linux-gnu/
COPY --from=py \
    /usr/lib/x86_64-linux-gnu/libGL.so.1 \
    /usr/lib/x86_64-linux-gnu/libGLX.so.0 \
    /usr/lib/x86_64-linux-gnu/libGLdispatch.so.0 \
    /usr/lib/x86_64-linux-gnu/libXau.so.6 \
    /usr/lib/x86_64-linux-gnu/libXxf86vm.so.1 \
    /usr/lib/x86_64-linux-gnu/libgio-2.0.so.0 \
    /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0 \
    /usr/lib/x86_64-linux-gnu/libgmodule-2.0.so.0 \
    /usr/lib/x86_64-linux-gnu/libgobject-2.0.so.0 \
    /usr/lib/x86_64-linux-gnu/libgthread-2.0.so.0 \
    /usr/lib/x86_64-linux-gnu/

ENV PATH=/opt/conda/bin:$PATH \
    PYTHONPATH=/opt/conda/lib/python3.8/site-packages \
    LANG=C.UTF-8

RUN sed -i 's/WxAgg/Agg/' /opt/conda/lib/python3.8/site-packages/deeplabcut/__init__.py
# https://github.com/DeepLabCut/DeepLabCut/issues/1190
ADD download_pretrain.py .
RUN python download_pretrain.py
RUN chmod -R go+rx /opt/conda/lib/python3.8/site-packages/deeplabcut/pose_estimation_tensorflow/models/pretrained

# VirtualGL
RUN apt-get update && apt-get install -y --no-install-recommends \
        libxtst6 \
        libxv1 \
        libglu1-mesa && \
    rm -rf /var/lib/apt/lists/*

COPY --from=py /tmp/virtualgl_2.6.5_amd64.deb /tmp/virtualgl_2.6.5_amd64.deb
RUN dpkg -r VirtualGL && \
    dpkg -i /tmp/virtualgl*.deb

# font
RUN apt-get update && apt-get install -y --no-install-recommends \
        fonts-noto && \
    rm -rf /var/lib/apt/lists/*

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/DeepLabCut/DeepLabCut \
      description="DeepLabCut is a toolbox for markerless pose estimation of animals performing various tasks." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["python"]
