import numpy as np
import os
import argparse

parser = argparse.ArgumentParser(description='Concatenating random seeds for A2C/PPO Baseline for minigrid')

parser.add_argument("--results_dir", help="Directory the output results are stored in", default="../results")
parser.add_argument("--env", help="Gym Environment to Use.")

args = parser.parse_args()

perf_arrays = []
num_frames_arrays = []

output_folder = os.path.join(args.results_dir , args.env)
assert os.path.exists(output_folder), 'The output folder: ' + output_folder + ' does not exist to concatenate random seed results within.'

for filename in os.listdir(output_folder):
	filepath = os.path.join(output_folder, filename)
	if os.path.isfile(filepath):
		res = np.load(filepath)
		perf_arrays.append(res['perf_array'])
		num_frames_arrays.append(res['num_frames_array'])

np.savez(os.path.join(output_folder, 'concat_result.npz'), perf_arrays = perf_arrays, num_frames_arrays = num_frames_arrays)

