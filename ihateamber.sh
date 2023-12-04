wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1D0RlcaAJv2AkfD_EnwSAolTPQ_lZQu-d' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1D0RlcaAJv2AkfD_EnwSAolTPQ_lZQu-d" -O AmberTools23.tar.bz2 && rm -rf /tmp/cookies.txt


wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1l_hl-_SY1jd_ryaMl0C3Jta2U9Jb6zEu' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1l_hl-_SY1jd_ryaMl0C3Jta2U9Jb6zEu" -O Amber22.tar.bz2 && rm -rf /tmp/cookies.txt


export AMBERHOME=$PWD
export PATH=$AMBERHOME/bin:$PATH

tar -xvjf AmberTools23.tar.bz2

tar -xvjf Amber22.tar.bz2
cd amber22_src

cd build
#CHANGE TO INTEL IN ./run_cmake


#source /nfs_share/intel/setvars.sh (load modules
ml Core/lmod/6.6
ml Core/settarg/6.6
ml mpi
ml compiler
ml icc
ml mkl


# first serail install
./run_cmake #there were like 50 billion stuff missing apparently?? worked after installing seperately tho but we obv cant do that. maybe a different source or smth?

make install
source $AMBERHOME/amber22/amber.sh
# -DINSTALL_TESTS=TRUE in cmake invocation, then:
#cd $AMBERHOME 
#make test.serial (tests if serial vers works)
