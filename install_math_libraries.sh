#!/bin/bash

# Function to check if a command is available and install it if not
check_and_install_command() {
    local package_name="$1"
    if ! command -v "$package_name" &>/dev/null; then
        echo "$package_name not found, attempting to install..."
        if [[ "$package_manager" == "apt-get" ]]; then
            apt-get update || { echo "Failed to update package lists. Exiting."; exit 1; }
            apt-get install -y "$package_name" || { echo "Failed to install $package_name. Exiting."; exit 1; }
        elif [[ "$package_manager" == "yum" ]]; then
            yum install -y "$package_name" || { echo "Failed to install $package_name. Exiting."; exit 1; }
        fi
    else
        echo "$package_name is already installed"
    fi
}

# Function to install math libraries from pre-built packages (assuming they are available)
install_math_libraries() {
    echo "Installing math libraries (BLAS, LAPACK, and ScaLAPACK) ..."

    if [[ "$package_manager" == "apt-get" ]]; then
        apt-get update || { echo "Failed to update package lists. Exiting."; exit 1; }
        apt-get install -y libopenblas-dev liblapack-dev libscalapack-mpi-dev || { echo "Failed to install math libraries. Exiting."; exit 1; }
    elif [[ "$package_manager" == "yum" ]]; then
        yum install -y epel-release || { echo "Failed to install EPEL repository. Exiting."; exit 1; }
        yum install -y openblas-devel lapack-devel scalapack-openmpi-devel || { echo "Failed to install math libraries. Exiting."; exit 1; }
    fi

    echo "Math libraries installation complete."
}

# Function to check if a command exists
command_exists() {
    command -v "$1" &>/dev/null
}

# Function to check if the math libraries are installed
check_math_libraries() {
    echo "Checking if math libraries (BLAS, LAPACK, and ScaLAPACK) are installed..."

    if [[ -n $(ldconfig -p | grep libblas) ]]; then
        echo "BLAS is installed."
    else
        echo "BLAS is not installed."
    fi

    if [[ -n $(ldconfig -p | grep liblapack) ]]; then
        echo "LAPACK is installed."
    else
        echo "LAPACK is not installed."
    fi

    if [[ -n $(ldconfig -p | grep libscalapack) ]]; then
        echo "ScaLAPACK is installed."
    else
        echo "ScaLAPACK is not installed."
    fi

   # Display the paths where the math libraries are installed
   echo "Paths where the math libraries are installed:"
   ldconfig -p | grep libblas
   ldconfig -p | grep liblapack
   ldconfig -p | grep libscalapack 
}

# Main script
# Detect the package manager available on the system
if command_exists apt-get; then
    package_manager="apt-get"
elif command_exists yum; then
    package_manager="yum"
else
    echo "Error: No supported package manager found (neither apt-get nor yum). Unable to install math libraries. Exiting."
    exit 1
fi

# Install dependencies
check_and_install_command "wget"
check_and_install_command "ssh"
check_and_install_command "tar"

# Install math libraries
install_math_libraries

# Check if math libraries are installed correctly
check_math_libraries
