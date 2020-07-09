FROM continuumio/miniconda3:4.8.2

RUN mkdir -p /usr/share/man/man1 && \
    apt-get update && apt-get install -y --no-install-recommends \
        build-essential gcc \
        db5.3-util \
        libssl-dev \
        libbz2-dev \
        libmcpp-dev \
        libdb++-dev \
        libdb-dev \
        nginx \
        libtiff5-dev \
        libjpeg62-turbo-dev \
        zlib1g-dev \
        libfreetype6-dev \
        liblcms2-dev \
        libwebp-dev \
        tcl8.6-dev \
        tk8.6-dev \
        unzip \
        default-jdk && \
    rm -rf /var/lib/apt/lists/*

ENV OMERO_ROOT /opt/omero
ENV OMERODIR $OMERO_ROOT/OMERO.server
ENV LC_ALL=C
WORKDIR $OMERO_ROOT

ARG SERVER_VERSION=5.6.1
ARG VERSION_SUFFIX=ice36-b225
ARG INSIGHT_VERSION=5.5.11

# install Ice 3.6.5
RUN conda install -c ome -c conda-forge \
        zeroc-ice36-python==3.6.5 omero-py ipykernel numpy pillow opencv && \
    conda clean --all

# install OMERO.insight
RUN wget -q https://github.com/ome/omero-insight/releases/download/v${INSIGHT_VERSION}/OMERO.insight-${INSIGHT_VERSION}.zip --no-check-certificate -O ./omero-insight.zip && \
    unzip omero-insight.zip && \
    mv OMERO.insight-${INSIGHT_VERSION} OMERO.insight && \
    rm omero-insight.zip

# install OMERO Python bindings
RUN wget -q https://github.com/ome/openmicroscopy/releases/download/v${SERVER_VERSION}/OMERO.server-${SERVER_VERSION}-${VERSION_SUFFIX}.zip --no-check-certificate -O ./omeropy.zip && \
    unzip omeropy.zip && \
    mv OMERO.server-${SERVER_VERSION}-${VERSION_SUFFIX} $OMERODIR && \
    rm omeropy.zip

ENV PATH $OMERODIR/bin:$OMERO_ROOT/OMERO.insight:$PATH
ENV PYTHONPATH $OMERODIR/lib/python:$PYTHONPATH

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["python"]
