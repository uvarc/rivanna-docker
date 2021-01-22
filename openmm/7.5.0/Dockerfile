ARG VERSION=7.5.0
ARG TINKER_VERSION=8.8.3

FROM nvidia/cuda:10.2-devel-ubuntu18.04 AS build
ARG VERSION

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates \
        gcc gfortran g++ cmake build-essential \
        libfftw3-dev python3-dev python3-pip doxygen swig && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget -q https://github.com/openmm/openmm/archive/${VERSION}.tar.gz && \
    tar xf ${VERSION}.tar.gz && rm ${VERSION}.tar.gz

WORKDIR /opt/openmm-${VERSION}/build
RUN cmake -DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs \
          -DOPENMM_BUILD_AMOEBA_PLUGIN=ON -DOPENMM_BUILD_AMOEBA_CUDA_LIB=ON \
          -DOPENMM_BUILD_CUDA_LIB=ON -DOPENMM_BUILD_C_AND_FORTRAN_WRAPPERS=ON .. && \
    make && make install 

RUN pip3 install --no-cache-dir numpy cython

RUN make PythonInstall

WORKDIR /opt
ARG TINKER_VERSION
RUN wget -q https://dasher.wustl.edu/tinker/downloads/tinker-${TINKER_VERSION}.tar.gz && \
    tar xf tinker-${TINKER_VERSION}.tar.gz && rm tinker-${TINKER_VERSION}.tar.gz

WORKDIR /opt/tinker/source

RUN cp ../openmm/* . && \
    make dynamic_omm.x TINKERDIR=/opt/tinker

FROM scratch
COPY --from=build /opt/tinker/source/dynamic_omm.x /dynamic_omm.x

COPY --from=build \
    /usr/local/cuda/targets/x86_64-linux/lib/stubs/libcuda.so \
    /usr/local/cuda/targets/x86_64-linux/lib/stubs/libcuda.so.1

COPY --from=build \
    /usr/local/cuda/targets/x86_64-linux/lib/stubs/libnvidia-ml.so \
    /usr/local/cuda/targets/x86_64-linux/lib/stubs/libnvidia-ml.so.1

COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2

COPY --from=build \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libgcc_s.so.1 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libmvec.so.1 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/librt.so.1 \
    /lib/x86_64-linux-gnu/

COPY --from=build /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/libstdc++.so.6

COPY --from=build /usr/local/cuda/targets/x86_64-linux/lib/libcudart.so.10.2 /usr/local/cuda/targets/x86_64-linux/lib/libcudart.so.10.2

COPY --from=build /usr/local/openmm /usr/local/openmm

COPY --from=build /opt/tinker/params /opt/tinker/params

ENV OPENMM_PLUGIN_DIR /usr/local/openmm/lib/plugins
ENV LD_LIBRARY_PATH /usr/local/openmm/lib:/usr/local/openmm/lib/plugins:/usr/local/cuda/targets/x86_64-linux/lib:/usr/local/cuda/targets/x86_64-linux/lib/stubs:$LD_LIBRARY_PATH

LABEL homepage=https://github.com/openmm/openmm
LABEL description="OpenMM is a toolkit for molecular simulation using high performance GPU code."
LABEL gpu=true
LABEL moduleclass=chem
LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["/dynamic_omm.x"]
