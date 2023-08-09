#!/bin/bash

# Download URLs for the packages
gcc_url=https://mirror.ufs.ac.za/gnu/gcc/gcc-13.2.0/gcc-13.2.0.tar.gz
gmp_url=https://mirror.ufs.ac.za/gnu/gmp/gmp-6.3.0.tar.gz
mpfr_url=https://mirror.ufs.ac.za/gnu/mpfr/mpfr-4.1.0.tar.gz
mpc_url=https://mirror.ufs.ac.za/gnu/mpc/mpc-1.3.1.tar.gz
m4_url=https://mirror.ufs.ac.za/gnu/m4/m4-1.4.19.tar.gz

# Create a directory to build everything
build_dir=/tmp/gcc_build
mkdir -p "$build_dir"

# Install a basic C compiler for bootstrapping
apt-get update
apt-get install -y build-essential wget tar

# Function to check and handle errors
check_error() {
    if [ $? -ne 0 ]; then
        echo "Error: $1"
        exit 1
    fi
}

# Download and install m4
cd "$build_dir"
if [ ! -d m4_install ]; then
    wget "$m4_url"
    tar -xf m4-1.4.19.tar.gz
    cd m4-1.4.19
    ./configure --prefix="$build_dir/m4_install"
    make
    check_error "Failed to build m4"
    make install
    check_error "Failed to install m4"
    export PATH="${build_dir}/m4_install/bin:$PATH"
    export LD_LIBRARY_PATH="${build_dir}/m4_install/lib:$LD_LIBRARY_PATH"
fi

# Download and install GMP
cd "$build_dir"
if [ ! -d gmp_install ]; then
    wget "$gmp_url"
    tar -xf gmp-6.3.0.tar.gz
    cd gmp-6.3.0
    ./configure --prefix="$build_dir/gmp_install"
    make
    check_error "Failed to build GMP"
    make install
    check_error "Failed to install GMP"
    export PATH="${build_dir}/gmp_install/bin:$PATH"
    export LD_LIBRARY_PATH="${build_dir}/gmp_install/lib:$LD_LIBRARY_PATH"
fi

# Download and install MPFR
cd "$build_dir"
if [ ! -d mpfr_install ]; then
    wget "$mpfr_url"
    tar -xf mpfr-4.1.0.tar.gz
    cd mpfr-4.1.0
    ./configure --prefix="$build_dir/mpfr_install" --with-gmp="$build_dir/gmp_install"
    make
    check_error "Failed to build MPFR"
    make install
    check_error "Failed to install MPFR"
    export PATH="${build_dir}/mpfr_install/bin:$PATH"
    export LD_LIBRARY_PATH="${build_dir}/mpfr_install/lib:$LD_LIBRARY_PATH"
fi

# Download and install MPC
cd "$build_dir"
if [ ! -d mpc_install ]; then
    wget "$mpc_url"
    tar -xf mpc-1.3.1.tar.gz
    cd mpc-1.3.1
    ./configure --prefix="$build_dir/mpc_install" --with-gmp="$build_dir/gmp_install" --with-mpfr="$build_dir/mpfr_install"
    make
    check_error "Failed to build MPC"
    make install
    check_error "Failed to install MPC"
    export PATH="${build_dir}/mpc_install/bin:$PATH"
    export LD_LIBRARY_PATH="${build_dir}/mpc_install/lib:$LD_LIBRARY_PATH"
fi

# Download and install GCC
cd "$build_dir"
if [ ! -d gcc_install ]; then
    wget "$gcc_url"
    tar -xf gcc-13.2.0.tar.gz
    cd gcc-13.2.0
    ./configure --prefix="$build_dir/gcc_install" --with-gmp="$build_dir/gmp_install" --with-mpfr="$build_dir/mpfr_install" --with-mpc="$build_dir/mpc_install" --disable-multilib
    make
    check_error "Failed to build GCC"
    make install
    check_error "Failed to install GCC"
    export PATH="${build_dir}/gcc_install/bin:$PATH"
    export LD_LIBRARY_PATH="${build_dir}/gcc_install/lib:$LD_LIBRARY_PATH"
fi

# Update PATH and LD_LIBRARY_PATH in ~/.bashrc
echo "export PATH=\"${build_dir}/gcc_install/bin:\$PATH\"" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\"${build_dir}/gcc_install/lib:\$LD_LIBRARY_PATH\"" >> ~/.bashrc
source ~/.bashrc

# Test if GCC was installed correctly
echo "Testing GCC installation..."
gcc_version=$(gcc --version | grep -oE "[0-9]+\.[0-9]+\.[0-9]+")
if [ "$gcc_version" == "13.2.0" ]; then
    echo "GCC is installed correctly with version $gcc_version."
else
    echo "GCC installation may have encountered issues."
fi

echo "GCC and its prerequisites (GMP, MPFR, MPC) installation completed successfully."

