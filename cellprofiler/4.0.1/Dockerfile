FROM ubuntu:20.04 AS build

RUN mkdir -p /usr/share/man/man1
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York 
RUN apt-get update && apt-get install -y --no-install-recommends \
        tzdata wget ca-certificates git \
        python3-pip gcc build-essential libgtk-3-dev \
        openjdk-11-jdk-headless default-libmysqlclient-dev libnotify-dev libsdl2-dev \
        lsof && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3-dev libzmq3-dev

WORKDIR /opt
RUN pip3 install -f https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-20.04 wxPython && \
    git clone https://github.com/CellProfiler/CellProfiler.git && \
    cd CellProfiler && \
    pip3 install . && \
    cd .. && rm -rf CellProfiler*

FROM ubuntu:20.04
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3-pip && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/lib/jvm/java-11-openjdk-amd64 /usr/lib/jvm/java-11-openjdk-amd64
COPY --from=build /usr/local/lib/python3.8/dist-packages /usr/local/lib/python3.8/dist-packages
COPY --from=build \
    /usr/local/bin/cellprofiler \
    /usr/local/bin/mahotas-features \
    /usr/local/bin/skivi \
    /usr/local/bin/lsm2bin \
    /usr/local/bin/tifffile \
    /usr/local/bin/chardetect \
    /usr/local/bin/futurize \
    /usr/local/bin/pasteurize \
    /usr/local/bin/__pycache__ \
    /usr/local/bin/jp.py \
    /usr/local/bin/imageio_download_bin \
    /usr/local/bin/imageio_remove_bin \
    /usr/local/bin/rst2html.py \
    /usr/local/bin/rst2html4.py \
    /usr/local/bin/rst2html5.py \
    /usr/local/bin/rst2latex.py \
    /usr/local/bin/rst2man.py \
    /usr/local/bin/rst2odt.py \
    /usr/local/bin/rst2odt_prepstyles.py \
    /usr/local/bin/rst2pseudoxml.py \
    /usr/local/bin/rst2s5.py \
    /usr/local/bin/rst2xetex.py \
    /usr/local/bin/rst2xml.py \
    /usr/local/bin/rstpep2html.py \
    /usr/local/bin/helpviewer \
    /usr/local/bin/img2png \
    /usr/local/bin/img2py \
    /usr/local/bin/img2xpm \
    /usr/local/bin/pycrust \
    /usr/local/bin/pyshell \
    /usr/local/bin/pyslices \
    /usr/local/bin/pyslicesshell \
    /usr/local/bin/pywxrc \
    /usr/local/bin/wxdemo \
    /usr/local/bin/wxdocs \
    /usr/local/bin/wxget \
    /usr/local/bin/f2py \
    /usr/local/bin/f2py3 \
    /usr/local/bin/f2py3.8 \
    /usr/local/bin/

COPY --from=build /usr/lib/jvm/java-11-openjdk-amd64/lib/server/libjvm.so /usr/lib/jvm/java-11-openjdk-amd64/lib/server/libjvm.so
COPY --from=build \
    /usr/lib/python3.8/lib-dynload/_asyncio.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/_bz2.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/_contextvars.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/_ctypes.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/_decimal.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/_hashlib.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/_json.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/_lzma.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/_multiprocessing.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/_opcode.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/_posixshmem.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/_queue.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/_ssl.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/_uuid.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/mmap.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/termios.cpython-38-x86_64-linux-gnu.so \
    /usr/lib/python3.8/lib-dynload/
