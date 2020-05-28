#!/bin/bash
userhome=~
vm_dir=~/python-vms
project_name=minigrid_baselines
virtualhome=${vm_dir}/${project_name}
terminal_output_folder=${userhome}/code_output/${project_name}
results_dir=${virtualhome}/results

mkdir -p terminal_output_folder
mkdir -p results_dir

frames=20000000 #number of samples
batch_size=400
frames_per_proc=400
recurrence=200
discount=0.99
epochs=1

#for conserving resources on a machine (frames should be 8 x 10**7 for last row)
envname=(MiniGrid-Empty-8x8-v0 MiniGrid-DoorKey-8x8-v0 MiniGrid-SimpleCrossingS9N1-v0 MiniGrid-SimpleCrossingS9N2-v0)
#envname=(MiniGrid-SimpleCrossingS9N3-v0 MiniGrid-SimpleCrossingS11N5-v0 MiniGrid-LavaCrossingS9N1-v0 MiniGrid-LavaCrossingS9N2-v0)
#envname=(MiniGrid-KeyCorridorS3R1-v0 MiniGrid-KeyCorridorS3R2-v0)
#envname=(MiniGrid-FourRooms-v0 MiniGrid-KeyCorridorS3R3-v0 MiniGrid-ObstructedMaze-1Dl-v0 MiniGrid-ObstructedMaze-1Dlh-v0)

#for unlimited resources
# envname=(MiniGrid-Empty-8x8-v0 MiniGrid-DoorKey-8x8-v0 MiniGrid-SimpleCrossingS9N1-v0 MiniGrid-SimpleCrossingS9N2-v0 
# 	MiniGrid-SimpleCrossingS9N3-v0 MiniGrid-SimpleCrossingS11N5-v0 MiniGrid-LavaCrossingS9N1-v0 MiniGrid-LavaCrossingS9N2-v0 
# 	MiniGrid-KeyCorridorS3R1-v0 MiniGrid-KeyCorridorS3R2-v0 
# 	MiniGrid-FourRooms-v0 MiniGrid-KeyCorridorS3R3-v0 MiniGrid-ObstructedMaze-1Dl-v0 MiniGrid-ObstructedMaze-1Dlh-v0)

seeds=(0 1 2)

if [ $1 = cat ]
then
	source $virtualhome/bin/activate
	cd $virtualhome/code/rl-starter-files/scripts
	for env in ${envname[@]}
	do
		python3 concat_results.py --env ${env} --results_dir ${results_dir}
	done
else
	source $virtualhome/bin/activate
	cd $virtualhome/code/rl-starter-files
	for env in ${envname[@]}
	do
		for seed in ${seeds[@]}
		do
			nohup python3 -u -m scripts.train --algo ppo --env ${env} --results_dir ${results_dir} --seed ${seed} --procs 16 --frames ${frames} --epochs ${epochs} --batch-size ${batch_size} --frames-per-proc ${frames_per_proc}  --discount ${discount} --recurrence ${recurrence} > terminal_output_folder/${env}_seed${seed}.out &
		done
	done
fi
