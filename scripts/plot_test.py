import numpy as np
import os
import argparse
import matplotlib.pyplot as plt

parser = argparse.ArgumentParser(description='Test for working plotting scripts')

parser.add_argument("--concat_file", help="Input file to plot (concatenated seeds file)")

args = parser.parse_args()

colors = ["#1f77b4", "#ff7f0e", "#d62728", "#9467bd", "#2ca02c", "#8c564b", "#e377c2", "#bcbd22", "#17becf"]
color_index = 0

filename = args.concat_file

plot_str = filename[:-4]

data = np.load(filename)
perf_arrays = data['perf_arrays']
num_frames_arrays = data['num_frames_arrays']

print (perf_arrays.shape)
print (num_frames_arrays.shape)

steps = num_frames_arrays[0, :]

rew_data_median = np.median(perf_arrays, axis=0)
rd_upper_quartile = np.percentile(perf_arrays, 75, axis=0)
rd_lower_quartile = np.percentile(perf_arrays, 25, axis=0)

plt.plot(steps, rew_data_median, color=colors[color_index], label=plot_str)
plt.fill_between(steps, rd_upper_quartile, rd_lower_quartile, alpha=0.2, edgecolor=colors[color_index], facecolor=colors[color_index])

plt.show()