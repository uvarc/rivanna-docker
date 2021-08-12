Container for DS 5110 with Spark 3.0

Usage on Rivanna:
```
module load singularity
singularity pull docker://uvarc/ds5110:spark3
jkrollout ds5110_spark3.sif "DS5110"
```

This will install a custom Jupyter kernel in your user space that you can access on JupyterLab.
