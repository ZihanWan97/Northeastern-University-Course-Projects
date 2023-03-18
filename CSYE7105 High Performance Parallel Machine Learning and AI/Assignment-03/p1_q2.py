import os
import multiprocessing as mp

process = ('script1.py', 'script2.py', 'script3.py')

def func(process):
    os.system('python {}'.format(process))

pool = mp.Pool(3)
pool.map(func, process)