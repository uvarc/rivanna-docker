FROM gcc:4.9.4 AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
        unzip wget liblapack-dev libopenblas-dev && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/argriffing/eigensoft/archive/refs/heads/master.zip && \
    unzip master.zip && rm master.zip

RUN cd eigensoft-master/src && make all && make install

FROM perl:5.12.5-slim-buster
COPY --from=build /eigensoft-master/bin /eigensoft/bin

COPY --from=build \
    /usr/lib/libblas.so.3 \
    /usr/lib/liblapack.so.3 \
    /usr/lib/libopenblas.so.0 \
    /usr/lib

COPY --from=build \
    /usr/local/lib64/libgcc_s.so.1 \
    /usr/local/lib64/libgfortran.so.3 \
    /usr/local/lib64/libquadmath.so.0 \
    /usr/local/lib64/

ENV PATH=/eigensoft/bin:$PATH \
    LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH

ENTRYPOINT ["smartpca"]
