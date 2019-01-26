#! /bin/bash

# Install dependencies

sudo apt-get update -y
sudo apt-get install cmake -y
sudo apt-get install gcc -y
sudo apt-get install g++ -y
sudo apt-get install git -y
sudo apt-get install tmux -y
sudo apt-get install nano -y
sudo apt-get install ocl-icd-opencl-dev -y

# Installation of Nvidia Driver v390

sleep 3

sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo apt update
sudo apt install nvidia-390 -y

# Start Nvidia driver and enable nvidia-smi

sudo modprobe nvidia

# Install gcc6

sudo apt-get install gcc-6 g++-6 -y

# Tell system that gcc6 is the default

sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 50
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 50

# Installation of Cuda Toolkit - Silent

cd ~

sleep 3

wget https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda_9.1.85_387.26_linux
sudo chmod +x cuda_9.1.85_387.26_linux
sudo bash cuda_9.1.85_387.26_linux --silent --toolkit

# Create sym links to enable Cuda to be recognised by Cryptogone's miner

export PATH=/usr/local/cuda-9.1/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-9.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}


# Clone into Bogdan's miner and locally compile

git clone http://github.com/bogdanadnan/ariominer.git
cd ariominer
mkdir build
cd build
cmake ..
make

# Create config file and re-run script if miner crashes

echo '#! /bin/bash

# please change pool address, wallet address and worker ID to yours
worker="OvErLoDe"
pool="http://arionum.rocks"
wallet="WALLET_ADDRESS"
cpuintensity="100"
gpuintensitycblocks="0"
gpuintensitygblocks="61"


# set this to false if you do not want miner to auto relaunch after crash
relaunch_miner_on_crash="true"

while :
do
    # -u means use all device, you can also use -d to specify list of devices (ex: -d 0,2,5)
    ./ariominer --mode miner --pool "$pool" --wallet "$wallet" --name "$worker" --cpu-intensity "$cpuintensity" --gpu-intensity-cblocks "$gpuintensitycblocks" --gpu-intensity-gblocks "$gpuintensitygblocks"  
    
    if [ "$relaunch_miner_on_crash" = "true" ]; then
        echo "miner crashed, relaunching in 5 seconds ..."
        sleep 5
    else
        break
    fi
done' > mine.sh
sudo chmod +x mine.sh
tmux new-session -d -s bogdan './mine.sh'

sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 50
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 50

sleep 3

