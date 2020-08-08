LightGBM 2.3.1 CLI

https://github.com/microsoft/LightGBM

Please refer to the tutorial:
https://lightgbm.readthedocs.io/en/latest/GPU-Tutorial.html

Usage on Rivanna:
```
module load singularity
singularity pull docker://uvarc/lightgbm:2.3.1
singularity run --nv lightgbm_2.3.1.sif <parameters>
```
