# https://hub.docker.com/r/ananace/skopeo/dockerfile
# modified Ruoshi Sun 2020-07-04

FROM golang:1.14.4 AS build

ARG VERSION=1.1.0

WORKDIR /opt

RUN wget -q https://github.com/containers/skopeo/archive/v${VERSION}.tar.gz && \
    tar xf v${VERSION}.tar.gz -C $GOPATH/src && \
    cd $GOPATH/src/skopeo-${VERSION} && \
    make binary-local-static DISABLE_CGO=1 && \
    mv skopeo /opt && \
    mkdir -p /etc/containers && \
    cp default-policy.json /etc/containers/policy.json

FROM frolvlad/alpine-glibc

COPY --from=build /opt/skopeo /opt/skopeo
COPY --from=build /etc/containers /etc/containers

RUN apk add --no-cache ca-certificates

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://github.com/containers/skopeo
LABEL description="skopeo is a command line utility that performs various operations on container images and image repositories."
LABEL moduleclass=tools

ENTRYPOINT ["/opt/skopeo"]
