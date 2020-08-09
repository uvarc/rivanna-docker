FROM continuumio/miniconda3:4.8.2 AS build

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

FROM continuumio/miniconda3:4.8.2
COPY --from=build /opt/samtools/bin /opt/samtools
WORKDIR /opt

RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        libbz2-dev libcurl4-openssl-dev libreadline-dev liblzma-dev \
        libncurses5-dev libncursesw5-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

RUN conda install -c conda-forge -c bioconda \
        python=3.7.6 \
        r-base=4.0.1 \
        numpy=1.18.5 \
        pysam=0.16.0.1 && \
    conda clean -a

RUN pip install --no-cache-dir \
        argparse==1.1 \
        rpy2==3.3.3

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
