FROM ubuntu:20.10 AS build
RUN apt-get update && apt-get install -y --no-install-recommends subversion && \
    rm -rf /var/lib/apt/lists/*

FROM scratch
COPY --from=build \
    /etc/subversion/config \
    /etc/subversion/servers \
    /etc/
COPY --from=build \
    /usr/bin/svn \
    /usr/bin/svnadmin \
    /usr/bin/svnauthz \
    /usr/bin/svnauthz-validate \
    /usr/bin/svnbench \
    /usr/bin/svndumpfilter \
    /usr/bin/svnfsfs \
    /usr/bin/svnlook \
    /usr/bin/svnmucc \
    /usr/bin/svnrdump \
    /usr/bin/svnserve \
    /usr/bin/svnsync \
    /usr/bin/svnversion \
    /usr/bin/
COPY --from=build \
    /lib/x86_64-linux-gnu/libapr-1.so.0 \
    /lib/x86_64-linux-gnu/libaprutil-1.so.0 \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libcom_err.so.2 \
    /lib/x86_64-linux-gnu/libcrypt.so.1 \
    /lib/x86_64-linux-gnu/libcrypto.so.1.1 \
    /lib/x86_64-linux-gnu/libdb-5.3.so \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libexpat.so.1 \
    /lib/x86_64-linux-gnu/libgssapi_krb5.so.2 \
    /lib/x86_64-linux-gnu/libk5crypto.so.3 \
    /lib/x86_64-linux-gnu/libkeyutils.so.1 \
    /lib/x86_64-linux-gnu/libkrb5.so.3 \
    /lib/x86_64-linux-gnu/libkrb5support.so.0 \
    /lib/x86_64-linux-gnu/liblz4.so.1 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libresolv.so.2 \
    /lib/x86_64-linux-gnu/libsasl2.so.2 \
    /lib/x86_64-linux-gnu/libserf-1.so.1 \
    /lib/x86_64-linux-gnu/libsqlite3.so.0 \
    /lib/x86_64-linux-gnu/libssl.so.1.1 \
    /lib/x86_64-linux-gnu/libsvn_client-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_delta-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_diff-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_fs-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_fs_base-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_fs_fs-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_fs_util-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_fs_x-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_ra-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_ra_local-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_ra_serf-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_ra_svn-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_repos-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_subr-1.so.1 \
    /lib/x86_64-linux-gnu/libsvn_wc-1.so.1 \
    /lib/x86_64-linux-gnu/libutf8proc.so.2 \
    /lib/x86_64-linux-gnu/libuuid.so.1 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    /lib/x86_64-linux-gnu/
COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2

COPY --from=build \
    /usr/share/bash-completion/completions/svn \
    /usr/share/bash-completion/completions/svnadmin \
    /usr/share/bash-completion/completions/svndumpfilter \
    /usr/share/bash-completion/completions/svnlook \
    /usr/share/bash-completion/completions/svnversion \
    /usr/share/

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["svn"]
