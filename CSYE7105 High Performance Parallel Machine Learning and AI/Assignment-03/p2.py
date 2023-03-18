import numpy as np
import pandas as pd
import multiprocessing as mp
import time
import matplotlib.pyplot as plt

df = pd.DataFrame(np.random.random(size=[20000,100]))

def square_root(i):
    return np.sqrt((df[i].min())**2 + (df[i].max())**2)

with mp.Pool(1) as pool:
    time_start1 = time.time()
    for result in pool.map(square_root,range(100)):
        print(result)
    time1 = float((time.time()-time_start1) % 60)
print(f'----------CPU=1: {time1} seconds----------')

with mp.Pool(2) as pool:
    time_start2 = time.time()
    for result in pool.map(square_root,range(100)):
        print(result)
    time2 = float((time.time()-time_start2) % 60)
print(f'----------CPU=2: {time2} seconds----------')

with mp.Pool(4) as pool:
    time_start4 = time.time()
    for result in pool.map(square_root,range(100)):
        print(result)
    time4 = float((time.time()-time_start4) % 60)
print(f'----------CPU=4: {time4} seconds----------')

with mp.Pool(8) as pool:
    time_start8 = time.time()
    for result in pool.map(square_root,range(100)):
        print(result)
    time8 = float((time.time()-time_start8) % 60)
print(f'----------CPU=8: {time8} seconds----------')

plt.plot([1,2,4,8],[time1,time2,time4,time8])
plt.xlabel('num of CPUs')
plt.ylabel('Elapsed Time (seconds)')
plt.savefig('Part2.png')