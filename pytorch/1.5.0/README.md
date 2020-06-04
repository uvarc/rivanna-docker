PyTorch 1.5.0

https://pytorch.org/

This container includes the following Python 3.7.7 packages:
- PyTorch-related packages:
    - TorchVision 0.6.0
    - TorchText 0.6.0
    - Torchaudio 0.5.0
    - BoTorch 0.2.5
    - Ignite 0.3.0
    - PyTorch Lightning 0.7.6
- Other packages:
    - NumPy 1.18.1
    - SciPy 1.4.1
    - Matplotlib 3.1.3
    - Seaborn 0.10.1
    - Pandas 1.0.4
    - Scikit-learn 0.23.1
    - Scikit-image 0.17.2
    - OpenSlide-Python 1.1.1
    - OpenCV 4.2.0.34

Usage on Rivanna:
```
module load singularity
singularity pull docker://uvarc/pytorch:1.5.0
singularity run --nv pytorch_1.5.0.sif your_script.py
```
