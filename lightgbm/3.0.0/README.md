LightGBM CLI

https://github.com/microsoft/LightGBM

Compiled with OpenCL. Versions 3+ are distroless and require singularity 3.6+.

[Tutorial](https://lightgbm.readthedocs.io/en/latest/GPU-Tutorial.html#dataset-preparation)

Usage on Rivanna:
```
module load singularity/3.6.1
singularity pull docker://uvarc/lightgbm:x.y.z
singularity run --nv lightgbm_x.y.z.sif <parameters>
```
