ARG VERSION=7.4.2
FROM debian:bullseye-slim AS build
ARG VERSION

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates \
        make gcc g++ gfortran \
        libopenjp2-7-dev libnetcdf-dev libnetcdff-dev libeccodes-dev \
        libhdf4-dev libhdf5-dev \
        vim python3 && \
    rm -rf /var/lib/apt/lists/*

# ESMF

WORKDIR /opt
RUN wget https://github.com/esmf-org/esmf/archive/refs/tags/ESMF_8_2_0.tar.gz && \
    tar xf ESMF_8_2_0.tar.gz && \
    rm ESMF_8_2_0.tar.gz 

RUN cd esmf-ESMF_8_2_0 && \
    export ESMF_DIR=/opt/esmf-ESMF_8_2_0 ESMF_INSTALL_PREFIX=/opt/esmf \
           ESMF_F90COMPILEOPTS="-O -fPIC -m64 -mcmodel=small -pthread -ffree-line-length-none -fopenmp -fallow-argument-mismatch" && \
    make -j4 && make install

# LISF
#https://github.com/NASA-LIS/LISF/archive/refs/tags/v7.4.2-public.tar.gz
RUN wget https://github.com/NASA-LIS/LISF/archive/refs/tags/v${VERSION}-public.tar.gz && \
    tar xf v${VERSION}-public.tar.gz && \
    rm v${VERSION}-public.tar.gz 

ARG SYSLIB=/usr/lib/x86_64-linux-gnu

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN cd /usr/include && \
    ln -sf /usr/include/hdf5/serial/* . && \
    ln -sf /usr/include/hdf/* .

ENV LD_LIBRARY_PATH=/opt/esmf/lib/libO/Linux.gfortran.64.mpiuni.default:$LD_LIBRARY_PATH

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
# Use HDF4? (1-yes, 0-no, default=1): 1
# Use HDF5? (1-yes, 0-no, default=1): 1
# Use HDFEOS? (1-yes, 0-no, default=1): 0
# Use MINPACK? (1-yes, 0-no, default=0): 0
# Use LIS-CRTM? (1-yes, 0-no, default=0): 0
# Use LIS-CMEM? (1-yes, 0-no, default=0): 0
# Use LIS-LAPACK? (1-yes, 0-no, default=0): 0
# Use LIS-MKL-LAPACK? (1-yes, 0-no, default=0): 0

# need to run compile to generate LIS_misc.h, but the configure.lis needs further editing
# - most INC and LIB directories are wrong
# - add -lr
RUN cd LISF-${VERSION}-public/lis && \
    export LIS_ARCH=linux_gfortran LIS_FC=gfortran LIS_CC=gcc \
           LIS_MODESMF=/opt/esmf/mod/modO/Linux.gfortran.64.mpiuni.default \
           LIS_LIBESMF=/opt/esmf/lib/libO/Linux.gfortran.64.mpiuni.default \
           LIS_OPENJPEG=$SYSLIB LIS_ECCODES=/usr/include LIS_NETCDF=/usr \
           LIS_HDF4=/usr LIS_HDF5=/usr && \
    printf '%s\n' 0 2 2 2 0 1 4 1 1 9 1 1 0 0 0 0 0 0 | ./configure

ADD configure.lis /opt/LISF-${VERSION}-public/lis/make/configure.lis 

RUN cd LISF-${VERSION}-public/lis/make && \
    make -j4

#Parallelism (0-serial, 1-dmpar, default=0): Optimization level (-3=strict checks with warnings, -2=strict checks, -1=debug, 0,1,2,3, default=2): Assume little/big_endian data format (1-little, 2-big, default=2): Use GRIBAPI/ECCODES? (0-neither, 1-gribapi, 2-eccodes, default=2): NETCDF version (3 or 4, default=4)?: NETCDF use shuffle filter? (1-yes, 0-no, default = 1): NETCDF use deflate filter? (1-yes, 0-no, default = 1): NETCDF use deflate level? (1 to 9-yes, 0-no, default = 9): Use HDF4? (1-yes, 0-no, default=1): Use HDF5? (1-yes, 0-no, default=1): Use HDFEOS? (1-yes, 0-no, default=1): Enable GeoTIFF support? (1-yes, 0-no, default=1): Enable LIBGEOTIFF support? (1-yes, 0-no, default=1): Include date/time stamp history? (1-yes, 0-no, default=1)
RUN cd LISF-${VERSION}-public/ldt && \
    export LDT_ARCH=linux_gfortran LDT_FC=gfortran LDT_CC=gcc \
           LDT_MODESMF=/opt/esmf/mod/modO/Linux.gfortran.64.mpiuni.default \
           LDT_LIBESMF=/opt/esmf/lib/libO/Linux.gfortran.64.mpiuni.default \
           LDT_OPENJPEG=$SYSLIB LDT_ECCODES=/usr/include LDT_NETCDF=/usr \
           LDT_HDF4=/usr LDT_HDF5=/usr && \
    printf '%s\n' 0 2 2 2 4 1 1 9 1 1 0 0 0 1 | ./configure

RUN cat /opt/LISF-${VERSION}-public/ldt/make/configure.ldt 

ADD configure.ldt /opt/LISF-${VERSION}-public/ldt/make/configure.ldt 

RUN cd LISF-${VERSION}-public/ldt/make && \
    make -j4

FROM python:3.9.16-slim-bullseye
ARG VERSION

COPY --from=build /opt/LISF-${VERSION}-public/lis/make/LIS /LIS
COPY --from=build /opt/LISF-${VERSION}-public/ldt/make/LDT /LDT
COPY --from=build /opt/esmf /opt/esmf

COPY --from=build \
    /lib/x86_64-linux-gnu/libgcc_s.so.1 \
    /lib/x86_64-linux-gnu/libgpg-error.so.0 \
    /lib/x86_64-linux-gnu/libkeyutils.so.1 \
    /lib/x86_64-linux-gnu/

COPY --from=build \
    /usr/lib/libdf.so.0 \
    /usr/lib/libmfhdf.so.0 \
    /usr/lib/

COPY --from=build \
    /usr/lib/x86_64-linux-gnu/libaec.so.0 \
    /usr/lib/x86_64-linux-gnu/libbrotlicommon.so.1 \
    /usr/lib/x86_64-linux-gnu/libbrotlidec.so.1 \
    /usr/lib/x86_64-linux-gnu/libcurl-gnutls.so.4 \
    /usr/lib/x86_64-linux-gnu/libeccodes.so.0 \
    /usr/lib/x86_64-linux-gnu/libeccodes_f90.so.0 \
    /usr/lib/x86_64-linux-gnu/libffi.so.7 \
    /usr/lib/x86_64-linux-gnu/libgcrypt.so.20 \
    /usr/lib/x86_64-linux-gnu/libgfortran.so.5 \
    /usr/lib/x86_64-linux-gnu/libgmp.so.10 \
    /usr/lib/x86_64-linux-gnu/libgnutls.so.30 \
    /usr/lib/x86_64-linux-gnu/libgomp.so.1 \
    /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2 \
    /usr/lib/x86_64-linux-gnu/libhdf5_serial.so.103 \
    /usr/lib/x86_64-linux-gnu/libhdf5_serial_fortran.so.102 \
    /usr/lib/x86_64-linux-gnu/libhdf5_serial_hl.so.100 \
    /usr/lib/x86_64-linux-gnu/libhogweed.so.6 \
    /usr/lib/x86_64-linux-gnu/libidn2.so.0 \
    /usr/lib/x86_64-linux-gnu/libjpeg.so.62 \
    /usr/lib/x86_64-linux-gnu/libk5crypto.so.3 \
    /usr/lib/x86_64-linux-gnu/libkrb5.so.3 \
    /usr/lib/x86_64-linux-gnu/libkrb5support.so.0 \
    /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2 \
    /usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2 \
    /usr/lib/x86_64-linux-gnu/libnetcdf.so.18 \
    /usr/lib/x86_64-linux-gnu/libnetcdff.so.7 \
    /usr/lib/x86_64-linux-gnu/libnettle.so.8 \
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

COPY --from=build /opt/LISF-${VERSION}-public/LICENSE.txt /LICENSE.txt
COPY --from=build /opt/LISF-${VERSION}-public/lis/LICENSES /LICENSES

ENV PATH=/:/opt/esmf/bin/binO/Linux.gfortran.64.mpiuni.default:$PATH \
    LD_LIBRARY_PATH=/opt/esmf/lib/libO/Linux.gfortran.64.mpiuni.default:$LD_LIBRARY_PATH

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["LIS"]
