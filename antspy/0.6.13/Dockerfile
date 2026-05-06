FROM python:3.13.13-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential ca-certificates git \
        libpng-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir antspyx==0.6.3

ENTRYPOINT ["python"]
