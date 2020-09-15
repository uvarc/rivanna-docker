QIIME 2

https://qiime2.org

This container includes the following Python 3.6 packages:  
https://data.qiime2.org/distro/core/qiime2-2020.8-py36-linux-conda.yml

Version 2020.8+ is distroless which requires singularity 3.6+.

## Usage on Rivanna
Pick the most convenient option for your workflow.
### Command-line
```
module load singularity/3.6.1
singularity pull qiime docker://uvarc/qiime2:2020.8
./qiime
```

### Python
```
module load singularity/3.6.1
singularity pull docker://uvarc/qiime2:2020.8
singularity exec qiime2_2020.8.sif python <script.py>
```

If you need other Python packages, please run:
```
module load anaconda/5.2.0-py3.6
pip install --user <package>
```
