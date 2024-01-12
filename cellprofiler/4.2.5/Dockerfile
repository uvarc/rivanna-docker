# RIV-13156
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

# https://forum.image.sc/t/issue-with-centrosome-while-installing-cellprofiler4-2-5-on-ubuntu22-04/83982/6
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget https://files.pythonhosted.org/packages/fd/b9/59f3f3d27440b3d896c64500311dc864e0115f0023d8888052d3cd39e4b9/cellprofiler-core-4.2.5.tar.gz && \
    tar xf cellprofiler-core-4.2.5.tar.gz && \
    rm cellprofiler-core-4.2.5.tar.gz 
RUN cd cellprofiler-core-4.2.5 && \
    sed -i 's/centrosome==1.2.1/centrosome==1.2.2/' setup.py && \
    pip install --no-cache-dir .

WORKDIR /opt
RUN wget https://files.pythonhosted.org/packages/24/d8/ceeb479bc09d2a41e9220bd06786c14e18250a92806a0b6049308e1550cb/CellProfiler-4.2.5.tar.gz && \
    tar xf CellProfiler-4.2.5.tar.gz && \
    rm CellProfiler-4.2.5.tar.gz 
RUN cd CellProfiler-4.2.5 && \
    sed -i 's/centrosome==1.2.1/centrosome==1.2.2/' setup.py && \
    pip install --no-cache-dir .

FROM debian:bullseye-slim
COPY --from=build /cp4 /cp4

RUN apt-get update && apt-get install -y --no-install-recommends \
        libgtk-3-0 libmariadb-dev libxxf86vm-dev && \
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
