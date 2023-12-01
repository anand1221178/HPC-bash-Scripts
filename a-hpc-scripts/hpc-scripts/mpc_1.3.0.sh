#prerequisites
#gmp and mpfr

#compilation from source of mpc
wget https://www.multiprecision.org/downloads/mpc-1.3.0.tar.gz
tar -zxvf mpc-1.3.0.tar.gz
cd mpc-1.3.0
./configure 

# cant do doesnt work --prefix=/home/ubuntu/mpc-1.3.0/ --with-gmp=/home/ubuntu/gmp-6.2.1 --with-mpfr=/home/ubuntu/mpfr-4.2.1
make
sudo make install

#potential modulefile
#%Module1.0
#set dir /home/ubuntu/mpc-1.3.0
#prepend-path PATH $dir/bin
#prepend-path LD_LIBRARY_PATH $dir/lib

