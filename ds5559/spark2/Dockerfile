FROM jupyter/pyspark-notebook:dc9744740e12
USER root
RUN mkdir -p /var/lib/apt/lists/partial

# for pdf conversion via nbconvert
RUN apt-get update && apt-get install -y --no-install-recommends \
        texlive-xetex texlive-fonts-recommended && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

ENV PATH /opt/conda/bin:$PATH
ENV LC_ALL C
ENV NUMBA_CACHE_DIR /tmp

RUN pip install --no-cache-dir \
        ipykernel \
        nltk \
        pyarrow \
        tensorflow-cpu==1.15 \
        tensorboard==1.15 \
        tensorframes \
        tensorflowonspark \
        jieba \
        sparkdl \
        requests \
        h5py \
        keras==2.1.5 \
        six \
        graphframes \
        requests_oauthlib \
        folium \
        shap \
        wfdb==3.0.1 \
        biosppy==0.6.1

RUN conda install -c conda-forge plotly==4.11.0 && \
    conda clean -ya

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    jupyter labextension install jupyterlab-plotly@4.11.0 --no-build && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager plotlywidget@4.11.0 --no-build && \
    jupyter lab build && \
    jupyter lab clean && \
    jlpm cache clean && \
    npm cache clean --force && \
    rm -rf "/home/${NB_USER}/.cache/yarn" && \
    rm -rf "/home/${NB_USER}/.node-gyp" && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# graphframes patch
USER root
RUN cd /tmp && \
    git clone https://github.com/rsdmse/graphframes-jars.git && \
    cd /usr/local/spark/jars && \
    mv /tmp/graphframes-jars/*.jar . && \
    wget -q http://dl.bintray.com/spark-packages/maven/graphframes/graphframes/0.6.0-spark2.3-s_2.11/graphframes-0.6.0-spark2.3-s_2.11.jar && \
    rm -rf /tmp/graphframes-jars

USER $NB_UID

LABEL maintainer=rs7wz@virginia.edu
