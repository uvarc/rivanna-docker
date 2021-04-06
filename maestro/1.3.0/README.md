MAESTRO 1.3.0

https://github.com/liulab-dfci/MAESTRO

Usage on Rivanna:
```
module load singularity
singularity pull MAESTRO docker://uvarc/maestro:1.3.0
./MAESTRO -h
```

To install additional Python packages:
```
singularity exec MAESTRO pip install --user <package>
```
