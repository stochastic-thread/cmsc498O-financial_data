#!/usr/bin/env python
import matplotlib as mpl
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cbook as cbook

data = np.genfromtxt('eza_24.csv', delimiter=',', skip_header=10, skip_footer=10, names=['x', 'y'])
data2 = np.genfromtxt('eza_diff.csv', delimiter=',', skip_header=10, skip_footer=10, names=['x', 'y1'])
fig = plt.figure()
ax1 = fig.add_subplot(111)
ax1.plot(data['x'], data['y'], color='r', label='the data')
ax1.plot(data['x'], data['y1'], color='b', label='the data')