import multiprocessing as mp

list_c = [[2, 3, 4, 5], [6, 9, 10, 12], [11, 12, 13, 14], [21, 24, 25, 26]]

def normalize(lc):
    return [(i - min(lc))/(max(lc)-min(lc)) for i in lc]

pool = mp.Pool(2)
results = [pool.apply(normalize, args=(lc, )) for lc in list_c]
pool.close()
print(results)
