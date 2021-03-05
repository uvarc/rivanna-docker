ARG VERSION=0.7.00

FROM gcc:10.2 AS build
ARG VERSION

RUN apt-get update && apt-get install -y --no-install-recommends \
        make libfftw3-dev liblapacke-dev libpng-dev libopenblas-dev \
        wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget -q https://github.com/mrirecon/bart/archive/v$VERSION.tar.gz && \
    tar xf v$VERSION.tar.gz && \
    cd bart-$VERSION && \
    make

FROM python:3.8.8-slim-buster
ARG VERSION

COPY --from=build \
    /opt/bart-$VERSION/bart \
    /opt/bart-$VERSION/startup.m \
    /opt/bart-$VERSION/startup.py \
    /opt/bart-$VERSION/startup.sh \
    /opt/bart-$VERSION/sub \
    /opt/bart-$VERSION/LICENSE \
    /opt/bart-$VERSION/

COPY --from=build /opt/bart-$VERSION/lib /opt/bart-$VERSION/lib

COPY --from=build /opt/bart-$VERSION/matlab /opt/bart-$VERSION/python
COPY --from=build /opt/bart-$VERSION/python /opt/bart-$VERSION/python
COPY --from=build /opt/bart-$VERSION/scripts /opt/bart-$VERSION/scripts
COPY --from=build \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libmvec.so.1 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    /lib/x86_64-linux-gnu/

COPY --from=build \
    /usr/lib/x86_64-linux-gnu/libblas.so.3 \
    /usr/lib/x86_64-linux-gnu/libfftw3f.so.3 \
    /usr/lib/x86_64-linux-gnu/libfftw3f_threads.so.3 \
    /usr/lib/x86_64-linux-gnu/liblapack.so.3 \
    /usr/lib/x86_64-linux-gnu/liblapacke.so.3 \
    /usr/lib/x86_64-linux-gnu/libopenblas.so.0 \
    /usr/lib/x86_64-linux-gnu/libpng16.so.16 \
    /usr/lib/x86_64-linux-gnu/libtmglib.so.3 \
    /usr/lib/x86_64-linux-gnu/

COPY --from=build \
    /usr/local/lib64/libgcc_s.so.1 \
    /usr/local/lib64/libgfortran.so.5 \
    /usr/local/lib64/libgomp.so.1 \
    /usr/local/lib64/libquadmath.so.0 \
    /usr/local/lib64/

COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2

ENV PATH=/opt/bart-$VERSION:$PATH \
    LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:/usr/local/lib64:$LD_LIBRARY_PATH

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["bart"]
