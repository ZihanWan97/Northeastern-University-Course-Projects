# Assignment-3

**Submission format:**

Submit a compressed package containing all the files in this assignment.

+Name this package with your name for the convenience of the TA.

Submission through Canvas.

**Review and Grade:**

TA will review the homework and grade for Professor’s reference.

Please submit your homework on time.

Please note the late submission penalty.

### Part 1: 15 points

1. Use Pool.apply() to get the row wise common items in list_a and list_b; and print the result. (5 pts)

```
list_a = [[1, 2, 3], [5, 6, 7, 8], [10, 11, 12], [20, 21]]

list_b = [[2, 3, 4, 5], [6, 9, 10], [11, 12, 13, 14], [21, 24, 25]]
```



 Ans:

```python
import multiprocessing as mp

list_a = [[1, 2, 3], [5, 6, 7, 8], [10, 11, 12], [20, 21]]
list_b = [[2, 3, 4, 5], [6, 9, 10], [11, 12, 13, 14], [21, 24, 25]]

def common_items(list_a, list_b):
    return list(set(list_a).intersection(list_b))

pool = mp.Pool(2)
results = [pool.apply(common_items, args=(la, lb)) for la, lb in zip(list_a, list_b)]
pool.close()
print(results)
```





1. Use Pool.map() to run the following python scripts in parallel; and print the result. (5 pts)

```
Script names: ‘script1.py’, ‘script2.py’, ‘script3.py’
```

Hint: you can put any content in the three scripts.



Ans:

```python
import os
import multiprocessing as mp

process = ('script1.py', 'script2.py', 'script3.py')

def func(process):
    os.system('python {}'.format(process))

pool = mp.Pool(3)
pool.map(func, process)
```



 

1. Normalize each row of 2d array (list) list_c to vary between 0 and 1. Parallelize the function with any subfunction of Pool; and print the result. (5 pts)

```
list_c = [[2, 3, 4, 5], [6, 9, 10, 12], [11, 12, 13, 14], [21, 24, 25, 26]]
```

 

Ans:

```python
import multiprocessing as mp

list_c = [[2, 3, 4, 5], [6, 9, 10, 12], [11, 12, 13, 14], [21, 24, 25, 26]]

def normalize(lc):
    return [(i - min(lc))/(max(lc)-min(lc)) for i in lc]

pool = mp.Pool(2)
results = [pool.apply(normalize, args=(lc, )) for lc in list_c]
pool.close()
print(results)
```



### Part 2: 30 points

Parallelize a panda DataFrame. Please complete the following tasks:

- Create a DataFrame. The required values are arbitrary numerical numbers, the shape of the values is 20000 x 100. (5 pts)
- Define a function to find the maximum and minimum values of each column, sum the squares of these two numbers, and then find the square root. (5 pts)
- Parallelize the function with any method of multiprocessing.Pool. (5 pts)
- Set a timer to calculate the elapsed time for the parallelized code when CPU=1, 2, 4, and 8.  (4 pts)
- Using matplotlib (or other tool) to plot the trend curve of speedup as the number of CPU (1, 2, 4, 8) and save the figure as an image file. (4 pts)
- Create a Word document. In this Word document, you should do:
  - Create a table and fill in the elapsed time (seconds or minutes) you obtained when running the parallelized program using different CPU numbers. (2 pts)
  - Insert the plot image in this Word document and analyze your results: the speedup, the overhead and optimal results, etc.         (5 pts)

Note: finish the part 2 in one python file. Submit this program file and the Word file.



Ans:

```python
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
```



 

### Part 3: 20 points

Please complete the following tasks in JupyterLab or Jupyter Notebook:

- Program to use xgboost classifier to train a model with a given dataset “train.csv” [train.csv](https://northeastern.instructure.com/courses/123482/files/18381466?wrap=1)[ Download train.csv](https://northeastern.instructure.com/courses/123482/files/18381466/download?download_frd=1)  . (10 points)
- Set a timer and build a for-loop to calculate the elapsed time for the parallelized code when CPU=1, 2, 4, 8. (5 pts)
- Using matplotlib (or other tool) to plot the trend curve of speedup as the number of CPU increases (1, 2, 4, 8) in JupyterLab. (5 pts)

 

### Part 4: 10 points

Performance comparison between numpy array and dask array: set a timer to calculate the time of the following operations:

- In numpy array, draw random samples from a normal (Gaussian) distribution, the mean of the distribution is 10, the standard deviation of the distribution is 0.1, and the output shape is 20000x20000. Then take the "mean" of x along axis=0 with a step of 100.                        (10 pts)
- In dask array, do the same thing as above. (Tips: you can set the size of “chunks” to 1000x1000) (10 pts)

Note: finish the part 4 in one Jupyter file.

 

Ans:

```python
import numpy as np
import dask.array as da

mean = 10
sd = 0.1

np_data = np.random.default_rng().normal(mean, sd, size=(20000,20000))

%time np_data_1 = np_data[::100,:].mean(axis=0)

np_data_1

da_data = da.from_array(np_data, chunks=(1000,1000))

%time da_data_1 = da_data[::100,:].mean(axis=0).compute()

da_data_1
```



### Part 5: 25 points

Please install nycflight dataframe package in your Anaconda environment (you can do it on “local” or “discovery”):

```
pip install nycflights13

from nycflights13 import flights
```

- Remove the samples with “NaN” in the feature “dep_delay” in this dataframe. (5 pts)
- Start a Dask Client and set “n_workers=4” for this client.         (5 pts)
- Using dask dataframe to compute the mean and standard deviation for departure delay “dep_delay” of all flights.   (5 pts)
- You are required to take a screenshot of Dask Dashboard for running the step 3 with the 3 observed processes “Dask Process”, “Dask Graph”, “Dask Task Stream” in a same JupyterLab window, or use static Dask performance report. (Hint: since the dataset is small, the execution would be very fast. You may need to take a very quick screen capture.)   (10 pts)

Note: finish the part 5 in a Jupyter file. Submit this Jupyter file and the screenshot image in the step 4.
