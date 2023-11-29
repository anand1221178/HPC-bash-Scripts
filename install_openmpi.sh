#!/bin/bash

# Exit immediately if any command exits with a non-zero status (error)
set -e

# Install essential build tools
sudo apt-get update
sudo apt-get install -y build-essential

# Create a directory for Open MPI in /home/benchmarks
mkdir -p /home/benchmarks/openmpi

# Download and install Open MPI
cd /tmp
wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.2.tar.gz
tar -xzvf openmpi-4.1.2.tar.gz
cd openmpi-4.1.2
./configure --prefix=/home/benchmarks/openmpi
make -j$(nproc)
sudo make install

# Add Open MPI to the PATH for the current user
export PATH=/home/benchmarks/openmpi/bin:$PATH

# Add Open MPI to the LD_LIBRARY_PATH for the current user
export LD_LIBRARY_PATH=/home/benchmarks/openmpi/lib:$LD_LIBRARY_PATH

# Verify installation
mpicc --version
                  