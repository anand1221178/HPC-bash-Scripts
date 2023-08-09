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


if ! command -v openmpi &> /dev/null
then
    echo "wget not found, installing..."
##INSTALL OPENMPI v4.1.5
# Get the installation directory from the user
read -p "Enter the installation directory for OpenMPI: " INSTALL_DIR

# Download and extract OpenMPI
wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.5.tar.gz
tar -xzf openmpi-4.1.5.tar.gz

# Configure and install OpenMPI
cd openmpi-4.1.5
./configure --prefix=$INSTALL_DIR
make -j$(nproc)
make install

# Write the module file
mkdir -p $INSTALL_DIR/modules
cat << EOF > $INSTALL_DIR/modules/openmpi
#%Module1.0
prepend-path PATH $INSTALL_DIR/bin
prepend-path LD_LIBRARY_PATH $INSTALL_DIR/lib
EOF

# Append the moduleuse line to the bashrc
echo "module use --append $INSTALL_DIR/modules" >> ~/.bashrc
source ~/.bashrc
##END OF OPENMPI INSTALL



##INSTALL OPENBLAS v0.3.23
read -p "Enter the installation directory for OpenBLAS: " INSTALL_DIR

# Configure and install OpenBLAS
cd OpenBLAS-0.3.23
make FC=gfortran

# Write the module file
mkdir -p $INSTALL_DIR/modules
cat << EOF > $INSTALL_DIR/modules/openBLAS
#%Module1.0
prepend-path PATH $INSTALL_DIR/bin
prepend-path LD_LIBRARY_PATH $INSTALL_DIR/lib
EOF

make $INSTALL_DIR/OpenBLAS-0.3.23 install

# Append the moduleuse line to the bashrc
echo "module use --append $INSTALL_DIR/modules" >> ~/.bashrc
source ~/.bashrc
##END OF OPENBLAS INSTALL


##INSTALL HPL-2.3
# Get the installation directory from the user
read -p "Enter the installation directory for HPL: " INSTALL_DIR

# Download and extract HPL
wget https://www.netlib.org/benchmark/hpl/hpl-2.3.tar.gz
tar -xzf hpl-2.3.tar.gz

# Configure and copy setup to working dir
cd hpl-2.3
cp setup/Linux_PII_CBLAS_gm .

##<File setup here>##

# Build HPL
make arch=Linux_PII_CBLAS_gm
##END OF HPL INSTALL

