Nanopolish 0.13.2

https://github.com/jts/nanopolish

This is a distroless container that requires Singularity 3.6+.

Usage on Rivanna:
```
module load singularity/3.6.1
singularity pull docker://uvarc/nanopolish:0.13.2
./nanopolish_0.13.2.sif
```

The Python scripts are located in `/opt/nanopolish/scripts`. Example:
```
singularity exec nanopolish_0.13.2.sif python /opt/nanopolish/scripts/nanopolish_merge.py
```
