#!/usr/bin/env python

from multiprocessing import Process
import random
import time

def some_function(first, last):
    time.sleep(random.randint(1, 3))
    print(first, last)

processes = []

for m in range(1,1000):
   n = m + 1
   p = Process(target=some_function, args=(m, n))
   p.start()
   processes.append(p)

for p in processes:
   p.join()
