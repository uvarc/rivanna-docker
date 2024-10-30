FROM mambaorg/micromamba:2.0.2-ubuntu24.10

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc g++ make \
        git ca-certificates && \
    rm -rf /var/lib/apt/lists/*

USER $MAMBA_USER
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

USER root
RUN git clone https://github.com/chr1shr/voro.git
RUN cd voro && sed -i 's/Wall/Wall -fPIC/' config.mk && \
    make && make install

RUN git clone https://github.com/richardjgowers/zeoplusplus.git
RUN cd zeoplusplus && make dylib

RUN cd zeoplusplus/cython_wrapper && \
    sed -i -e '11s#]$#, "/usr/local/include/voro++"]#' \
           -e '12s#]$#, "/usr/local/lib"]#' \
           setup_alt.py && \
    /opt/conda/bin/python setup_alt.py develop

RUN git clone https://github.com/learningmatter-mit/VOID.git
RUN cd VOID && /opt/conda/bin/pip install --no-cache-dir .

USER $MAMBA_USER
LABEL maintainer=rs7wz@virginia.edu
ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "python"]
