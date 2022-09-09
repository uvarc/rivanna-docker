FROM gcc:9.5.0-buster AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
        git wget unzip bzip2 \
        gcc libc6-dev make && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# BWA
RUN wget https://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.17.tar.bz2 -O bwa.tar.bz2 && \
    tar xf bwa.tar.bz2 && \
    rm bwa.tar.bz2

RUN cd bwa-0.7.17 && make && \
    mv bwa *.pl /usr/local/bin && cd ..

# Picard
RUN wget https://downloads.sourceforge.net/project/picard/picard-tools/1.119/picard-tools-1.119.zip -O picard.zip && \
    unzip picard.zip && rm picard.zip && \
    mkdir /usr/local/bin/picard-tools && \
    mv picard-tools-1.119/*.jar /usr/local/bin/picard-tools

# BLAT
RUN wget -P /usr/local/bin https://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/blat/blat && \
    chmod +x /usr/local/bin/blat

# GATK
RUN mkdir /usr/local/bin/GATK
RUN wget https://storage.googleapis.com/gatk-software/package-archive/gatk/GenomeAnalysisTK-3.5-0-g36282e4.tar.bz2 && \
    tar xf GenomeAnalysisTK-3.5-0-g36282e4.tar.bz2 && \
    mv GenomeAnalysisTK.jar /usr/local/bin/GATK && \
    rm GenomeAnalysisTK-3.5-0-g36282e4.tar.bz2

# Bedtools
RUN wget -P /usr/local/bin -O bedtools \
        https://github.com/arq5x/bedtools2/releases/download/v2.30.0/bedtools.static.binary && \
    chmod +x bedtools

# Samtools
RUN wget https://github.com/samtools/samtools/releases/download/1.5/samtools-1.5.tar.bz2 && \
    tar xf samtools-1.5.tar.bz2 && rm samtools-1.5.tar.bz2
RUN cd samtools-1.5 && ./configure && make && make install

# RNAEditor
#RUN wget https://github.com/djhn75/RNAEditor/archive/refs/tags/RNAEditor_v1.1_alpha.tar.gz && \
    #tar xf RNAEditor_v1.1_alpha.tar.gz && rm RNAEditor_v1.1_alpha.tar.gz
RUN wget https://github.com/djhn75/RNAEditor/archive/refs/heads/master.zip && \
    unzip master.zip && rm master.zip

# Java
ADD jdk-7u80-linux-x64.tar.gz .

FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        perl \
        python3-numpy python3-pysam python3-matplotlib python3-pip python3-tk \
        libgl1-mesa-glx libglib2.0-0 libnss3 libxcomposite1 libxdamage1 \
        libxrender1 libxrandr2 libxcursor1 libxi6 libxtst6 libxkbcommon0 \
        libdbus-1-3 libasound2 libfontconfig1 \
        libcurl4 \
        qt5-default && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/bin /usr/local/bin
#COPY --from=build /opt/RNAEditor-RNAEditor_v1.1_alpha /opt/RNAEditor
COPY --from=build /opt/RNAEditor-master /opt/RNAEditor

# Java
COPY --from=build /opt/jdk1.7.0_80/ /usr/local/java

ENV JAVA_HOME=/usr/local/java \
    JRE_HOME=/usr/local/java \
    PATH=$PATH:$JAVA_HOME/bin

RUN update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/bin/java" 1 && \
    update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/bin/javac" 1 && \
    update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/local/java/bin/javaws" 1 && \
    update-alternatives --set java /usr/local/java/bin/java && \
    update-alternatives --set javac /usr/local/java/bin/javac && \
    update-alternatives --set javaws /usr/local/java/bin/javaws

RUN pip install --no-cache-dir PyQt5 PyQtWebEngine

#
RUN ln -s /usr/bin/java /usr/local/bin/java
RUN ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /opt/RNAEditor
# debug
#RUN sed -i '195a\            Helper.error("%s %s" % (os.system("which java"), os.system("java -version")), self.logFile,self.textField)' RNAEditor.py
RUN sed -i '195,196d' RNAEditor.py

ENV PATH=/opt/RNAEditor:$PATH

LABEL maintainer=rs7wz@virginia.edu \
      homepage=https://github.com/djhn75/RNAEditor \
      description="RNAEditor is tool to analyze RNA editing events from RNA-seq data. It accepts Fastq and Bam files as input, handles all the analysis and filter steps for you and outputs comprehensive statistics and editing Islands." \
      moduleclass=bio

ENTRYPOINT ["python3", "/opt/RNAEditor/RNAEditor.py"]
