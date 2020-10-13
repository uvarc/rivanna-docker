FROM ubuntu:20.10 AS build
RUN apt-get update && apt-get install -y --no-install-recommends \
        vim && \
    rm -rf /var/lib/apt/lists/*

FROM ubuntu:20.10
RUN apt-get update && apt-get install -y --no-install-recommends \
        subversion && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/bin/vi /usr/bin/vi

COPY --from=build \
    /lib/x86_64-linux-gnu/libacl.so.1 \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libcanberra.so.0 \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libexpat.so.1 \
    /lib/x86_64-linux-gnu/libgpm.so.2 \
    /lib/x86_64-linux-gnu/libltdl.so.7 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libogg.so.0 \
    /lib/x86_64-linux-gnu/libpcre2-8.so.0 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libpython3.8.so.1.0 \
    /lib/x86_64-linux-gnu/libselinux.so.1 \
    /lib/x86_64-linux-gnu/libtdb.so.1 \
    /lib/x86_64-linux-gnu/libtinfo.so.6 \
    /lib/x86_64-linux-gnu/libutil.so.1 \
    /lib/x86_64-linux-gnu/libvorbis.so.0 \
    /lib/x86_64-linux-gnu/libvorbisfile.so.3 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    /lib/x86_64-linux-gnu/

RUN ln -s /usr/bin/vi /usr/bin/vim

ENV LC_ALL C

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=http://subversion.apache.org/
LABEL description="Subversion is an open source version control system."
LABEL moduleclass=tools

ENTRYPOINT ["svn"]
