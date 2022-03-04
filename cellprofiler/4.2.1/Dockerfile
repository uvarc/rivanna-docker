FROM mambaorg/micromamba:0.22.0 AS build
USER root

RUN micromamba create -p /cp4 -c conda-forge -c anaconda -c bioconda \
        python=3.8 \
        numpy \
        matplotlib \
        pandas \
        mysqlclient \
        openjdk \
        scikit-learn \
        mahotas \
        gtk2 \
        Jinja2=3.0.1 \
        inflect=5.3.0 \
        wxpython=4.1.0 \
        mysqlclient=1.4.4 \
        sentry-sdk=0.18.0 && \
    micromamba clean -ya

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc g++ libstdc++-10-dev && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=/cp4/bin:$PATH \
    JAVA_HOME=/cp4

RUN pip install --no-cache-dir cellprofiler==4.2.1

RUN apt-get update && apt-get install -y --no-install-recommends \
        lsof && \
    rm -rf /var/lib/apt/lists/*

FROM debian:bullseye-slim
COPY --from=build /cp4 /cp4

ENV PATH=/cp4/bin:$PATH \
    JAVA_HOME=/cp4 \
    LC_ALL=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/CellProfiler/CellProfiler \
      description="CellProfiler is a free open-source software designed to enable biologists without training in computer vision or programming to quantitatively measure phenotypes from thousands of images automatically." \
      moduleclass="bio"

ENTRYPOINT ["cellprofiler"]

