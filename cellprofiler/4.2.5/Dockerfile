FROM mambaorg/micromamba:1.3.1 AS build
USER root

RUN micromamba create -p /cp4 -c conda-forge \
        python=3.8 \
        boto3 \
        docutils \
        h5py \
        matplotlib \
        numpy \
        openjdk=11.0 \
        psutil \
        pyzmq \
        scikit-image \
        scipy \
        scyjava \
        imageio \
        inflect \
        joblib \
        mahotas \
        mysqlclient \
        wxpython=4.1.0 && \
    micromamba clean -ya

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc g++ libstdc++-10-dev libgtk-3-dev libmariadb-dev libxxf86vm-dev && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=/cp4/bin:$PATH \
    JAVA_HOME=/cp4

RUN pip install --no-cache-dir cellprofiler==4.2.5

FROM debian:bullseye-slim
COPY --from=build /cp4 /cp4

RUN apt-get update && apt-get install -y --no-install-recommends \
        libmariadb-dev libxxf86vm-dev && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=/cp4/bin:$PATH \
    LD_LIBRARY_PATH=/cp4/lib:$LD_LIBRARY_PATH \
    JAVA_HOME=/cp4 \
    LC_ALL=C.UTF-8

RUN ln -s /cp4/lib/libtiff.so.6 /cp4/lib/libtiff.so.5 

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/CellProfiler/CellProfiler \
      description="CellProfiler is a free open-source software designed to enable biologists without training in computer vision or programming to quantitatively measure phenotypes from thousands of images automatically." \
      moduleclass="bio"

ENTRYPOINT ["cellprofiler"]

