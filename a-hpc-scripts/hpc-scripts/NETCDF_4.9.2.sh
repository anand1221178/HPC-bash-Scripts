#prerequisites
module load Core/libxml2/latest 
module load Core/gcc/13.2
ml Core/zlib

#install netcdf-c
wget https://downloads.unidata.ucar.edu/netcdf-c/4.9.2/netcdf-c-4.9.2.tar.gz
tar -xzvf netcdf-c-4.9.2.tar.gz
cd netcdf-c-4.9.2/
./configure 
#--disable-hdf5
#fix this with
./configure ./configure --with-hdf5=$HDF5_LIB --with-szlib=$SZ_LIB
export LIBS="-L/home/ubuntu/hdf5-1.14.0/lib -lhdf5 $LIBS"
export CFLAGS="-I/home/ubuntu/hdf5-1.14.0/include $CFLAGS"
export CFLAGS="-I/nfs_share/benchmarks/wrf/libxml/include $CFLAGS"
export LIBS="-L/nfs_share/benchmarks/wrf/libxml/lib -lxml2 $LIBS"
export CFLAGS=" -I/nfs_share/benchmarks/wrf/szlib/SZ/sz/include $CFLAGS"
export LIBS="-L/nfs_share/benchmarks/wrf/szlib/SZ/sz/lib -lsz $LIBS"
export CFLAGS="-I/nfs_share/benchmarks/wrf/szlib/SZ/sz -I/nfs_share/benchmarks/wrf/szlib -I/include -I/nfs_share/benchmarks/wrf/netcdf/netcdf-c-4.9.2/include $CFLAGS"

export NETCDF=/nfs_share/benchmarks/wrf/netcdf/netcdf-c/netcdf

#./configure --disable-netcdf-4 --disable-dap --with-hdf5=/nfs_share/benchmarks/swift/hdf5-1.14.0/hdf5/lib --with-hdf5-libdir=/nfs_share/benchmarks/swift/hdf5-1.14.0/hdf5/lib

# fix --disable-byterange issue by installing curl
make
sudo make install
nc-config --version

#install netcdf-fortran
#sudo apt-get install gfortran
#wget https://downloads.unidata.ucar.edu/netcdf-fortran/4.6.0/netcdf-fortran-4.6.0.tar.gz
#tar -zxvf netcdf-fortran-4.6.0.tar.gz
#cd netcdf-fortran-4.6.0
#./configure --disable-fortran-type-check
#or
#mkdir build
#cd build
#cmake -D CMAKE_INSTALL_PREFIX=/home/ubuntu/netcdf-fortran-4.6.0 -D BUILD_MPI=on -D PKG_KOKKOS=on -D PKG_MOLECULE=yes -D PKG_BODY=on -D PKG_COLLID=on -D PKG_DIPOLE=on -D PKG_MANYBODY=on -D PKG_KSPACE=on -D PKG_RIGID=on -D PKG_USER-COLVARS=on -D PKG_READOFF=on -D BUILD_OMP=on ../../netcdf-fortran-4.6.0

echo 'export NETCDF="/usr/local"' >> ~/.bashrc && source ~/.bashrc
sudo ln -s /usr/local/include/netcdf.h /usr/local/include/netcdf.inc

#issues:
#cannot do --prefix=/home/ubuntu/netcdf-c-4.9.2/ since make install has conflicting /include for some reason
#so just opt for it to be installed in the default location :) 









== Building NetCDF with HDF5, use GNU Compiler ==
1. download source files

ftp://ftp.unidata.ucar.edu/pub/netcdf/
# Download zlib 1.2.8
wget https://www.zlib.net/fossils/zlib-1.2.8.tar.gz

# Extract the downloaded file
tar -xzvf zlib-1.2.8.tar.gz


# Download HDF5 1.8.13
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.13/src/hdf5-1.8.13.tar.gz

# Extract the downloaded file
tar -xzvf hdf5-1.8.13.tar.gz

# Download NetCDF 4.1.3 from Fedora Project lookaside cache
wget https://src.fedoraproject.org/lookaside/pkgs/netcdf/netcdf-4.1.3.tar.gz/46a40e1405df19d8cc6ddac16704b05f/netcdf-4.1.3.tar.gz

# Extract the downloaded file
tar -xzvf netcdf-4.1.3.tar.gz


#download above in different dir and then change into them for below

2. configure to install zlib, hdf5, netcdf
##### export environment
export F77=gfortran
export FC=gfortran
export CC=gcc
export CXX=g++
export CFLAGS=-fPIC

export fld_install=/home/witsa2/netcdf #change this to your folder

#sudo apt-get install libnsl-dev

##### install zlib
./configure --prefix=$fld_install; make clean; make all install
##### install hdf5
./configure --prefix=$fld_install --with-zlib=$fld_install; make clean; make all install
##### install netcdf
LDFLAGS=-L$fld_install/lib CPPFLAGS=-I$fld_install/include \
./configure --prefix=$fld_install; make clean; make all install

rather do this if error for netcdf 
LDFLAGS="-L$fld_install/lib -static" CPPFLAGS="-I$fld_install/include" \
./configure --prefix=$fld_install
make clean
make all install

#for gfortran-7 now 9
sudo apt-get -y install gfortran-9
sudo update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-9 50
sudo update-alternatives --config gfortran
gfortran --version


3. export variables to .bashrc
#NETCDF
export NETCDF=/home/witsa2/netcdf
export PATH=$NETCDF/bin:$PATH
export NETCDF_INCDIR=$NETCDF/include 
export NETCDF_LIBDIR=$NETCDF/lib
export LD_LIBRARY_PATH=$NETCDF/lib:$LD_LIBRARY_PATH
export PATH NETCDF

#module file
#%Module1.0
set NETCDF /home/witsa2/netcdf
prepend-path PATH $NETCDF/bin
prepend-path LD_LIBRARY_PATH $NETCDF/lib
setenv NETCDF_INCDIR $NETCDF/include
setenv NETCDF_LIBDIR $NETCDF/lib


nc-config --version

cp /nfs_share/benchmarks/wrf/WRF/share/landread.c.dist /nfs_share/benchmarks/wrf/WRF/share/landread.c




