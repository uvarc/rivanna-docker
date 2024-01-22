FROM nvcr.io/nvidia/tensorflow:23.08-tf2-py3

RUN pip install --no-cache-dir \
        seaborn==0.12.2 \
        scikit-image==0.21.0 \
        openslide-python==1.3.0 \
        opencv-python==4.8.0.76 \
        sox ipywidgets 

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://www.tensorflow.org \
      description="TensorFlow is an open-source software library for Machine Intelligence." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["/opt/nvidia/nvidia_entrypoint.sh", "python"]
