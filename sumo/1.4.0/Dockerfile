FROM debian:bullseye-slim
LABEL maintainer=rs7wz@virginia.edu

RUN apt-get update && apt-get install -y --no-install-recommends \
        sumo sumo-tools sumo-doc && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["sumo"]
