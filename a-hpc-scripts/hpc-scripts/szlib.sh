git clone https://github.com/szcompressor/SZ.git
cd SZ
./configure --prefix=/nfs_share/benchmarks/wrf/szlib/SZ/
libtool --finish /nfs_share/benchmarks/wrf/szlib/SZ/lib
make
sudo make install
sz --version

#potential module file
#%Module1.0
#set dir  /nfs_share/benchmarks/wrf/szlib/SZ/
#prepend-path PATH $dir/bin
#prepend-path LD_LIBRARY_PATH $dir/lib

    export SZ_LIB=/nfs_share/benchmarks/wrf/szlib/SZ/lib
    export SZ_INCLUDE=/nfs_share/benchmarks/wrf/szlib/SZ/include
    export CFLAGS="-I$SZ_INCLUDE $CFLAGS"
export LDFLAGS="-L$SZ_LIB $LDFLAGS"


