TensorFlow

https://tensorflow.org/

## Tags
We are experimenting with the distroless base image starting from version 2.3.0, which requires singularity 3.6+. This applies to all tags (`x.y.z`, `x.y.z-cpu`, `x.y.z-distroless`). Go through the next section to decide which to pull.

We recommend `x.y.z` for use on Rivanna.

### Which tag should I use?

Move right if "no"; down if "yes"

- Do you intend to use this on a GPU? --(no)--> `x.y.z-cpu`
- Do you need preinstalled Python packages? --(no)--> `x.y.z-distroless`
- `x.y.z`

### Details

- `x.y.z-cpu`
    - can only run on CPU
    - all tags without `cpu` can run on GPU
    - usage on Rivanna:
        ```
        module load singularity
        singularity pull docker://uvarc/tensorflow:x.y.z-cpu
        ./tensorflow_x.y.z-cpu.sif your_script.py
        ```
- `x.y.z-distroless`
    - contains necessary CUDA libraries
    - usage on Rivanna:
        ```
        module load singularity
        singularity pull docker://uvarc/tensorflow:x.y.z-distroless
        singularity run --nv tensorflow_x.y.z-distroless.sif your_script.py
        ```
- `x.y.z`
    - extends `x.y.z-distroless` with preinstalled Python packages (see below)
    - usage on Rivanna:
        ```
        module load singularity
        singularity pull docker://uvarc/tensorflow:x.y.z
        singularity run --nv tensorflow_x.y.z.sif your_script.py
        ```

## Preinstalled Python Packages
**Bold: contained in all tags**

| Package\Tensorflow| 2.4.0 | 2.3.0 | 2.2.0 | 1.5.1 |
|---|---|---|---|---|
|**Python**   | 3.7.3   | 3.7.3   | 3.7.7   | 2.7.16 |
|**NumPy**    | 1.19.4  | 1.18.5  | 1.18.4  | 1.16.6 |
|**SciPy**    | 1.5.4   | 1.4.1   | 1.4.1   | 1.2.3 |
|Keras        | 2.4.3   | 2.4.3   | 2.3.1   | 2.2.5 |
|Keras-vis    | 0.4.1   | 0.4.1   | 0.4.1   | |
|Matplotlib   | 3.3.3   | 3.3.1   | 3.2.1   | |
|Seaborn      | 0.11.0  | 0.10.1  | 0.10.1  | |
|Pandas       | 1.1.5   | 1.1.1   | 1.0.4   | |
|Scikit-learn | 0.23.2  | 0.23.2  | 0.23.1  | 0.20.4 |
|Scikit-image | 0.17.2  | 0.17.2  | 0.17.2  | |
|OpenCV       | 4.4.0.46| 4.4.0.42| 4.2.0.32| 4.2.0.32 |

To install more packages:
```
./<sif> -m pip install --user <package>
```
