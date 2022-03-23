# maskrcnn-benchmark

https://github.com/facebookresearch/maskrcnn-benchmark

## Versions

- Python 3.6
- CUDA 10.0
- PyTorch 1.1
- maskrcnn-benchmark commit 57eec25 (Nov 20, 2019)

## Usage on Rivanna

```bash
module load singularity
singularity pull docker://uvarc/maskrcnn-benchmark:0.1
singularity run --nv maskrcnn-benchmark_0.1.sif myscript.py
```
