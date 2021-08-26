FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive \
    TZ="America/New_York"
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget ca-certificates \
        libgl1 tzdata qt5-default && \
    rm -rf /var/lib/apt/lists/*

ENV PREFIX_CC3D=/opt/cc3d
WORKDIR /opt
RUN wget -qO CC3D_4.2.5_ubuntu_20.04_64bit.tar.gz https://sourceforge.net/projects/cc3d/files/4.2.5/linux/CC3D_4.2.5_ubuntu_20.04_64bit.tar.gz/download && \
    tar xf CC3D_4.2.5_ubuntu_20.04_64bit.tar.gz && \
    rm CC3D_4.2.5_ubuntu_20.04_64bit.tar.gz && \
    mv /opt/CC3D_4.2.5_ubuntu_20.04_64bit $PREFIX_CC3D

RUN sed -i -e s'/^export PYTHON_EXEC=.*$/export PYTHON_EXEC=${PREFIX_CC3D}\/Python37\/bin\/python/g' \
           -e '/^export PREFIX_CC3D=.*$/d' \
           $PREFIX_CC3D/*.sh

ENV PATH=$PREFIX_CC3D:$PATH

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://compucell3d.org \
      description="CompuCell3D is a flexible scriptable modeling environment, which allows the rapid construction of sharable Virtual Tissue in silico simulations of a wide variety of multi-scale, multi-cellular problems including angiogenesis, bacterial colonies, cancer, developmental biology, evolution, the immune system, tissue engineering, toxicology and even non-cellular soft materials. CompuCell3D models have been used to solve basic biological problems, to develop medical therapies, to assess modes of action of toxicants and to design engineered tissues. CompuCell3D's intuitive interface makes Virtual Tissue modeling accessible to users without extensive software development or programming experience." \
      moduleclass=vis

ENTRYPOINT ["compucell3d.sh"]
