ARG OMPI_VERSION=3.1.6

FROM gcc:9.2.0
ARG OMPI_VERSION \
    OMPI_DIR=/opt/ompi

RUN apt-get update && apt-get install -y --no-install-recommends \
        libibverbs-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR $OMPI_DIR
RUN wget -q https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-${OMPI_VERSION}.tar.gz && \
    tar xf openmpi-${OMPI_VERSION}.tar.gz && \
    rm openmpi-${OMPI_VERSION}.tar.gz && \
    cd openmpi-$OMPI_VERSION && \
    ./configure --prefix=$OMPI_DIR --enable-shared --with-verbs --enable-mpirun-prefix-by-default && \
    make install

ENV PATH=$OMPI_DIR/bin:$PATH \
    LD_LIBRARY_PATH=$OMPI_DIR/lib:$LD_LIBRARY_PATH \
    MANPATH=$OMPI_DIR/share/man:$MANPATH

WORKDIR /
ADD mpitest.c .
RUN mpicc -o mpitest mpitest.c
