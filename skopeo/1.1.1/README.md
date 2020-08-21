skopeo 1.1

https://github.com/containers/skopeo

Note: Versions 1.1.1+ are distroless which requires singularity 3.6+

Usage on Rivanna:
```
module load singularity
singularity pull docker://uvarc/skopeo:1.1.0
./skopeo_1.1.0.sif

module load singularity/3.6.1
singularity pull docker://uvarc/skopeo:1.1.1
./skopeo_1.1.1.sif
```

