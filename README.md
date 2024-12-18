# rivanna-docker

This repository contains Dockerfiles (before 2024) and Apptainer definition files for containers deployed on the high-performance computing cluster at the University of Virginia.

Since 2024 we can build Apptainer containers natively on the cluster, which eliminates the need for Docker.

## Structure

<pre>
.
├── app1
│   ├── version1
│   │   ├── Dockerfile
│   │   └── README.md
│   └── version2
│       └── app1-version2.def
└── app2
    └── version1
        ├── Dockerfile
        └── README.md
</pre>

Individual `README.md` files are used as the Docker Hub repository overview.

To contribute, please visit the [wiki](https://github.com/uvarc/rivanna-docker/wiki) for instructions and tips.

## Popular images
| image | description | pulls |
|-------|-------------|-------|
| [alphafold](https://hub.docker.com/r/uvarc/alphafold) | Multistage build to reduce image size | ![Docker Pulls](https://img.shields.io/docker/pulls/uvarc/alphafold) |
| [deeplabcut](https://hub.docker.com/r/uvarc/deeplabcut) | DeepLabCut with Anipose | ![Docker Pulls](https://img.shields.io/docker/pulls/uvarc/deeplabcut) |
| [pytorch](https://hub.docker.com/r/uvarc/pytorch) | PyTorch with popular packages for HPC users | ![Docker Pulls](https://img.shields.io/docker/pulls/uvarc/pytorch) |
| [qiime2](https://hub.docker.com/r/uvarc/qiime2) | QIIME2 with proper clean up | ![Docker Pulls](https://img.shields.io/docker/pulls/uvarc/qiime2) |
| [tensorflow](https://hub.docker.com/r/uvarc/tensorflow) | TensorFlow with popular packages for HPC users | ![Docker Pulls](https://img.shields.io/docker/pulls/uvarc/tensorflow) |

## License
[MIT license](LICENSE)

## Citation

R. Sun and K. Siller, HPC Container Management at the University of Virginia, PEARC '24: Practice and Experience in Advanced Research Computing 2024: Human Powered Computing 73, 1 (2024). [doi:10.1145/3626203.3670568](https://doi.org/10.1145/3626203.3670568)
