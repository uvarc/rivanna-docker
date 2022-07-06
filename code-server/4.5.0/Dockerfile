FROM codercom/code-server:4.5.0
USER root

RUN mkdir -p /var/lib/apt/lists/partial
RUN apt-get update && apt-get install -y --no-install-recommends python3-pip && \
    rm -rf /var/lib/apt/lists/*

USER 1000

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/coder/code-server \
      description="Run VS Code on any machine anywhere and access it in the browser." \
      moduleclass=tools

ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]
