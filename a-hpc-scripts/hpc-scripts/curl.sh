#needs openssl to be installed
ml Core/OpenSSL

wget https://curl.se/download/curl-7.82.0.tar.gz
tar -zxvf curl-7.82.0.tar.gz
cd curl-7.82.0
./configure --with-ssl
make
sudo make install
sudo ldconfig

