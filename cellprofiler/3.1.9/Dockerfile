FROM openjdk:8-jdk-slim
LABEL maintainer=rs7wz@virginia.edu

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc curl \
        build-essential \
        libmariadb-dev-compat libmariadb-dev \
        libhdf5-dev \
        libxml2-dev \
        libxslt1-dev \
        python-dev \
        python-pip && \
    rm -rf /var/lib/apt/lists/*

ARG VERSION=3.1.9

RUN pip install --no-cache-dir setuptools wheel

RUN pip install --no-cache-dir \
        numpy==1.15.4 \
        centrosome==1.1.6 \
        docutils==0.15

RUN cd /opt && \
    curl -LO https://github.com/CellProfiler/CellProfiler/archive/v${VERSION}.tar.gz${TARBALL} && \
    tar xf v${VERSION}.tar.gz && \
    cd CellProfiler-${VERSION} && \
    pip install --no-cache-dir --editable . && \
    rm /opt/v${VERSION}.tar.gz

ENV PATH /opt/CellProfiler-${VERSION}:$PATH
ENV JAVA_TOOL_OPTIONS "-Xss1280k $JAVA_TOOL_OPTIONS"
ENV LC_ALL C

ENTRYPOINT ["cellprofiler"]
