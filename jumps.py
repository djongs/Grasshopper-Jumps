import numpypy as np
import math
import time
import random

def generate_jump(r):
    theta = random.uniform(0,2)*math.pi
    x = r*math.cos(theta)
    y = r*math.sin(theta)
    return x,y

def generate_n_jump(n, r):
    x, y = 0,0
    for i in range(n):
        jump = generate_jump(r)
        incx, incy =  jump
        x += incx
        y += incy
    return x,y


def simulate_jumps(N,n,r):
    x = np.zeros(N)
    y = np.zeros(N)
    for i in range(N):
        xy = generate_n_jump(n, r)
        x[i] = xy[0]
        y[i] = xy[1]
    return x,y

t0 = time.time()
simulate_jumps(100000, 1000, 1)
t1 = time.time()

#print t1-t0

