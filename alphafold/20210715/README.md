# AlphaFold

https://github.com/deepmind/alphafold

The commit date is used as the tag, since there is no version.

## Notes on Dockerfile
Modified from official Dockerfile:
- `conda clean` -> saves ~1 GB
- added a second production stage without buildtime dependencies -> saves 0.45 GB

Overall the image size is ~2 GB smaller than that built from the official Dockerfile.

## Usage on Rivanna
```
module load singularity
singularity pull docker://uvarc/alphafold:20210715
```
