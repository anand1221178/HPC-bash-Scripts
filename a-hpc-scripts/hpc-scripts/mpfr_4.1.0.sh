#prerequisites
#GMP

#compilation from source of mpfr
wget https://www.mpfr.org/mpfr-current/mpfr-4.2.1.tar.xz
tar -xf mpfr-4.2.1.tar.xz
cd mpfr-4.2.1
./configure  
#cant do doesnt work --prefix=/home/ubuntu/mpfr-4.2.1/ --with-gmp=/home/ubuntu/gmp-6.2.1
make
sudo make install

#potential modulefile
#%Module1.0
#set dir /home/ubuntu/mpfr-4.2.1
#prepend-path PATH $dir/bin
#prepend-path LD_LIBRARY_PATH $dir/lib
