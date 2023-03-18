import multiprocessing as mp

list_a = [[1, 2, 3], [5, 6, 7, 8], [10, 11, 12], [20, 21]]
list_b = [[2, 3, 4, 5], [6, 9, 10], [11, 12, 13, 14], [21, 24, 25]]

def common_items(list_a, list_b):
    return list(set(list_a).intersection(list_b))

pool = mp.Pool(2)
results = [pool.apply(common_items, args=(la, lb)) for la, lb in zip(list_a, list_b)]
pool.close()
print(results)