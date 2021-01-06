FROM continuumio/miniconda3:4.9.2

RUN mkdir -p /usr/share/man/man1 && \
    apt-get update && apt-get install -y --no-install-recommends \
        zlib1g-dev libbz2-dev libcurl4-openssl-dev libssl-dev && \
    rm -rf /var/lib/apt/lists/*

RUN conda install -c conda-forge mamba && \
    mamba install -c liulab-dfci -c bioconda -c conda-forge maestro=1.3.0 && \
    conda clean -ya

ENV LC_ALL=C

LABEL homepage=https://github.com/liulab-dfci/MAESTRO
LABEL description="MAESTRO(Model-based AnalysEs of Single-cell Transcriptome and RegulOme) is a comprehensive single-cell RNA-seq and ATAC-seq analysis suit built using snakemake. MAESTRO combines several dozen tools and packages to create an integrative pipeline, which enables scRNA-seq and scATAC-seq analysis from raw sequencing data (fastq files) all the way through alignment, quality control, cell filtering, normalization, unsupervised clustering, differential expression and peak calling, celltype annotation and transcription regulation analysis."
LABEL moduleclass=bio
LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["MAESTRO"]
