FROM ubuntu:18.04 AS build
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc build-essential \
        libkpathsea-dev libgd-dev libpng-dev \
        ghostscript texlive-latex-base texinfo \
        wget ca-certificates unzip && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget -q http://mirrors.ctan.org/dviware/dvipng.zip && \
    unzip dvipng.zip && \
    cd dvipng && \
    ./configure LDFLAGS=-L/lib/x86_64-linux-gnu && make && make install

FROM gcr.io/distroless/cc-debian10
COPY --from=build /usr/local/bin/dvipng /usr/local/bin/dvipng
COPY --from=build \
    /usr/lib/x86_64-linux-gnu/libfreetype.so.6 \
    /usr/lib/x86_64-linux-gnu/libkpathsea.so.6 \
    /usr/lib/x86_64-linux-gnu/libgd.so.3 \
    /usr/lib/x86_64-linux-gnu/libpng16.so.16 \
    /usr/lib/x86_64-linux-gnu/libfontconfig.so.1 \
    /usr/lib/x86_64-linux-gnu/libjpeg.so.8 \
    /usr/lib/x86_64-linux-gnu/libXpm.so.4 \
    /usr/lib/x86_64-linux-gnu/libtiff.so.5 \
    /usr/lib/x86_64-linux-gnu/libwebp.so.6 \
    /usr/lib/x86_64-linux-gnu/libX11.so.6 \
    /usr/lib/x86_64-linux-gnu/libjbig.so.0 \
    /usr/lib/x86_64-linux-gnu/libxcb.so.1 \
    /usr/lib/x86_64-linux-gnu/libXau.so.6 \
    /usr/lib/x86_64-linux-gnu/libXdmcp.so.6 \
    /usr/lib/x86_64-linux-gnu/
COPY --from=build \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    /lib/x86_64-linux-gnu/libexpat.so.1 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/liblzma.so.5 \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libbsd.so.0 \
    /lib/x86_64-linux-gnu/librt.so.1 \
    /lib/x86_64-linux-gnu/
COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2

ENV PATH=/usr/local/bin

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://ctan.org/pkg/dvipng
LABEL description="dvipng – A fast DVI to PNG/GIF converter. This program makes PNG and/or GIF graphics from DVI files as obtained from TeX and its relatives."
LABEL moduleclass=tools

ENTRYPOINT ["dvipng"]
