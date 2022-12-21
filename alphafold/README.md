# AlphaFold

https://github.com/deepmind/alphafold

## Notes on Dockerfile
On disk the image size is 5.4 GB, 47% smaller than that built from the official Dockerfile (10.1 GB).

Major differences:
- No need to have system CUDA libraries (all in conda env)
- Use micromamba as base image for build stage
- Three-stage build process to eliminate buildtime dependencies

## Versions

| Package\AlphaFold| 2.3.0 | 2.2.2 | 2.2.0, 2.1.2 | 2.1.1, 2.0.1 | 2.0.0 |
|---|---|---|---|---|---|
|python      | 3.8.15 | 3.8.13 | 3.8.12 | 3.8.12 | 3.8.10 |
|cudatoolkit | 11.1.1 | 11.1.1 | 11.1   | 11.0.3 | 11.0.3 |
|tensorflow  | 2.9.0  | 2.5.0  | 2.5.0  | 2.5.0  | 2.4.1 |

## Usage on HPC via Singularity

This image is fully compatible with Singularity. Please visit https://www.rc.virginia.edu/userinfo/rivanna/software/alphafold/ for instructions.
