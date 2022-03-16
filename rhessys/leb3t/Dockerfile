FROM ubuntu:18.04 AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
        software-properties-common libxml2-dev libxslt-dev libbsd-dev ffmpeg vlc libudunits2-dev && \
    rm -rf /var/lib/apt/lists/*
        
RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable && \
    apt-get update && apt-get install -y --no-install-recommends \
        grass grass-dev libgdal-dev libproj-dev && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget && \
    rm -rf /var/lib/apt/lists/*

RUN wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba

RUN micromamba create -p /env python=3.7.9 -c conda-forge && \
    micromamba clean -ya

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc g++ \
        proj-data proj-bin && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=/env/bin:$PATH

ADD requirements1.txt .
RUN pip install --no-cache-dir -r requirements1.txt

ADD requirements2.txt .
RUN pip install --no-cache-dir -r requirements2.txt

RUN apt-get update && apt-get install -y --no-install-recommends \
        gdal-data gdal-bin && \
    rm -rf /var/lib/apt/lists/*

ADD requirements3.txt .
RUN pip install --no-cache-dir -r requirements3.txt
