#prerequisites
module load Core/NETCDF

#install WRF 4.4
git clone --recurse-submodules https://github.com/wrf-model/WRF
cd WRF/
./configure 
./compile wrf

#if error check video for exports FC, F77 ect..

#sudo apt-get install csh

