FROM gcc:11.3.0 AS build
ARG VERSION=0.10.0

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates \
        libisal2 libisal-dev libdeflate0 libdeflate-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget https://github.com/lilab-bcb/cumulus_feature_barcoding/archive/refs/tags/$VERSION.tar.gz && \
    tar xf $VERSION.tar.gz && \
    rm -rf $VERSION.tar.gz 

RUN cd cumulus_feature_barcoding-$VERSION && \
    make all

FROM scratch
COPY --from=build \
    /opt/cumulus_feature_barcoding-0.10.0/generate_count_matrix_ADTs \
    /opt/cumulus_feature_barcoding-0.10.0/LICENSE \
    /
COPY --from=build \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/
COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2
COPY --from=build \
    /usr/lib/x86_64-linux-gnu/libdeflate.so.0 \
    /usr/lib/x86_64-linux-gnu/libisal.so.2 \
    /usr/lib/x86_64-linux-gnu/
COPY --from=build \
    /usr/local/lib64/libgcc_s.so.1 \
    /usr/local/lib64/libstdc++.so.6 \
    /usr/local/lib64/

ENV LD_LIBRARY_PATH=/usr/local/lib64:/usr/lib/x86_64-linux-gnu:/lib/x86_64-linux-gnu/

LABEL maintainter=rs7wz@virginia.edu \
      homepage=https://github.com/lilab-bcb/cumulus_feature_barcoding \
      description="A fast C++ tool to extract feature-count matrix from sequence reads in FASTQ files. We uses isal-l for decompressing and Heng Li's kseq library for read parsing. It is used by Cumulus for feature-count matrix generation of cell hashing, nucleus hashing, CITE-Seq and Perturb-seq protocols, using either 10x Genomics V2 or V3 chemistry." \
      moduleclass=bio

ENTRYPOINT ["/generate_count_matrix_ADTs"]
