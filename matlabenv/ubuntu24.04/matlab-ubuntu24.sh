#!/bin/bash
# Instructions:
# - Build matlabenv.sif from the definition file
# - Adjust the path to sif and version
# - Copy the license token from the matlab module
SIF=/path/to/matlabenv.sif
MATLAB_VERSION=R2025b
module purge
ml apptainer
apptainer exec \
    -B /sfs/gpfs/tardis/applications/vendor/production/software/matlab:/apps/software/vendor/matlab \
    --env PATH=/apps/software/vendor/matlab/${MATLAB_VERSION}/bin:$PATH \
    --env MALLOC_ARENA_MAX=2 \
    --env MLM_LICENSE_TOKEN="(copy from modulefile)" \
    $SIF matlab
