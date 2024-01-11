FROM codercom/code-server:4.16.1-focal
USER root

RUN mkdir -p /var/lib/apt/lists/partial
RUN apt-get update && apt-get install -y --no-install-recommends python3-pip && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python

USER 1000

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/coder/code-server \
      description="Run VS Code on any machine anywhere and access it in the browser." \
      moduleclass=tools
