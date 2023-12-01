wget https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2
tar -xvf jemalloc-5.2.1.tar.bz2
cd jemalloc-5.2.1
sudo bash autogen.sh 
./configure --prefix=/home/ubuntu/jemalloc-5.2.1/jemalloc
#--enable-prof enables memory profiling
make
sudo make install

export LD_PRELOAD=/home/ubuntu/jemalloc-5.2.1/jemalloc/lib/libjemalloc.so

#module file for jemalloc
#%Module1.0
#set dir /home/ubuntu/jemalloc-5.2.1/jemalloc
#prepend-path PATH $dir/bin
#prepend-path LD_LIBRARY_PATH $dir/lib

