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

FROM python:3.7.4-slim-buster AS py
COPY --from=build /opt/nanopolish/scripts/requirements.txt /opt/nanopolish/scripts/requirements.txt
RUN pip install --no-cache-dir -r /opt/nanopolish/scripts/requirements.txt

FROM gcr.io/distroless/python3-debian10
COPY --from=build /opt/nanopolish/nanopolish /opt/nanopolish/nanopolish
COPY --from=build /opt/nanopolish/scripts /opt/nanopolish/scripts

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

COPY --from=build /opt/nanopolish/LICENSE /opt/nanopolish/LICENSE

COPY --from=py /usr/local/lib/python3.7/site-packages /site-packages

ENV PYTHONPATH=/site-packages
ENV PATH=/opt/nanopolish:/opt/nanopolish/scripts:$PATH

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["nanopolish"]
