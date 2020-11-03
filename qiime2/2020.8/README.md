QIIME 2

https://qiime2.org

This container includes [Empress](https://github.com/biocore/empress) and the following Python 3.6 packages:  
https://data.qiime2.org/distro/core/qiime2-2020.8-py36-linux-conda.yml

## Usage on Rivanna
Pick the most convenient option for your workflow.
### Command-line
```
module load singularity
singularity pull qiime docker://uvarc/qiime2:2020.8
./qiime
```

### Python
```
module load singularity
singularity pull docker://uvarc/qiime2:2020.8
singularity exec qiime2_2020.8.sif python <script.py>
```

If you need other Python packages, please run:
```
singularity exec qiime2_2020.8.sif python -m pip install --user <package>
```
