ARG VERSION=0.6

FROM uvarc/pytorch:1.10.0 AS PY
ARG VERSION

RUN apt-get update && apt-get install -y --no-install-recommends build-essential \
&& rm -rf /var/lib/apt/lists/*

RUN pupip install --no-cache-dir --upgrade pip && \
pip install --no-cache-dir detectron2==$VERSION -f \
        https://dl.fbaipublicfiles.com/detectron2/wheels/cu102/torch1.10/index.html

LABEL maintainer=uvahrc \
      homepage=https://ai.facebook.com/tools/detectron2/ \
      description="Detectron2 is Facebook AI Research's next generation library that provides state-of-the-art \
                   detection and segmentation algorithms. It is the successor of Detectron and maskrcnn-benchmark." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["python"]