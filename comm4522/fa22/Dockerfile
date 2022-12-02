FROM uvarc/comm4522:sp22

# 2022-11-17
RUN pip install --no-cache-dir plotly jupyter-dash

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/cuda/lib64:$LD_LIBRARY_PATH \
    LC_ALL=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://www.tensorflow.org \
      description="TensorFlow is an open-source software library for Machine Intelligence." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["python"]
