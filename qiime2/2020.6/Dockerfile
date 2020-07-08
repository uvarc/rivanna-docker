FROM continuumio/miniconda3:4.8.2
LABEL maintainer=rs7wz@virginia.edu

WORKDIR /opt

ARG VERSION=2020.6
ARG YML=qiime2-${VERSION}-py36-linux-conda.yml 

ENV PATH /opt/qiime2/bin:/opt/conda/bin:$PATH

RUN wget https://data.qiime2.org/distro/core/$YML && \
    conda env create --force -f $YML -p /opt/qiime2 && \
    conda clean --all && \
    rm $YML

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

LABEL homepage=https://qiime2.org/
LABEL description="QIIME 2 is a next-generation microbiome bioinformatics platform that is extensible, free, open source, and community developed."
LABEL moduleclass=bio

ENTRYPOINT ["qiime"]
