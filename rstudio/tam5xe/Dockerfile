# RIV-12044
FROM rocker/rstudio:4.3.1
RUN apt-get update && apt-get install -y --no-install-recommends \
        cargo libcairo2-dev libfontconfig1-dev libgsl-dev libhdf5-dev \
        libharfbuzz-dev libfribidi-dev \
        libfreetype6-dev libtiff5-dev libjpeg-dev libpng-dev \
        libxml2-dev pkg-config zlib1g-dev \
    && rm -rf /var/lib/apt/lists*

RUN R -e "install.packages('BiocManager', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('devtools', dependencies=TRUE, repos='http://cran.rstudio.com/')"

RUN apt-get update && apt-get install -y --no-install-recommends \
        libpq-dev libudunits2-dev \
        libbz2-dev libglpk40 \
    && rm -rf /var/lib/apt/lists*
RUN R -e "devtools::install_github('GreenleafLab/ArchR', ref='master', repos = BiocManager::repositories())"
RUN R -e "library(ArchR); ArchR::installExtraPackages()"

RUN R -e "install.packages('tidyverse', dependencies=TRUE, repos='http://cran.rstudio.com/')"

RUN apt-get update && apt-get install -y --no-install-recommends \
        patch libfftw3-dev libmagick++-dev libavfilter-dev xz-utils \
        librsvg2-dev libgdal-dev libgeos-dev libwebp-dev libpoppler-cpp-dev \
    && rm -rf /var/lib/apt/lists*
RUN R -e "install.packages('Seurat', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggalluvial', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('fossil', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('rlang', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('gganimate', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('magick', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('scales', dependencies=TRUE, repos='http://cran.rstudio.com/')"
