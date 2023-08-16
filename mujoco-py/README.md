# mujoco-py
https://github.com/openai/mujoco-py

## Usage

You must set `/` as `$HOME` and optionally mount your actual home to a different directory, say `/data`:

```
singularity run --nv -H / -B $HOME:/data mujoco-py_2.1.2.14.sif
```
