TensorFlow

https://tensorflow.org/

## Tags
We are experimenting with the distroless base image starting from version 2.3.0, which requires singularity 3.6+. This applies to all tags (`cpu`, `distroless`, `slim`, `base`). Go through the next section to decide which tag to use.

We recommend `base` for use on Rivanna.

### Which tag should I use?

Move right if "no"; down if "yes"

- Do you intend to use this on a GPU? -- no --> `cpu`
- Does your computer/platform have CUDA and cuDNN? -- no --> `distroless`
- Do you need preinstalled Python packages? -- no --> `slim`
- `base`

### Details

- `cpu`
    - can only run on CPU
    - all tags without `cpu` can run on GPU
    - usage on Rivanna:
        ```
        module load singularity/3.6.1
        singularity pull docker://uvarc/tensorflow:x.y.z-cpu
        singularity run tensorflow_x.y.z-cpu.sif your_script.py
        ```
- `distroless`
    - contains necessary CUDA libraries
    - usage on Rivanna:
        ```
        module load singularity/3.6.1
        singularity pull docker://uvarc/tensorflow:x.y.z-distroless
        singularity run --nv tensorflow_x.y.z-distroless.sif your_script.py
        ```
- `slim`
    - does not contain CUDA libraries that are present in Rivanna's `cuda` and `cudnn` modules
    - need to bind mount `/apps` at runtime on Rivanna
    - usage on Rivanna:
        ```
        module load singularity/3.6.1
        singularity pull docker://uvarc/tensorflow:x.y.z-slim
        singularity run --nv -B /apps tensorflow_x.y.z-slim.sif your_script.py
        ```
- `base`
    - extends `slim` with preinstalled Python packages (see below)
    - usage on Rivanna: same as `slim`

## Preinstalled Python Packages
**Bold: contained in all tags**

| Package\Tensorflow| 2.3.0 | 2.2.0 |
|---|---|---| 
|**Python**   | 3.7.3   | 3.7.7   |
|**NumPy**    | 1.18.5  | 1.18.4  |
|**SciPy**    | 1.4.1   | 1.4.1   |
|Keras        | 2.4.3   | 2.3.1   |
|Keras-vis    | 0.4.1   | 0.4.1   |
|Matplotlib   | 3.3.1   | 3.2.1   |
|Seaborn      | 0.10.1  | 0.10.1  |
|Pandas       | 1.1.1   | 1.0.4   |
|Scikit-learn | 0.23.2  | 0.23.1  |
|Scikit-image | 0.17.2  | 0.17.2  |
|OpenCV       | 4.4.0.42| 4.2.0.32|

To install more packages:
```
singularity exec <sif> python -m pip install --user <package>
```
