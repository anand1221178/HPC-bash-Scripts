#compilation from source of mpfr
wget https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.xz
tar -xf gmp-6.2.1.tar.xz
cd gmp-6.2.1
./configure 
#cant do doesnt work --prefix=/home/ubuntu/gmp-6.2.1/
make
sudo make install

#potential modulefile
#%Module1.0
#set dir /home/ubuntu/gmp-6.2.1
#prepend-path PATH $dir/bin
#prepend-path LD_LIBRARY_PATH $dir/lib
