FROM continuumio/miniconda3:4.9.2 AS build

RUN conda install -c conda-forge mamba conda-pack && \
    mamba create -n funannotate python=2.7 funannotate=1.8.3 -c bioconda -c conda-forge && \
    conda clean -ya

WORKDIR /funannotate
RUN conda-pack -n funannotate -o /tmp/funannotate.tar && \
    tar xf /tmp/funannotate.tar && \
    rm /tmp/funannotate.tar

FROM debian:buster-slim
COPY --from=build /funannotate /funannotate

ENV PATH=/funannotate/bin:$PATH

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["funannotate"]
