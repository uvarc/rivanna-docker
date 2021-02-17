FROM rocker/rstudio:4.0.3

RUN R -e "install.packages('BiocManager',dependencies=TRUE)"
RUN R -e "BiocManager::install(version='3.12',dependencies=TRUE)"
RUN R -e "install.packages('devtools')"
RUN R -e "BiocManager::install('remotes')"
RUN R -e "BiocManager::install('snpStats')"

RUN apt-get update && apt-get install -y --no-install-recommends \
        zlib1g-dev libbz2-dev liblzma-dev libxml2 libglpk-dev && \
    rm -rf /var/lib/apt/lists/*

RUN R -e "BiocManager::install('biovizBase')"
RUN R -e "BiocManager::install('ggbio')"
RUN R -e "devtools::install_github('uvarc/echolocatoR')"

RUN chown -R root:root /var/lib/rstudio-server && \
    chmod -R g=u /var/lib/rstudio-server

LABEL maintainer=rs7wz@virginia.edu
