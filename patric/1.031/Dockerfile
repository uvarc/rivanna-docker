FROM debian:buster-slim
ARG VERSION=1.031
WORKDIR /opt

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates \
        libanyevent-perl \
        libanyevent-http-perl \
        libarchive-zip-perl \
        libcapture-tiny-perl \
        libclass-accessor-perl \
        libclass-load-perl \
        libclone-perl \
        libconfig-simple-perl \
        libcrypt-openssl-rsa-perl \
        libdbi-perl \
        libdancer2-perl \
        libdata-uuid-perl \
        libdatetime-perl \
        libdatetime-format-dateparse-perl \
        libdatetime-format-iso8601-perl \
        libdatetime-format-mysql-perl \
        libdatetime-timezone-perl \
        libdigest-md5-perl \
        libev-perl \
        libencode-perl \
        libexception-class-perl \
        libfile-copy-recursive-perl \
        libfile-homedir-perl \
        libfile-searchpath-perl \
        libfile-slurp-perl \
        libfile-spec-perl \
        libfile-which-perl \
        libgetopt-long-descriptive-perl \
        libio-socket-ssl-perl \
        libipc-run-perl \
        libjson-perl \
        libjson-any-perl \
        libjson-pp-perl \
        libjson-rpc-perl \
        libjson-xs-perl \
        liblog-log4perl-perl \
        libmime-base64-perl \
        libmath-round-perl \
        libmodule-metadata-perl \
        libmongodb-perl \
        libmoose-perl \
        libscope-guard-perl \
        libspreadsheet-parseexcel-perl \
        libspreadsheet-writeexcel-perl \
        libspreadsheet-xlsx-perl \
        libstorable-perl \
        libtemplate-perl \
        libterm-readkey-perl \
        libtext-table-perl \
        libtime-hires-perl \
        libtry-tiny-perl \
        liburi-perl \
        libxml-libxml-perl \
        libyaml-perl && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/PATRIC3/PATRIC-distribution/releases/download/$VERSION/patric-cli-$VERSION.deb && \
    dpkg -i patric-cli-$VERSION.deb && \
    rm patric-cli-$VERSION.deb 

ENV LC_ALL C

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=https://github.com/PATRIC3/PATRIC-distribution
LABEL description="PATRIC is an integration of different types of data and software tools that support research on bacterial pathogens."
LABEL moduleclass=bio
