ARG VERSION=2.2a2

FROM ubuntu:18.04 AS build
ARG VERSION
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates \
        libxkbcommon-dev libxcb1-dev libgtk-3-dev \
        libglib2.0-dev mesa-common-dev libglu1-mesa-dev \
        build-essential qt5-default qt5-qmake libqt5opengl5-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /Muview2
RUN wget -q https://github.com/grahamrow/Muview2/archive/${VERSION}.tar.gz && \
    tar xf ${VERSION}.tar.gz && \
    cd Muview2-${VERSION} && \
    deploy/deployLinux.sh && \
    mv muview LICENSE .. && \
    cd .. && rm -rf Muview2-${VERSION} ${VERSION}.tar.gz

FROM ubuntu:18.04
COPY --from=build /Muview2 /Muview2
RUN apt-get update && apt-get install -y --no-install-recommends \
        qt5-default libqt5opengl5-dev && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /Muview2:$PATH

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["muview"]
