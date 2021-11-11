# AlphaFold

https://github.com/deepmind/alphafold

## Notes on Dockerfile
Overall the image size is ~3 GB smaller than that built from the official Dockerfile.

- `conda clean` -> saves ~1 GB
- Added a second production stage without buildtime dependencies -> saves ~0.5 GB
- No need to have system CUDA libraries -> saves ~1 GB

## Versions

| Package\AlphaFold| 2.0.1+ | 2.0.0 |
|---|---|---|
|python      | 3.8.12 | 3.8.10 |
|cudatoolkit | 11.0.3 | 11.0.3 |
|tensorflow  | 2.5.0  | 2.4.1 |

## Usage on HPC via Singularity

Please visit https://www.rc.virginia.edu/userinfo/rivanna/software/alphafold/
