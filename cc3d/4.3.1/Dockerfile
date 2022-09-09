FROM ubuntu:20.04
ARG VERSION 4.3.1
ENV DEBIAN_FRONTEND=noninteractive \
    TZ="America/New_York"
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates \
        libgl1 tzdata qt5-default && \
    rm -rf /var/lib/apt/lists/*

ENV PREFIX_CC3D=/opt/cc3d
WORKDIR /opt
RUN wget -q https://downloads.sourceforge.net/project/cc3d/4.3.1/linux/cc3d-installer-linux-4.3.1.0.sh && \
    chmod +x cc3d-installer-linux-4.3.1.0.sh && \
    ./cc3d-installer-linux-4.3.1.0.sh

#RUN sed -i -e s'/^export PYTHON_EXEC=.*$/export PYTHON_EXEC=${PREFIX_CC3D}\/Python37\/bin\/python/g' \
           #-e '/^export PREFIX_CC3D=.*$/d' \
           #$PREFIX_CC3D/*.sh

# for roadrunner
RUN ln -s $PREFIX_CC3D/Python37/lib/libncurses.so $PREFIX_CC3D/Python37/lib/libncurses.so.5

ENV PATH=$PREFIX_CC3D:$PREFIX_CC3D/Python37/bin:$PATH \
    PYTHONPATH=$PREFIX_CC3D/lib/site-packages:$PREFIX_CC3D/Python37/lib/python3.7/site-packages \
    COMPUCELL3D_PLUGIN_PATH=${PREFIX_CC3D}/lib/site-packages/cc3d/cpp/CompuCell3DPlugins \
    COMPUCELL3D_STEPPABLE_PATH=${PREFIX_CC3D}/lib/site-packages/cc3d/cpp/CompuCell3DSteppables
ENV LD_LIBRARY_PATH=${PREFIX_CC3D}/lib/site-packages/cc3d/cpp/lib:${COMPUCELL3D_PLUGIN_PATH}:${COMPUCELL3D_STEPPABLE_PATH}:$LD_LIBRARY_PATH \
    COMPUCELL3D_MAJOR_VERSION=4 \
    COMPUCELL3D_MINOR_VERSION=3 \
    COMPUCELL3D_BUILD_VERSION=1

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://compucell3d.org \
      description="CompuCell3D is a flexible scriptable modeling environment, which allows the rapid construction of sharable Virtual Tissue in silico simulations of a wide variety of multi-scale, multi-cellular problems including angiogenesis, bacterial colonies, cancer, developmental biology, evolution, the immune system, tissue engineering, toxicology and even non-cellular soft materials. CompuCell3D models have been used to solve basic biological problems, to develop medical therapies, to assess modes of action of toxicants and to design engineered tissues. CompuCell3D's intuitive interface makes Virtual Tissue modeling accessible to users without extensive software development or programming experience." \
      moduleclass=vis

ENTRYPOINT ["python"]
