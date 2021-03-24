OpenMM 7.5.0

https://github.com/openmm/openmm

Compiled with TINKER 8.8.3 and GPU support. This is based on `scratch` so Singularity 3.6+ is required. The default command is `dynamic_omm.x`.

Usage on Rivanna:
```
module load singularity
singularity pull docker://uvarc/openmm:7.5.0
```

The TINKER params directory is located in `/opt/tinker/params`.
