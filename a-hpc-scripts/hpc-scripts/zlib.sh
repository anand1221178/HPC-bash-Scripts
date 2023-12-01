git clone https://github.com/madler/zlib.git
cd zlib
./configure 

make
sudo make install

#potential modulefile
#%Module1.0
#set dir /nfs_share/benchmarks/wrf/szlib/SZ/sz
#prepend-path PATH $dir/bin
#prepend-path LD_LIBRARY_PATH $dir/lib

