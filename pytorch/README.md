# PyTorch

https://pytorch.org/

## Tags

- `x.y.z` contains additional preinstalled Python packages (see below). **This is the recommended tag for most Rivanna users.**
- `x.y.z-<user>` is a custom container prepared for a specific user.

All are GPU-compatible.

## Usage on Rivanna
```
module load singularity
singularity pull docker://uvarc/pytorch:x.y.z
singularity run --nv pytorch_x.y.z.sif your_script.py
```

## Preinstalled Python Packages

| Package\PyTorch | 1.12.0 | 1.10.0 | 1.8.0/1 | 1.7.0 | 1.6.0 |
|---|---|---|---|---|---|
|Python            | 3.9.13  | 3.8.12  |3.7.3/3.8.8 | 3.7.3 | 3.7.3 | 
|NumPy             | 1.23.1  | 1.20.1  | 1.20.1  | 1.19.2  | 1.19.1  | 
|SciPy             | 1.8.1   | 1.6.1   | 1.6.1   | 1.5.3   | 1.5.2   |
|TorchVision       | 0.13.0  | 0.11.1  | 0.9.0/1 | 0.8.1   | 0.7.0   |
|Torchaudio        | 0.12.0  | 0.10.0  | 0.8.0/1 | 0.7.0   | 0.6.0   |
|PyTorch Lightning | 1.6.5+  | 1.5.3+  | 1.2.1+  | 1.0.3   | 0.8.5   |
|TorchText         | 0.13.0  | 0.11.0  | 0.9.0/1 | 0.8.0   | 0.7.0   |
|BoTorch           | 0.6.5   | 0.5.1   | 0.4.0   | 0.3.2   | 0.3.0   |
|Ignite            | 1.1.0   | 1.1.0   | 1.1.0   | 1.1.0   | 0.4.1   |
|LightGBM          |         |         |         | 2.3.1   |
|Matplotlib        | 3.5.2   | 3.5.0   | 3.3.4   | 3.3.2   | 3.3.0   |
|Seaborn           | 0.11.2  | 0.11.2  | 0.11.1  | 0.11.0  | 0.10.1  |
|Pandas            | 1.4.3   | 1.3.4   | 1.2.3   | 1.1.3   | 1.1.0   |
|Scikit-learn      | 1.1.1   | 1.0.1   | 0.24.1  | 0.23.2  | 0.23.2  |
|Scikit-image      | 0.19.3  | 0.18.3  | 0.18.1  | 0.17.2  | 0.17.2  |
|OpenSlide-Python  | 1.2.0   | 1.1.2   | 1.1.2   | 1.1.2   | 1.1.1   |
|OpenCV            | 4.6.0.66| 4.5.4.60| 4.5.1.48|4.4.0.44| 4.3.0.36|

To install more packages:
```
/path/to/sif -m pip install --user <package>
```
