FROM ubuntu:21.04 AS build
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        rsync \
        doxygen \
        pandoc \
        gettext \
        libssl-dev \
        libiconv-hook-dev \
        zlib1g-dev \
        liblzma-dev \
        bzip2 \
        libbrotli-dev \
        libzstd-dev \
        libgnutls28-dev \
        libidn2-0-dev \
        flex \
        libpsl-dev \
        libnghttp2-dev \
        libmicrohttpd-dev \
        lzip \
        lcov \
        libgpgme-dev \
        libpcre2-dev && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates texinfo && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://gnuwget.gitlab.io/wget2/wget2-latest.tar.gz && \
	tar xf wget2-latest.tar.gz && \
    rm wget2-latest.tar.gz && \
	cd wget2-* && \
	./configure && \
	make && \
	make install

ENTRYPOINT ["/usr/local/bin/wget2"]

FROM debian:bullseye-slim
COPY --from=build /usr/local/bin/wget2 /usr/local/bin/wget2
COPY --from=build \
    /lib/x86_64-linux-gnu/libassuan.so.0 \
    /lib/x86_64-linux-gnu/libbrotlicommon.so.1 \
    /lib/x86_64-linux-gnu/libbrotlidec.so.1 \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libffi.so.8 \
    /lib/x86_64-linux-gnu/libgmp.so.10 \
    /lib/x86_64-linux-gnu/libgnutls.so.30 \
    /lib/x86_64-linux-gnu/libgpg-error.so.0 \
    /lib/x86_64-linux-gnu/libgpgme.so.11 \
    /lib/x86_64-linux-gnu/libhogweed.so.6 \
    /lib/x86_64-linux-gnu/libidn2.so.0 \
    /lib/x86_64-linux-gnu/liblzma.so.5 \
    /lib/x86_64-linux-gnu/libnettle.so.8 \
    /lib/x86_64-linux-gnu/libnghttp2.so.14 \
    /lib/x86_64-linux-gnu/libp11-kit.so.0 \
    /lib/x86_64-linux-gnu/libpcre2-8.so.0 \
    /lib/x86_64-linux-gnu/libpsl.so.5 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libtasn1.so.6 \
    /lib/x86_64-linux-gnu/libunistring.so.2 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    /lib/x86_64-linux-gnu/libzstd.so.1 \
    /lib/x86_64-linux-gnu/
COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2
COPY --from=build /usr/local/lib /usr/local/lib

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
#/lib/x86_64-linux-gnu:/lib64

ENTRYPOINT ["wget2"]
