FROM python:3.8-slim-buster AS py
ARG VERSION=1.10.0

RUN pip install --no-cache-dir -U pip numpy==1.20.1 scipy==1.6.1 && \
    pip install --no-cache-dir \
        torch==${VERSION}+cu113 torchvision==0.11.1+cu113 torchaudio==0.10.0+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html

# dependencies for torchaudio, openslide, opencv
RUN apt-get update && apt-get install -y --no-install-recommends \
        sox \
        libsndfile1 \
        gcc libc6-dev openslide-tools \
        libgl1 libsm6 libxext6 libxrender1 libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
        torchtext==0.11.0 \
        botorch==0.5.1 \
        ignite==1.1.0 \
        matplotlib==3.5.0 \
        seaborn==0.11.2 \
        pandas==1.3.4 \
        scikit-learn==1.0.1 \
        scikit-image==0.18.3 \
        openslide-python==1.1.2 \
        opencv-python==4.5.4.60 \
        sox jupyter ipykernel ipywidgets pyqt5-tools
        
# pytorch-lightning: need bleeding edge for compatibility with torchtext
RUN pip install --no-cache-dir https://github.com/PyTorchLightning/pytorch-lightning/archive/master.zip

RUN apt-get update && apt-get install -y --no-install-recommends lsof && \
    rm -rf /var/lib/apt/lists/*

FROM python:3.8-slim-buster
COPY --from=py /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages
#COPY --from=py /usr/local/lib/libpython3.8m.so.1.0 /usr/local/lib/libpython3.8m.so.1.0
COPY --from=py /lib/x86_64-linux-gnu/libpcre.so.3 /lib/x86_64-linux-gnu/libpcre.so.3
COPY --from=py \
    /lib/x86_64-linux-gnu/libblkid.so.1 \
    /lib/x86_64-linux-gnu/libbz2.so.1 \
    /lib/x86_64-linux-gnu/libexpat.so.1 \
    /lib/x86_64-linux-gnu/libgcc_s.so.1 \
    /lib/x86_64-linux-gnu/liblzma.so.5 \
    /lib/x86_64-linux-gnu/libmount.so.1 \
    /lib/x86_64-linux-gnu/libncursesw.so.6 \
    /lib/x86_64-linux-gnu/libresolv-2.28.so \
    /lib/x86_64-linux-gnu/librt-2.28.so \
    /lib/x86_64-linux-gnu/libselinux.so.1 \
    /lib/x86_64-linux-gnu/libtinfo.so.6 \
    /lib/x86_64-linux-gnu/libuuid.so.1 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    /lib/x86_64-linux-gnu/

COPY --from=py \
    /usr/lib/x86_64-linux-gnu/libGL.so.1 \
    /usr/lib/x86_64-linux-gnu/libGLX.so.0 \
    /usr/lib/x86_64-linux-gnu/libGLdispatch.so.0 \
    /usr/lib/x86_64-linux-gnu/libX11.so.6 \
    /usr/lib/x86_64-linux-gnu/libXau.so.6 \
    /usr/lib/x86_64-linux-gnu/libXdmcp.so.6 \
    /usr/lib/x86_64-linux-gnu/libXext.so.6 \
    /usr/lib/x86_64-linux-gnu/libXrender.so.1 \
    /usr/lib/x86_64-linux-gnu/libbsd.so.0 \
    /usr/lib/x86_64-linux-gnu/libcairo.so.2 \
    /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 \
    /usr/lib/x86_64-linux-gnu/libffi.so.6 \
    /usr/lib/x86_64-linux-gnu/libfontconfig.so.1 \
    /usr/lib/x86_64-linux-gnu/libfreetype.so.6 \
    /usr/lib/x86_64-linux-gnu/libgdk_pixbuf-2.0.so.0 \
    /usr/lib/x86_64-linux-gnu/libgio-2.0.so.0 \
    /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0 \
    /usr/lib/x86_64-linux-gnu/libgmodule-2.0.so.0 \
    /usr/lib/x86_64-linux-gnu/libgobject-2.0.so.0 \
    /usr/lib/x86_64-linux-gnu/libgthread-2.0.so.0 \
    /usr/lib/x86_64-linux-gnu/libicudata.so.63 \
    /usr/lib/x86_64-linux-gnu/libicui18n.so.63 \
    /usr/lib/x86_64-linux-gnu/libicuuc.so.63 \
    /usr/lib/x86_64-linux-gnu/libjbig.so.0 \
    /usr/lib/x86_64-linux-gnu/libjpeg.so.62 \
    /usr/lib/x86_64-linux-gnu/libopenjp2.so.2.3.0 \
    /usr/lib/x86_64-linux-gnu/libopenjp2.so.7 \
    /usr/lib/x86_64-linux-gnu/libopenslide.so.0 \
    /usr/lib/x86_64-linux-gnu/libpixman-1.so.0 \
    /usr/lib/x86_64-linux-gnu/libpng16.so.16 \
    /usr/lib/x86_64-linux-gnu/libsqlite3.so.0 \
    /usr/lib/x86_64-linux-gnu/libssl.so.1.1 \
    /usr/lib/x86_64-linux-gnu/libstdc++.so.6 \
    /usr/lib/x86_64-linux-gnu/libtiff.so.5 \
    /usr/lib/x86_64-linux-gnu/libwebp.so.6 \
    /usr/lib/x86_64-linux-gnu/libxcb-render.so.0 \
    /usr/lib/x86_64-linux-gnu/libxcb-shm.so.0 \
    /usr/lib/x86_64-linux-gnu/libxcb.so.1 \
    /usr/lib/x86_64-linux-gnu/libxml2.so.2 \
    /usr/lib/x86_64-linux-gnu/libzstd.so.1 \
    /usr/lib/x86_64-linux-gnu/

# sox
COPY --from=py /usr/bin/sox /usr/bin/sox
COPY --from=py \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    /lib/x86_64-linux-gnu/
COPY --from=py \
    /usr/lib/x86_64-linux-gnu/libgomp.so.1 \
    /usr/lib/x86_64-linux-gnu/libgsm.so.1 \
    /usr/lib/x86_64-linux-gnu/libltdl.so.7 \
    /usr/lib/x86_64-linux-gnu/libmagic.so.1 \
    /usr/lib/x86_64-linux-gnu/libsox.so.3 \
    /usr/lib/x86_64-linux-gnu/

ENV LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:/usr/local/lib:$LD_LIBRARY_PATH \
    LANG=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://www.pytorch.org \
      description="PyTorch is a deep learning framework that puts Python first. It provides Tensors and Dynamic neural networks in Python with strong GPU acceleration." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["python"]
