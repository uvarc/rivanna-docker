FROM python:3.7.9-slim-buster AS build

RUN apt update && apt install -y --no-install-recommends \
        g++ git \
        gnuplot-nox \
        libgmp-dev \
        libmpfr-dev \
        libgsl-dev && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
        appdirs cython matplotlib pandas pysam scipy setuptools sklearn tqdm

WORKDIR /opt
RUN git clone https://github.com/popgenmethods/smcpp.git && \
    cd smcpp && \
    python setup.py install

FROM python:3.7.9-slim-buster

RUN apt update && apt install -y --no-install-recommends \
        gnuplot-nox && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/bin/smc++ /usr/local/bin/smc++
COPY --from=build /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.7/site-packages

COPY --from=build \
    /lib/x86_64-linux-gnu/libbz2.so.1.0.4 \
    /lib/x86_64-linux-gnu/libexpat.so.1.6.8 \
    /lib/x86_64-linux-gnu/libgcc_s.so.1 \
    /lib/x86_64-linux-gnu/liblzma.so.5.2.4 \
    /lib/x86_64-linux-gnu/librt-2.28.so \
    /lib/x86_64-linux-gnu/libuuid.so.1.3.0 \
    /lib/x86_64-linux-gnu/libz.so.1.2.11 \
    /lib/x86_64-linux-gnu/

COPY --from=build \
    /usr/lib/x86_64-linux-gnu/libmpfr.so.6 \
    /usr/lib/x86_64-linux-gnu/libgomp.so.1 \
    /usr/lib/x86_64-linux-gnu/libgslcblas.so.0 \
    /usr/lib/x86_64-linux-gnu/libgsl.so.23 \
    /usr/lib/x86_64-linux-gnu/libgmpxx.so.4 \
    /usr/lib/x86_64-linux-gnu/libgmp.so.10 \
    /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 \
    /usr/lib/x86_64-linux-gnu/libffi.so.6.0.4 \
    /usr/lib/x86_64-linux-gnu/libssl.so.1.1 \
    /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.25 \
    /usr/lib/x86_64-linux-gnu/

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["smc++"]
