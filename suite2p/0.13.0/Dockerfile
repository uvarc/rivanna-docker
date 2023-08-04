FROM python:3.8
RUN apt-get update && apt-get install -y --no-install-recommends \
        qtbase5-dev qt5-qmake qtbase5-dev-tools cmake && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir suite2p[gui]==0.13.0

RUN apt-get update && apt-get install -y --no-install-recommends \
        libhdf5-dev && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir h5py
RUN pip install --no-cache-dir sbxreader paramiko

# https://github.com/MouseLand/suite2p/issues/999
RUN pip install --no-cache-dir rastermap==0.1.3

LABEL maintainer=rs7wz@virginia.edu \
      homepage='https://github.com/MouseLand/suite2p' \
      description="Pipeline for processing two-photon calcium imaging data." \
      moduleclass=bio

ENTRYPOINT ["python"]
