FROM python:3.6.14-slim-buster AS py

RUN apt-get update && apt-get install -y --no-install-recommends \
        git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone https://github.com/facebookresearch/stochastic_gradient_push.git

WORKDIR /opt/stochastic_gradient_push
RUN pip install --no-cache-dir .
RUN pip install --no-cache-dir ipykernel

FROM python:3.6.14-slim-buster
COPY --from=py /usr/local/lib/python3.6/site-packages /usr/local/lib/python3.6/site-packages
COPY --from=py /opt/stochastic_gradient_push /opt/stochastic_gradient_push

ENV LANG=C.UTF-8

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/facebookresearch/stochastic_gradient_push \
      description="Gossip-based distributed optimization algorithms implemented in PyTorch" \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["python"]
