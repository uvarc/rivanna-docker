FROM python:3.8-slim-buster
USER root

RUN pip3 install --upgrade pip 
RUN apt-get update && apt-get install -y --no-install-recommends \
	gcc \
	zlib1g-dev \
        g++ \
	openexr \
	libopenexr-dev 
RUN pip install openexr

LABEL maintainer=hpc-support@virginia.edu \
      homepage=https://github.com/jamesbowman/openexrpython \
      description="The pip package for OpenEXR Python bindings." \
      gpu=false \
      moduleclass=data

ENTRYPOINT ["python"]
