#!/bin/bash

#requires openmpi to be installed already!!

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

# Install required packages
check_and_install_command "git"
check_and_install_command "cmake"
check_and_install_command "gfortran"

# Install OpenBLAS
install_from_source "OpenBLAS" "https://github.com/xianyi/OpenBLAS.git" "OpenBLAS"

# Install LAPACK
install_from_source "LAPACK" "https://github.com/Reference-LAPACK/lapack.git" "lapack"

# Install ScaLAPACK
install_from_source "ScaLAPACK" "https://github.com/Reference-ScaLAPACK/scalapack.git" "scalapack"

# Print paths where the math libraries are installed
echo "Paths where the math libraries are installed:"
find /usr/local -name "libblas*"
find /usr/local -name "liblapack*"
find /usr/local -name "libscalapack*"

echo "Installation of LAPACK, ScaLAPACK, and OpenBLAS is complete."
