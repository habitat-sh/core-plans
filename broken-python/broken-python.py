# -*- coding: utf-8; mode: python -*-

import random
import time

from threading import Thread


def do_nothing(i):
    print("Thread %d has started" % i)
    time.sleep(random.randint(0, 3))
    print("Thread %d is done" % i)

threads = [Thread(target=do_nothing, args=(i,)) for i in range(3)]

for thread in threads:
    thread.start()

for thread in threads:
    thread.join()
