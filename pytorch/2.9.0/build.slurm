#!/bin/bash
#SBATCH -A hpc_build
#SBATCH -p standard
#SBATCH -c 1
#SBATCH --mem=120G
#SBATCH -t 2:0:0

VERSION=2.9.0
module purge
ml apptainer
apptainer build pytorch-${VERSION}.sif pytorch-${VERSION}.def
