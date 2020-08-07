#!/bin/bash
function search_conda {
    for i in $@; do
        conda search -c conda-forge -f $i | tail -5
        echo
    done
}

search_conda mkl numpy scipy scikit-learn jupyter notebook ipython pandas matplotlib
