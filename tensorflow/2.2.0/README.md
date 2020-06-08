TensorFlow 2.2.0

https://tensorflow.org/

This container includes the following Python 3.7.5 packages:
- NumPy 1.18.4
- SciPy 1.4.1
- Matplotlib 3.2.1
- Seaborn 0.10.1
- Pandas 1.0.4
- Scikit-learn 0.23.1
- Scikit-image 0.17.2
- OpenCV 4.2.0.34

Usage on Rivanna:
```
module load singularity
singularity pull docker://uvarc/tensorflow:2.2.0
singularity run --nv tensorflow_2.2.0.sif your_script.py
```

If you need other Python packages, please run:
```
singularity shell tensorflow_2.2.0.sif
python -m pip install --user <package>
```
