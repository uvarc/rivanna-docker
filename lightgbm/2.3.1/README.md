LightGBM 2.3.1

https://github.com/microsoft/LightGBM

This container also includes the following Python 3.7.7 packages:
- NumPy 1.19.1
- SciPy 1.5.2
- Matplotlib 3.3.0
- Pandas 1.1.0
- Scikit-learn 0.23.2

Usage on Rivanna:
```
module load singularity
singularity pull docker://uvarc/lightgbm:2.3.1
singularity run --nv lightgbm_2.3.1.sif <parameters>
```
