FROM --platform=linux/386 ubuntu:16.04 AS lib

RUN apt-get update && \
    apt-get install -y \
        libgtk2.0-0 libglib2.0-0 libx11-6 libgcc1 \
        fontconfig fonts-noto \
        wget && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget http://serialbasics.free.fr/Serial_Cloner-Download_files/SerialCloner2-6.tar.gz && \
    tar xf SerialCloner2-6.tar.gz && \
    rm SerialCloner2-6.tar.gz

ENV PATH=/opt/SerialCloner2-6:$PATH \
    LD_LIBRARY_PATH=/usr/lib/i386-linux-gnu:/lib/i386-linux-gnu:/lib

ENTRYPOINT ["SerialCloner2.6.1"]
