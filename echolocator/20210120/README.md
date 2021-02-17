echolocatoR

https://github.com/RajLabMSSM/echolocatoR

This container also includes samtools 1.11, htslib 1.11, and TensorFlow 1.15 with Python 3.7.9.

Usage on Rivanna:
```
module load singularity
singularity pull docker://uvarc/cnnpeaks:200913
singularity run --nv cnnpeaks_200913.sif [arugments]
```

The default command is `python CNNpeaks`. It is installed under `/opt/CNNPeaks`.
