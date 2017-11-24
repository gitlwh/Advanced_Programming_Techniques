#!/usr/bin/env python
#Weiheng Li
#wel615@lehigh.edu

import numpy as np
import math

def oneSample(data,mean):
    if(len(data)==0):
        print "You should input some value!"
        return
    npdata = np.array(data)
    deviation = np.std(npdata,ddof=1)
    t_test = (sum(data)/len(data)-mean)*math.sqrt(len(npdata))/deviation
    if t_test>0:
        print "Original system is faster than mean"
    else:
        print "Original system is not faster than mean"
    return t_test
    
def pairedTTesting(data1,data2):
    if(len(data1)==0|len(data2)==0):
        print "You should input some value in both list!"
        return
    npdata1 = np.array(data1)
    npdata2 = np.array(data2)
    t_test = (sum(data2)/len(data2)-sum(data1)/len(data1))/math.sqrt(abs((np.std(npdata1,ddof=1)**2)/len(data1)+(np.std(npdata2,ddof=1)**2)/len(data2)))
    if t_test>0:
        print "Optimal system is faster than original system"
    else:
        print "Optimal system is not faster than original system"
    return t_test

originSystem=[11300,9890,10400,9900,10545,12334]
optimalSystem=[11400,9800,11345,9739,10787,12555]
mean=10000
#input should be two list and one integer

print "one-sample t-testing result = "+str(oneSample(originSystem,mean))
print "Generic paired t-testing result = "+str(pairedTTesting(originSystem,optimalSystem))
