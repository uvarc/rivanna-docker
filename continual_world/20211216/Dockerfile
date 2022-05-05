FROM uvarc/mujoco-py:2.0.2.5
USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
        git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone https://github.com/awarelab/continual_world.git && \
    cd continual_world && \
    pip install --no-cache-dir .

USER 1000

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/awarelab/continual_world \
      description="Continual World is a benchmark for continual reinforcement learning. It contains realistic robotic tasks which come from MetaWorld." \
      gpu=true \
      moduleclass=phys

ENTRYPOINT ["python"]
