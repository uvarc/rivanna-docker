ARG VERSION=7.5.0

FROM nvidia/cuda:11.2.0-devel-ubuntu20.04
ARG VERSION

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ America/New_York
RUN apt-get update && apt-get -y --no-install-recommends install tzdata && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates git \
        gcc gfortran g++ cmake build-essential \
        libfftw3-dev python3 python3-pip doxygen swig && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget -q https://github.com/openmm/openmm/archive/${VERSION}.tar.gz && \
    tar xf ${VERSION}.tar.gz && rm ${VERSION}.tar.gz

WORKDIR /opt/openmm-${VERSION}/build
RUN cmake -DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs \
          -DOPENMM_BUILD_AMOEBA_PLUGIN=ON -DOPENMM_BUILD_AMOEBA_CUDA_LIB=ON \
          -DOPENMM_BUILD_CUDA_LIB=ON -DOPENMM_BUILD_C_AND_FORTRAN_WRAPPERS=ON .. && \
    make && make install 

RUN apt-get update && apt-get -y --no-install-recommends install python3-dev && \
    rm -rf /var/lib/apt/lists/*
RUN pip3 install --no-cache-dir numpy cython

RUN make PythonInstall

WORKDIR /opt
RUN wget -q https://dasher.wustl.edu/tinker/downloads/tinker-7.1.3.tar.gz && \
    tar xf tinker-7.1.3.tar.gz && rm tinker-7.1.3.tar.gz

WORKDIR /opt/tinker/source
ADD tinker-plugin/dynamic_omm.f \
    tinker-plugin/ommstuff.cpp \
    tinker-plugin/openmm.f \
    tinker-plugin/Makefile ./

RUN make dynamic_omm.x \
    TINKERDIR=/opt/tinker OPENMMDIR=/usr/local/openmm \
    CC=gcc CXX=g++ F77=gfortran LIBS="-lstdc++ -L. -lfftw3_threads -lfftw3" \
    CFLAGS="-c" F77FLAGS="-c" OPTFLAGS="-O3 -ffast-math -fopenmp" \
    LIBFLAGS=-crusv RANLIB="ranlib -c" \
    LINKFLAGS="-O3 -ffast-math -fopenmp -static-libgcc"
