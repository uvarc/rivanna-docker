#!/bin/bash
function search_pytorch {
    for i in $@; do
        conda search -c pytorch -c gpytorch -f $i | tail -5
        echo
    done
}

function search_conda {
    for i in $@; do
        conda search -c conda-forge -f $i | tail -5
        echo
    done
}

function search_pip {
    for i in $@; do
        pip search $i | grep "^$i"
        echo
    done
}

#search_pytorch torchaudio torchtext botorch ignite
#search_conda scipy matplotlib pandas seaborn pytorch-lightning scikit-learn scikit-image
search_conda matplotlib
search_pip openslide-python opencv-python
