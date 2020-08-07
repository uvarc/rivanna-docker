PyTorch 1.6.0

https://pytorch.org/

This container includes the following Python 3.7.7 packages:
- PyTorch-related packages:
    - TorchVision 0.7.0
    - TorchText 0.7.0
    - Torchaudio 0.6.0
    - BoTorch 0.3.0
    - Ignite 0.4.1
    - PyTorch Lightning 0.8.5
- Other packages:
    - LightGBM 2.3.1
    - NumPy 1.19.1
    - SciPy 1.5.2
    - Matplotlib 3.3.0
    - Seaborn 0.10.1
    - Pandas 1.1.0
    - Scikit-learn 0.23.2
    - Scikit-image 0.17.2
    - OpenSlide-Python 1.1.1
    - OpenCV 4.3.0.36

Usage on Rivanna:
```
module load singularity
singularity pull docker://uvarc/pytorch:1.6.0
singularity run --nv pytorch_1.6.0.sif your_script.py
```
