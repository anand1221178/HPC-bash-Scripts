wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.14/hdf5-1.14.0/src/hdf5-1.14.0.tar.gz
tar -zxvf hdf5-1.14.0.tar.gz
cd hdf5-1.14.0
sudo bash autogen.sh 
./configure --prefix=/nfs_share/benchmarks/wrf/hdf5/hdf5-1.14.0/hdf5
make
sudo make install
h5cc -show

#module file for hdf5
#%Module1.0
#set hdf5_root /nfs_share/benchmarks/wrf/hdf5/hdf5-1.14.0/hdf5
#prepend-path PATH $hdf5_root/bin
#prepend-path LD_LIBRARY_PATH $hdf5_root/lib

