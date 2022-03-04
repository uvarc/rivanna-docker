ARG VERSION=0.15.2

FROM uvarc/tensorflow:2.8.0 AS py
ARG VERSION

RUN apt-get update && apt-get install -y --no-install-recommends \
        libgomp1 && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
        open3d==$VERSION

LABEL maintainer=khs3z@virginia.edu \
      homepage=http://www.open3d.org \
      description="Open3D is an open-source library that supports rapid development of software that deals with 3D data." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["python"]
