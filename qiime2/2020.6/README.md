QIIME 2020.6

https://qiime2.org

This container includes the following Python 3.7.6 packages:
https://data.qiime2.org/distro/core/qiime2-2020.6-py36-linux-conda.yml

Usage on Rivanna:
```
module load singularity
singularity pull docker://uvarc/qiime2:2020.6
./qiime2_2020.6.sif
```

If you need other Python packages, please run:
```
singularity shell qiime2_2020.6.sif
pip install --user <package>
```
