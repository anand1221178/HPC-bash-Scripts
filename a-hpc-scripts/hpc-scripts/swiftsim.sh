#prerequisite
ml Core/hdf5

git clone https://github.com/SWIFTSIM/SwiftSim.git
cd SwiftSim
sudo bash autogen.sh 
./configure --prefix=/home/ubuntu/SwiftSim/swift 
#for optimization --with-jemalloc=/home/ubuntu/jemalloc-5.2.1/jemalloc/
make
sudo make install

#%Module1.0
#set dir /home/ubuntu/SwiftSim/swift
#prepend-path PATH $dir/bin
#prepend-path LD_LIBRARY_PATH $dir/lib

#optimization dependencies
    tclmalloc is specific to the Tcl programming language.
    *jemalloc is a general-purpose memory allocator known for its efficiency and scalability.
    tbbmalloc is part of Intel TBB and is designed to work efficiently in parallelized applications.
    
    use libnuma to pin threads
    
    check video for flags
