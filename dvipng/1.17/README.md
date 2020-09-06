dvipng 1.17

https://ctan.org/pkg/dvipng

This is a distroless container which requires singularity 3.6+.

Usage on Rivanna:
```
module load singularity/3.6.1
singularity pull docker://uvarc/dvipng:1.17
./dvipng_1.17.sif
```

If other programs need `dvipng` in your PATH, please rename the container to `dvipng` and put it under e.g. `~/bin`:
```
mkdir ~/bin
mv /path/to/dvipng_1.17.sif ~/bin/dvipng
export PATH=~/bin:$PATH
```
You can now run `dvipng` directly.
