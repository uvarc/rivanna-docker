Container for DS 5559 with Spark 3.0

Usage on Rivanna:
```
module load singularity
singularity pull docker://uvarc/ds5559:spark3
jkrollout ds5559_spark3.sif "DS5559 Spark3"
```

This will install a custom Jupyter kernel in your user space that you can access on JupyterLab.
