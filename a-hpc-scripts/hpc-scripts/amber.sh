#prerequisites
sudo apt-get install flex bison 
module load Core/CMAKE/3.21.3 

#Amber
scp AmberTools23.tar.bz2 ubuntu@154.114.57.240:~/ #copy tar to node from local computer

tar -xvjf AmberTools23.tar.bz2
cd amber22_src/
cd build 
bash run_cmake.sample* #config file
bash run_cmake


