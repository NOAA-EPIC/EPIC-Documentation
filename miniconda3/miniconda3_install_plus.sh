#!/bin/bash
# Initialize Lmod:
export BASH_ENV=/usr/share/lmod/lmod/init/bash
source $BASH_ENV
#
PREFIX0="/home/ubuntu/miniconda3"
version="4.12.0"
MODULEFILES="${PREFIX0}/modulefiles"
module use $MODULEFILES
module avail miniconda3
module load  miniconda3/$version
#
# Add git-lfs package to the base conda environment
conda activate base
conda install -y git-lfs
conda list
# Save the list of base conda packages:
env_recipes="${PREFIX0}/environments"
[[ -d "$env_recipes" ]] || mkdir -p $env_recipes
conda list --export > $env_recipes/conda_base_git-lfs.txt
conda list --explicit > $env_recipes/conda_base_git-lfs.explicit.txt
conda deactivate
echo "Installed conda git-lfs package"
