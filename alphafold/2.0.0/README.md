# AlphaFold

https://github.com/deepmind/alphafold

## Notes on Dockerfile
Modified from official Dockerfile.

### TensorFlow and missing cudnn/cusolver
Issue reported here: https://github.com/deepmind/alphafold/pull/28

Our solution:

- CUDA version kept at 11.0
- Downgraded Python to 3.8.10
- Downgraded TensorFlow to 2.4.1
- Added `libcudnn8` and `libcusolver-11-0` in production stage

### Image size reduction
Overall the image size is ~2 GB smaller than that built from the official Dockerfile.

- `conda clean` -> saves ~1 GB
- Added a second production stage without buildtime dependencies -> saves 0.45 GB

## Usage on HPC via Singularity

Please visit https://www.rc.virginia.edu/userinfo/rivanna/software/alphafold/
