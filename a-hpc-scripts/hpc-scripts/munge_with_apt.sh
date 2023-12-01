#hnode
sudo nano /etc/hosts
IP_ADDRESS_OF_COMPUTE_NODE scccomputen

sudo apt-get update
sudo apt-get install munge
sudo dd if=/dev/urandom bs=1 count=1024 | sudo tee /etc/munge/munge.key > /dev/null
sudo chown munge:munge /etc/munge/munge.key
sudo chmod 400 /etc/munge/munge.key

#cnode
sudo chown munge:munge /etc/munge/munge.key
sudo chmod 400 /etc/munge/munge.key
sudo mkdir -p /etc/munge/
sudo chmod 700 /etc/munge/

#hnode
sudo chmod 777 /etc/munge/munge.key

sudo scp -i ~/.ssh/id_rsa /etc/munge/munge.key ubuntu@10.100.0.143:~/
move it to /etc/munge

#cnode
sudo mv munge.key /etc/munge/

#hnode
sudo chown -R slurm:slurm /var/spool/slurmctld
sudo chmod 755 /var/spool/slurmctld


sudo apt update
sudo apt install -y slurm-wlm
sudo nano /etc/slurm/slurm.conf #confirm exists

#add this, not anymore both files must be the same
#ControlMachine=scchead
# COMPUTE NODES
#NodeName=scccomputen[1-32] CPUs=1 State=UNKNOWN
#PartitionName=debug Nodes=ALL Default=YES MaxTime=INFINITE State=UP



sudo systemctl start slurmctld
sudo systemctl enable slurmctld
sudo systemctl status slurmctld


#errors
journalctl -xe | grep slurmctld
sudo /usr/sbin/slurmctld -D -vvv or this for cnode sudo /usr/sbin/slurmd -D -vvv #manual start if status is inactive
man cgroup.conf
hostname


#cnode
# makes random file for munge sudo dd if=/dev/urandom of=/etc/munge/munge.key bs=1 count=1024
sudo chmod 400 /etc/munge/munge.key
sudo chown munge:munge /etc/munge/munge.key



sudo apt update
sudo apt install slurm-wlm
sudo nano /etc/slurm/slurm.conf #confirm exists

#make config file
sudo nano /etc/slurm/cgroup.conf
#add this in file
CgroupAutomount=yes
CgroupMountpoint=/sys/fs/cgroup
ConstrainCores=yes
ConstrainDevices=yes
ConstrainKmemSpace=no        # Avoid known Kernel issues
ConstrainRAMSpace=yes
ConstrainSwapSpace=yes

sudo nano /etc/slurm/slurm.conf
#add this in file, not anymore since both files must be the same
#SlurmctldHost=scchead
#NodeName=scccomputen CPUs=8 RealMemory=8000 State=UNKNOWN
#PrologFlags=Contain                     # X11 flag is also suggested, dont have to include this


#hnode
#creates new key sudo dd if=/dev/urandom of=/etc/munge/munge.key bs=1 count=1024
sudo chmod 400 /etc/munge/munge.key
sudo chown munge:munge /etc/munge/munge.key

#dont do this incase of..
#sudo apt-get install cgroup-tools
#sudo mkdir -p /sys/fs/cgroup/freezer
#sudo mount -t cgroup -o freezer none /sys/fs/cgroup/freezer

sudo systemctl restart slurmd
sudo systemctl enable slurmd
sudo systemctl status slurmd

#hnode
sinfo
squeue
scontrol show nodes
systemctl status slurmctld
host scccomputen1








