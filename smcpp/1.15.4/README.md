SMC++ 1.15.4 Python 3.7

https://github.com/popgenmethods/smcpp

Usage on Rivanna:
```
module load singularity
singularity pull smc++ docker://uvarc/smcpp:1.15.4
./smc++ -h
```

To install additional Python packages:
```
singularity exec smc++ pip install <package>
```
