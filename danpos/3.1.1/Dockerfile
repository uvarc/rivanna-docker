FROM python:3.7.6-slim-buster AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates git build-essential \
        libbz2-dev libcurl4-openssl-dev libreadline-dev liblzma-dev \
        libncurses5-dev libncursesw5-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Samtools
ARG SAMTOOLS_VERSION=1.7
WORKDIR /opt/samtools
RUN wget -q https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
    tar xf samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
    cd samtools-${SAMTOOLS_VERSION} && \
    ./configure --prefix=/opt/samtools && make && make install

FROM python:3.7.6-slim-buster
COPY --from=build /opt/samtools/bin /opt/samtools
WORKDIR /opt

# R 4.0
RUN apt-get update && apt-get install -y --no-install-recommends \
        git gnupg \
        libbz2-dev libcurl4-openssl-dev libreadline-dev liblzma-dev \
        libncurses5-dev libncursesw5-dev zlib1g-dev && \
    echo "deb http://cloud.r-project.org/bin/linux/debian buster-cran40/" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keys.gnupg.net --recv-key FCAE2A0E115C3D8A && \
    apt-get update && apt-get install -y --no-install-recommends -t buster-cran40 r-base && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
        rpy2==3.3.3 \
        argparse==1.1 \
        numpy==1.18.5 \
        pysam==0.16.0.1

# Danpos
ARG DANPOS_VERSION=3.1.1
RUN git clone https://github.com/sklasfeld/DANPOS3.git

ENV DANPOS_HOME=/opt/DANPOS3
ENV SAMTOOLS_HOME=/opt/samtools
ENV PYTHONPATH=$DANPOS_HOME
ENV PATH=${SAMTOOLS_HOME}:$PATH
ENV LC_ALL=C

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://sites.google.com/site/danposdoc/
LABEL description="A toolkit for Dynamic Analysis of Nucleosome and Protein Occupancy by Sequencing"
LABEL moduleclass=bio

ENTRYPOINT ["python"]
