DragoNN 0.4.1

https://kundajelab.github.io/dragonn/

This container includes the following Python 3.7.3 packages:
- NumPy 1.16
- Matplotlib 3.3.3
- TensorFlow 1.15
- Scikit-learn 0.23.1

Usage on Rivanna:
```
module load singularity/3.6.1
singularity pull docker://uvarc/dragonn:0.4.1
singularity run --nv dragonn_0.4.1.sif your_script.py
```

If you need other Python packages, please run:
```
./dragonn_0.4.1.sif -m pip install --user <package>
```
