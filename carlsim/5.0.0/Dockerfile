ARG CUDA=10.2

FROM nvidia/cuda:${CUDA}-devel-ubuntu18.04 AS build
ARG CUDA

RUN apt-get update && apt-get install -y --no-install-recommends \
        git make wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

ENV CARLSIM5_INSTALL_DIR=/usr/local \
    CUDA_PATH=/usr/local/cuda

RUN wget -q https://github.com/NVIDIA/cuda-samples/archive/refs/tags/v${CUDA}.tar.gz && \
    tar xf v${CUDA}.tar.gz -C $CUDA_PATH && \
    mv $CUDA_PATH/cuda-samples-${CUDA} $CUDA_PATH/samples && \
    mv $CUDA_PATH/samples/Common $CUDA_PATH/samples/common && \ 
    rm v${CUDA}.tar.gz

WORKDIR /opt
RUN git clone --recursive https://github.com/UCI-CARL/CARLsim5.git && \
    cd CARLsim5 && \
    sed -i '126s/.*/NVCCFL             += $(GENCODE_SM35) $(GENCODE_SM60) $(GENCODE_SM70)/' carlsim/configure.mk && \
    sed -i '95s#.*#NVCCINCFL          := -I$(CUDA_PATH)/samples/common#' carlsim/configure.mk && \
    sed -i '94 a #include <helper_timer.h>' carlsim/kernel/inc/snn.h && \
    sed -i '65 a #include <cuda_version_control.h>' carlsim/kernel/src/snn_manager.cpp && \
    make && \
    make install

FROM nvidia/cuda:${CUDA}-runtime-ubuntu18.04
ARG CUDA

COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /usr/local/include /usr/local/include
COPY --from=build /usr/local/cuda/samples /usr/local/cuda/samples

LABEL maintainer=rs7wz@virginia.edu
