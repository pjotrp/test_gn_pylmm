import pycuda.autoinit
import pycuda.gpuarray as gpuarray
import numpy as np
import scikits.cuda.linalg as linalg
linalg.init()
x = np.asarray(np.random.rand(4, 4), np.float32)
y = np.asarray(np.random.rand(4, 4), np.float32)
x_gpu = gpuarray.to_gpu(x)
y_gpu = gpuarray.to_gpu(y)
z_gpu = linalg.multiply(x_gpu, y_gpu)
np.allclose(x*y, z_gpu.get())
