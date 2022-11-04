ARG VERSION=3.1.0

FROM mambaorg/micromamba:1.0.0-bionic AS build
ARG VERSION
USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates \
        gcc g++ build-essential && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN wget https://github.com/nservant/HiC-Pro/archive/refs/tags/v${VERSION}.tar.gz && \
    tar xf v${VERSION}.tar.gz && \
    rm v${VERSION}.tar.gz

WORKDIR /tmp/HiC-Pro-${VERSION}
RUN micromamba create -p /HiC-Pro-env -f environment.yml && micromamba clean -a

ENV PATH=/HiC-Pro-env/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
        unzip && \
    rm -rf /var/lib/apt/lists/*

RUN make configure prefix=/ && \
    make install

FROM ubuntu:18.04
ARG VERSION

COPY --from=build /HiC-Pro-env /HiC-Pro-env
COPY --from=build /HiC-Pro_3.1.0 /HiC-Pro_3.1.0

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PATH=/HiC-Pro-env/bin:/HiC-Pro_${VERSION}/bin:$PATH \
    LD_LIBRARY_PATH=/HiC-Pro-env/lib:$LD_LIBRARY_PATH

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/nservant/HiC-Pro \
      description="An optimized and flexible pipeline for Hi-C data processing" \
      moduleclass=bio

ENTRYPOINT ["HiC-Pro"]
