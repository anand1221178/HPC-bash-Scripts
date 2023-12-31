#!/bin/bash

#scalapack requires MPI to be installed already 
#installs gfortran via apt if gcc was not installed previously (run install_gcc.sh before executing this script!!) m

# Function to check if a command is available and install it if not
check_and_install_command() {
    local package_name="$1"
    if ! command -v "$package_name" &>/dev/null; then
        echo "$package_name not found, attempting to install..."
        apt-get update || { echo "Failed to update package lists. Exiting."; exit 1; }
        apt-get install -y "$package_name" || { echo "Failed to install $package_name. Exiting."; exit 1; }
    else
        echo "$package_name is already installed"
    fi
}

# Install required packages
check_and_install_command "git"
check_and_install_command "cmake"

# Function to install a package from source if not already installed
install_from_source() {
    local package_name="$1"
    local source_url="$2"
    local source_dir="$3"

    if [ ! -d "$source_dir" ]; then
        echo "Cloning $package_name from $source_url..."
        git clone "$source_url" "$source_dir" || { echo "Failed to clone $package_name. Exiting."; exit 1; }
    else
        echo "$package_name source code already exists"
    fi

    cd "$source_dir"
    mkdir build
    cd build
    cmake ..
    make
    make install
    cd ../..
}

# Install gfortran and openmpi if not installed via other means 
check_and_install_command "gfortran"
check_and_install_command "openmpi"

# Install OpenBLAS
install_from_source "OpenBLAS" "https://github.com/xianyi/OpenBLAS.git" "OpenBLAS"

# Install LAPACK
install_from_source "LAPACK" "https://github.com/Reference-LAPACK/lapack.git" "lapack"

# Install ScaLAPACK
install_from_source "ScaLAPACK" "https://github.com/Reference-ScaLAPACK/scalapack.git" "scalapack"

# Update PATH and LD_LIBRARY_PATH for the math libraries
echo "export LD_LIBRARY_PATH=\"/usr/local/lib:\$LD_LIBRARY_PATH\"" >> ~/.bashrc
source ~/.bashrc

# Print paths where the math libraries are installed
echo "Paths where the math libraries are installed:"
find /usr/local -name "libblas*"
find /usr/local -name "liblapack*"
find /usr/local -name "libscalapack*"

echo "Installation of gfortran and math libraries is complete."
