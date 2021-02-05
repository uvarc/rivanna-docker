RAPIDS 0.17 

https://rapids.ai

CUDA 11.0, Python 3.7. Roughly equivalent to the official `base`, plus `ipykernel`. Image size is 40% smaller due to proper clean up and `conda-pack`.

Usage on Rivanna:
```
module load singularity
singularity pull docker://uvarc/rapidsai:0.17
singularity run --nv rapidsai_0.17.sif your_script.py
```

To install more packages:
```
./<sif> -m pip install --user <package>
```
