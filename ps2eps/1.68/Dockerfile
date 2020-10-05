FROM debian:buster-slim AS build
RUN apt-get update && apt-get install -y --no-install-recommends ps2eps && \
    rm -rf /var/lib/apt/lists/*

FROM scratch
COPY --from=build \
    /usr/bin/perl \
    /usr/bin/ps2eps \
    /usr/bin/

COPY --from=build /etc/perl /etc/perl
COPY --from=build /usr/share/perl5 /usr/share/perl5
COPY --from=build /usr/lib/x86_64-linux-gnu/perl/5.28 /usr/lib/x86_64-linux-gnu/perl/5.28
COPY --from=build /usr/share/perl/5.28 /usr/share/perl/5.28
COPY --from=build /usr/lib/x86_64-linux-gnu/perl-base /usr/lib/x86_64-linux-gnu/perl-base
COPY --from=build \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libcrypt.so.1 \
    /lib/x86_64-linux-gnu/
COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["/usr/bin/ps2eps"]
