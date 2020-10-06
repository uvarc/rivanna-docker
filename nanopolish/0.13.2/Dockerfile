FROM debian:buster-slim AS build
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc g++ make zlib1g-dev \
        git wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends bzip2 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone --recursive https://github.com/jts/nanopolish.git && \
    cd nanopolish && \
    make

FROM debian:buster-slim
COPY --from=build /opt/nanopolish/nanopolish /nanopolish

COPY --from=build \
    /usr/lib/x86_64-linux-gnu/libstdc++.so.6 \
    /usr/lib/x86_64-linux-gnu/libgomp.so.1 \
    /usr/lib/x86_64-linux-gnu/
COPY --from=build \
    /lib/x86_64-linux-gnu/libz.so.1 \
    /lib/x86_64-linux-gnu/librt.so.1 \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libgcc_s.so.1 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["/nanopolish"]
