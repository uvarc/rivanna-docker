FROM mambaorg/micromamba:0.25.1 AS build
ARG VERSION=2022.2
ARG YML=qiime2-${VERSION}-py38-linux-conda.yml

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates build-essential gcc lsof git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget https://data.qiime2.org/distro/core/$YML && \
    micromamba create -f $YML -p /opt/qiime2 && \
    micromamba clean -a && \
    rm $YML

ENV PATH /opt/qiime2/bin:$PATH

# plugin: empress
RUN pip install --no-cache-dir numpy cython && \
    pip install --no-cache-dir git+https://github.com/biocore/empress.git && \
    qiime dev refresh-cache

# plugin: picrust2
RUN pip install --no-cache-dir git+https://github.com/picrust/picrust2.git && \
    pip install --no-cache-dir git+https://github.com/gavinmdouglas/q2-picrust2.git && \
    qiime dev refresh-cache

FROM debian:bullseye-slim
COPY --from=build /opt/qiime2 /opt/qiime2

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PATH=/opt/qiime2/bin:$PATH \
    PYTHONPATH=/opt/qiime2/lib/python3.8/site-packages

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://qiime2.org/
LABEL description="QIIME 2 is a next-generation microbiome bioinformatics platform that is extensible, free, open source, and community developed."
LABEL moduleclass=bio

ENTRYPOINT ["qiime"]
