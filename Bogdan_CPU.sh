#! /bin/bash

# Install dependencies

sudo apt-get update -y
sudo apt-get install ocl-icd-opencl-dev -y
sudo apt-get install cmake -y
sudo apt-get install gcc -y
sudo apt-get install g++ -y
sudo apt-get install git -y
sudo apt-get install tmux -y
sudo apt-get install nano -y

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
# adjust -b & -t value as described in the README and FAQ
worker="OvErLoDe"
pool="http://arionum.rocks"
wallet="65AkkjBs2arwbikYVDh3B57aeehzpVp9Xw69tgewj8y8stx9FjajNhxR5Y3D9vzjYGgPGzuXbf7xSKn1C2i2DxFY"
cpuintensity="100"
gpuintensitycblocks="0"
gpuintensitygblocks="0"
cpuoptimization="AVX2"


# set this to false if you do not want miner to auto relaunch after crash
relaunch_miner_on_crash="true"

while :
do
    # -u means use all device, you can also use -d to specify list of devices (ex: -d 0,2,5)
    ./ariominer --mode miner --pool "$pool" --wallet "$wallet" --name "$worker" --cpu-intensity "$cpuintensity" --gpu-intensity-cblocks "$gpuintensitycblocks" --gpu-intensity-gblocks "$gpuintensitygblocks" --force-cpu-optimization "$cpuoptimization" 
    
    if [ "$relaunch_miner_on_crash" = "true" ]; then
        echo "miner crashed, relaunching in 5 seconds ..."
        sleep 5
    else
        break
    fi
done' > mine.sh
sudo chmod +x mine.sh
tmux new-session -d -s bogdan './mine.sh'
