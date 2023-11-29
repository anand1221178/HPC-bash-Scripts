#!/bin/bash

#exit immediately if any command exits with a non-zero status (error)
set -e

# Create MILC folder in benchmarks folder and go there
mkdir MILC
cd MILC

# Download, extract, and delete MILC .tgz file
wget https://portal.nersc.gov/project/m888/apex/MILC_160413.tgz
tar -xzf MILC_160413.tgz
rm MILC_160413.tgz

#from the video, still to iron out:
#go to the subfolder MILC-apex/benchmarks/medium (cd MILC/MILC-apex/benchmarks/medium)
#download the lattice file, its huge (wget https://portal.nersc.gov/project/m888/apex/MILC_lattices/36x36x36x72.chklat)

#go to the MILC/MILC-apex/ks_imp_rhmc folder (cd MILC/MILC-apex/ks_imp_rhmc)
#run the make clean (make clean)
#adjust parameters in the Makefile (vim Makefile)
#adjust parameters in the Make_template, check the includes (vim Make_template)
#adjust parameters in the ../libraries/Make_template, check the includes (vim ../libraries/Make_template)
#run make, it will pipe the output of the errors to the log file (make su3_rhmd_hisq 2>&1 | tee make_i201h260_skx.log)