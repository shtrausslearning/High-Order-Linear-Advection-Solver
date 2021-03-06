# create gif animation from sol_ files

import os,glob
import matplotlib.pyplot as plt
import numpy as np
import math as m
from HOscheme import *

def func(x):
    pi = 4.0*m.atan(1.0)
    return (np.sin(2.0*pi*x))**2

xf = np.linspace(0,1,1000)
print(xf)
yf = func(xf)

M = np.loadtxt('./sp20.dat')

fig, ax = plt.subplots(figsize=(20,10))
plt.setp(ax.spines.values(),linewidth=3)
line, = plt.plot(M[:,0],M[:,1],'k.',ms=10,zorder=-100)

# MAIN NODE
cnod = 6

# LHS STATE
#         i-2					i-1					i					i+1						i+2
LYum2 = M[cnod-2,1] ; LYum1 = M[cnod-1,1] ; LYu0 = M[cnod,1] ; LYup1 = M[cnod+1,1] ; LYup2 = M[cnod+2,1]
LXum2 = M[cnod-2,0] ; LXum1 = M[cnod-1,0] ; LXu0 = M[cnod,0] ; LXup1 = M[cnod+1,0] ; LXup2 = M[cnod+2,0]

# RHS STATE
#         i+2					i+1					i					i-1						i-2
RYup2 = M[cnod-1,1] ; RYup1 = M[cnod,1] ; RYu0 = M[cnod+1,1] ; RYum1 = M[cnod+2,1] ; RYum2 = M[cnod+3,1]
RXup2 = M[cnod-1,0] ; RXup1 = M[cnod,0] ; RXu0 = M[cnod+1,0] ; RXum1 = M[cnod+2,0] ; RXum2 = M[cnod+3,0]

Xint = (LXup1 + LXu0)/2.0
YL = weno5(LYum2,LYum1,LYu0,LYup1,LYup2) ; YR = weno5(RYum2,RYum1,RYu0,RYup1,RYup2)
#Yint2 = tvd(Yum1,Yu0,Yup1) 
#Yint2 = weno3(Yum1,Yu0,Yup1)
YL2 = muscl(LYum1,LYu0,LYup1)  ; YR2 = muscl(RYum1,RYu0,RYup1)

#plt.axhline(YR,c='k',ls='--',alpha=0.5,zorder=-100)
plt.axvline(Xint,c='k',ls='--',alpha=1)
plt.axhspan(LYu0,RYu0,fc='b',alpha=0.2,zorder=-100)
plt.axhspan(YL2,YR2,fc='b',alpha=0.5,zorder=-99)
plt.axhspan(YL,YR,fc='b',alpha=1,zorder=-80)

print('diff1: ',YR-YL)
print('diff2: ',YR2-YL2)

P = 0.1
#plt.scatter(Xum2,Yum2,marker='^',c='b',s=60,label='um2')
#plt.scatter(Xum1,Yum1,marker='s',c='b',s=90,label='um1')
#plt.scatter(Xu0,Yu0,marker='o',s=120,label='um')
#plt.scatter(Xup1,Yup1,marker='s',c='r',s=90,label='up1')
#plt.scatter(Xup2,Yup2,marker='^',c='r',s=60,label='up2')
#plt.scatter(Xint,YL,label='LHS')
#plt.scatter(Xint,YR,label='RHS')
#plt.scatter(Xint,YL2,label='LHS2')
#plt.scatter(Xint,YR2,label='RHS2')


plt.plot(xf,yf,'--',label='analytical')
plt.plot(LXum2,LYum2,'s',ms=10,mfc='None',mec='g',label='i-2')
plt.plot(LXum1,LYum1,'o',ms=10,mfc='None',mec='g',label='i-1')
plt.plot(LXu0,LYu0,'o',ms=10,mfc='None',mec='k',label='i')
plt.plot(LXup1,LYup1,'o',ms=10,mfc='None',mec='b',label='i+1')
plt.plot(LXup2,LYup2,'s',ms=10,mfc='None',mec='b',label='i+2')

for i in range(20):
	plt.axvline((i/20),c='k',ls='--',alpha=0.5,zorder=-100)

minY = min([LYum2,LYum1,LYu0,LYup1,LYup2])  # find min of all segment
maxY = max([LYum2,LYum1,LYu0,LYup1,LYup2])  # find max of all segment
plt.axis([LXum2-P,LXup2+P,minY-P,maxY+P])
plt.grid()

plt.legend()
plt.show()

