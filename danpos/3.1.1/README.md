DANPOS3 3.1.1

https://sites.google.com/site/danposdoc/

This container provides the following applications:
- Python 3.7.6
    - NumPy 1.18.5
    - rpy2 3.3.3
    - argparse 1.1
    - Pysam 0.16.0.1
- R 4.0.2
- Samtools 1.7

Usage on Rivanna:
```
module load singularity
singularity pull docker://uvarc/danpos:3.1.1
./danpos_3.1.1.sif your_script.py
```
