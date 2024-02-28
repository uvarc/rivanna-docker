FROM mambaorg/micromamba:1.5.6
COPY --chown=$MAMBA_USER:$MAMBA_USER sibbork.yml /tmp/sibbork.yml
RUN micromamba install -y -n base -f /tmp/sibbork.yml && \
    micromamba clean --all --yes

ENV PATH=/opt/conda/bin:$PATH \
    LD_LIBRARY_PATH=/opt/conda/lib:$LD_LIBRARY_PATH \
    PYTHONPATH=/opt/conda/lib/python3.7/site-packages

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "python"]
