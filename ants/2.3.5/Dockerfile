ARG VERSION=2.3.5

FROM ubuntu:20.04 AS build
ARG VERSION

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        cmake make gcc g++ \
        wget ca-certificates git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN wget -q https://github.com/ANTsX/ANTs/archive/refs/tags/v${VERSION}.tar.gz && \
    tar xf v${VERSION}.tar.gz && \
    rm v${VERSION}.tar.gz

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

RUN cd ANTs-${VERSION} && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/opt/ANTs -DCMAKE_BUILD_TYPE=Release \
          -DBUILD_SHARED_LIBS=ON -DBUILD_TESTING=OFF -DSuperBuild_ANTS_USE_GIT_PROTOCOL=OFF \
          .. && \
    make

RUN cd /tmp/ANTs-${VERSION}/build/ANTS-build && make install

FROM ubuntu:20.04
ARG VERSION

COPY --from=build /opt/ANTs /opt/ANTs
COPY --from=build /tmp/ANTs-${VERSION}/ANTSCopyright.txt /opt/ANTs/ANTSCopyright.txt

ENV PATH=/opt/ANTs/bin:$PATH \
    LD_LIBRARY_PATH=/opt/ANTs/lib:$LD_LIBRARY_PATH

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["ANTS"]
