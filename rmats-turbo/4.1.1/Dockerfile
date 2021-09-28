FROM mambaorg/micromamba:0.15.3 AS build
USER root

RUN micromamba create -p /rmats -c conda-forge \
        Cython=0.29.21 numpy=1.16.6 python==3.6.12 r-base=3.6.3 && \
    micromamba clean -ya

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        git wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/Xinglab/rmats-turbo/archive/refs/tags/v4.1.1.tar.gz && \
    tar xf v4.1.1.tar.gz && \
    rm -rf v4.1.1.tar.gz

ENV PATH=/rmats/bin:$PATH \
    LD_LIBRARY_PATH=/rmats/lib:$LD_LIBRARY_PATH

WORKDIR /tmp/rmats-turbo-4.1.1
RUN git clone https://github.com/Xinglab/PAIRADISE.git && Rscript install_r_deps.R

RUN apt-get update && apt-get install -y --no-install-recommends \
        cmake zlib1g-dev gfortran && \
    rm -rf /var/lib/apt/lists/*

RUN export GSL_LDFLAGS=$(/rmats/bin/gsl-config --libs) GSL_CFLAGS=$(/rmats/bin/gsl-config --cflags) && \
    make

FROM debian:bullseye-slim
COPY --from=build /rmats /rmats
COPY --from=build /tmp/rmats-turbo-4.1.1 /rmats-turbo-4.1.1

ENV PATH=/rmats/bin:$PATH \
    LD_LIBRARY_PATH=/rmats/lib:$LD_LIBRARY_PATH

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/Xinglab/rmats-turbo \
      description="rMATS turbo is the C/Cython version of rMATS (refer to http://rnaseq-mats.sourceforge.net). The major difference between rMATS turbo and rMATS is speed and space usage. rMATS turbo is 100 times faster and the output file is 1000 times smaller than rMATS. These advantages make analysis and storage of a large scale dataset easy and convenient." \
      moduleclass=bio

ENTRYPOINT ["python", "/rmats-turbo-4.1.1/rmats.py"]
