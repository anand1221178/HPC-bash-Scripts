# Check if SZIP is installed
if ! command -v sztool &> /dev/null
then
    echo "SZIP not found, installing..."
    
    # Download and install SZIP
    SZIP_SOURCE_URL="https://support.hdfgroup.org/ftp/lib-external/szip/2.1.1/src/szip-2.1.1.tar.gz"
    #Get the install directory
    read -p "Enter the installation directory for SZIP " INSTALL_DIR
    wget $SZIP_SOURCE_URL
    tar -xvf szip-2.1.1.tar.gz
    cd szip-2.1.1
    ./configure --prefix=$INSTALL_DIR
    make -j$(nproc)
    make install
    cd ..
    rm -rf szip-2.1.1.tar.gz
    cd ~
    echo "SZIP installation complete"
else
    echo "SZIP is already installed"
fi

# Check if ZLIB is installed
if ! command -v zlib-flate &> /dev/null
then
    echo "ZLIB not found, installing..."
    
    # Download and install ZLIB
    #GET THE INSTALL DIRECTORY
    read -p "Enter the installation directory ZLIB" INSTALL_DIR
    mkdir $INSTALL_DIR
    cd $INSTALL_DIR
    ZLIB_SOURCE_URL="https://www.zlib.net/fossils/zlib-1.2.13.tar.gz"
    wget $ZLIB_SOURCE_URL
    tar -xzvf zlib-1.2.13.tar.gz
    cd zlib-1.2.13
    ./configure 
    make -j$(nproc)
    make check
    make install
    cd ..
    rm -rf zlib-1.2.13 zlib-1.2.13.tar.gz
    cd ~
    echo "ZLIB installation complete"
else
    echo "ZLIB is already installed"
fi
