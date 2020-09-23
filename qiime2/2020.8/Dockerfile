FROM continuumio/miniconda3:4.8.2 AS build
ARG VERSION=2020.8
ARG YML=qiime2-${VERSION}-py36-linux-conda.yml

WORKDIR /opt
RUN wget https://data.qiime2.org/distro/core/$YML && \
    conda env create -f $YML -p /opt/qiime2 && \
    conda clean -a && \
    rm $YML

RUN apt-get update && apt-get install -y --no-install-recommends lsof && \
    rm -rf /var/lib/apt/lists/*

FROM gcr.io/distroless/python3-debian10
COPY --from=build /opt/qiime2 /opt/qiime2

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PATH /opt/qiime2/bin
ENV PYTHONPATH /opt/qiime2/lib/python3.6/site-packages

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://qiime2.org/
LABEL description="QIIME 2 is a next-generation microbiome bioinformatics platform that is extensible, free, open source, and community developed."
LABEL moduleclass=bio

ENTRYPOINT ["qiime"]