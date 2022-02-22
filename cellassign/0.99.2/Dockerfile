FROM rocker/ml:4.0.5
RUN R -e 'install.packages("tensorflow")'
RUN R -e 'tensorflow::install_tensorflow(version="2.4.0-gpu", extra_packages="tensorflow-probability")'

RUN apt-get update && apt-get install -y --no-install-recommends \
        libglpk40 && \
    rm -rf /var/lib/apt/lists/*

RUN R -e 'BiocManager::install("bluster")'
RUN R -e 'BiocManager::install("scran")'
RUN R -e 'devtools::install_github("Irrationone/cellassign")'

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/irrationone/cellassign \
      description="cellassign automatically assigns single-cell RNA-seq data to known cell types across thousands of cells accounting for patient and batch specific effects. Information about a priori known markers cell types is provided as input to the model in the form of a (binary) marker gene by cell-type matrix. cellassign then probabilistically assigns each cell to a cell type, removing subjective biases from typical unsupervised clustering workflows." \
      gpu=true \
      moduleclass="bio"

ENTRYPOINT ["Rscript"]
