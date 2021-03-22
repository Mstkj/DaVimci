#!/usr/bin/python3
#import random
from random import randint
import sys
from time import sleep

import numpy as np

#import math
# create requirements.txt

randomlist = []
for i in range(0,10):
    n = randint(367,613)
    randomlist.append(n)
    print(randomlist)
    sleep(0.10)

# Object 277 130mm M-65
# The average damage is 490

arr1 = np.array(randomlist)
targ = len(arr1) # stores length of array as variable
# If you have a multi-dimensional array, len() might not give you the value you are looking for.

# indexes array
index = (arr1[0] + arr1[1] + arr1[2] + arr1[3] + arr1[4] + arr1[5] + arr1[6] + arr1[7] + arr1[8] + arr1[9])
# You perform the above with a for loop
mean = (index / targ)

# add the values of the array and return the average
print("The length of the array is", targ) # prints the length of the array
print("The average value of the array is", mean)
sleep(1.5)

sys.exit()
