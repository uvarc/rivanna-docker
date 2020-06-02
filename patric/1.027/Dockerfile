FROM centos:8.1.1911
LABEL maintainer=rs7wz@virginia.edu

ARG VERSION=1.027

RUN cd /opt && \
    curl -sLO https://github.com/PATRIC3/PATRIC-distribution/releases/download/$VERSION/patric-cli-$VERSION-1.el8.x86_64.rpm && \
    yum -y install *.rpm && \
    yum -y clean all && rm -rf /var/cache/yum && \
    rm *.rpm

ENV LC_ALL C

ENTRYPOINT ["p3-login"]
