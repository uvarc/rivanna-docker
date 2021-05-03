FROM jupyter/pyspark-notebook:4a112c0f11eb
USER root
RUN mkdir -p /var/lib/apt/lists/partial

# for pdf conversion via nbconvert
RUN apt-get update && apt-get install -y --no-install-recommends \
        texlive-xetex texlive-fonts-recommended && \
    rm -rf /var/lib/apt/lists/*

ENV LC_ALL=C \
    NUMBA_CACHE_DIR=/tmp

ARG TF_VERSION=1.15.5
RUN pip install --no-cache-dir \
        ipykernel \
        nltk \
        pyarrow \
        tensorflow==$TF_VERSION \
        tensorboard==$TF_VERSION \
        tensorframes \
        tensorflowonspark \
        jieba \
        sparkdl \
        requests \
        h5py \
        keras \
        six \
        graphframes \
        requests_oauthlib \
        folium \
        shap \
        wfdb==3.0.1 \
        biosppy==0.6.1

RUN cd /usr/local/spark/jars && \
    wget http://dl.bintray.com/spark-packages/maven/graphframes/graphframes/0.8.1-spark3.0-s_2.12/graphframes-0.8.1-spark3.0-s_2.12.jar 

LABEL maintainer=rs7wz@virginia.edu
