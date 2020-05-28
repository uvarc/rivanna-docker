FROM node:14.3.0-slim
LABEL maintainer=rs7wz@virginia.edu

ARG VERSION=0.0.10

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates wget \
        libasound2 \
        libgtk-3-0 \
        libnotify4 \
        libnss3 \
        libxss1 \
        libxtst6 \
        xdg-utils \
        libatspi2.0-0 \
        libappindicator3-1 \
        libsecret-1-0 && \
    cd /opt && \
    wget https://github.com/DocNow/hydrator/releases/download/v${VERSION}/hydrator_${VERSION}_amd64.deb && \
    dpkg --add-architecture amd64 && dpkg -i *.deb && \
    rm *.deb && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /opt/Hydrator:$PATH
ENV LC_ALL C

ENTRYPOINT ["/opt/Hydrator/hydrator"]
