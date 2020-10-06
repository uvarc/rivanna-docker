FROM debian:buster-slim
RUN apt-get update && apt-get install -y --no-install-recommends ps2eps && \
    rm -rf /var/lib/apt/lists/*

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["/usr/bin/ps2eps"]
