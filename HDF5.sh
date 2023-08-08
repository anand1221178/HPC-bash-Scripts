#!/bin/bash

# Check if HDF5 is already installed
if [ -x "$(command -v hdf5)" ]; then
    echo "HDF5 is already installed."
    exit 0
fi

# Check if wget is installed and install it if not
if ! [ -x "$(command -v wget)" ]; then
    echo "wget is not installed. Installing wget..."
    sudo apt update
    sudo apt install -y wget
fi

# Step 1: Download HDF5 source code
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.14/hdf5-1.14.0/src/hdf5-1.14.0.tar.gz

# Step 2: Extract the downloaded archive
tar -xzf hdf5-1.14.0.tar.gz

# Step 3: Change into the extracted folder
cd hdf5-1.14.0

# Step 4: Prompt user for installation directory or use default
echo "Enter the installation directory (press Enter for default):"
read INSTALL_DIR

# Step 5: Configure with provided prefix or use default
if [ -z "$INSTALL_DIR" ]; then
    ./configure
else
    ./configure --prefix="$INSTALL_DIR" --with-szip=/root/szip-2.1.1 --with-zlib=/root/zlib/
fi

# Step 6: Compile the code
make

# Step 7: Run tests
make check

# Step 8: Install the program
make install

# Step 9: Run installation tests
make check-install

# Step 10: Check if installation was successful
if [ $? -eq 0 ]; then
    echo "HDF successfully installed."
else
    echo "Installation failed."
fi
