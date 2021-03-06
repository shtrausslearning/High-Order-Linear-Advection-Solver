import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl
import os,glob

mpl.rcParams['font.size'] = 10
#mpl.rcParams['figure.autolayout'] = True

# INTPUT DATA
init = np.loadtxt("init.dat")
first = np.loadtxt("sol_0.dat")
tvd = np.loadtxt("sol_1.dat")
weno3 = np.loadtxt("sol_2.dat")
weno5 = np.loadtxt("sol_3.dat")

# PLOT DATA
plt.plot(init[:,0],init[:,1],'k',linewidth=2,label='Initial')
plt.plot(first[:,0],first[:,1],'r',linewidth=2,label='1st order')
plt.plot(tvd[:,0],tvd[:,1],'b',linewidth=2, label='TVD')
plt.plot(weno3[:,0],weno3[:,1],'c',linewidth=2,label='WENO3')
plt.plot(weno5[:,0],weno5[:,1],'g--',linewidth=2, label='WENO5')
xlimits = plt.xlim()

plt.xlabel("$x$",fontsize=10)
plt.ylabel("$u$",fontsize=10)
plt.legend(fontsize=10)
plt.grid(ls='--',alpha=0.4)
plt.title("Solution of $u_t+u_x=0$ at $t=5$, 100 cells")
plt.savefig("compare.pdf")
plt.show()
