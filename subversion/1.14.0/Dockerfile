FROM ubuntu:20.10 AS build
RUN apt-get update && apt-get install -y --no-install-recommends subversion && \
    rm -rf /var/lib/apt/lists/*

LABEL maintainer=rs7wz@virginia.edu
LABEL homepage=http://subversion.apache.org/
LABEL description="Subversion is an open source version control system."
LABEL moduleclass=tools

ENTRYPOINT ["svn"]
