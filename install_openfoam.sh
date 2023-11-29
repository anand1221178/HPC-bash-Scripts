#!/bin/bash

# Exit immediately if any command exits with a non-zero status (error)
set -e

# Check if the openfoam directory exists in the benchmarks folder and create if it doesn't
# -p ensures that parent directories are created too
[ -d "/home/benchmarks/openfoam" ] && echo "Directory already exists" || mkdir -p /home/benchmarks/openfoam

# Check if the openfoam-11 has been downloaded or if the directory already exists, else download and extract
if [ -f "/home/benchmarks/openfoam/openfoam-11.tar.gz" ] || [ -d "/home/benchmarks/openfoam/openfoam-11" ]; then
    echo "OpenFOAM already downloaded"
else
    echo "Downloading OpenFOAM"
    cd /home/benchmarks/openfoam
    wget https://dl.openfoam.org/source/11 -O openfoam-11.tar.gz
    tar -xvzf openfoam-11.tar.gz
    rm openfoam-11.tar.gz
fi

# Change the name of the unpacked directory to the desired one
mv OpenFOAM-11-version-11 openfoam-11

# Conditional statement that checks if the directory openfoam-11 exists.
[ -d "/home/benchmarks/openfoam/openfoam-11" ] && echo "Downloaded and extracted successfully" || echo "Download and extraction failed"