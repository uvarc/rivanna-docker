FROM continuumio/anaconda3

COPY requirements.txt .
COPY environment.yml .
RUN conda create --name rayTune

RUN conda init bash
RUN echo "conda activate rayTune" > ~/.bashrc

RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

RUN conda env update --file environment.yml	--prune
RUN conda clean -ay

LABEL maintainer=uvahrc \
      homepage=https://docs.ray.io/en/latest/ \
      description="Ray is an open-source project developed at UC Berkeley RISE Lab.\
       As a general-purpose and universal distributed compute framework,\
       you can flexibly run any compute-intensive Python workload \
       -from distributed training or hyperparameter tuning to deep reinforcement learning \
       and production model serving.." \
      gpu=true \
      moduleclass=data

ENTRYPOINT ["python"]