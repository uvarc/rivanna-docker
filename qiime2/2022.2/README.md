# QIIME 2

https://qiime2.org

## Contents

| Contents\QIIME 2 | 2022.2 | 2020.8 | 2020.6 |
|---|---|---|---|
|Python packages| [3.8](https://data.qiime2.org/distro/core/qiime2-2022.2-py38-linux-conda.yml) | [3.6](https://data.qiime2.org/distro/core/qiime2-2020.8-py36-linux-conda.yml) | [3.6](https://data.qiime2.org/distro/core/qiime2-2020.6-py36-linux-conda.yml) |
|[Empress](https://github.com/biocore/empress)           | Y | Y | N |
|[PICRUSt2](https://github.com/gavinmdouglas/q2-picrust2)| Y | Y | N |

## Usage on Rivanna
Pick the most convenient option for your workflow.

### Command line

Follow the instructions displayed upon loading the module.

### Python
```
singularity exec $CONTAINERDIR/qiime2-x.y.sif python <script.py>
```

If you need other Python packages:
```
singularity exec $CONTAINERDIR/qiime2-x.y.sif python -m pip install --user <package>
```
