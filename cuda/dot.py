import pycuda.gpuarray as gpuarray
import pycuda.autoinit
import numpy as np
import scikits.cuda.linalg as linalg

import timeit

np.random.seed(1)

x=4000
y=150000
fpsize=4

print("X=%d,Y=%d float size=%d (%f GB)" % (x,y,fpsize,(2.0*float(x)*float(y)+float(x)*float(x))*fpsize/1000000000.0))
# sys.exit(1)

linalg.init()
print("Creating matrices\n")
a = np.asarray(np.random.rand(x,y), np.float32)
b = np.asarray(np.random.rand(y,x), np.float32)
print("Pump to GPU\n")
start_time1 = timeit.default_timer()
a_gpu = gpuarray.to_gpu(a)
b_gpu = gpuarray.to_gpu(b)
print("Time elapsed ",timeit.default_timer() - start_time1)

print("Calculate\n")
start_time2 = timeit.default_timer()
d_gpu = linalg.dot(a_gpu, b_gpu)
print(d_gpu)
print(d_gpu.shape)
print("Time elapsed ",timeit.default_timer() - start_time1)

print("Numpy")
start_timenumpy1 = timeit.default_timer()
c = np.dot(a,b)
print(c)
print("Time elapsed ",timeit.default_timer() - start_timenumpy1)

