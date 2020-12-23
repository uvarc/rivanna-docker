DragoNN 0.4.1

https://kundajelab.github.io/dragonn/

This container includes the following Python 3.7.3 packages:
- NumPy 1.16.0
- Matplotlib 3.3.3
- TensorFlow 1.15
- Scikit-learn 0.23.2

Usage on Rivanna:
```
module load singularity/3.6.1
singularity pull docker://uvarc/dragonn:0.4.1
singularity run --nv dragonn_0.4.1.sif -h
```

If you need other Python packages, please run:
```
singularity exec dragonn_0.4.1.sif pip install --user <package>
```
