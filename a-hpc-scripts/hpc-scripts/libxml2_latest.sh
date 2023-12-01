wget http://xmlsoft.org/download/LATEST_LIBXML2 -O libxml2-latest.tar.gz
tar -xzvf libxml2-latest.tar.gz
cd libxml2-2.9.12/
./configure --prefix=/nfs_share/benchmarks/wrf/libxml

make
sudo make install
xml2-config --version

#potential module file
#%Module1.0
#set dir  /nfs_share/benchmarks/wrf/libxml/libxml2-2.9.12/
#prepend-path PATH $dir/bin
#prepend-path LD_LIBRARY_PATH $dir/lib

