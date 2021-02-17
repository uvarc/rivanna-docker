echolocatoR

https://github.com/RajLabMSSM/echolocatoR

## Usage on Rivanna

### Command line

```
module load singularity
singularity pull docker://uvarc/echolocator:20210120
singularity exec echolocator_20210120.sif Rscript my_script.R
```

### RStudio
- Start a FastX Web or Desktop session.
- In a terminal, run:

```
module load singularity
singularity pull docker://uvarc/echolocator:20210120
./echolocator_20210120.sif
```
