# Bogdan-Auto-Install-Important note, 20 Gb instances at least are needed!!!

Auto install scripts for Bogdan's Arionum miner

These scripts have been created by myself for those that would prefer to use just one single miner rather than my other repository which uses a combination of Cryptogone's GPU miner and ProgrammerDan's Java CPU miner.

They are designed to be run on Google Cloud Platform instances utilising the Nvidia Tesla V100 and P100 GPU's.

There are 3 scripts, one for Ubuntu 16.04 and one for Ubuntu 18.04 and finally Bogdan_CPU which is purely for those wishing to utilise just CPU with cloud instances.

To use the scripts, simply copy and paste the raw data into the automation box when creating your GCP instance.

Please remember to change the pool, wallet and other details. You can choose your CPU and GPU intensity settings in the script and also set which CPU optimization method you want. Currently GCP supports up to AVX512F however I have found the best performance to be AVX2.

I have also used Cryptogone's miner reset routine so that if the miner crashes it will restart automatically, you can set this to "Off" if you prefer simply by editing the script when pasting into the GCP automation box.

In all cases to access the miner, simply type "sudo tmux attach -t bogdan". To exit tmux and keep the instance running so it is safe to exit the VPS, simply press CTRL+B and then "d" on it's own, this will return you to the command line interface prompt.

If you wish to donate towards my research and testing please feel free to donate ARO to the following address -
4cAKS6DE81sT3PfNcQBQwPa2NsfGRSP6WGqiQepXPjfTjZhrAWa77uHPb4nQbppetMTAEt9GiTjX9bHpC589FX3E
