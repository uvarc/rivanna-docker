FROM nvcr.io/nvidia/tensorflow:20.07-tf1-py3
USER root

RUN apt-get update && apt-get install -y --no-install-recommends git unzip sudo \
&&  rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/NVIDIA/DeepLearningExamples

RUN chmod -R u=rwx ./DeepLearningExamples/TensorFlow/Recommendation/
RUN cd DeepLearningExamples/TensorFlow/Recommendation/NCF

WORKDIR DeepLearningExamples/TensorFlow/Recommendation/NCF
ADD DeepLearningExamples/TensorFlow/Recommendation/NCF ~/DeepLearningExamples/TensorFlow/Recommendation/NCF 

RUN mkdir data
RUN pip install -r requirements.txt

ADD . /workspace/recommendation
WORKDIR /workspace/recommendation

LABEL maintainer=hpc-support@virginia.edu \
      homepage=https://github.com/NVIDIA/DeepLearningExamples/tree/master/TensorFlow/Recommendation/NCF \
      description="The Neural Collaborative Filtering (NCF) model is a neural network that provides collaborative filtering based on implicit feedback. Specifically, it provides product recommendations based on user and item interactions. " \
      gpu=true \
      moduleclass=data
