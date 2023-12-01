#prerequisites
sudo apt-get -y install tcl-dev lua5.3 luarocks liblua5.3-dev
sudo luarocks install luaposix

#install lmod from source
git clone https://github.com/TACC/Lmod.git
cd Lmod
./configure 
make 
sudo make install

#set vars permanently
echo 'export MODULEPATH="/usr/local/lmod/8.7.32/modulefiles:$MODULEPATH"' >> ~/.bashrc && echo 'source /usr/local/lmod/lmod/init/bash' >> ~/.bashrc && source ~/.bashrc

