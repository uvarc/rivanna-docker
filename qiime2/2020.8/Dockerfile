FROM continuumio/miniconda3:4.8.2 AS build
ARG VERSION=2020.8
ARG YML=qiime2-${VERSION}-py36-linux-conda.yml

WORKDIR /opt
RUN wget https://data.qiime2.org/distro/core/$YML && \
    conda env create -f $YML -p /opt/qiime2 && \
    conda clean -a && \
    rm $YML

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential gcc lsof git && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /opt/qiime2/bin:$PATH

# plugin: empress
RUN pip install --no-cache-dir numpy cython && \
    pip install --no-cache-dir git+https://github.com/biocore/empress.git && \
    qiime dev refresh-cache

# plugin: picrust2
RUN pip install --no-cache-dir git+https://github.com/picrust/picrust2.git && \
    pip install --no-cache-dir git+https://github.com/gavinmdouglas/q2-picrust2.git && \
    qiime dev refresh-cache

# cannot use distroless due to "#!/usr/bin/env Rscript"
FROM debian:buster-slim
COPY --from=build /opt/qiime2 /opt/qiime2

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PATH /opt/qiime2/bin:$PATH
ENV PYTHONPATH /opt/qiime2/lib/python3.6/site-packages

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://qiime2.org/
LABEL description="QIIME 2 is a next-generation microbiome bioinformatics platform that is extensible, free, open source, and community developed."
LABEL moduleclass=bio

ENTRYPOINT ["qiime"]
