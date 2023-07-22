FROM rocker/rstudio:4.3.1
RUN apt-get update && apt-get install -y --no-install-recommends \
        cargo libcairo2-dev libfontconfig1-dev libgsl-dev libhdf5-dev \
        libharfbuzz-dev libfribidi-dev \
        libfreetype6-dev libtiff5-dev libjpeg-dev libpng-dev \
        libpq-dev libudunits2-dev \
        libbz2-dev libglpk40 \
        libxml2-dev pkg-config zlib1g-dev \
        libgdal-dev libgeos-dev patch && \
    rm -rf /var/lib/apt/lists*

RUN R -e "install.packages('BiocManager', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "BiocManager::install('biomaRt')"

RUN R -e "BiocManager::install(c('biomaRt','S4Vectors', 'SummarizedExperiment', 'SingleCellExperiment', 'MAST', 'DESeq2', 'BiocGenerics', 'GenomicRanges', 'GenomeInfoDb', 'IRanges', 'rtracklayer', 'monocle', 'Biobase', 'limma', 'multtest'))"

RUN R -e "install.packages(c('devtools', 'dplyr'), dependencies=TRUE, repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('ggplot2', 'hdf5r'), dependencies=TRUE, repos='http://cran.rstudio.com/')"

RUN apt-get update && apt-get install -y --no-install-recommends \
        libfftw3-dev libmagick++-dev libxt-dev && \
    rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages(c('kableExtra', 'KernSmooth', 'knitr', 'limma', 'MultiK', 'org.Hs.eg.db', 'reshape2', 'rmarkdown'), dependencies=TRUE, repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('scran', 'Seurat', 'sva', 'tinytex', 'topGO'), dependencies=TRUE, repos='http://cran.rstudio.com/')"

RUN R -e "install.packages('devtools')"
RUN R -e "library(devtools); install_github('siyao-liu/MultiK')"
RUN R -e "BiocManager::install(c('limma', 'org.Hs.eg.db'))"
RUN R -e "BiocManager::install('scran')"
RUN R -e "BiocManager::install(c('sva', 'topGO'))"
