ARG VERSION=3.0.0

FROM nvidia/opencl:devel AS build
ARG DEBIAN_FRONTEND=noninteractive
ARG VERSION

# Global Path Setting
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV OPENCL_LIBRARIES /usr/lib/x86_64-linux-gnu
ENV OPENCL_INCLUDE_DIR /usr/include/CL

# SYSTEM
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        wget \
        ca-certificates \
        libglib2.0-0 \
        libxext6 \
        libsm6 \
        libxrender1 \
        cmake \
        libboost-dev \
        libboost-system-dev \
        libboost-filesystem-dev \
        gcc \
        g++ && \
    rm -rf /var/lib/apt/lists/*

# LightGBM
WORKDIR /opt
RUN wget -q https://github.com/microsoft/LightGBM/archive/v${VERSION}.tar.gz && \
    tar xf v${VERSION}.tar.gz && \
    cd LightGBM-$VERSION && mkdir build && cd build && \
    cmake -DUSE_GPU=1 -DOpenCL_LIBRARY=${OPENCL_LIBRARIES}/libOpenCL.so.1 -DOpenCL_INCLUDE_DIR=$OPENCL_INCLUDE_DIR .. && \
    make OPENCL_HEADERS=$OPENCL_INCLUDE_DIR LIBOPENCL=$OPENCL_LIBRARIES

FROM gcr.io/distroless/cc-debian10
ARG VERSION
COPY --from=build \
    /opt/LightGBM-${VERSION}/lightgbm \
    /opt/LightGBM-${VERSION}/lib_lightgbm.so \
    /opt/LightGBM-${VERSION}/
COPY --from=build \
    /usr/lib/x86_64-linux-gnu/libOpenCL.so.1 \
	/usr/lib/x86_64-linux-gnu/libboost_filesystem.so.1.65.1 \
	/usr/lib/x86_64-linux-gnu/libboost_system.so.1.65.1 \
	/usr/lib/x86_64-linux-gnu/libgomp.so.1 \
	/usr/lib/x86_64-linux-gnu/libstdc++.so.6 \
	/usr/lib/x86_64-linux-gnu/
COPY --from=build \
	/lib/x86_64-linux-gnu/libm.so.6 \
	/lib/x86_64-linux-gnu/libgcc_s.so.1 \
	/lib/x86_64-linux-gnu/libpthread.so.0 \
	/lib/x86_64-linux-gnu/libc.so.6 \
	/lib/x86_64-linux-gnu/libdl.so.2 \
	/lib/x86_64-linux-gnu/
COPY --from=build \
	/lib64/ld-linux-x86-64.so.2 \
	/lib64/
COPY --from=build /etc/OpenCL/vendors/nvidia.icd /etc/OpenCL/vendors/nvidia.icd

ENV PATH /opt/LightGBM-${VERSION}:${PATH}

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://github.com/microsoft/LightGBM
LABEL description="LightGBM is a gradient boosting framework that uses tree based learning algorithms."
LABEL gpu=true
LABEL moduleclass=data

ENTRYPOINT ["lightgbm"]
