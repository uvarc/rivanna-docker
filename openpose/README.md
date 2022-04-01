# OpenPose

https://github.com/CMU-Perceptual-Computing-Lab/openpose

## Notes

- The 1.7.0 tag here is actually commit `607a012` (Mar 24, 2022).
- CUDA 11.4.2
- No Python/C++ API
- Entrypoint is `openpose.bin`

## Usage on Rivanna

To get a display, please request an OOD Desktop session.

Using the `video.avi` as an example, first download the file from https://github.com/CMU-Perceptual-Computing-Lab/openpose/blob/master/examples/media/video.avi

```bash
singularity pull docker://uvarc/openpose:x.y.z
singularity run --nv --pwd /openpose openpose_x.y.z.sif --video $PWD/video.avi --face --hand --write_json $PWD/output_json_folder
```
