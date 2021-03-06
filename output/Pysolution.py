# create gif animation from sol_ files

import os,glob
import matplotlib.pyplot as plt
import numpy as np
import imageio

cwd = os.getcwd()
print(f'Current Directory: {cwd}')
os.chdir(cwd)

def genIMGS():
    
    files1 = []
    for i in sorted(glob.glob("./sol/sol_*"),key=os.path.getmtime):
        files1.append(i)
        
    ii=-1
    for i in files1:
        
        ii+=1
        M = np.loadtxt(i)
        
        fig = plt.figure()
        plt.plot(M[:,0],M[:,1],'k.')
        maxY = M[:,1].max() ; minY = M[:,1].min()
        plt.axhline(maxY,c='grey',ls='--')
        plt.axhline(minY,c='grey',ls='--')
        plt.xlim((0.0,1.0))
        plt.ylim((0.0,1.0))
        plt.grid(ls='--',linewidth=0.5)
        
        plt.axhline(1.0,c='k',ls='-')
        plt.axhline(0.0,c='k',ls='-')
        plt.savefig('./sol/out'+ str(ii)+'.png')
        
    for i in files1:
        os.remove(i)
    
def genGIF():
    
    files2 = []
    images = list()
    
    for i in sorted(glob.glob("./sol/out*"),key=os.path.getmtime):
        files2.append(i)
        
    print(files2)
        
    for fileN in files2:
        images.append(imageio.imread(fileN))
    imageio.mimsave('animation.gif',images)
    
    for i in files2:
        os.remove(i)

genIMGS()
genGIF()