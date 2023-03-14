FROM tensorflow/tensorflow:2.11.0-gpu-jupyter

RUN pip install --no-cache-dir --extra-index-url https://download.pytorch.org/whl/cu113 \
        torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
        bertopic==0.13.0 \
        pandas==1.5.3 \
        scikit-learn==1.2.1 \
        seaborn==0.12.2 \
        spacy==3.5.0 \
        tqdm==4.64.1 \
        transformers==4.26.0 \
        transformers_interpret==0.9.6 \
        wordcloud==1.8.2.2

# RIV-10409
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get update && apt-get install git-lfs && rm -rf /var/lib/apt/lists/*

LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["python"]
