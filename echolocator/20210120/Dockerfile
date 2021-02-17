FROM r-base:4.0.3

RUN R -e "install.packages('BiocManager',dependencies=TRUE)"
RUN R -e "BiocManager::install(version='3.12',dependencies=TRUE)"
RUN R -e "BiocManager::install('remotes')"
RUN R -e "remotes::install_github('RajLabMSSM/echolocatoR')"

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["Rscript"]
