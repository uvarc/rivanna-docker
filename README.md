# rivanna-docker

This repository contains Dockerfiles and Apptainer definition files for containers deployed on Rivanna, the high-performance computing cluster at the University of Virginia.

## Structure

<pre>
.
├── app1
│   ├── version1
│   │   ├── Dockerfile
│   │   └── README.md
│   └── version2
│       ├── Dockerfile
│       └── README.md
└── app2
    └── version1
        ├── Dockerfile
        └── README.md
</pre>

Each version should reside in its own directory with a `README.md`. Here is a suggested template:
````
<name of main app> <version> <any other important info>

<homepage of main app>

<any other apps/packages>

Usage on Rivanna:
```
module load apptainer
apptainer pull docker://uvarc/<app>:<tag>
./<app>_<tag>.sif
```
````

Individual `README.md` files are used as the Docker Hub repository overview.

To contribute, please visit the [wiki](https://github.com/uvarc/rivanna-docker/wiki) for instructions and tips.

## Popular images
| image | description | pulls |
|-------|-------------|-------|
| [alphafold](https://hub.docker.com/r/uvarc/alphafold) | Multistage build to reduce image size | ![Docker Pulls](https://img.shields.io/docker/pulls/uvarc/alphafold) |
| [deeplabcut](https://hub.docker.com/r/uvarc/deeplabcut) | DeepLabCut with Anipose | ![Docker Pulls](https://img.shields.io/docker/pulls/uvarc/deeplabcut) |
| [pytorch](https://hub.docker.com/r/uvarc/pytorch) | PyTorch with popular packages for Rivanna users | ![Docker Pulls](https://img.shields.io/docker/pulls/uvarc/pytorch) |
| [qiime2](https://hub.docker.com/r/uvarc/qiime2) | QIIME2 with proper clean up | ![Docker Pulls](https://img.shields.io/docker/pulls/uvarc/qiime2) |
| [tensorflow](https://hub.docker.com/r/uvarc/tensorflow) | TensorFlow with popular packages for Rivanna users | ![Docker Pulls](https://img.shields.io/docker/pulls/uvarc/tensorflow) |

## License
[MIT license](LICENSE)
