import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator
import os,glob

# INTPUT DATA

E_nc,E_l1,E_l2 = np.loadtxt("error1.dat",delimiter=',',unpack=True)
E2_nc,E2_l1,E2_l2 = np.loadtxt("errortvd.dat",delimiter=',',unpack=True) 
E3_nc,E3_l1,E3_l2 = np.loadtxt("errorM.dat",delimiter=',',unpack=True) 
E4_nc,E4_l1,E4_l2 = np.loadtxt("errorW.dat",delimiter=',',unpack=True) 

# ORDER OF ACCURACY FOR EACH SEGMENT -------------------------------------------------------
def order(a,b,c):
	
	orderl1 = np.zeros(a.shape[0]-1) # reset
	orderl2 = np.zeros(a.shape[0]-1) # reset
	
	for i in range(a.shape[0]-1):
		orderl1[i] = (np.log10(b[i+1]) - np.log10(b[i]))/(np.log10(a[i+1]) - np.log10(a[i]) )
		orderl2[i] = (np.log10(c[i+1]) - np.log10(c[i]))/(np.log10(a[i+1]) - np.log10(a[i]) )
	print('errors : L1: ',orderl1)
	print('errors : L2: ',orderl2 )
		
# -------------------------------------------------------------------------------------------

order(E_nc,E_l1,E_l2)     # 1st order
order(E2_nc,E2_l1,E2_l2)  # tvd 
order(E3_nc,E3_l1,E3_l2)  # muscl
order(E4_nc,E4_l1,E4_l2)   # weno5

# subplot layout of figure
fig,ax = plt.subplots(1,2,figsize=(8,4))

# figure structure
ax[0].axis([1e1,5e2,1e-7,1])
ax[0].loglog()
ax[0].grid(color='k',ls='-.',lw=0.5,alpha=0.5)
ax[0].set_xlabel('N',fontsize=10)
ax[0].set_ylabel('L1 error',fontsize=10)
#ax[0].text(70,0.08,f's: {orderl1[0]:.2f}')  # [f string format py3.6+]
# figure plot
ax[0].plot(E_nc,E_l1,'--o',c='k',ms=4,lw=1,mfc='None',mec='k',mew=1.5,label='1')
ax[0].plot(E2_nc,E2_l1,'--o',c='b',ms=4,lw=1,mfc='None',mec='b',mew=1.5,label='tvd')
ax[0].plot(E3_nc,E3_l1,'--o',c='r',ms=4,lw=1,mfc='None',mec='r',mew=1.5,label='muscl')
ax[0].plot(E4_nc,E4_l1,'--o',c='g',ms=4,lw=1,mfc='None',mec='g',mew=1.5,label='weno5')
ax[0].legend(loc=3)

# figure structure
ax[1].axis([1e1,5e2,1e-7,1])
ax[1].loglog()
ax[1].grid(color='k',ls='-.',lw=0.5,alpha=0.5)
ax[1].set_xlabel('N',fontsize=10)
ax[1].set_ylabel('L1 error',fontsize=10)
#ax[0].text(70,0.08,f's: {orderl1[0]:.2f}')  # [f string format py3.6+]
# figure plot
ax[1].plot(E_nc,E_l2,'--o',c='k',ms=4,lw=1,mfc='None',mec='k',mew=1.5,label='1')
ax[1].plot(E2_nc,E2_l2,'--o',c='b',ms=4,lw=1,mfc='None',mec='b',mew=1.5,label='tvd')
ax[1].plot(E3_nc,E3_l2,'--o',c='r',ms=4,lw=1,mfc='None',mec='r',mew=1.5,label='muscl')
ax[1].plot(E4_nc,E4_l2,'--o',c='g',ms=4,lw=1,mfc='None',mec='g',mew=1.5,label='weno5')
ax[1].legend(loc=3)

plt.subplots_adjust(left=0.15,bottom=0.15,wspace=0.4) # control spacing between graphs
plt.savefig('error.png',bbox_inches='tight',figsize=(8,5),dpi=100)
#plt.savefig('error.pdf',bbox_inches='tight',figsize=(8,6),dpi=100,format='pdf')
plt.show()
