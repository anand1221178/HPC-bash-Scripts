#prerequisites
ml Core/CMAKE/3.21.3 
ml Core/gcc/13.2.0
ml Core/anaconda/3
ml Core/mpich/4.2.0b1 #also try using openmpi mpich might have a performance gain

#install lammps
git clone https://github.com/lammps/lammps.git
cd lammps/
mkdir build
cd build

#configure build
cmake -D CMAKE_INSTALL_PREFIX=/home/ubuntu/lammps -D BUILD_MPI=on -D PKG_KOKKOS=on -D PKG_MOLECULE=yes -D PKG_BODY=on -D PKG_COLLID=on -D PKG_DIPOLE=on -D PKG_MANYBODY=on -D PKG_KSPACE=on -D PKG_RIGID=on -D PKG_USER-COLVARS=on -D PKG_READOFF=on -D BUILD_OMP=on ../cmake/ #specify installation dir, mpi ect..

#add the following to cmake for gpu with cuda
-D PKG_GPU=on
-D GPU_API=CUDA
-D GPU_PREC=single
-D GPU_ARCH=sm_70

make -j$(( $(nproc) - 2 )) #can specify the amount of cores
make install

#potential modulefile
#%Module1.0
#set dir /home/ubuntu/lammps
#prepend-path PATH $dir/bin
#prepend-path LD_LIBRARY_PATH $dir/lib

#lammps binary in /home/ubuntu/lammps/bin/lmp

#find benchmarks in /home/ubuntu/lammps/bench
#below run the in.chain benchmark
export OMP_NUM_THREADS=1 #specify number of threads to use to run
mpirun -np 2 /home/ubuntu/lammps/bin/lmp < /home/ubuntu/lammps/bench/in.chain

#unrelated but check gpu with :)
nvidia-smi
or
lspci | grep VGA
or
sudo apt-get install inxi
inxi -G
