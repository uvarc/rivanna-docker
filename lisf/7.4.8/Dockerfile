FROM debian:buster-slim AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates \
        make gcc g++ gfortran \
        libopenjp2-7-dev libnetcdf-dev libnetcdff-dev libeccodes-dev && \
    rm -rf /var/lib/apt/lists/*

# ESMF

WORKDIR /opt
RUN wget https://github.com/esmf-org/esmf/archive/refs/tags/ESMF_8_2_0.tar.gz && \
    tar xf ESMF_8_2_0.tar.gz && \
    rm ESMF_8_2_0.tar.gz 

RUN cd esmf-ESMF_8_2_0 && \
    export ESMF_DIR=/opt/esmf-ESMF_8_2_0 ESMF_INSTALL_PREFIX=/opt/esmf && \
    make && make install

# LISF

RUN wget https://github.com/NASA-LIS/LISF/archive/refs/tags/v7.4.8-557WW.tar.gz && \
    tar xf v7.4.8-557WW.tar.gz && \
    rm v7.4.8-557WW.tar.gz 

ARG SYSLIB=/usr/lib/x86_64-linux-gnu

RUN apt-get update && apt-get install -y --no-install-recommends \
        vim python3 && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python

# Parallelism (0-serial, 1-dmpar, default=1): 0
# Optimization level (-3=strict checks with warnings, -2=strict checks, -1=debug, 0,1,2,3, default=2): 2
# Assume little/big_endian data format (1-little, 2-big, default=2): 2
# Use GRIBAPI/ECCODES? (0-neither, 1-gribapi, 2-eccodes, default=2): 2
# Enable AFWA-specific grib configuration settings? (1-yes, 0-no, default=0): 0
# Use NETCDF? (1-yes, 0-no, default=1): 1
# NETCDF version (3 or 4, default=4): 4
# NETCDF use shuffle filter? (1-yes, 0-no, default = 1): 1
# NETCDF use deflate filter? (1-yes, 0-no, default = 1): 1
# NETCDF use deflate level? (1 to 9-yes, 0-no, default = 9): 9
# Use HDF4? (1-yes, 0-no, default=1): 0
# Use HDF5? (1-yes, 0-no, default=1): 0
# Use HDFEOS? (1-yes, 0-no, default=1): 0
# Use MINPACK? (1-yes, 0-no, default=0): 0
# Use LIS-CRTM? (1-yes, 0-no, default=0): 0
# Use LIS-CMEM? (1-yes, 0-no, default=0): 0
# Use LIS-LAPACK? (1-yes, 0-no, default=0): 0
# Use LIS-MKL-LAPACK? (1-yes, 0-no, default=0): 0

# need to run compile to generate LIS_misc.h, but the configure.lis needs further editing
# - most INC and LIB directories are wrong
# - add -lr
RUN cd LISF-7.4.8-557WW/lis && \
    export LIS_ARCH=linux_gfortran LIS_FC=gfortran LIS_CC=gcc \
           LIS_MODESMF=/opt/esmf/mod/modO/Linux.gfortran.64.mpiuni.default \
           LIS_LIBESMF=/opt/esmf/lib/libO/Linux.gfortran.64.mpiuni.default \
           LIS_OPENJPEG=$SYSLIB LIS_ECCODES=/usr/include LIS_NETCDF=/usr && \
    printf '%s\n' 0 2 2 2 0 1 4 1 1 9 0 0 0 0 0 0 0 0 | ./configure

ADD configure.lis /opt/LISF-7.4.8-557WW/lis/make/configure.lis 

ENV LD_LIBRARY_PATH=/opt/esmf/lib/libO/Linux.gfortran.64.mpiuni.default:$LD_LIBRARY_PATH

RUN cd LISF-7.4.8-557WW/lis/make && \
    make -j4

FROM python:3.7.12-slim-buster

COPY --from=build /opt/LISF-7.4.8-557WW/lis/make/LIS /LIS
COPY --from=build /lib/x86_64-linux-gnu/libkeyutils.so.1 /lib/x86_64-linux-gnu/libkeyutils.so.1
COPY --from=build /opt/esmf /opt/esmf
COPY --from=build /usr/lib/gcc/x86_64-linux-gnu/8/libgcc_s.so.1 /usr/lib/gcc/x86_64-linux-gnu/8/libgcc_s.so.1
COPY --from=build \
    /usr/lib/x86_64-linux-gnu/libaec.so.0 \
    /usr/lib/x86_64-linux-gnu/libcurl-gnutls.so.4 \
    /usr/lib/x86_64-linux-gnu/libeccodes.so.0 \
    /usr/lib/x86_64-linux-gnu/libeccodes_f90.so.0 \
    /usr/lib/x86_64-linux-gnu/libffi.so.6 \
    /usr/lib/x86_64-linux-gnu/libgfortran.so.5 \
    /usr/lib/x86_64-linux-gnu/libgmp.so.10 \
    /usr/lib/x86_64-linux-gnu/libgnutls.so.30 \
    /usr/lib/x86_64-linux-gnu/libgomp.so.1 \
    /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2 \
    /usr/lib/x86_64-linux-gnu/libhdf5_serial.so.103 \
    /usr/lib/x86_64-linux-gnu/libhdf5_serial_hl.so.100 \
    /usr/lib/x86_64-linux-gnu/libhogweed.so.4 \
    /usr/lib/x86_64-linux-gnu/libidn2.so.0 \
    /usr/lib/x86_64-linux-gnu/libk5crypto.so.3 \
    /usr/lib/x86_64-linux-gnu/libkrb5.so.3 \
    /usr/lib/x86_64-linux-gnu/libkrb5support.so.0 \
    /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2 \
    /usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2 \
    /usr/lib/x86_64-linux-gnu/libnetcdf.so.13 \
    /usr/lib/x86_64-linux-gnu/libnetcdff.so.6 \
    /usr/lib/x86_64-linux-gnu/libnettle.so.6 \
    /usr/lib/x86_64-linux-gnu/libnghttp2.so.14 \
    /usr/lib/x86_64-linux-gnu/libopenjp2.so.7 \
    /usr/lib/x86_64-linux-gnu/libp11-kit.so.0 \
    /usr/lib/x86_64-linux-gnu/libpng16.so.16 \
    /usr/lib/x86_64-linux-gnu/libpsl.so.5 \
    /usr/lib/x86_64-linux-gnu/libquadmath.so.0 \
    /usr/lib/x86_64-linux-gnu/librtmp.so.1 \
    /usr/lib/x86_64-linux-gnu/libsasl2.so.2 \
    /usr/lib/x86_64-linux-gnu/libssh2.so.1 \
    /usr/lib/x86_64-linux-gnu/libstdc++.so.6 \
    /usr/lib/x86_64-linux-gnu/libsz.so.2 \
    /usr/lib/x86_64-linux-gnu/libtasn1.so.6 \
    /usr/lib/x86_64-linux-gnu/libunistring.so.2 \
    /usr/lib/x86_64-linux-gnu/

COPY --from=build /opt/LISF-7.4.8-557WW/LICENSE.txt /LICENSE.txt
COPY --from=build /opt/LISF-7.4.8-557WW/lis/LICENSES /LICENSES

ENV PATH=/:/opt/esmf/bin/binO/Linux.gfortran.64.mpiuni.default:$PATH \
    LD_LIBRARY_PATH=/opt/esmf/lib/libO/Linux.gfortran.64.mpiuni.default:$LD_LIBRARY_PATH

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["LIS"]
