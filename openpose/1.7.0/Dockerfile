FROM nvidia/cuda:11.4.2-cudnn8-devel-ubuntu20.04 AS build
USER root

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential cmake git \
    zlib1g \
    libgoogle-glog-dev \
    protobuf-compiler \
    libprotobuf-dev \
    libopencv-dev \
    libboost-all-dev \
    && rm -rf /var/lib/apt/lists/* && pkg-config --modversion opencv4

RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose
WORKDIR /openpose
RUN git submodule update --init --recursive --remote
RUN sed -i 's/sudo//g' scripts/ubuntu/install_deps.sh && \
    bash scripts/ubuntu/install_deps.sh && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir build && cd build && cmake .. && make -j `nproc`

FROM ubuntu:20.04
COPY --from=build /openpose/build/examples/openpose/openpose.bin /openpose/build/examples/openpose/openpose.bin
COPY --from=build /openpose/models /openpose/models
COPY --from=build /openpose/examples /openpose/examples
COPY --from=build /openpose/LICENSE /openpose/LICENSE
COPY --from=build /openpose/build/caffe/lib/libcaffe.so.1.0.0 /openpose/build/caffe/lib/libcaffe.so.1.0.0
COPY --from=build /openpose/build/src/openpose/libopenpose.so.1.7.0 /openpose/build/src/openpose/libopenpose.so.1.7.0
COPY --from=build \
    /lib/libarmadillo.so.9 \
    /lib/libdfalt.so.0 \
    /lib/libgdal.so.26 \
    /lib/libmfhdfalt.so.0 \
    /lib/libogdi.so.4.1 \
    /lib/

COPY --from=build \
    /lib/x86_64-linux-gnu/libCharLS.so.2 \
    /lib/x86_64-linux-gnu/libHalf.so.24 \
    /lib/x86_64-linux-gnu/libIex-2_3.so.24 \
    /lib/x86_64-linux-gnu/libIlmImf-2_3.so.24 \
    /lib/x86_64-linux-gnu/libIlmThread-2_3.so.24 \
    /lib/x86_64-linux-gnu/libX11.so.6 \
    /lib/x86_64-linux-gnu/libXau.so.6 \
    /lib/x86_64-linux-gnu/libXcomposite.so.1 \
    /lib/x86_64-linux-gnu/libXcursor.so.1 \
    /lib/x86_64-linux-gnu/libXdamage.so.1 \
    /lib/x86_64-linux-gnu/libXdmcp.so.6 \
    /lib/x86_64-linux-gnu/libXext.so.6 \
    /lib/x86_64-linux-gnu/libXfixes.so.3 \
    /lib/x86_64-linux-gnu/libXi.so.6 \
    /lib/x86_64-linux-gnu/libXinerama.so.1 \
    /lib/x86_64-linux-gnu/libXrandr.so.2 \
    /lib/x86_64-linux-gnu/libXrender.so.1 \
    /lib/x86_64-linux-gnu/libaec.so.0 \
    /lib/x86_64-linux-gnu/libaom.so.0 \
    /lib/x86_64-linux-gnu/libarpack.so.2 \
    /lib/x86_64-linux-gnu/libasn1.so.8 \
    /lib/x86_64-linux-gnu/libatk-1.0.so.0 \
    /lib/x86_64-linux-gnu/libatk-bridge-2.0.so.0 \
    /lib/x86_64-linux-gnu/libatlas.so.3 \
    /lib/x86_64-linux-gnu/libatspi.so.0 \
    /lib/x86_64-linux-gnu/libavcodec.so.58 \
    /lib/x86_64-linux-gnu/libavformat.so.58 \
    /lib/x86_64-linux-gnu/libavutil.so.56 \
    /lib/x86_64-linux-gnu/libblas.so.3 \
    /lib/x86_64-linux-gnu/libblkid.so.1 \
    /lib/x86_64-linux-gnu/libbluray.so.2 \
    /lib/x86_64-linux-gnu/libboost_filesystem.so.1.71.0 \
    /lib/x86_64-linux-gnu/libboost_thread.so.1.71.0 \
    /lib/x86_64-linux-gnu/libbrotlicommon.so.1 \
    /lib/x86_64-linux-gnu/libbrotlidec.so.1 \
    /lib/x86_64-linux-gnu/libbsd.so.0 \
    /lib/x86_64-linux-gnu/libbz2.so.1.0 \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libcairo-gobject.so.2 \
    /lib/x86_64-linux-gnu/libcairo.so.2 \
    /lib/x86_64-linux-gnu/libcblas.so.3 \
    /lib/x86_64-linux-gnu/libcfitsio.so.8 \
    /lib/x86_64-linux-gnu/libchromaprint.so.1 \
    /lib/x86_64-linux-gnu/libcodec2.so.0.9 \
    /lib/x86_64-linux-gnu/libcom_err.so.2 \
    /lib/x86_64-linux-gnu/libcrypt.so.1 \
    /lib/x86_64-linux-gnu/libcrypto.so.1.1 \
    /lib/x86_64-linux-gnu/libcudnn.so.8 \
    /lib/x86_64-linux-gnu/libcurl-gnutls.so.4 \
    /lib/x86_64-linux-gnu/libdap.so.25 \
    /lib/x86_64-linux-gnu/libdapclient.so.6 \
    /lib/x86_64-linux-gnu/libdatrie.so.1 \
    /lib/x86_64-linux-gnu/libdbus-1.so.3 \
    /lib/x86_64-linux-gnu/libdc1394.so.22 \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libdrm.so.2 \
    /lib/x86_64-linux-gnu/libepoxy.so.0 \
    /lib/x86_64-linux-gnu/libepsilon.so.1 \
    /lib/x86_64-linux-gnu/libexpat.so.1 \
    /lib/x86_64-linux-gnu/libffi.so.7 \
    /lib/x86_64-linux-gnu/libfontconfig.so.1 \
    /lib/x86_64-linux-gnu/libfreetype.so.6 \
    /lib/x86_64-linux-gnu/libfreexl.so.1 \
    /lib/x86_64-linux-gnu/libfribidi.so.0 \
    /lib/x86_64-linux-gnu/libfyba.so.0 \
    /lib/x86_64-linux-gnu/libfygm.so.0 \
    /lib/x86_64-linux-gnu/libfyut.so.0 \
    /lib/x86_64-linux-gnu/libgcc_s.so.1 \
    /lib/x86_64-linux-gnu/libgcrypt.so.20 \
    /lib/x86_64-linux-gnu/libgdcmCommon.so.3.0 \
    /lib/x86_64-linux-gnu/libgdcmDICT.so.3.0 \
    /lib/x86_64-linux-gnu/libgdcmDSED.so.3.0 \
    /lib/x86_64-linux-gnu/libgdcmIOD.so.3.0 \
    /lib/x86_64-linux-gnu/libgdcmMSFF.so.3.0 \
    /lib/x86_64-linux-gnu/libgdcmjpeg12.so.3.0 \
    /lib/x86_64-linux-gnu/libgdcmjpeg16.so.3.0 \
    /lib/x86_64-linux-gnu/libgdcmjpeg8.so.3.0 \
    /lib/x86_64-linux-gnu/libgdk-3.so.0 \
    /lib/x86_64-linux-gnu/libgdk_pixbuf-2.0.so.0 \
    /lib/x86_64-linux-gnu/libgeos-3.8.0.so \
    /lib/x86_64-linux-gnu/libgeos_c.so.1 \
    /lib/x86_64-linux-gnu/libgeotiff.so.5 \
    /lib/x86_64-linux-gnu/libgflags.so.2.2 \
    /lib/x86_64-linux-gnu/libgfortran.so.5 \
    /lib/x86_64-linux-gnu/libgif.so.7 \
    /lib/x86_64-linux-gnu/libgio-2.0.so.0 \
    /lib/x86_64-linux-gnu/libglib-2.0.so.0 \
    /lib/x86_64-linux-gnu/libglog.so.0 \
    /lib/x86_64-linux-gnu/libgme.so.0 \
    /lib/x86_64-linux-gnu/libgmodule-2.0.so.0 \
    /lib/x86_64-linux-gnu/libgmp.so.10 \
    /lib/x86_64-linux-gnu/libgnutls.so.30 \
    /lib/x86_64-linux-gnu/libgobject-2.0.so.0 \
    /lib/x86_64-linux-gnu/libgomp.so.1 \
    /lib/x86_64-linux-gnu/libgpg-error.so.0 \
    /lib/x86_64-linux-gnu/libgraphite2.so.3 \
    /lib/x86_64-linux-gnu/libgsm.so.1 \
    /lib/x86_64-linux-gnu/libgssapi.so.3 \
    /lib/x86_64-linux-gnu/libgssapi_krb5.so.2 \
    /lib/x86_64-linux-gnu/libgstapp-1.0.so.0 \
    /lib/x86_64-linux-gnu/libgstaudio-1.0.so.0 \
    /lib/x86_64-linux-gnu/libgstbase-1.0.so.0 \
    /lib/x86_64-linux-gnu/libgstpbutils-1.0.so.0 \
    /lib/x86_64-linux-gnu/libgstreamer-1.0.so.0 \
    /lib/x86_64-linux-gnu/libgstriff-1.0.so.0 \
    /lib/x86_64-linux-gnu/libgsttag-1.0.so.0 \
    /lib/x86_64-linux-gnu/libgstvideo-1.0.so.0 \
    /lib/x86_64-linux-gnu/libgtk-3.so.0 \
    /lib/x86_64-linux-gnu/libharfbuzz.so.0 \
    /lib/x86_64-linux-gnu/libhcrypto.so.4 \
    /lib/x86_64-linux-gnu/libhdf5_serial.so.103 \
    /lib/x86_64-linux-gnu/libhdf5_serial_hl.so.100 \
    /lib/x86_64-linux-gnu/libheimbase.so.1 \
    /lib/x86_64-linux-gnu/libheimntlm.so.0 \
    /lib/x86_64-linux-gnu/libhogweed.so.5 \
    /lib/x86_64-linux-gnu/libhx509.so.5 \
    /lib/x86_64-linux-gnu/libicudata.so.66 \
    /lib/x86_64-linux-gnu/libicuuc.so.66 \
    /lib/x86_64-linux-gnu/libidn2.so.0 \
    /lib/x86_64-linux-gnu/libjbig.so.0 \
    /lib/x86_64-linux-gnu/libjpeg.so.8 \
    /lib/x86_64-linux-gnu/libjson-c.so.4 \
    /lib/x86_64-linux-gnu/libk5crypto.so.3 \
    /lib/x86_64-linux-gnu/libkeyutils.so.1 \
    /lib/x86_64-linux-gnu/libkmlbase.so.1 \
    /lib/x86_64-linux-gnu/libkmldom.so.1 \
    /lib/x86_64-linux-gnu/libkmlengine.so.1 \
    /lib/x86_64-linux-gnu/libkrb5.so.26 \
    /lib/x86_64-linux-gnu/libkrb5.so.3 \
    /lib/x86_64-linux-gnu/libkrb5support.so.0 \
    /lib/x86_64-linux-gnu/liblapack.so.3 \
    /lib/x86_64-linux-gnu/liblber-2.4.so.2 \
    /lib/x86_64-linux-gnu/liblcms2.so.2 \
    /lib/x86_64-linux-gnu/libldap_r-2.4.so.2 \
    /lib/x86_64-linux-gnu/libltdl.so.7 \
    /lib/x86_64-linux-gnu/liblz4.so.1 \
    /lib/x86_64-linux-gnu/liblzma.so.5 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libminizip.so.1 \
    /lib/x86_64-linux-gnu/libmount.so.1 \
    /lib/x86_64-linux-gnu/libmp3lame.so.0 \
    /lib/x86_64-linux-gnu/libmpg123.so.0 \
    /lib/x86_64-linux-gnu/libmysqlclient.so.21 \
    /lib/x86_64-linux-gnu/libnetcdf.so.15 \
    /lib/x86_64-linux-gnu/libnettle.so.7 \
    /lib/x86_64-linux-gnu/libnghttp2.so.14 \
    /lib/x86_64-linux-gnu/libnspr4.so \
    /lib/x86_64-linux-gnu/libnss3.so \
    /lib/x86_64-linux-gnu/libnssutil3.so \
    /lib/x86_64-linux-gnu/libnuma.so.1 \
    /lib/x86_64-linux-gnu/libodbc.so.2 \
    /lib/x86_64-linux-gnu/libodbcinst.so.2 \
    /lib/x86_64-linux-gnu/libogg.so.0 \
    /lib/x86_64-linux-gnu/libopencv_calib3d.so.4.2 \
    /lib/x86_64-linux-gnu/libopencv_core.so.4.2 \
    /lib/x86_64-linux-gnu/libopencv_features2d.so.4.2 \
    /lib/x86_64-linux-gnu/libopencv_flann.so.4.2 \
    /lib/x86_64-linux-gnu/libopencv_highgui.so.4.2 \
    /lib/x86_64-linux-gnu/libopencv_imgcodecs.so.4.2 \
    /lib/x86_64-linux-gnu/libopencv_imgproc.so.4.2 \
    /lib/x86_64-linux-gnu/libopencv_objdetect.so.4.2 \
    /lib/x86_64-linux-gnu/libopencv_video.so.4.2 \
    /lib/x86_64-linux-gnu/libopencv_videoio.so.4.2 \
    /lib/x86_64-linux-gnu/libopenjp2.so.7 \
    /lib/x86_64-linux-gnu/libopenmpt.so.0 \
    /lib/x86_64-linux-gnu/libopus.so.0 \
    /lib/x86_64-linux-gnu/liborc-0.4.so.0 \
    /lib/x86_64-linux-gnu/libp11-kit.so.0 \
    /lib/x86_64-linux-gnu/libpango-1.0.so.0 \
    /lib/x86_64-linux-gnu/libpangocairo-1.0.so.0 \
    /lib/x86_64-linux-gnu/libpangoft2-1.0.so.0 \
    /lib/x86_64-linux-gnu/libpcre.so.3 \
    /lib/x86_64-linux-gnu/libpcre2-8.so.0 \
    /lib/x86_64-linux-gnu/libpixman-1.so.0 \
    /lib/x86_64-linux-gnu/libplc4.so \
    /lib/x86_64-linux-gnu/libplds4.so \
    /lib/x86_64-linux-gnu/libpng16.so.16 \
    /lib/x86_64-linux-gnu/libpoppler.so.97 \
    /lib/x86_64-linux-gnu/libpq.so.5 \
    /lib/x86_64-linux-gnu/libproj.so.15 \
    /lib/x86_64-linux-gnu/libprotobuf.so.17 \
    /lib/x86_64-linux-gnu/libpsl.so.5 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libqhull.so.7 \
    /lib/x86_64-linux-gnu/libquadmath.so.0 \
    /lib/x86_64-linux-gnu/libraw1394.so.11 \
    /lib/x86_64-linux-gnu/libresolv.so.2 \
    /lib/x86_64-linux-gnu/libroken.so.18 \
    /lib/x86_64-linux-gnu/librsvg-2.so.2 \
    /lib/x86_64-linux-gnu/librt.so.1 \
    /lib/x86_64-linux-gnu/librtmp.so.1 \
    /lib/x86_64-linux-gnu/libsasl2.so.2 \
    /lib/x86_64-linux-gnu/libselinux.so.1 \
    /lib/x86_64-linux-gnu/libshine.so.3 \
    /lib/x86_64-linux-gnu/libsmime3.so \
    /lib/x86_64-linux-gnu/libsnappy.so.1 \
    /lib/x86_64-linux-gnu/libsoxr.so.0 \
    /lib/x86_64-linux-gnu/libspatialite.so.7 \
    /lib/x86_64-linux-gnu/libspeex.so.1 \
    /lib/x86_64-linux-gnu/libsqlite3.so.0 \
    /lib/x86_64-linux-gnu/libssh-gcrypt.so.4 \
    /lib/x86_64-linux-gnu/libssh.so.4 \
    /lib/x86_64-linux-gnu/libssl.so.1.1 \
    /lib/x86_64-linux-gnu/libstdc++.so.6 \
    /lib/x86_64-linux-gnu/libsuperlu.so.5 \
    /lib/x86_64-linux-gnu/libswresample.so.3 \
    /lib/x86_64-linux-gnu/libswscale.so.5 \
    /lib/x86_64-linux-gnu/libsystemd.so.0 \
    /lib/x86_64-linux-gnu/libsz.so.2 \
    /lib/x86_64-linux-gnu/libtasn1.so.6 \
    /lib/x86_64-linux-gnu/libtbb.so.2 \
    /lib/x86_64-linux-gnu/libthai.so.0 \
    /lib/x86_64-linux-gnu/libtheoradec.so.1 \
    /lib/x86_64-linux-gnu/libtheoraenc.so.1 \
    /lib/x86_64-linux-gnu/libtiff.so.5 \
    /lib/x86_64-linux-gnu/libtwolame.so.0 \
    /lib/x86_64-linux-gnu/libudev.so.1 \
    /lib/x86_64-linux-gnu/libunistring.so.2 \
    /lib/x86_64-linux-gnu/libunwind.so.8 \
    /lib/x86_64-linux-gnu/liburiparser.so.1 \
    /lib/x86_64-linux-gnu/libusb-1.0.so.0 \
    /lib/x86_64-linux-gnu/libuuid.so.1 \
    /lib/x86_64-linux-gnu/libva-drm.so.2 \
    /lib/x86_64-linux-gnu/libva-x11.so.2 \
    /lib/x86_64-linux-gnu/libva.so.2 \
    /lib/x86_64-linux-gnu/libvdpau.so.1 \
    /lib/x86_64-linux-gnu/libvorbis.so.0 \
    /lib/x86_64-linux-gnu/libvorbisenc.so.2 \
    /lib/x86_64-linux-gnu/libvorbisfile.so.3 \
    /lib/x86_64-linux-gnu/libvpx.so.6 \
    /lib/x86_64-linux-gnu/libwavpack.so.1 \
    /lib/x86_64-linux-gnu/libwayland-client.so.0 \
    /lib/x86_64-linux-gnu/libwayland-cursor.so.0 \
    /lib/x86_64-linux-gnu/libwayland-egl.so.1 \
    /lib/x86_64-linux-gnu/libwebp.so.6 \
    /lib/x86_64-linux-gnu/libwebpmux.so.3 \
    /lib/x86_64-linux-gnu/libwind.so.0 \
    /lib/x86_64-linux-gnu/libx264.so.155 \
    /lib/x86_64-linux-gnu/libx265.so.179 \
    /lib/x86_64-linux-gnu/libxcb-render.so.0 \
    /lib/x86_64-linux-gnu/libxcb-shm.so.0 \
    /lib/x86_64-linux-gnu/libxcb.so.1 \
    /lib/x86_64-linux-gnu/libxerces-c-3.2.so \
    /lib/x86_64-linux-gnu/libxkbcommon.so.0 \
    /lib/x86_64-linux-gnu/libxml2.so.2 \
    /lib/x86_64-linux-gnu/libxvidcore.so.4 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    /lib/x86_64-linux-gnu/libzstd.so.1 \
    /lib/x86_64-linux-gnu/libzvbi.so.0 \
    /lib/x86_64-linux-gnu/

COPY --from=build \
    /usr/local/cuda/lib64/libcublas.so.11 \
    /usr/local/cuda/lib64/libcublasLt.so.11 \
    /usr/local/cuda/lib64/libcudart.so.11.0 \
    /usr/local/cuda/lib64/libcurand.so.10 \
    /usr/local/cuda/lib64/

COPY --from=build /usr/local/cuda/targets/x86_64-linux/lib/libOpenCL.so.1 /usr/local/cuda/targets/x86_64-linux/lib/libOpenCL.so.1

COPY --from=build /lib/x86_64-linux-gnu/libcudnn_ops_infer.so.8 /lib/x86_64-linux-gnu/libcudnn_ops_infer.so.8

COPY --from=build \
    /lib/x86_64-linux-gnu/libcudnn_adv_infer.so.8 \
    /lib/x86_64-linux-gnu/libcudnn_cnn_infer.so.8 \
    /lib/x86_64-linux-gnu/

ENV PATH=/openpose/build/examples/openpose:$PATH \
    LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda/targets/x86_64-linux/lib:$LD_LIBRARY_PATH \
    LC_ALL=C.UTF-8

LABEL maintainer=hpc-support@virginia.edu \
      homepage=https://github.com/CMU-Perceptual-Computing-Lab/openpose \
      description="OpenPose has represented the first real-time multi-person system to jointly detect human body, hand, facial, and foot keypoints (in total 135 keypoints) on single images." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["openpose.bin"]
