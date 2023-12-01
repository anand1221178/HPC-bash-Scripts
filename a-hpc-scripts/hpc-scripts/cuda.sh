#prerequisites
sudo apt-get install -y pkg-config xorg-dev vulkan-loader
sudo update-initramfs -u

wget https://download.nvidia.com/XFree86/Linux-x86_64/545.29.06/NVIDIA-Linux-x86_64-545.29.06.run
sudo bash NVIDIA-Linux-x86_64-545.29.06.run 

wget https://developer.download.nvidia.com/compute/cuda/12.3.1/local_installers/cuda_12.3.1_545.23.08_linux.run

sudo sh cuda_12.3.1_545.23.08_linux.run

#check all after signing eula
