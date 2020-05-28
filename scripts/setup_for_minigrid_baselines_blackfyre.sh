#!/bin/bash
torch_ac_repo=https://github.com/amitfishy/torch-ac
rl_starter_files_repo=https://github.com/amitfishy/rl-starter-files

vm_dir=~/python-vms
project_name=minigrid_baselines

mkdir ${vm_dir}
virtualenv --no-download ${vm_dir}/${project_name}
source ${vm_dir}/${project_name}/bin/activate

#install libraries
pip3 install numpy torch==1.1.0 matplotlib tensorboardX

#for gym
mkdir ${vm_dir}/${project_name}/libraries
cd ${vm_dir}/${project_name}/libraries
git clone https://github.com/openai/gym
cd gym
pip3 install -e .
pip3 install gym[atari]

#for gym-minigrid
cd ${vm_dir}/${project_name}/libraries
git clone https://github.com/maximecb/gym-minigrid.git
cd gym-minigrid
pip3 install -e .
cp -r gym_minigrid ${vm_dir}/${project_name}/lib/python3.7/site-packages

#for torch-ac
cd ${vm_dir}/${project_name}/libraries
git clone ${torch_ac_repo}
cd torch-ac
pip3 install -e .

#setup code
mkdir ${vm_dir}/${project_name}/code
cd ${vm_dir}/${project_name}/code
git clone ${rl_starter_files_repo}