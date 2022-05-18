ARG FEDORA=35

FROM fedora:${FEDORA}
ARG FEDORA

RUN dnf -y update && dnf -y install dnf-plugins-core && dnf clean all

RUN dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/${FEDORA}/winehq.repo && \
    dnf -y install \
        winehq-stable wine-mono && \
    dnf clean all

ENV WINEDEBUG=fixme-all \
    WINEARCH=win64

ENTRYPOINT ["wine"]
