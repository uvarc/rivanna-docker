# RIV-6864
# Need TF 1.x which only works with Python 3.7- (see RIV-6193)

FROM continuumio/miniconda3:4.9.2

ARG JAVA_VERSION=11

RUN mkdir -p /usr/share/man/man1 && \
    apt-get update && apt-get install -y --no-install-recommends \
# "base" https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile
        wget ca-certificates unzip \
        locales fonts-liberation \
# "minimal" https://github.com/jupyter/docker-stacks/blob/master/minimal-notebook/Dockerfile
        build-essential git \
        libsm6 libxext-dev libxrender1 \
        lmodern netcat \
# for nbconvert
        texlive-xetex texlive-fonts-recommended texlive-plain-generic \
# "scipy" https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile
        ffmpeg dvipng cm-super \
# "pyspark" https://github.com/jupyter/docker-stacks/blob/master/pyspark-notebook/Dockerfile
        openjdk-${JAVA_VERSION}-jre-headless ca-certificates-java \
    && rm -rf /var/lib/apt/lists/*

ENV LC_ALL=C.UTF-8 \
    NUMBA_CACHE_DIR=/tmp \
    APACHE_SPARK_VERSION=3.1.2 \
    HADOOP_VERSION=3.2 \
    PLOTLY_VERSION=4.14.3 \
    TF_VERSION=1.15.0

RUN conda install -c conda-forge mamba && \
    mamba install -c conda-forge \
# "base"
        notebook=6.3.0 \
        jupyterhub=1.1.0 \
        jupyterlab=2.2.8 \
        pyarrow=1.0.1 \
        requests=2.24.0 \
        six=1.15.0 \
        ipykernel=5.3.4 \
# "scipy"
        python=3.7.10 \
        beautifulsoup4=4.9.3 \
        blas=2.14 \
        bokeh=2.2.1 \
        bottleneck=1.3.2 \
        cloudpickle=1.6.0 \
        cython=0.29.21 \
        dask=2.25.0 \
        dask-core=2.25.0 \
        dill=0.3.2 \
        h5py=2.10.0 \
        ipympl=0.5.8 \
        ipywidgets=7.5.1 \
        libopenblas=0.3.7 \
        libprotobuf=3.12.4 \
        matplotlib-base=3.3.2 \
        numba=0.51.2 \
        numexpr=2.7.1 \
        pandas=1.1.2 \
        patsy=0.5.1 \
        protobuf=3.12.4 \
        pytables=3.6.1 \
        scikit-image=0.17.2 \
        scikit-learn=0.23.2 \
        scipy=1.4.1 \
        seaborn=0.11.0 \
        seaborn-base=0.11.0 \
        sqlalchemy=1.3.19 \
        statsmodels=0.12.0 \
        sympy=1.6.2 \
        widgetsnbextension=3.5.1 \
        xlrd=1.2.0 \
# ds5559
        plotly=$PLOTLY_VERSION \
    && conda clean -ya

RUN pip install --no-cache-dir \
        nltk==3.5 \
        tensorflow==$TF_VERSION \
        tensorboard==$TF_VERSION \
        tensorframes \
        tensorflowonspark \
        jieba==0.42.1 \
        sparkdl==0.2.2 \
        keras \
        graphframes==0.6 \
        requests_oauthlib \
        folium==0.11.0 \
        shap==0.36.0 \
        wfdb==3.0.1 \
        biosppy==0.6.1

WORKDIR /tmp
# Using the preferred mirror to download Spark
# hadolint ignore=SC2046
ARG TGZ=spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN wget -q https://mirror.nodesdirect.com/apache/spark/spark-${APACHE_SPARK_VERSION}/$TGZ && \
    tar xf $TGZ -C /usr/local --owner root --group root --no-same-owner && \
    rm $TGZ

WORKDIR /usr/local

# Configure Spark
ENV SPARK_HOME=/usr/local/spark \
    SPARK_OPTS="--driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info" \
    PATH=$PATH:$SPARK_HOME/bin

RUN ln -s "spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}" spark && \
    # Add a link in the before_notebook hook in order to source automatically PYTHONPATH
    mkdir -p /usr/local/bin/before-notebook.d && \
    ln -s "${SPARK_HOME}/sbin/spark-config.sh" /usr/local/bin/before-notebook.d/spark-config.sh

# Fix Spark installation for Java 11 and Apache Arrow library
# see: https://github.com/apache/spark/pull/27356, https://spark.apache.org/docs/latest/#downloading
RUN cp -p "$SPARK_HOME/conf/spark-defaults.conf.template" "$SPARK_HOME/conf/spark-defaults.conf" && \
    echo 'spark.driver.extraJavaOptions -Dio.netty.tryReflectionSetAccessible=true' >> $SPARK_HOME/conf/spark-defaults.conf && \
    echo 'spark.executor.extraJavaOptions -Dio.netty.tryReflectionSetAccessible=true' >> $SPARK_HOME/conf/spark-defaults.conf

# graphframes not available for spark 3.1
#RUN cd /usr/local/spark/jars && \
    #wget -q https://github.com/rsdmse/graphframes-jars/raw/master/graphframes-0.8.1-spark3.0-s_2.12.jar

WORKDIR /opt

# RIV-6264
RUN wget -q https://mirror.nodesdirect.com/apache/kafka/2.8.0/kafka_2.13-2.8.0.tgz && \
    tar xf kafka_2.13-2.8.0.tgz && \
    rm kafka_2.13-2.8.0.tgz

WORKDIR $HOME

ENV PATH=/opt/kafka_2.13-2.8.0/bin:$PATH \
    PYTHONPATH=${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-0.10.9-src.zip

LABEL maintainer=rs7wz@virginia.edu
