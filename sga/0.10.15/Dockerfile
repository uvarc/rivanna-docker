ARG BAMTOOLS_VERSION=2.4.2

FROM gcc:8.5.0 AS build
ARG BAMTOOLS_VERSION

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget git \
        automake autotools-dev build-essential cmake \
        libhts-dev libjemalloc-dev libsparsehash-dev libz-dev zlib1g-dev

# bamtools
WORKDIR /opt
RUN wget https://github.com/pezmaster31/bamtools/archive/v${BAMTOOLS_VERSION}.tar.gz && \
    tar -xzvf v${BAMTOOLS_VERSION}.tar.gz && \
    rm v${BAMTOOLS_VERSION}.tar.gz && \
    cd bamtools-${BAMTOOLS_VERSION} && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && make install

# build SGA
WORKDIR /opt
RUN git clone https://github.com/jts/sga.git && \
    cd sga/src && \
    ./autogen.sh && \
    ./configure --with-bamtools=/usr/local --with-jemalloc=/usr --prefix=/usr/local && \
    make && \
    make install

FROM python:3.7-slim-buster
COPY --from=build \
    /usr/local/bin/bamtools \
    /usr/local/bin/sga \
    /usr/local/bin/sga-astat.py \
    /usr/local/bin/
COPY --from=build /usr/local/lib/libbamtools.a /usr/local/lib
COPY --from=build /usr/lib/x86_64-linux-gnu/libjemalloc.so.2 /usr/lib/x86_64-linux-gnu/libjemalloc.so.2
COPY --from=build \
    /usr/local/lib64/libgcc_s.so.1 \
    /usr/local/lib64/libgomp.so.1 \
    /usr/local/lib64/libstdc++.so.6 \
    /usr/local/lib64/

COPY --from=build /opt/sga/src/bin/sga-preqc-report.py /usr/local/bin/

RUN pip install --no-cache-dir pysam ruffus matplotlib

ENV LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH \
    LC_ALL=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/jts/sga \
      description="SGA is a de novo genome assembler based on the concept of string graphs. The major goal of SGA is to be very memory efficient, which is achieved by using a compressed representation of DNA sequence reads." \
      moduleclass=bio

ENTRYPOINT ["/usr/local/bin/sga"]
