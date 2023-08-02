#!/bin/bash

if ! command -v wget &> /dev/null
then
    echo "wget not found, installing..."
    apt-get update
    apt-get install -y wget
else
    echo "wget is already installed"
fi


# Checks if make is installed
if ! command -v make &> /dev/null
then
    echo "make not found, installing..."
    apt-get update
    apt-get install -y build-essential
else
    echo "make is already installed"
fi


# Checks if tar is installed
if ! command -v tar &> /dev/null
then
    echo "tar not found, installing..."
    apt-get update
    apt-get install -y tar
else
    echo "tar is already installed"
fi


# Step 2: Download HPL
HPL_SOURCE_URL="https://www.netlib.org/benchmark/hpl/hpl-2.3.tar.gz"
wget $HPL_SOURCE_URL
tar -xvf hpl-2.3.tar.gz
cd hpl-2.3


# Get the installation directory from the user
read -p "Enter the installation directory for OpenMPI: " INSTALL_DIR

# Download and extract OpenMPI
wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.3.tar.gz
tar -xzf openmpi-4.1.3.tar.gz

# Configure and install OpenMPI
cd openmpi-4.1.3
./configure --prefix=$INSTALL_DIR
make -j$(nproc)
make install

# Write the module file
mkdir -p $INSTALL_DIR/modules
cat << EOF > $INSTALL_DIR/modules/openmpi
#%Module1.0