COPY --from=build \
    /usr/lib/x86_64-linux-gnu/gconv/UTF-32.so \
    /usr/lib/x86_64-linux-gnu/libFLAC.so.8.3.0 \
    /usr/lib/x86_64-linux-gnu/libICE.so.6.3.0 \
    /usr/lib/x86_64-linux-gnu/libSDL2-2.0.so.0.10.0 \
    /usr/lib/x86_64-linux-gnu/libSM.so.6.0.1 \
    /usr/lib/x86_64-linux-gnu/libX11.so.6.3.0 \
    /usr/lib/x86_64-linux-gnu/libXau.so.6.0.0 \
    /usr/lib/x86_64-linux-gnu/libXcomposite.so.1.0.0 \
    /usr/lib/x86_64-linux-gnu/libXcursor.so.1.0.2 \
    /usr/lib/x86_64-linux-gnu/libXdamage.so.1.1.0 \
    /usr/lib/x86_64-linux-gnu/libXdmcp.so.6.0.0 \
    /usr/lib/x86_64-linux-gnu/libXext.so.6.4.0 \
    /usr/lib/x86_64-linux-gnu/libXfixes.so.3.1.0 \
    /usr/lib/x86_64-linux-gnu/libXi.so.6.1.0 \
    /usr/lib/x86_64-linux-gnu/libXinerama.so.1.0.0 \
    /usr/lib/x86_64-linux-gnu/libXrandr.so.2.2.0 \
    /usr/lib/x86_64-linux-gnu/libXrender.so.1.3.0 \
    /usr/lib/x86_64-linux-gnu/libXss.so.1.0.0 \
    /usr/lib/x86_64-linux-gnu/libXtst.so.6.1.0 \
    /usr/lib/x86_64-linux-gnu/libXxf86vm.so.1.0.0 \
    /usr/lib/x86_64-linux-gnu/libasound.so.2.0.0 \
    /usr/lib/x86_64-linux-gnu/libasyncns.so.0.3.1 \
    /usr/lib/x86_64-linux-gnu/libatk-1.0.so.0.23510.1 \
    /usr/lib/x86_64-linux-gnu/libatk-bridge-2.0.so.0.0.0 \
    /usr/lib/x86_64-linux-gnu/libatspi.so.0.0.1 \
    /usr/lib/x86_64-linux-gnu/libblkid.so.1.1.0 \
    /usr/lib/x86_64-linux-gnu/libbsd.so.0.10.0 \
    /usr/lib/x86_64-linux-gnu/libbz2.so.1.0.4 \
    /usr/lib/x86_64-linux-gnu/libcairo-gobject.so.2.11600.0 \
    /usr/lib/x86_64-linux-gnu/libcairo.so.2.11600.0 \
    /usr/lib/x86_64-linux-gnu/libcom_err.so.2.1 \
    /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 \
    /usr/lib/x86_64-linux-gnu/libdatrie.so.1.3.5 \
    /usr/lib/x86_64-linux-gnu/libdbus-1.so.3.19.11 \
    /usr/lib/x86_64-linux-gnu/libepoxy.so.0.0.0 \
    /usr/lib/x86_64-linux-gnu/libffi.so.7.1.0 \
    /usr/lib/x86_64-linux-gnu/libfontconfig.so.1.12.0 \
    /usr/lib/x86_64-linux-gnu/libfreetype.so.6.17.1 \
    /usr/lib/x86_64-linux-gnu/libfribidi.so.0.4.0 \
    /usr/lib/x86_64-linux-gnu/libgcc_s.so.1 \
    /usr/lib/x86_64-linux-gnu/libgcrypt.so.20.2.5 \
    /usr/lib/x86_64-linux-gnu/libgdk-3.so.0.2404.16 \
    /usr/lib/x86_64-linux-gnu/libgdk_pixbuf-2.0.so.0.4000.0 \
    /usr/lib/x86_64-linux-gnu/libgio-2.0.so.0.6400.3 \
    /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.3 \
    /usr/lib/x86_64-linux-gnu/libgmodule-2.0.so.0.6400.3 \
    /usr/lib/x86_64-linux-gnu/libgobject-2.0.so.0.6400.3 \
    /usr/lib/x86_64-linux-gnu/libgpg-error.so.0.28.0 \
    /usr/lib/x86_64-linux-gnu/libgraphite2.so.3.2.1 \
    /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2.2 \
    /usr/lib/x86_64-linux-gnu/libgtk-3.so.0.2404.16 \
    /usr/lib/x86_64-linux-gnu/libharfbuzz.so.0.20600.4 \
    /usr/lib/x86_64-linux-gnu/libjbig.so.0 \
    /usr/lib/x86_64-linux-gnu/libjpeg.so.8.2.2 \
    /usr/lib/x86_64-linux-gnu/libk5crypto.so.3.1 \
    /usr/lib/x86_64-linux-gnu/libkeyutils.so.1.8 \
    /usr/lib/x86_64-linux-gnu/libkrb5.so.3.3 \
    /usr/lib/x86_64-linux-gnu/libkrb5support.so.0.1 \
    /usr/lib/x86_64-linux-gnu/liblz4.so.1.9.2 \
    /usr/lib/x86_64-linux-gnu/liblzma.so.5.2.4 \
    /usr/lib/x86_64-linux-gnu/libmount.so.1.1.0 \
    /usr/lib/x86_64-linux-gnu/libmpdec.so.2.4.2 \
    /usr/lib/x86_64-linux-gnu/libmysqlclient.so.21.1.21 \
    /usr/lib/x86_64-linux-gnu/libnorm.so.1.5.8 \
    /usr/lib/x86_64-linux-gnu/libnotify.so.4.0.0 \
    /usr/lib/x86_64-linux-gnu/libnsl-2.31.so \
    /usr/lib/x86_64-linux-gnu/libnss_files-2.31.so \
    /usr/lib/x86_64-linux-gnu/libogg.so.0.8.4 \
    /usr/lib/x86_64-linux-gnu/libpango-1.0.so.0.4400.7 \
    /usr/lib/x86_64-linux-gnu/libpangocairo-1.0.so.0.4400.7 \
    /usr/lib/x86_64-linux-gnu/libpangoft2-1.0.so.0.4400.7 \
    /usr/lib/x86_64-linux-gnu/libpcre.so.3.13.3 \
    /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0.9.0 \
    /usr/lib/x86_64-linux-gnu/libpgm-5.2.so.0.0.122 \
    /usr/lib/x86_64-linux-gnu/libpixman-1.so.0.38.4 \
    /usr/lib/x86_64-linux-gnu/libpng16.so.16.37.0 \
    /usr/lib/x86_64-linux-gnu/libpulse.so.0.21.2 \
    /usr/lib/x86_64-linux-gnu/libresolv-2.31.so \
    /usr/lib/x86_64-linux-gnu/librt-2.31.so \
    /usr/lib/x86_64-linux-gnu/libselinux.so.1 \
    /usr/lib/x86_64-linux-gnu/libsndfile.so.1.0.28 \
    /usr/lib/x86_64-linux-gnu/libsodium.so.23.3.0 \
    /usr/lib/x86_64-linux-gnu/libssl.so.1.1 \
    /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.28 \
    /usr/lib/x86_64-linux-gnu/libsystemd.so.0.28.0 \
    /usr/lib/x86_64-linux-gnu/libthai.so.0.3.1 \
    /usr/lib/x86_64-linux-gnu/libtiff.so.5.5.0 \
    /usr/lib/x86_64-linux-gnu/libuuid.so.1.3.0 \
    /usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.8 \
    /usr/lib/x86_64-linux-gnu/libvorbisenc.so.2.0.11 \
    /usr/lib/x86_64-linux-gnu/libwayland-client.so.0.3.0 \
    /usr/lib/x86_64-linux-gnu/libwayland-cursor.so.0.0.0 \
    /usr/lib/x86_64-linux-gnu/libwayland-egl.so.1.0.0 \
    /usr/lib/x86_64-linux-gnu/libwebp.so.6.0.2 \
    /usr/lib/x86_64-linux-gnu/libwrap.so.0.7.6 \
    /usr/lib/x86_64-linux-gnu/libxcb-render.so.0.0.0 \
    /usr/lib/x86_64-linux-gnu/libxcb-shm.so.0.0.0 \
    /usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0 \
    /usr/lib/x86_64-linux-gnu/libxkbcommon.so.0.0.0 \
    /usr/lib/x86_64-linux-gnu/libzmq.so.5.2.2 \
    /usr/lib/x86_64-linux-gnu/libzstd.so.1.4.4 \
    /usr/lib/x86_64-linux-gnu/pulseaudio/libpulsecommon-13.99.so \
    /usr/lib/x86_64-linux-gnu/

RUN for i in /usr/lib/x86_64-linux-gnu/lib*.so.*; do LN=$(echo $i|sed 's/\.so\.\([0-9]*\)\..*$/.so.\1/'); if [ ! -e $LN ]; then ln -s $i $LN; fi; done

ENV LC_ALL=C.UTF-8
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
ENV PYTHONPATH=/usr/local/lib/python3.8/dist-packages 

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["cellprofiler"]
