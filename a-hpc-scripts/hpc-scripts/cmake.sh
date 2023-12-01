sudo apt-get update
sudo apt-get -y install libssl-dev

wget https://cmake.org/files/v3.22/cmake-3.22.0.tar.gz
tar -zxvf cmake-3.22.0.tar.gz
cd cmake-3.22.0
./configure --prefix=/home/ubuntu/cmake-3.22.0/
gmake

#potential modulefile
#%Module1.0
#set dir /home/ubuntu/cmake-3.22.0/
#prepend-path PATH $dir/bin
#prepend-path LD_LIBRARY_PATH $dir/lib
