## Taken from the supplemental online materials For the "Two step Melting" paper

## PROGRAM : correlation_position.py
## PURPOSE : positional correlations for a single config.
## of N= 1024^2 disks in a square box of length 1.
## I/O : Input configuration from file "config_0_718.dat",
## histogram output into "correlation_0.718.png".
## LANGUAGE: Python 2.7
##========+=========+=========+=========+=========+=========+
import numpy, math, random
import matplotlib.pyplot as plt

x = numpy.loadtxt('config_0_718.dat')
N = 1048576
sigma = 0.00046686  # for eta=0.718
delta = 20 * sigma
x_dist = [0, 50 * sigma, 100 * sigma, 200 * sigma]
x_draw = [[], [], [], []]
y_draw = [[], [], [], []]
M = 100  # run-time: 10 minutes. For fig S 7, M=1000 was used
for k in range(M * N):
    i = numpy.random.randint(0, N)
    j = numpy.random.randint(0, N)
    yy = (x[j, 1] - x[i, 1]) % 1.0
    if yy > 0.5: yy -= 1.0
    if abs(yy) < delta:
        xx = (x[j, 0] - x[i, 0]) % 1.0
        if xx > 0.5: xx -= 1.0
        for k in range(4):
            if abs(xx - x_dist[k]) < delta and i != j:
                x_draw[k].append(xx / sigma)
                y_draw[k].append(yy / sigma)
plt.figure(figsize=(18, 3.2))
plt.suptitle('Positional correlations')
plt.subplots_adjust(wspace=.3, bottom=0.15, top=0.85)
for k in range(4):
    plt.subplot(1, 4, k + 1)
    ymin = -20
    ymax = 20
    xmin = x_dist[k] / sigma - 20
    xmax = x_dist[k] / sigma + 20
    plt.hexbin(x_draw[k], y_draw[k], gridsize=100)
    plt.axis([xmin, xmax, ymin, ymax])
    plt.xlabel("$\Delta x/\sigma$")
    plt.ylabel("$\Delta y/\sigma$", x=30.)
    plt.yticks([-20, 0, 20])
    plt.xticks([xmin, xmin + 20, xmax])
    cb = plt.colorbar()
plt.savefig('correlation_0.718.png')
