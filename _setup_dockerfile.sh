#!/bin/bash

function announce {
    echo
    echo "#######################################################################################"
    echo "## $1       ("`date -u`")"
    echo
}

announce "Cleaning base environment"
/opt/XENONnT/anaconda/bin/conda update -n base -c defaults conda
source /opt/XENONnT/setup.sh

echo "Removing old versions of analysis software"
pip uninstall -y strax straxen utilix admix

announce "Installing dependenencies"
conda env update --file xnt_conda_env.yml
pip install tensorflow==2.0.0-beta1          # Update conda-installed version. Installing 2 via pip does not work.
conda clean --all --yes

announce "Installing XENON software"
pip install strax straxen flamedisx
pip install git+https://github.com/XENONnT/utilix.git
pip install git+https://github.com/XENONnT/admix.git

announce "Running tests"
conda activate XENONnT_development

# Strax
git clone --single-branch --branch stable https://github.com/AxFoundation/strax.git
pytest strax || { echo 'strax tests failed' ; exit 1; }
rm -r strax

# Straxen
git clone --single-branch --branch stable https://github.com/XENONnT/straxen.git
pytest straxen || { echo 'straxen tests failed' ; exit 1; }
rm -r straxen
